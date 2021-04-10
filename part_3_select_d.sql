SELECT
  f.name AS food,
  p.quantity AS total_quantity
FROM
  (
    SELECT
      food_id,
      quantity,
      ROW_NUMBER() OVER (
        ORDER BY
          quantity desc
      ) AS rank
    FROM
      (
        SELECT 
          food_id,
          sum(quantity) AS quantity
        FROM
          purchases
        GROUP BY
          1
      ) a
  ) p
  LEFT JOIN food_inventory f on p.food_id = f.id
WHERE
  p.rank = 3;
