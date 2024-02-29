SELECT
    id_type,
    nom_type,
    ARRAY_AGG (id_charges_compte) AS ids_charges_compte,
    ARRAY_AGG (nom_charges_compte) AS noms_charges_compte,
    ARRAY_AGG (prenoms_charges_compte) AS prenoms_charges_compte,
    ARRAY_AGG (id_carte) AS ids_cartes,
    ARRAY_AGG (libelle_carte) AS libelles_cartes,
    ARRAY_AGG (nombre_types) AS nombres_types_cartes,
    ARRAY_AGG (total_reglements) AS totaux_reglements_carte,
    ARRAY_AGG (montant_reglements) AS montants_reglements_carte
FROM (
        SELECT
            comptes_clients.id AS id_compte, clients.id AS id_client, clients.nom AS nom_client, clients.prenoms AS prenoms_client, charges_compte.id AS id_charge_compte, charges_compte.nom AS nom_charge_compte, charges_compte.prenoms AS prenoms_charge_compte, cartes.id AS id_carte, cartes.libelle AS libelle_carte, cartes.nombre_types AS nombre_types, types.id AS id_type, types.nom AS nom_type, COALESCE(
                bilan_reglements.total_reglements, 0
            ) AS total_reglements, COALESCE(
                cartes.nombre_types * types.mise * bilan_reglements.total_reglements, 0
            ) AS montant_reglements
        FROM
            cartes
            LEFT JOIN types ON cartes.id_type = types.id
            LEFT JOIN comptes_clients ON cartes.id = ANY (comptes_clients.ids_cartes)
            LEFT JOIN clients ON comptes_clients.id_client = clients.id
            LEFT JOIN charges_compte ON comptes_clients.id_charge_compte = charges_compte.id
            LEFT JOIN (
                SELECT id_carte, COALESCE(
                        SUM(
                            CASE
                                WHEN est_valide THEN nombre
                                ELSE 0
                            END
                        ), 0
                    ) AS total_reglements
                FROM reglements
                GROUP BY
                    id_carte
            ) AS bilan_reglements ON bilan_reglements.id_carte = cartes.id
        ORDER BY
            id_charge_compte, nom_charge_compte, prenoms_charge_compte, id_client, nom_client, prenoms_client
    ) AS subquery_1
GROUP BY
    id_type,
    nom_type;