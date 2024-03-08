

create
or replace function get_collectors_weekly_collections () returns table (
  jour text,
  date_collecte timestamp with time zone,
  ids_charges_compte bigint[],
  charges_comptes text[],
  montants_collectes real[]
) as $$
BEGIN
RETURN QUERY
select
    jours.jour,
    get_day_date (jours.numero_semaine) as date_collecte,
    ARRAY_AGG (charges_compte.id) as ids_charges_compte,
    ARRAY_AGG (
        CONCAT (charges_compte.nom, ' ', charges_compte.prenoms)
    ) as charges_comptes,
    ARRAY_AGG (coalesce(collections_data.montant_collecte, 0)) as montants_collectes
from
    jours
    cross join charges_compte
    left join (
        select
            jours.jour,
            current_week_collections.id_charge_compte,
            get_day_date (jours.numero_semaine) as date_collecte,
            coalesce(current_week_collections.montant_collecte, 0) as montant_collecte
        from
            jours
            left join (
                select
                    id_charge_compte,
                    DATE (date_collecte) as date_collecte,
                    SUM(montant) as montant_collecte
                from
                    collectes
                where
                    extract(
                        WEEK
                        from
                            date_collecte
                    ) = extract(
                        WEEK
                        from
                            CURRENT_DATE
                    )
                    and extract(
                        MONTH
                        from
                            date_collecte
                    ) = extract(
                        MONTH
                        from
                            CURRENT_DATE
                    )
                    and extract(
                        YEAR
                        from
                            date_collecte
                    ) = extract(
                        YEAR
                        from
                            CURRENT_DATE
                    )
                group by
                    date_collecte,
                    id_charge_compte
                order by
                    date_collecte,
                    id_charge_compte
            ) as current_week_collections on date_part ('dow', current_week_collections.date_collecte) = jours.numero_semaine
        order by
            jours.numero_semaine
    ) as collections_data on collections_data.id_charge_compte = charges_compte.id
    and collections_data.date_collecte = get_day_date (jours.numero_semaine)
group by
    jours.numero_semaine,
    jours.jour
order by
    jours.numero_semaine;
END;
$$ language plpgsql;