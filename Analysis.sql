--Total Sales
Select
  sum(f.NumberOfItemsPurchased * di.CostPerItem) as total_revenue
from
  store.fact_orders f
    left join store.dim_items di
      on f.item_skey = di.item_skey;

--Sales Trend Over Time
select
  year(f.transactiontime),
  month(transactiontime),
  sum(f.NumberOfItemsPurchased * di.CostPerItem) as revenue
from
  store.fact_orders f
    left join store.dim_items di
      on f.item_skey = di.item_skey
group by
  1,
  2
order by
  1,
  2;

--Top-Selling Items
select
  di.ItemDescription,
  sum(f.numberofitemspurchased) as total_sold
from
  store.fact_orders f
  left join store.dim_items di on f.item_skey = di.item_skey
group by
  1
order by
  2 desc
limit
  10 
  
--Revenue by Country
select
  dc.country,
  sum(f.numberofitemspurchased * di.costperitem) as revenue_by_country
from
  store.fact_orders f
  left join store.dim_items di on f.item_skey = di.item_skey
  left join store.dim_country dc on f.country_skey = dc.country_skey
group by
  1
order by
  1 
  
--User Purchase Behaviour
select
  round(
    SUM(NumberOfItemsPurchased) / COUNT(TransactionId)
  ) item_per_transaction
from
  store.fact_orders;

--Customer Segmentation
select count(distinct UserID) as total_customers from store.dim_users;

--Peak Shopping Hours
SELECT
  CASE
    WHEN
      hour(transactiontime) >= 23
      OR hour(transactiontime) < 9
    THEN
      '11PM to 9AM'
    WHEN
      hour(transactiontime) >= 9
      AND hour(transactiontime) < 13
    THEN
      '9AM to 1PM'
    WHEN
      hour(transactiontime) >= 13
      AND hour(transactiontime) < 17
    THEN
      '1PM to 5PM'
    WHEN
      hour(transactiontime) >= 17
      AND hour(transactiontime) < 23
    THEN
      '5PM to 11PM'
  END AS time_range,
  COUNT(*) AS transaction_count
FROM
  store.fact_orders
GROUP BY
  time_range
ORDER BY
  transaction_count DESC;

--Top Revenue Contributing Items
select
  di.ItemDescription,
  SUM(f.NumberOfItemsPurchased * di.CostPerItem) as revenue_by_item
from
  store.fact_orders f
    left join store.dim_items di
      on f.item_skey = di.item_skey
group by
  1
order by
  2 desc
limit 10;