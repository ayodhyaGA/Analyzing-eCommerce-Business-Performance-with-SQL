-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.customers_dataset
(
    customer_id character varying COLLATE pg_catalog."default",
    """customer_unique_id""" character varying COLLATE pg_catalog."default",
    """customer_zip_code_prefix""" numeric,
    """customer_city""" character varying COLLATE pg_catalog."default",
    """customer_state""" character varying COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public.geolocation_dataset
(
    geolocation_zip_code_prefix numeric,
    """geolocation_lat""" double precision,
    """geolocation_lng""" double precision,
    """geolocation_city""" character varying COLLATE pg_catalog."default",
    """geolocation_state""" character varying COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public.order_items_dataset
(
    order_id character varying COLLATE pg_catalog."default",
    """order_item_id""" numeric,
    """product_id""" character varying COLLATE pg_catalog."default",
    """seller_id""" character varying COLLATE pg_catalog."default",
    """shipping_limit_date""" timestamp with time zone,
    """price""" double precision,
    """freight_value""" double precision
);

CREATE TABLE IF NOT EXISTS public.order_payments_dataset
(
    order_idorder_id character varying COLLATE pg_catalog."default",
    """payment_sequential""" numeric,
    """payment_type""" character varying COLLATE pg_catalog."default",
    """payment_installments""" numeric,
    """payment_value""" double precision
);

CREATE TABLE IF NOT EXISTS public.order_reviews_dataset
(
    review_id character varying COLLATE pg_catalog."default",
    """order_id""" character varying COLLATE pg_catalog."default",
    """review_score""" numeric,
    """review_comment_title""" character varying COLLATE pg_catalog."default",
    """review_comment_message""" character varying COLLATE pg_catalog."default",
    """review_creation_date""" timestamp without time zone,
    """review_answer_timestamp""" timestamp without time zone
);

CREATE TABLE IF NOT EXISTS public.orders_dataset
(
    order_id character varying COLLATE pg_catalog."default",
    """customer_id""" character varying COLLATE pg_catalog."default",
    """order_status""" character varying COLLATE pg_catalog."default",
    """order_purchase_timestamp""" timestamp without time zone,
    """order_approved_at""" timestamp without time zone,
    """order_delivered_carrier_date""" timestamp without time zone,
    """order_delivered_customer_date""" timestamp without time zone,
    """order_estimated_delivery_date""" timestamp without time zone
);

CREATE TABLE IF NOT EXISTS public.product_dataset
(
    "number" numeric,
    product_id character varying COLLATE pg_catalog."default",
    product_category_name character varying COLLATE pg_catalog."default",
    product_name_lenght double precision,
    product_description_lenght double precision,
    product_photos_qty double precision,
    product_weight_g double precision,
    product_length_cm double precision,
    product_height_cm double precision,
    product_width_cm double precision
);

CREATE TABLE IF NOT EXISTS public.sellers_dataset
(
    seller_id character varying COLLATE pg_catalog."default",
    """seller_zip_code_prefix""" numeric,
    """seller_city""" character varying COLLATE pg_catalog."default",
    """seller_state""" character varying COLLATE pg_catalog."default"
);
END;
		
--MENGECEK KOLOM PRODUCT_ID--
select * from product_dataset where product_id in (select product_id from (
select product_id, count(*)
from product_dataset
group by product_id
HAVING count(*) > 1) as foo);

select * from order_items_dataset where product_id in (select product_id from (
select product_id, count(*)
from order_items_dataset
group by product_id
HAVING count(*) > 1) as foo);

--Mengecek ID antar tabel 
SELECT pd.product_id 
FROM product_dataset as PD
INNER JOIN order_items_dataset as OID
ON (PD.product_id = OID.product_id);

/*Kesimpulan Product_id dari product_dataset one to many, dikarenakan 
Product_id dari order_items_dataset terdapat duplikat */

--MENGECEK KOLOM SELLER_ID--
select * from order_items_dataset where seller_id in (select seller_id from (
select seller_id, count(*)
from order_items_dataset
group by seller_id
HAVING count(*) > 1) as foo);

select * from sellers_dataset where seller_id in (select seller_id from (
select seller_id, count(*)
from sellers_dataset
group by seller_id
HAVING count(*) > 1) as foo);

--Mengecek ID antar tabel 
SELECT SD.seller_id 
FROM sellers_dataset as SD
INNER JOIN order_items_dataset as OID
ON (SD.seller_id = OID.seller_id);

/*Kesimpulan seller_id dari sellers_dataset one to many
dikarenakan seller_id dari order_items_dataset terdapat duplikat */

--MENGECEK KOLOM ORDER_ID--
select * from orders_dataset where order_id in (select order_id from (
select order_id, count(*)
from orders_dataset
group by order_id
HAVING count(*) > 1) as foo);
--tidak ada duplikat

select * from order_items_dataset where order_id in (select order_id from (
select order_id, count(*)
from order_items_dataset
group by order_id
HAVING count(*) > 1) as foo);
--terdapat duplikat

select * from order_payments_dataset where order_id in (select order_id from (
select order_id, count(*)
from order_payments_dataset
group by order_id
HAVING count(*) > 1) as foo);
--terdapat duplikat

select * from order_reviews_dataset where order_id in (select order_id from (
select order_id, count(*)
from order_reviews_dataset
group by order_id
HAVING count(*) > 1) as foo);
--terdapat duplikat

--Mengecek ID antar tabel 
SELECT OD.order_id 
FROM orders_dataset as OD
INNER JOIN order_items_dataset as OID
ON (OD.order_id = OID.order_id)
INNER JOIN order_payments_dataset as OPD
ON (OD.order_id = OPD.order_id)
INNER JOIN order_reviews_dataset as ORD
ON (OD.order_id = ORD.order_id);
/*Kesimpulan order_id dari orders_dataset one to many dikarenakan pada tabel
order_items_dataset, order_payments_dataset dan order_reviews_dataset terdapat duplikat*/

--MENGECEK KOLOM CUSTOMER_ID--
select * from orders_dataset where customer_id in (select customer_id from (
select customer_id, count(*)
from orders_dataset
group by customer_id
HAVING count(*) > 1) as foo);
-- tidak terdapat duplikat

select * from customers_dataset where customer_id in (select customer_id from (
select customer_id, count(*)
from customers_dataset
group by customer_id
HAVING count(*) > 1) as foo);
-- tidak terdapat duplikat

--Mengecek ID antar tabel 
SELECT OD.customer_id 
FROM orders_dataset as OD
INNER JOIN customers_dataset as CD
ON (OD.customer_id = CD.customer_id);
-- Kesimpulan customer_id one to one karena dari kedua tabel tidak terdapat duplikat

--MENGECEK KOLOM ZIP_CODE_PREFIX--
select * from customers_dataset where customer_zip_code_prefix in (select customer_zip_code_prefix from (
select customer_zip_code_prefix, count(*)
from customers_dataset
group by customer_zip_code_prefix
HAVING count(*) > 1) as foo);
--terdapat duplikat

select * from geolocation_dataset where geolocation_zip_code_prefix in (select geolocation_zip_code_prefix from (
select geolocation_zip_code_prefix, count(*)
from geolocation_dataset
group by geolocation_zip_code_prefix
HAVING count(*) > 1) as foo);
--terdapat duplikat

select * from sellers_dataset where seller_zip_code_prefix in (select seller_zip_code_prefix from (
select seller_zip_code_prefix, count(*)
from sellers_dataset
group by seller_zip_code_prefix
HAVING count(*) > 1) as foo);
--terdapat duplikat

SELECT CD.customer_zip_code_prefix, GD.geolocation_zip_code_prefix, SD.seller_zip_code_prefix
FROM customers_dataset as CD
INNER JOIN geolocation_dataset as GD
ON (CD.customer_zip_code_prefix = GD.geolocation_zip_code_prefix)
INNER JOIN sellers_dataset as SD
ON (CD.customer_zip_code_prefix = SD.seller_zip_code_prefix);
--Kesimpulan many to many

--customize primary key
alter table product_dataset add constraint pk_products primary key (product_id);
alter table customers_dataset add constraint pk_cust primary key (customer_id);
alter table geolocation_dataset add constraint pk_geo primary key (geo_zip_code_prefix);
alter table orders_dataset add constraint pk_orders primary key (order_id);
alter table sellers_dataset add constraint pk_seller primary key (seller_id);

--customize foreign key
alter table customers_dataset add foreign key (customer_zip_code_prefix) references geolocation;
alter table orders_dataset add foreign key (customer_id) references customers;
alter table order_items_dataset add foreign key (order_id) references orders;
alter table order_items_dataset add foreign key (seller_id) references sellers;
alter table order_items_dataset add foreign key (product_id) references products;
alter table sellers_dataset add foreign key (seller_zip_code_prefix) references geolocation;
alter table payments_dataset add foreign key (order_id) references orders;
alter table reviews_dataset add foreign key (order_id) references orders; 














