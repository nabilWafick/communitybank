CREATE OR REPLACE FUNCTION get_customers_types(
    customer_account_id bigint,
    collector_id bigint,
    type_id bigint
) 
RETURNS TABLE (
    id_type bigint,
    nom_type text,
    mise_type numeric,
    ids_charges_compte bigint[],
    charges_compte text[],
    ids_comptes_clients bigint[],
    ids_clients bigint[],
    clients text[],
    ids_cartes bigint[],
    libelles_cartes text[],
    nombres_types_cartes int[],
    totaux_reglements_cartes int[],
    montants_reglements_cartes numeric[]
) AS 
$$
BEGIN
    RETURN QUERY 
    SELECT 
        types.id AS id_type,
        types.nom AS nom_type,
        types.mise AS mise_type,
        COALESCE(ARRAY_AGG(subquery.id_charge_compte), ARRAY[]::BIGINT[]) AS ids_charges_compte,
        COALESCE(ARRAY_AGG(subquery.charge_compte), ARRAY[]::TEXT[]) AS charges_compte,
        COALESCE(ARRAY_AGG(subquery.id_compte_client), ARRAY[]::BIGINT[]) AS ids_comptes_clients,
        COALESCE(ARRAY_AGG(subquery.id_client), ARRAY[]::BIGINT[]) AS ids_clients,
        COALESCE(ARRAY_AGG(subquery.client), ARRAY[]::TEXT[]) AS clients,
        COALESCE(ARRAY_AGG(subquery.id_carte), ARRAY[]::BIGINT[]) AS ids_cartes,
        COALESCE(ARRAY_AGG(subquery.libelle_carte), ARRAY[]::TEXT[]) AS libelles_cartes,
        COALESCE(ARRAY_AGG(subquery.nombre_types), ARRAY[]::INT[]) AS nombres_types_cartes,
        COALESCE(ARRAY_AGG(subquery.total_reglements), ARRAY[]::INT[]) AS totaux_reglements_cartes,
        COALESCE(ARRAY_AGG(subquery.montant_reglements), ARRAY[]::NUMERIC[]) AS montants_reglements_cartes
    FROM 
        types
    LEFT JOIN (
        SELECT 
            comptes_clients.id AS id_compte_client,
            clients.id AS id_client,
            CONCAT(clients.nom, ' ', clients.prenoms) AS client,
            charges_compte.id AS id_charge_compte,
            CONCAT(charges_compte.nom, ' ', charges_compte.prenoms) AS charge_compte,
            cartes.id AS id_carte,
            cartes.libelle AS libelle_carte,
            cartes.nombre_types AS nombre_types,
            types.id AS id_type,
            types.nom AS nom_type,
            types.mise AS mise_type,
            COALESCE(bilan_reglements.total_reglements, 0) AS total_reglements,
            COALESCE(cartes.nombre_types * types.mise * bilan_reglements.total_reglements, 0) AS montant_reglements
        FROM 
            cartes
        LEFT JOIN 
            types ON cartes.id_type = types.id
        LEFT JOIN 
            comptes_clients ON cartes.id = ANY(comptes_clients.ids_cartes)
        LEFT JOIN 
            clients ON comptes_clients.id_client = clients.id
        LEFT JOIN 
            charges_compte ON comptes_clients.id_charge_compte = charges_compte.id
        LEFT JOIN (
            SELECT 
                id_carte,
                COALESCE(SUM(CASE WHEN est_valide THEN nombre ELSE 0 END), 0) AS total_reglements
            FROM 
                reglements
            GROUP BY 
                id_carte
        ) AS bilan_reglements ON bilan_reglements.id_carte = cartes.id
        WHERE 
            (collector_id IS NULL OR charges_compte.id = collector_id)
            AND (customer_account_id IS NULL OR comptes_clients.id = customer_account_id)
            AND (type_id IS NULL OR types.id = type_id)
        ORDER BY 
            id_type,
            nom_type,
            charge_compte,
            id_compte_client,
            id_client,
            client
    ) AS subquery ON types.id = subquery.id_type
    GROUP BY 
        types.id, subquery.id_type
    ORDER BY 
        types.nom ASC;
END;
$$
LANGUAGE plpgsql;
