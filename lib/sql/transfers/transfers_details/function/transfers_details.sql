create
or replace function get_transfers_details (
  agent_id bigint,
  creation_date text,
  validation_date text,
  discardation_date text,
  issuing_customer_card_id bigint,
  issuing_customer_card_type_id bigint,
  issuing_customer_account_id bigint,
  issuing_customer_collector_id bigint,
  receiving_customer_card_id bigint,
  receiving_customer_card_type_id bigint,
  receiving_customer_account_id bigint,
  receiving_customer_collector_id bigint
) returns table (
  id_transfert bigint,
  id_agent bigint,
  date_validation timestamp with time zone,
  date_rejet timestamp with time zone,
  date_creation timestamp with time zone,
  date_modification timestamp with time zone,
  id_carte_emettrice bigint,
  libelle_carte_emettrice text,
  id_type_emetteur bigint,
  nom_type_emetteur text,
  id_compte_client_emetteur bigint,
  id_charge_compte_emetteur bigint,
  client_emetteur text,
  id_carte_receptrice bigint,
  libelle_carte_receptrice text,
  id_type_recepteur bigint,
  nom_type_recepteur text,
  id_compte_client_recepteur bigint,
  id_charge_compte_recepteur bigint,
  client_recepteur text
) as $$
BEGIN
RETURN QUERY
SELECT
  transferts.id as id_transfert,
  transferts.id_agent,
  transferts.date_validation,
  transferts.date_creation,
  transferts.date_modification,
  compte_emetteur.id_carte_emettrice,
  compte_emetteur.libelle_carte_emettrice,
  compte_emetteur.id_type_emetteur,
  compte_emetteur.nom_type_emetteur,
  compte_emetteur.id_compte_client_emetteur,
  compte_emetteur.id_charge_compte_emetteur,
  compte_emetteur.client_emetteur,
  compte_recepteur.id_carte_receptrice,
  compte_recepteur.libelle_carte_receptrice,
  compte_recepteur.id_type_recepteur,
  compte_recepteur.nom_type_recepteur,
  compte_recepteur.id_compte_client_recepteur,
  compte_recepteur.id_charge_compte_recepteur,
  compte_recepteur.client_recepteur
FROM
  transferts
  INNER JOIN (
    SELECT
      cartes.id as id_carte_emettrice,
      cartes.libelle as libelle_carte_emettrice,
      types.id as id_type_emetteur,
      types.nom as nom_type_emetteur,
      comptes_clients.id as id_compte_client_emetteur,
      charges_compte.id as id_charge_compte_emetteur,
      CONCAT(charges_compte.nom, ' ', charges_compte.prenoms) as charge_compte_emetteur,
      clients.id as id_client_emetteur,
      CONCAT(clients.nom, ' ', clients.prenoms) as client_emetteur
    FROM
      cartes,
      transferts,
      types,
      comptes_clients,
      charges_compte,
      clients
    WHERE
      cartes.id = transferts.id_carte_emettrice 
      AND cartes.id_type = types.id
      AND cartes.id_compte_client = comptes_clients.id 
      AND comptes_clients.id_charge_compte = charges_compte.id
      AND comptes_clients.id_client = clients.id
  ) AS compte_emetteur 
  ON compte_emetteur.id_carte_emettrice = transferts.id_carte_emettrice
  INNER JOIN (
    SELECT
      cartes.id as id_carte_receptrice,
      cartes.libelle as libelle_carte_receptrice,
      types.id as id_type_recepteur,
      types.nom as nom_type_recepteur,
      comptes_clients.id as id_compte_client_recepteur,
      charges_compte.id as id_charge_compte_recepteur,
      CONCAT(charges_compte.nom, ' ', charges_compte.prenoms) as charge_compte_recepteur,
      clients.id as id_client_recepteur,
      CONCAT(clients.nom, ' ', clients.prenoms) as client_recepteur
    FROM
      cartes,
      transferts,
      types,
      comptes_clients,
      charges_compte,
      clients
    WHERE
      cartes.id = transferts.id_carte_receptrice 
      AND cartes.id_type = types.id
      AND cartes.id_compte_client = comptes_clients.id 
      AND comptes_clients.id_charge_compte = charges_compte.id
      AND comptes_clients.id_client = clients.id
  ) AS compte_recepteur 
  ON compte_recepteur.id_carte_receptrice = transferts.id_carte_receptrice
  WHERE 
      (agent_id IS NULL OR transferts.id_agent = agent_id)
      AND (creation_date IS NULL OR DATE(transferts.date_creation) = DATE(creation_date))
      AND (validation_date IS NULL OR DATE(transferts.date_validation) = DATE(validation_date))
      AND (discardation_date IS NULL OR DATE(transferts.date_rejet) = DATE(discardation_date))
      AND (issuing_customer_card_id IS NULL OR compte_emetteur.id_carte_emettrice = issuing_customer_card_id)
      AND (issuing_customer_card_type_id  IS NULL OR compte_emetteur.id_type_emetteur = issuing_customer_card_type_id)
      AND (issuing_customer_account_id  IS NULL OR compte_emetteur.id_compte_client_emetteur = issuing_customer_account_id)
      AND (issuing_customer_collector_id  IS NULL OR compte_emetteur.id_charge_compte_emetteur = issuing_customer_collector_id)

      AND (receiving_customer_card_id IS NULL OR compte_recepteur.id_carte_receptrice = receiving_customer_card_id)
      AND (receiving_customer_card_type_id  IS NULL OR compte_recepteur.id_type_recepteur = receiving_customer_card_type_id)
      AND (receiving_customer_account_id  IS NULL OR compte_recepteur.id_compte_client_recepteur = receiving_customer_account_id)
      AND (receiving_customer_collector_id  IS NULL OR compte_recepteur.id_charge_compte_recepteur = receiving_customer_collector_id)
      ;
END;
$$ language plpgsql;