*********************************************Import data***********************************************;
*******************************************************************************************************;
proc import datafile='	
/home/u63790845/My SAS Program/dataset/olist_customers_dataset.csv'
    out=olist_customers
    dbms=csv
    replace;
run;

proc import datafile='	
/home/u63790845/My SAS Program/dataset/olist_geolocation_dataset.csv'
    out=olist_geolocation
    dbms=csv
    replace;
run;

proc import datafile='	
/home/u63790845/My SAS Program/dataset/olist_orders_dataset.csv'
    out=olist_orders
    dbms=csv
    replace;
run;

proc import datafile='	
/home/u63790845/My SAS Program/dataset/olist_order_items_dataset.csv'
    out=olist_order_items
    dbms=csv
    replace;
run;

proc import datafile='	
/home/u63790845/My SAS Program/dataset/olist_products_dataset.csv'
    out=olist_products
    dbms=csv
    replace;
run;

proc import datafile='	
/home/u63790845/My SAS Program/dataset/product_category_name_translation.csv'
    out=product_category_name_translation
    dbms=csv
    replace;
run;

****************************************************************************************************************;
*********************************************Data Manipulation and Merging**************************************;
****************************************************************************************************************;

proc sql;
    create table geoloc as
    select geolocation_zip_code_prefix, mean(geolocation_lat) as geolocation_lat, mean(geolocation_lng) as geolocation_lng
    from olist_geolocation
    group by geolocation_zip_code_prefix;
quit;

proc sql;
    create table customer_data as
    select a.*, b.geolocation_lat, b.geolocation_lng
    from olist_customers a
    left join geoloc b
    on a.customer_zip_code_prefix = b.geolocation_zip_code_prefix;
quit;

proc sql;
    create table complete_order as
    select a.*, b.customer_id, b.order_purchase_timestamp, b.price, b.freight_value
    from olist_orders a
    inner join olist_order_items b
    on a.order_id = b.order_id;
quit;

proc sql;
    create table cust_orders as
    select a.*, b.customer_unique_id
    from complete_order a
    inner join olist_customers b
    on a.customer_id = b.customer_id;
quit;

proc sql;
    create table products as
    select a.*, b.product_category_name_english
    from olist_products a
    left join product_category_name_translation b
    on a.product_category_name = b.product_category_name;
quit;

proc sql;
    create table cust_order as
    select a.*, b.product_category_name_english
    from cust_orders a
    inner join products b
    on a.product_id = b.product_id;
quit;

data txn_data;
    set cust_order;
    array cats {*} catg_:;
    do over cats;
        cats = 0;
    end;
    do i = 1 to dim(cats);
        if cats(i) = product_category_name_english then cats(i) = 1;
    end;
    drop i;
run;

proc transpose data=txn_data out=txn_data_t;
    by customer_unique_id order_purchase_timestamp;
    var catg_:;
run;

******************************************************************************************************************;
*********************************************Data Manipulation and Merging****************************************;
******************************************************************************************************************;


proc export data=customer_data
    outfile='/home/u63790845/My SAS Program/generated_dataset/customer_data.csv'
    dbms=csv
    replace;
run;

proc export data=cust_order
    outfile='/home/u63790845/My SAS Program/generated_dataset/customer_order.csv'
    dbms=csv
    replace;
run;

proc export data=txn_data_t
    outfile='/home/u63790845/My SAS Program/generated_dataset/transaction_data.csv'
    dbms=csv
    replace;
run;
