
create
or replace function get_collectors_monthly_collections () returns table (
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
  dates_mois as date_collecte,
  ARRAY_AGG(charges_compte.id) as ids_charges_compte,
  ARRAY_AGG(
    CONCAT(charges_compte.nom, ' ', charges_compte.prenoms)
  ) as charges_comptes,
  ARRAY_AGG(coalesce(collections_data.montant_collecte, 0)) as montants_collectes
from
  jours
  inner join get_dates_in_month (
    EXTRACT(
      MONTH
      FROM
        CURRENT_DATE
    )::INTEGER,
    EXTRACT(
      YEAR
      FROM
        CURRENT_DATE
    )::INTEGER
  ) as dates_mois on date_part('dow', dates_mois) = jours.numero_semaine
  cross join charges_compte
  left join (
    select
      jours.jour,
      dates_mois as date_collecte,
      current_month_collections.id_charge_compte,
      coalesce(current_month_collections.montant_collecte, 0) as montant_collecte
    from
      jours
      inner join get_dates_in_month (
        EXTRACT(
          MONTH
          FROM
            CURRENT_DATE
        )::INTEGER,
        EXTRACT(
          YEAR
          FROM
            CURRENT_DATE
        )::INTEGER
      ) as dates_mois on date_part('dow', dates_mois) = jours.numero_semaine
      left join (
        select
          id_charge_compte,
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
          date_collecte,
          id_charge_compte
        order by
          date_collecte,
          id_charge_compte
      ) as current_month_collections on DATE (current_month_collections.date_collecte) = DATE (dates_mois)
    order by
      dates_mois
  ) as collections_data on collections_data.id_charge_compte = charges_compte.id
  and collections_data.date_collecte = dates_mois
group by
  jours.numero_semaine,
  jours.jour,
  dates_mois.dates_mois
order by
  dates_mois.dates_mois;
END;
$$ language plpgsql;