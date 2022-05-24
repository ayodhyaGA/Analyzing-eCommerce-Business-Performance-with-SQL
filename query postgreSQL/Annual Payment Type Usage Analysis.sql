/*
1. Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit (Hint: Perhatikan struktur (kolom-kolom apa saja) dari tabel akhir yang ingin didapatkan)
2. Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun (Hint: Perhatikan struktur (kolom-kolom apa saja) dari tabel akhir yang ingin didapatkan)
*/

--Nomor 1
select * from order_payments_dataset;
select payment_type, count (order_id) from order_payments_dataset
group by 1
order by 2 desc;

--Nomor 2
select * from order_payments_dataset;
with 
year_payment as (
select 
	date_part('year', od.order_purchase_timestamp) as year,
	opd.payment_type,
	count(opd.order_id) as total_order
from order_payments_dataset opd 
join orders_dataset od on od.order_id = opd.order_id
group by 1, 2
	order by 1 asc
) 
select 
  payment_type,
  sum(case when year = '2016' then total_order else 0 end) as yr_2016,
  sum(case when year = '2017' then total_order else 0 end) as yr_2017,
  sum(case when year = '2018' then total_order else 0 end) as yr_2018
from year_payment 
group by 1 
order by 4 desc;


