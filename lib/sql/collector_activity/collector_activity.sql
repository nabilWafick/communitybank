CREATE OR REPLACE FUNCTION get_customer_periodic_activity
(collection_begin_date TEXT, collection_end_date TEXT
, collector_id BIGINT, settlements_total INT, customer_account_id 
BIGINT) RETURNS TABLE(date_collecte DATE, id_compte_client 
BIGINT, id_client BIGINT, nom_client TEXT, prenoms_client 
TEXT, id_charge_compte BIGINT, nom_charge_compte TEXT, 
prenoms_charge_compte TEXT, ids_cartes BIGINT[], libelles_cartes TEXT[], 
nombres_types_cartes INT[], ids_types BIGINT[], noms_types TEXT[], totaux_reglements_cartes 
BIGINT[], montants_reglements_cartes NUMERIC[]) AS 
$$
BEGIN
	RETURN QUERY
	SELECT
	    subquery.date_collecte,
	    subquery.id_compte_client,
	    subquery.id_client,
	    subquery.nom_client,
	    subquery.prenoms_client,
	    subquery.id_charge_compte,
	    subquery.nom_charge_compte,
	    subquery.prenoms_charge_compte,
	    ARRAY_AGG (subquery.id_carte) AS ids_cartes,
	    ARRAY_AGG (subquery.libelle_carte) AS libelles_cartes,
	    ARRAY_AGG (subquery.nombre_types) AS nombres_types_cartes,
	    ARRAY_AGG (subquery.id_type) AS ids_types,
	    ARRAY_AGG (subquery.nom_type) AS noms_types,
	    ARRAY_AGG (subquery.total_reglements) AS totaux_reglements_cartes,
	    ARRAY_AGG (subquery.montant_reglements) AS montants_reglements_cartes
	FROM (
	        SELECT
	            comptes_clients.id AS id_compte_client, clients.id AS id_client, clients.nom AS nom_client, clients.prenoms AS prenoms_client, charges_compte.id AS id_charge_compte, charges_compte.nom AS nom_charge_compte, charges_compte.prenoms AS prenoms_charge_compte, cartes.id AS id_carte, cartes.libelle AS libelle_carte, cartes.nombre_types AS nombre_types, types.id AS id_type, types.nom AS nom_type, COALESCE(
	                bilan_reglements.total_reglements, 0
	            ) AS total_reglements, COALESCE(
	                nombre_types * types.mise * bilan_reglements.total_reglements, 0
	            ) AS montant_reglements, dates_collectes.date_collecte AS date_collecte
	        FROM
	            comptes_clients
	            LEFT JOIN clients ON comptes_clients.id_client = clients.id
	            LEFT JOIN charges_compte ON comptes_clients.id_charge_compte = charges_compte.id
	            LEFT JOIN cartes ON cartes.id = ANY (comptes_clients.ids_cartes)
	            LEFT JOIN types ON cartes.id_type = types.id
	            LEFT JOIN (
	                SELECT DISTINCT
	                    DATE(reglements.date_collecte) AS date_collecte
	                FROM reglements
	                WHERE (
	                        collection_begin_date IS NULL
	                        OR DATE(reglements.date_collecte) > = DATE(collection_begin_date)
	                    )
	                    AND (
	                        collection_end_date IS NULL
	                        OR DATE(reglements.date_collecte) < = DATE(collection_end_date)
	                    )
	            ) AS dates_collectes ON TRUE
	            LEFT JOIN (
	                SELECT
	                    id_carte, DATE(reglements.date_collecte) AS date_collecte, COALESCE(
	                        SUM(
	                            CASE
	                                WHEN est_valide THEN nombre
	                                ELSE 0
	                            END
	                        ), 0
	                    ) AS total_reglements
	                FROM reglements
	                WHERE (
	                        collection_begin_date IS NULL
	                        OR collection_end_date IS NULL
	                        OR (
	                            DATE(reglements.date_collecte) BETWEEN DATE(collection_begin_date) AND DATE(collection_end_date)
	                        )
	                    )
	                GROUP BY
	                    id_carte, DATE(reglements.date_collecte)
	            ) AS bilan_reglements ON bilan_reglements.id_carte = cartes.id
	            AND bilan_reglements.date_collecte = dates_collectes.date_collecte
	        WHERE (
	                collector_id IS NULL
	                OR comptes_clients.id_charge_compte = collector_id
	            )
	            AND (
	                settlements_total IS NULL
	                OR total_reglements = settlements_total
	            )
	            AND (
	                customer_account_id IS NULL
	                OR comptes_clients.id = customer_account_id
	            )
	    ) AS subquery
	GROUP BY
	    subquery.date_collecte,
	    subquery.id_compte_client,
	    subquery.id_client,
	    subquery.nom_client,
	    subquery.prenoms_client,
	    subquery.id_charge_compte,
	    subquery.nom_charge_compte,
	    subquery.prenoms_charge_compte;
END;
$$
LANGUAGE
plpgsql; 