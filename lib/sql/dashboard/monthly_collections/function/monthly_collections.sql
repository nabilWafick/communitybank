
create
or replace function get_monthly_collections () returns table (
  jour text,
  date_collecte timestamp with time zone,
  montant_collecte numeric
) as $$
BEGIN
RETURN QUERY
select
  jours.jour, dates_mois as date_collecte,
  coalesce(current_month_collections.montant_collecte, 0) as montant_collecte
  from jours
  inner join 
  get_dates_in_month(EXTRACT(MONTH FROM CURRENT_DATE)::INTEGER, EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER)as dates_mois
  on 
   date_part('dow', dates_mois) = jours.numero_semaine
  left join (
    select
      DATE (date_collecte) as date_collecte,
      SUM(montant) as montant_collecte
    from
      collectes
    where
      extract(
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
      date_collecte
    order by
      date_collecte
  ) as current_month_collections on DATE(current_month_collections.date_collecte) = DATE(dates_mois)
order by
  dates_mois;
END;
$$ language plpgsql;