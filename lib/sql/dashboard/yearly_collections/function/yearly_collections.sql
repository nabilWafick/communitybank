create
or replace function get_yearly_collections () returns table (mois text, montant_collecte numeric) as $$
BEGIN
    RETURN QUERY
    select
        mois.mois,
        coalesce(current_year_collections.montant_collecte, 0) as montant_collecte
    from
        mois
        left join (
            select
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
                )
            order by
                extract(
                    MONTH
                    from
                        date_collecte
                )
        ) as current_year_collections on mois.numero_annee = current_year_collections.numero_mois;
END;
$$ language plpgsql;