
create
or replace function get_satisfied_customers_cards (
  begin_date text default null,
  end_date text default null,
  collector_id bigint default null,
  customer_account_id bigint default null,
  customer_card_id bigint default null,
  type_id bigint default null
) returns table (
  id_charge_compte bigint,
  charge_compte text,
  ids_comptes_clients bigint[],
  clients text[],
  ids_cartes bigint[],
  libelles_cartes text[],
  nombre_types_cartes bigint[],
  ids_types_cartes bigint[],
  noms_types text[],
  dates_remboursements_cartes timestamp with time zone [],
  dates_satisfactions_cartes timestamp with time zone [],
  dates_transfert_cartes timestamp with time zone []
) as $$
BEGIN
    RETURN QUERY
    SELECT
        charges_compte.id as id_charge_compte,
        CONCAT(charges_compte.nom, ' ', charges_compte.prenoms) as charge_compte,
        ARRAY_AGG(comptes_clients.id) as ids_comptes_clients,
        ARRAY_AGG(CONCAT(clients.nom, ' ', clients.prenoms)) as clients,
        ARRAY_AGG(card_data.id_carte) as ids_cartes,
        ARRAY_AGG(card_data.libelle_carte) as libelles_cartes,
        ARRAY_AGG(card_data.nombre_types_carte) as nombre_types_cartes,
        ARRAY_AGG(card_data.id_type_carte) as ids_types_cartes,
        ARRAY_AGG(types.nom) as noms_types,
        ARRAY_AGG(card_data.date_remboursement_carte) as dates_remboursements_cartes,
        ARRAY_AGG(card_data.date_satisfaction_carte) as dates_satisfactions_cartes,
        ARRAY_AGG(card_data.date_transfert_carte) as dates_transfert_cartes
    FROM
        charges_compte
        INNER JOIN comptes_clients ON comptes_clients.id_charge_compte = charges_compte.id
        INNER JOIN clients ON clients.id = comptes_clients.id_client
        INNER JOIN (
            SELECT
                cartes.id as id_carte,
                cartes.libelle as libelle_carte,
                cartes.id_type as id_type_carte,
                cartes.nombre_types as nombre_types_carte,
                cartes.id_compte_client as id_compte_client_carte,
                cartes.date_remboursement as date_remboursement_carte,
                cartes.date_satisfaction as date_satisfaction_carte,
                cartes.date_transfert as date_transfert_carte
            FROM
                cartes
            WHERE
                (cartes.date_remboursement IS NOT NULL AND ((begin_date is null or end_date is null) or cartes.date_remboursement BETWEEN DATE(begin_date) AND DATE(end_date)))
                OR (cartes.date_satisfaction IS NOT NULL AND ((begin_date is null or end_date is null) or cartes.date_satisfaction BETWEEN DATE(begin_date) AND DATE(end_date)))
                OR (cartes.date_transfert IS NOT NULL AND ((begin_date is null or end_date is null) or cartes.date_transfert BETWEEN DATE(begin_date) AND DATE(end_date)))
        ) AS card_data ON card_data.id_compte_client_carte = comptes_clients.id
        INNER JOIN types ON types.id = card_data.id_type_carte
    WHERE
        (collector_id IS NULL OR charges_compte.id = collector_id)
        AND (customer_account_id IS NULL OR comptes_clients.id = customer_account_id)
        AND (customer_card_id IS NULL OR card_data.id_carte = customer_card_id)
        AND (type_id IS NULL OR types.id = type_id)
    GROUP BY
        charges_compte.id,
        charge_compte;
END;
$$ language plpgsql;