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
        LEFT JOIN purchases p on u.id = p.user_id
      WHERE
        u.approval_status = 1
    ) a
  GROUP BY
    1
),
purchase_buckets(account_purchase_bucket, bucket_count)
AS
(
  SELECT
    CASE WHEN purchase_count = 0 THEN '0'
      WHEN purchase_count > 0 AND purchase_count <= 5 THEN '1 to 5'
      ELSE '6 or more' END AS account_purchase_bucket,
    COUNT(*) AS bucket_count
  FROM
    account_purchases
  GROUP BY
    1
)
SELECT
  account_purchase_bucket,
  CEIL(bucket_count/(SELECT SUM(bucket_count) FROM purchase_buckets)*100) AS percentage
FROM
  purchase_buckets;
