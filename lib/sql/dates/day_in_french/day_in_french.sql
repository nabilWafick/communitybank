CREATE OR REPLACE FUNCTION day_in_french(date_value DATE)
RETURNS TEXT AS $$
BEGIN
  CASE date_part('dow', date_value)
    WHEN 0 THEN RETURN 'Dimanche';
    WHEN 1 THEN RETURN 'Lundi';
    WHEN 2 THEN RETURN 'Mardi';
    WHEN 3 THEN RETURN 'Mercredi';
    WHEN 4 THEN RETURN 'Jeudi';
    WHEN 5 THEN RETURN 'Vendredi';
    WHEN 6 THEN RETURN 'Samedi';
    ELSE RETURN NULL;
  END CASE;
END;
$$ LANGUAGE plpgsql;
