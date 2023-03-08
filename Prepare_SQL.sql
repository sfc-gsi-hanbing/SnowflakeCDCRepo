--Run the below SQLs in a Snowflake worksheet
create or replace database db_cdc;
alter database db_cdc set DATA_RETENTION_TIME_IN_DAYS =0;
use database db_cdc;

 --create source table
 create or replace table stg_site
  (id string,
   acct_id string,
   site_type string,
   address string
  );

 --create target table
   create or replace table dim_acct
  (  id string,
     address string,
     last_update_dt TIMESTAMP,
     insert_dt TIMESTAMP
  );

insert into stg_site values
('site0','acct0','BILL_TO','161 N Clark, Chicago, IL, 60601');

--Create a stream to capture changes(insert, delete and update) from stg_site table.
create or replace stream stm_site on table stg_site;

--query stm_site table, it should show no record as no actions happened toward stg_site.
--the reason you won't see site0 is because stream is created after the insert.
select * from stm_site;
