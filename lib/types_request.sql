SELECT
    types.id,
    types.nom,
    ARRAY_AGG (DISTINCT comptes_clients.id) AS ids_comptes_clients,
    ARRAY_AGG (DISTINCT clients.id) AS ids_clients,
    ARRAY_AGG (DISTINCT clients.nom) AS noms_clients,
    ARRAY_AGG (DISTINCT clients.prenoms) AS prenoms_clients
FROM
    comptes_clients
    JOIN clients ON comptes_clients.id_client = clients.id
    JOIN charges_compte ON comptes_clients.id_charge_compte = charges_compte.id
    JOIN cartes ON cartes.id = ANY (comptes_clients.ids_cartes)
    JOIN types ON cartes.id_type = types.id
GROUP BY
    types.id,
    types.nom
ORDER BY
    types.nom ASC;