DELETE FROM public.cartes c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM public.comptes_clients cc
        WHERE
            c.id = ANY (cc.ids_cartes)
    );