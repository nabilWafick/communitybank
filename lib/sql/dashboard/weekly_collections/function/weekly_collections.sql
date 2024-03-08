create
or replace function get_weekly_collections () returns table (
  jour text,
  date_collecte timestamp with time zone,
  montant_collecte numeric
) as $$
BEGIN
RETURN QUERY
select
jours.jour,
get_day_date (jours.numero_semaine) as date_collecte,
coalesce(current_week_collections.montant_collecte, 0) as montant_collecte
from
jours
left join (
select
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
date_collecte
order by
date_collecte
) as current_week_collections on date_part ('dow', current_week_collections.date_collecte) = jours.numero_semaine
order by
jours.numero_semaine;
END;
$$ language plpgsql;
