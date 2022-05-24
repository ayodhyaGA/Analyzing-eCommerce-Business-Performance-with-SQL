/*
1. Membuat tabel yang berisi informasi pendapatan/revenue perusahaan total untuk masing-masing tahun (Hint: Revenue adalah harga barang dan juga biaya kirim. Pastikan juga melakukan filtering terhadap order status yang tepat untuk menghitung pendapatan)
2. Membuat tabel yang berisi informasi jumlah cancel order total untuk masing-masing tahun (Hint: Perhatikan filtering terhadap order status yang tepat untuk menghitung jumlah cancel order)
3. Membuat tabel yang berisi nama kategori produk yang memberikan pendapatan total tertinggi untuk masing-masing tahun (Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan)
4. Membuat tabel yang berisi nama kategori produk yang memiliki jumlah cancel order terbanyak untuk masing-masing tahun (Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan)
5. Menggabungkan informasi-informasi yang telah didapatkan ke dalam satu tampilan tabel (Hint: Perhatikan teknik join yang dilakukan serta kolom-kolom yang dipilih)
*/

--Nomor 1 
select * from order_payments_dataset;
select * from order_items_dataset;

create table if not exists revenue_year as (
select year, sum(revenue) as total_revenue 
from
(select date_part('year', od.order_purchase_timestamp) as year,
		oid.price + oid.freight_value as revenue
		from orders_dataset od
		join order_items_dataset oid 
		on oid.order_id=od.order_id
		where od.order_status = 'delivered') a
group by 1);

--2. Membuat tabel yang berisi informasi jumlah cancel order total untuk masing-masing tahun
select order_status, count(order_id) from orders_dataset
group by 1;

create table if not exists cancel_order_year as (
select date_part('year', order_purchase_timestamp) as year,
		count(distinct order_id) as total_cancel
		from orders_dataset 
		where order_status = 'canceled'
group by 1);

--3. Membuat tabel yang berisi nama kategori produk yang memberikan pendapatan total tertinggi untuk masing-masing tahun (Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan)
select product_category_name, count(distinct product_id) from product_dataset
group by 1;

create table if not exists rank_product_revenue as( 
select year, product_category_name, revenue
from (
select 
	date_part('year', od.order_purchase_timestamp) as year,
	pd.product_category_name,
	rank() over(partition by date_part('year', od.order_purchase_timestamp) 
	order by sum(oid.price + oid.freight_value) desc) as product_rank,
	sum(oid.price + oid.freight_value) as revenue
from orders_dataset od
		join order_items_dataset oid 
		on oid.order_id=od.order_id
		join product_dataset as pd
		on oid.product_id = pd.product_id
		where od.order_status = 'delivered' 
		group by 1,2) a
where product_rank = 1);
		
--4. Membuat tabel yang berisi nama kategori produk yang memiliki jumlah cancel order terbanyak untuk masing-masing tahun (Hint: Perhatikan penggunaan window function dan juga filtering yang dilakukan)	
	
create table if not exists rank_cancel_order as (
select year, product_category_name, total_cancel
from (
	select 
		date_part('year', order_purchase_timestamp) as year,
		pd.product_category_name,
		rank() over(partition by date_part('year', od.order_purchase_timestamp) 
		order by count(distinct od.order_id) desc) as cancel_rank,
		count(distinct od.order_id) as total_cancel
	from orders_dataset od
	join order_items_dataset oid 
	on oid.order_id=od.order_id
	join product_dataset as pd
	on oid.product_id = pd.product_id
	where order_status = 'canceled'
	group by 1,2) a
where cancel_rank = 1);

--5. Menggabungkan informasi-informasi yang telah didapatkan ke dalam satu tampilan tabel (Hint: Perhatikan teknik join yang dilakukan serta kolom-kolom yang dipilih)
select 
	rpr.year,
	rpr.product_category_name,
	rpr.revenue,
	ry.total_revenue as total_revenue_order_per_year, 
	rco.product_category_name,
	rco.total_cancel,
	coy.total_cancel as total_cancel_order_per_year
from revenue_year ry
join cancel_order_year coy on ry.year = coy.year 
join rank_product_revenue rpr on ry.year = rpr.year 
join rank_cancel_order rco on coy.year = rco.year;



