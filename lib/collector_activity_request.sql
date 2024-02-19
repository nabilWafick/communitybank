/**************** Daily data ********************/
SELECT
    id_compte,
    id_client,
    nom_client,
    prenoms_client,
    id_charge_compte,
    nom_charge_compte,
    prenoms_charge_compte,
    ARRAY_AGG (id_carte) AS id_cartes,
    ARRAY_AGG (libelle_carte) AS libelle_cartes,
    ARRAY_AGG (nombre_types) AS nombre_types_cartes,
    ARRAY_AGG (nom_type) AS nom_types,
    ARRAY_AGG (total_reglements) AS total_reglements_per_carte,
    ARRAY_AGG (montant_reglements) AS montant_reglements_per_carte
FROM
    (
        SELECT
            comptes_clients.id AS id_compte,
            clients.id AS id_client,
            clients.nom AS nom_client,
            clients.prenoms AS prenoms_client,
            charges_compte.id AS id_charge_compte,
            charges_compte.nom AS nom_charge_compte,
            charges_compte.prenoms AS prenoms_charge_compte,
            cartes.id AS id_carte,
            cartes.libelle AS libelle_carte,
            cartes.nombre_types AS nombre_types,
            types.nom AS nom_type,
            COALESCE(bilan_reglements.total_reglements, 0) AS total_reglements,
            COALESCE(
                nombre_types * types.mise * bilan_reglements.total_reglements,
                0
            ) AS montant_reglements
        FROM
            comptes_clients
            JOIN clients ON comptes_clients.id_client = clients.id
            JOIN charges_compte ON comptes_clients.id_charge_compte = charges_compte.id
            JOIN cartes ON cartes.id = ANY (comptes_clients.ids_cartes)
            JOIN types ON cartes.id_type = types.id
            LEFT JOIN (
                SELECT
                    id_carte,
                    COALESCE(
                        SUM(
                            CASE
                                WHEN est_valide THEN nombre
                                ELSE 0
                            END
                        ),
                        0
                    ) AS total_reglements
                FROM
                    reglements
                WHERE
                    DATE (date_collecte) = '2024-01-12'
                GROUP BY
                    id_carte
            ) AS bilan_reglements ON bilan_reglements.id_carte = cartes.id
        WHERE
            id_charge_compte = 9
            and total_reglements != 0
    ) AS default_data
GROUP BY
    id_compte,
    id_client,
    nom_client,
    prenoms_client,
    id_charge_compte,
    nom_charge_compte,
    prenoms_charge_compte;

/**************** Periodic data ********************/
SELECT
    date_collecte,
    id_compte,
    id_client,
    nom_client,
    prenoms_client,
    id_charge_compte,
    nom_charge_compte,
    prenoms_charge_compte,
    ARRAY_AGG (id_carte) AS id_cartes,
    ARRAY_AGG (libelle_carte) AS libelle_cartes,
    ARRAY_AGG (nombre_types) AS nombre_types_cartes,
    ARRAY_AGG (nom_type) AS nom_types,
    ARRAY_AGG (total_reglements) AS total_reglements,
    ARRAY_AGG (montant_reglements) AS montant_reglements
FROM
    (
        SELECT
            comptes_clients.id AS id_compte,
            clients.id AS id_client,
            clients.nom AS nom_client,
            clients.prenoms AS prenoms_client,
            charges_compte.id AS id_charge_compte,
            charges_compte.nom AS nom_charge_compte,
            charges_compte.prenoms AS prenoms_charge_compte,
            cartes.id AS id_carte,
            cartes.libelle AS libelle_carte,
            cartes.nombre_types AS nombre_types,
            types.nom AS nom_type,
            COALESCE(bilan_reglements.total_reglements, 0) AS total_reglements,
            COALESCE(
                nombre_types * types.mise * bilan_reglements.total_reglements,
                0
            ) AS montant_reglements,
            dates_collectes.date_collecte AS date_collecte
        FROM
            comptes_clients
            JOIN clients ON comptes_clients.id_client = clients.id
            JOIN charges_compte ON comptes_clients.id_charge_compte = charges_compte.id
            JOIN cartes ON cartes.id = ANY (comptes_clients.ids_cartes)
            JOIN types ON cartes.id_type = types.id
            JOIN (
                SELECT DISTINCT
                    DATE (date_collecte) AS date_collecte
                FROM
                    reglements
                WHERE
                    DATE (date_collecte) BETWEEN '2024-01-01' AND '2024-01-12'
            ) AS dates_collectes ON TRUE
            JOIN (
                SELECT
                    id_carte,
                    DATE (date_collecte) AS date_collecte,
                    COALESCE(
                        SUM(
                            CASE
                                WHEN est_valide THEN nombre
                                ELSE 0
                            END
                        ),
                        0
                    ) AS total_reglements
                FROM
                    reglements
                WHERE
                    DATE (date_collecte) BETWEEN '2024-01-01' AND '2024-01-12'
                GROUP BY
                    id_carte,
                    DATE (date_collecte)
            ) AS bilan_reglements ON bilan_reglements.id_carte = cartes.id
            AND bilan_reglements.date_collecte = dates_collectes.date_collecte
        WHERE
            id_charge_compte = 9
    ) AS subquery
GROUP BY
    id_compte,
    id_client,
    nom_client,
    prenoms_client,
    id_charge_compte,
    nom_charge_compte,
    prenoms_charge_compte,
    date_collecte;