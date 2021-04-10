SELECT
  CASE WHEN approval_status = 0 THEN 'Pending approval' WHEN approval_status = 1 THEN 'Approved' ELSE 'Rejected' END AS account_status,
  COUNT(*) AS number_of_accounts
FROM
  users
GROUP BY
  account_status;
