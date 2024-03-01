CREATE OR REPLACE FUNCTION get_customers_products(
    customer_account_id bigint,
    product_id bigint
) 
RETURNS TABLE (
    id_produit bigint,
    nom_produit text,
    ids_comptes_clients bigint[],
    ids_clients bigint[],
    clients text[]
) AS 
$$
BEGIN
    RETURN QUERY 
    SELECT
        produits.id AS id_produit,
        produits.nom AS nom_produit,
        COALESCE(ARRAY_AGG(comptes_clients.id), ARRAY[]::bigint[]) AS ids_comptes_clients,
        COALESCE(ARRAY_AGG(clients.id), ARRAY[]::bigint[]) AS ids_clients,
        COALESCE(ARRAY_AGG(CONCAT(clients.nom, ' ', clients.prenoms)), ARRAY[]::text[]) AS clients
    FROM
        produits
    LEFT JOIN 
        types ON produits.id = ANY(types.ids_produits)
    LEFT JOIN 
        cartes ON types.id = cartes.id_type
    LEFT JOIN 
        comptes_clients ON cartes.id = ANY(comptes_clients.ids_cartes)
    LEFT JOIN 
        clients ON comptes_clients.id_client = clients.id
    LEFT JOIN 
        charges_compte ON comptes_clients.id_charge_compte = charges_compte.id
    WHERE
        (produits.id = product_id OR product_id IS NULL)
        AND (comptes_clients.id = customer_account_id OR customer_account_id IS NULL)
    GROUP BY
        produits.id,
        produits.nom
    ORDER BY
        produits.nom ASC; 
END;
$$
LANGUAGE plpgsql;
