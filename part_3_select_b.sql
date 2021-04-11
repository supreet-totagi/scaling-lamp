SELECT
  A.user_id,
  CASE WHEN A.login_count IS NULL THEN 0 ELSE A.login_count END AS total_logins,
  CASE WHEN B.purchase_count IS NULL THEN 0 ELSE B.purchase_count END AS total_purchases
FROM
  (
    SELECT
      user_id,
      COUNT(*) AS login_count
    FROM
      login_attempts
    WHERE
      is_success = true
    GROUP BY
      user_id
  ) A FULL
  OUTER JOIN (
    SELECT
      user_id,
      COUNT(*) AS purchase_count
    FROM
      purchases
    GROUP BY
      user_id
  ) B ON A.user_id = B.user_id;
