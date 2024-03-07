CREATE OR REPLACE FUNCTION get_day_date(day_week_number INTEGER)
RETURNS TIMESTAMP WITH TIME ZONE AS $$
DECLARE
  -- Get current date's week number
  current_date_week_number INTEGER := date_part('dow', CURRENT_DATE);
  -- Calculate the offset from today's weekday
  offset_days INTEGER := (day_week_number - current_date_week_number) % 7;
BEGIN
    -- check if the day_week_number is valid
    IF day_week_number < 0 OR day_week_number > 6 THEN
    RAISE EXCEPTION 'Invalid day. Please enter a value between 0 and 6.';
    END IF;
  -- Add the offset to today's date to get the desired date
  RETURN now() + INTERVAL '1 day' * offset_days;
END;
$$ LANGUAGE plpgsql;

SELECT get_day_date(1) AS date_jour;