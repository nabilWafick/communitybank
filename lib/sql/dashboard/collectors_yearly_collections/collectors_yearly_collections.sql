select
    mois.mois,
    ARRAY_AGG (charges_compte.id) as ids_charges_compte,
    ARRAY_AGG (
        CONCAT (charges_compte.nom, ' ', charges_compte.prenoms)
    ) as charges_compte,
    ARRAY_AGG (COALESCE(collections_data.montant_collecte, 0)) AS montants_collectes
from
    mois
    cross join charges_compte
    left join (
        select
            current_year_collections.numero_mois,
            mois.mois,
            current_year_collections.id_charge_compte,
            coalesce(current_year_collections.montant_collecte, 0) as montant_collecte
        from
            mois
            left join (
                select
                    id_charge_compte,
                    extract(
                        MONTH
                        from
                            date_collecte
                    ) as numero_mois,
                    SUM(montant) as montant_collecte
                from
                    collectes
                where
                    extract(
                        YEAR
                        from
                            date_collecte
                    ) = extract(
                        YEAR
                        from
                            CURRENT_DATE
                    )
                group by
                    extract(
                        MONTH
                        from
                            date_collecte
                    ),
                    id_charge_compte
                order by
                    extract(
                        MONTH
                        from
                            date_collecte
                    ),
                    id_charge_compte
            ) as current_year_collections on mois.numero_annee = current_year_collections.numero_mois
    ) as collections_data on mois.numero_annee = collections_data.numero_mois
    and charges_compte.id = collections_data.id_charge_compte
group by
    mois.mois,
    mois.numero_annee
order by
    mois.numero_annee;