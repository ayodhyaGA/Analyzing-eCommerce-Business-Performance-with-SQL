/* 
1. Menampilkan rata-rata jumlah customer aktif bulanan (monthly active user) untuk setiap tahun (Hint: Perhatikan kesesuaian format tanggal)
2. Menampilkan jumlah customer baru pada masing-masing tahun (Hint: Pelanggan baru adalah pelanggan yang melakukan order pertama kali)
3. Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali (repeat order) pada masing-masing tahun (Hint: Pelanggan yang melakukan repeat order adalah pelanggan yang melakukan order lebih dari 1 kali)
4. Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun (Hint: Hitung frekuensi order (berapa kali order) untuk masing-masing customer terlebih dahulu)
5. Menggabungkan ketiga metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel


*/

select * from customers_dataset;
select * from orders_dataset;


--mengekstrak kolom date_added tahunnya saja dah menghitung customer aktif tiap bulan tiap tahun
--1. Menampilkan rata-rata jumlah customer aktif bulanan (monthly active user) untuk setiap tahun
select year, round(avg(total_customer),2) as avg_active_user
from
(select date_part('year', od.order_purchase_timestamp) as year,
 		date_part('month', od.order_purchase_timestamp) as month,
 		count(distinct cd.customer_unique_id) as total_customer
from orders_dataset as od
join customers_dataset as cd on od.customer_id = cd.customer_id
group by 1,2) a
group by 1;

--2. Menampilkan jumlah customer baru pada masing-masing tahun
select date_part('year', newest) as year, new_customer
from
(select date_part('year', od.order_purchase_timestamp) as year,
 		min(order_purchase_timestamp) as newest,
 		count(distinct cd.customer_unique_id) as new_customer
from orders_dataset as od
join customers_dataset as cd on od.customer_id = cd.customer_id
where order_status = 'delivered'
group by 1) a
group by 1,2;

--3. Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali 
select year, count(total_customer) as repear_order
from
(select date_part('year', od.order_purchase_timestamp) as year,
 		cd.customer_unique_id,
 		count(cd.customer_unique_id) as total_customer,
 		count(od.order_id) as total_order
from orders_dataset as od
join customers_dataset as cd on od.customer_id = cd.customer_id
group by 1,2
having count(order_id) >1
) a
group by 1
order by 1;


--4. Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun
select year, round(avg(total_order),2) as avg_frequency_order
from
(select date_part('year', od.order_purchase_timestamp) as year,
 		cd.customer_unique_id,
 		count(distinct order_id) as total_order
from orders_dataset as od
join customers_dataset as cd on od.customer_id = cd.customer_id
group by 1,2
) a
group by 1
order by 1;

--5. Menggabungkan ketiga metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel
with count_mau as (
select year, round(avg(total_customer),2) as avg_active_user
from
(select date_part('year', od.order_purchase_timestamp) as year,
 		date_part('month', od.order_purchase_timestamp) as month,
 		count(distinct cd.customer_unique_id) as total_customer
from orders_dataset as od
join customers_dataset as cd on od.customer_id = cd.customer_id
group by 1,2) a
group by 1
),

count_newcust as(
select date_part('year', newest) as year, new_customer
from
(select date_part('year', od.order_purchase_timestamp) as year,
 		min(order_purchase_timestamp) as newest,
 		count(distinct cd.customer_unique_id) as new_customer
from orders_dataset as od
join customers_dataset as cd on od.customer_id = cd.customer_id
where order_status = 'delivered'
group by 1) a
group by 1,2
),

count_repeat_order as(
select year, count(total_customer) as repeat_order
from
(select date_part('year', od.order_purchase_timestamp) as year,
 		cd.customer_unique_id,
 		count(cd.customer_unique_id) as total_customer,
 		count(od.order_id) as total_order
from orders_dataset as od
join customers_dataset as cd on od.customer_id = cd.customer_id
group by 1,2
having count(order_id) >1
) a
group by 1
order by 1
),

avg_order as (
select year, round(avg(total_order),2) as avg_frequency_order
from
(select date_part('year', od.order_purchase_timestamp) as year,
 		cd.customer_unique_id,
 		count(distinct order_id) as total_order
from orders_dataset as od
join customers_dataset as cd on od.customer_id = cd.customer_id
group by 1,2
) a
group by 1
order by 1)

select 
cm.year,
cm.avg_active_user,
cn.new_customer,
cro.repeat_order,
ao.avg_frequency_order
from count_mau cm 
join count_newcust cn on cm.year=cn.year
join count_repeat_order cro on cm.year=cro.year
join avg_order ao on cm.year=ao.year;









