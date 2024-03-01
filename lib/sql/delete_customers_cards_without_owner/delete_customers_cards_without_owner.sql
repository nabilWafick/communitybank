DELETE FROM cartes
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            comptes_clients
        WHERE
            cartes.id = ANY (comptes_clients.ids_cartes)
    );