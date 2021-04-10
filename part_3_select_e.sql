WITH day_count(day, login_count) AS (
  SELECT
    TO_CHAR(created_at, 'Day') AS day,
    COUNT(*) as login_count
  FROM
    login_attempts
  GROUP BY
    1
)
SELECT
  day,
  login_count
FROM
  day_count
WHERE
  login_count =(
    SELECT
      MAX(login_count)
    FROM
      day_count
  );
