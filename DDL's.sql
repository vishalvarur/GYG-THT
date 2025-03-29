create or replace table stg_orders
(
  UserId integer
  ,TransactionId integer
  ,TransactionTime varchar(255)
  ,ItemCode integer
  ,ItemDescription varchar(255)
  ,NumberOfItemsPurchased integer
  ,CostPerItem decimal(18,2)
  ,Country varchar(100)
  ,load_date timestamp
);


create or replace table dim_users
(
user_skey integer,
userID integer,
load_date timestamp
);


create or replace table dim_items
(
item_skey integer,
ItemCode integer,
ItemDescription varchar(255),
CostPerItem decimal(18,2),
load_date timestamp
);

create or replace table dim_country
(
country_skey integer,
country varchar(100),
load_date timestamp
);

create or replace table fact_orders
(
key integer,
TransactionId integer,
TransactionTime timestamp,
user_skey integer,
item_skey integer,
NumberOfItemsPurchased integer,
country_skey integer,
load_date timestamp
);


