CREATE OR REPLACE FUNCTION get_dates_in_month(target_month INTEGER, target_year INTEGER, target_timezone TEXT DEFAULT 'UTC')
RETURNS SETOF TIMESTAMP WITH TIME ZONE AS $$
DECLARE
  date_to_check TIMESTAMP WITH TIME ZONE;
  day_count INTEGER := 31;  -- Initial assumption (adjusted later)
BEGIN
  -- Check if month is valid (1-12)
  IF target_month < 1 OR target_month > 12 THEN
    RAISE EXCEPTION 'Invalid month. Please enter a value between 1 and 12.';
  END IF;

  -- Get the first day of the target month at the specified timezone
  date_to_check := date_trunc('month', to_timestamp(target_year || '-' || target_month || '-01', 'YYYY-MM-DD')) AT TIME ZONE target_timezone;

  -- Adjust day count based on month and year (considering leap years)
  IF target_month IN (4, 6, 9, 11) THEN
    day_count := 30;
  ELSEIF target_month = 2 THEN
    IF EXTRACT(YEAR FROM date_to_check) % 4 = 0 AND (EXTRACT(YEAR FROM date_to_check) % 100 <> 0 OR EXTRACT(YEAR FROM date_to_check) % 400 = 0) THEN
      day_count := 29;  -- Leap year
    ELSE
      day_count := 28;
    END IF;
  END IF;

  -- Generate series of days and filter for the target month
  RETURN QUERY 
  SELECT dates as dates
  FROM (
    SELECT generate_series(date_to_check, date_to_check + INTERVAL '1 day' * (day_count - 1), '1 day') AS dates
  ) AS dates_series
  WHERE EXTRACT(MONTH FROM dates) = target_month;
END;
$$ LANGUAGE plpgsql;

-- Example usage with default timezone
SELECT * FROM get_dates_in_month(3, 2024);

-- Example usage with specific timezone
--SELECT * FROM get_dates_in_month(5, 2024, 'America/Los_Angeles');
