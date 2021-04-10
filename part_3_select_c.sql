WITH account_purchases(id, purchase_count)
AS
(
  SELECT
    a.id,
    SUM(a.purchase) AS purchase_count
  FROM
    (
      SELECT
        u.id AS id,
        CASE WHEN p.id IS NULL THEN 0 else 1 END AS purchase
      FROM
        users u
        left join purchases p on u.id = p.user_id
      WHERE
        u.approval_status = 2
    ) a
  GROUP BY
    1
)
SELECT
  CASE WHEN purchase_count = 0 THEN '0'
    WHEN purchase_count > 0 AND purchase_count <= 5 THEN '1 to 5'
    ELSE '6 or more' END AS account_purchase_bucket,
  CEIL(COUNT(*)/(SELECT SUM(purchase_count) FROM account_purchases)*100) AS percentage
FROM
  account_purchases
GROUP BY
  1;
