# Analyzing-eCommerce-Business-Performance-with-SQL

Sumber skema dan dataset berasal dari 
<a href="https://www.rakamin.com/">Rakamin Academy</a>.

## LATAR BELAKANG.
Dalam suatu perusahaan mengukur performa bisnis sangatlah penting untuk melacak, memantau, dan menilai keberhasilan atau kegagalan dari berbagai proses bisnis. Perusahaan ini merupakan salah satu marketplace terbesar di Amerika Selatan yang menghubungkan pelaku bisnis mikro dengan para pelanggannya.  Oleh karena itu, dalam paper ini akan menganalisa performa bisnis untuk sebuah perusahan eCommerce, dengan memperhitungkan beberapa metrik bisnis yaitu pertumbuhan pelanggan, kualitas produk, dan tipe pembayaran. Salah satu metrik yang digunakan untuk mengukur performa bisnis eCommerce adalah aktivitas customer yang berinteraksi di dalam platform eCommerce tersebut. Selain itu, performa bisnis eCommerce tentunya sangat berkaitan erat dengan produk-produk yang tersedia di dalamnya. Menganalisis kualitas dari produk dalam eCommerce dapat memberikan keputusan untuk mengembangkan bisnis dengan lebih baik. Lebih jauh lagi, bisnis eCommerce umumnya menyediakan sistem pembayaran berbasis open-payment yang memungkinkan customer untuk memilih berbagai macam tipe pembayaran yang tersedia. Menganalisis performa dari tipe pembayaran yang ada dapat memberikan insight untuk menciptakan strategic partnership dengan perusahaan penyedia jasa pembayaran dengan lebih baik.
PERTANYAAN STUDI KASUS.
1.	Bagaimana pertumbuhan pelanggan dilihat dari segi aktivitas customer seperti jumlah customer aktif, jumlah customer baru, jumlah customer yang melakukan repeat order dan juga rata-rata transaksi yang dilakukan customer setiap tahun?
    a.	Menampilkan rata-rata jumlah customer aktif bulanan (monthly active user/MAU) untuk setiap tahun.
    b.	Menampilkan jumlah customer baru pada masing-masing tahun.
    c.	Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali (repeat order) pada masing-masing tahun.
    d.	Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun.
    e.	Menggabungkan keempat metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel
2.	Bagaimana kualitas produk dilihat dari performa dari masing-masing kategori produk yang ada?
    a.	Membuat tabel yang berisi informasi pendapatan/revenue perusahaan total untuk masing-masing tahun.
    b.	Membuat tabel yang berisi informasi jumlah cancel order total untuk masing-masing tahun.
    c.	Membuat tabel yang berisi nama kategori produk yang memberikan pendapatan total tertinggi untuk masing-masing tahun.
    d.	Membuat tabel yang berisi nama kategori produk yang memiliki jumlah cancel order terbanyak untuk masing-masing tahun.
    e.	Menggabungkan informasi-informasi yang telah didapatkan ke dalam satu tampilan tabel.
3.	Tipe pembayaran yang seperti apa yang lebih disukai oleh pelanggan?
    a.	Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit.
    b.	Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun.
    
## DATA DAN ERD
Sebelum memulai pemrosesan data, tahap paling awal yang harus dilakukan adalah mempersiapkan data mentah menjadi data yang terstruktur dan siap diolah. Pada Dataset eCommerce berikut ini terdiri dari 8 dataset yang nantinya saling berinteraksi. Sehingga langka yang dilakukan adalah sebagai berikut.
a.	Membuat database baru beserta tabel-tabelnya untuk data yang sudah disiapkan dengan memperhatikan tipe data setiap kolom.
b.	Importing data csv ke dalam database dengan memperhatikan path penyimpanan dataset.
c.	Membuat entity relationship antar tabel, berdasarkan skema pada Gambar 1. Data Relationship. Kemudian export Entity Relationship Diagram (ERD) dalam bentuk gambar dengan menyesuaikan tipe data dan penamaan kolom antar tabel yang saling berhubungan.
 
![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/Data%2BRelationship.png)
Gambar 1. Data Relationship
Setelah menyesuaikan kolom yang menjadi primary key dan foreign key pada setiap dataset kemudian menghasilkan Entity Relationship Diagram (ERD) sebagai berikut. 

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/ERD_eCommerce.PNG)
Gambar 2. Entity Relationship Diagram (ERD)

## ANALISIS DATA
### Annual Customer Activity Growth
1.	Menampilkan rata-rata jumlah customer aktif bulanan (monthly active user/MAU) untuk setiap tahun.
Dikarenakan tidak adanya kolom tahun, kita dapat membuat kolom tahun dengan mengambil bagian tahun saja menggunakan fungsi DATE_PART pada kolom order_purchase_timestamp yang memiliki format data timestamp without time zone dan terdiri dari pukul, tanggal, bulan, dan tahun. Setelah itu menghitung jumlah unik customer_unique_id menggunakan fungsi COUNT DISTINCT dan menghitung rata-rata jumlah pelanggan menggunakan fungsi AVG sehingga menghasilkan tampilan berikut ini.

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/(MAU)%20per%20Tahun.png)
 
2.	Menampilkan jumlah customer baru pada masing-masing tahun.
Seperti sebelumnya menggunakan untuk fungsi DATE_PART dan COUNT DISTICNT untuk menampilkan tahun dan jumlah pelanggan. Jumlah pelanggan baru disini merupakan pelanggan yang melakukan order pertama kali, dimana dapat dilakukan dengan mencari melalui tanggal order yang paling awal yaitu menggunakan fungsi NEWEST yang diterapkan pada kolom order_purchase_timestamp sehingga menghasilkan tampilan berikut. 

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/Customer%20Baru%20per%20Tahun.png)

3.	Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali (repeat order) pada masing-masing tahun. 
Pada tabel berikut ini yang dihitung merupakan jumlah pelanggan yang melakukan repeat order yaitu pelanggan yang melakukan order lebih dari 1 kali pada tiap tahunnya untuk menampilkan jumlah tersebut dapat menggunakan fungsi HAVING COUNT kolom order_id yang lebih dari 1.

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/Repeat%20Order%20per%20Tahun.png)
 
4.	Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun.
Untuk mendapatkan nilai rata-rata dari jumlah order dapat menggunakan fungsi AVG dari hasil COUNT DISTINCT kolom order_id sedangkan fungsi ROUND dan diakhir angka 2 untuk menyesuaikan agar nilai yang dihasilkan hanya memiliki 2 angka di belakang koma. 

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/Frekuensi%20Order%20untuk%20Setiap%20Tahun.png)

5.	Menggabungkan keempat metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel.
Untuk menggabungkan hasil matrix antara lain jumlah MAU, jumlah pelanggan baru, jumlah pelanggan repeat order dan rata-rata jumlah order setiap tahunnya yang sebelumnya telah dibuat dapat menggunakan Common Table Expression (CTE) yaitu dengan fungsi WITH … AS () atau dapat juga disebut sebagai temporary table. Selanjutnya untuk menjadikan satu tampilan menambahkan fungsi JOIN pada CTE yang telah dibuat dan disatukan menggunakan kolom “year”,  sehingga menghasilkan pada satu tampilan seperti berikut ini. 

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/matrix%20ANNUAL%20CUSTOMER%20ACTIVITY%20GROWTH.PNG)

Dashboard Visualisasi Data Annual Customer Activity Growth 
![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/dashboard%20Annual%20Customer%20Activity%20Growth.png)

Insight/Interpretasi:
●	Terjadi peningkatan yang jauh pada 2017 dikarenakan data yang tersedia pada 2016 hanya pada 4 bulan terakhir yaitu dimulai pada bulan September sehingga dapat disimpulkan baru terjadi peningkatan pertumbuhan pada tahun 2017.
●	Meskipun sama-sama terdapat peningkatan tren pada tahun 2017 sampai tahun 2018 baik terhadap jumlah customer baru dan jumlah customer yang melakukan pembelian lebih dari satu kali. Namun terjadi sedikit penurun pada tahun 2018 terhadap jumlah customer yang melakukan pembelian lebih dari satu kali. 
●	Sedangkan tren terhadap Monthly Active User (MAU) setiap tahunnya juga mengalami peningkatan hingga menembus angka 5338 pelanggan.
●	Rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun tidak terlalu mengalami perubahan dari tahun ke tahun yaitu rata-rata per customer hanya melakukan 1 kali pemesanan. 


### Annual Product Category Quality Analysis
1.	Membuat tabel yang berisi informasi pendapatan/revenue perusahaan total untuk masing-masing tahun.
Revenue merupakan harga barang dan juga biaya kirim, untuk itu perlu menambahkan kolom price dan freight_value. Selain itu juga memastikan bahwa order_status adalah delivered dengan cara filtering menggunakan fungsi WHERE. Untuk membuat tabel sendiri menggunakan fungsi CREATE TABLE dan nama tabelnya yaitu “revenue_year”. Sehingga menghasilkan tabel berikut. 

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/revenue%20perusahaan%20total%20untuk%20masing-masing%20tahun.PNG)

2.	Membuat tabel yang berisi informasi jumlah cancel order total untuk masing-masing tahun. 
Sama seperti seblumnya, untuk membuat tabel menggunakan fungsi CREATE TABLE  dengan nama tabel “cancel_order_year”. Menggunakan fungsi COUNT pada kolom order_id dan filtering WHERE dimana order_status adalah ‘canceled’ dan tidak lupa mengelompokan berdasarkan tahun. Sehingga menghasilkan tabel sebagai berikut.

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/cancel_order_year.PNG)

3.	Membuat tabel kategori produk yang memberikan pendapatan total tertinggi untuk masing-masing tahun.
Untuk mempermudah mendapatakan total pendapatan tertinggi perlu membuat subquery yaitu membuat query didalam query, dengan tujuan mendapatkan value dari tabel lain. Pada subquery tersebut diterapkan window function untuk mendapatkan total pendapatan tertinggi dengan menggunakan fungsi RANK() OVER (PARTITION BY <tahun>) dan ORDER BY <total pendapatan> karena yang diminta adalah setiap tahunnya dan diurutakan berdasarkan total pendapatan. Penggunaan window function seperti halnya agregasi menggunakan fungsi GROUP BY namun perbedaanya adalah hasil agregat tidak dikelompokkan menjadi satu baris sehingga ketika menggunakan window function hanya menampilkan per baris dan rank/urutan dari valuenya. Sehingga menghasilkan tabel “rank_product_revenue” seperti berikut ini. 

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/rank_product_revenue.PNG)

4.	Membuat tabel yang berisi nama kategori produk yang memiliki jumlah cancel order terbanyak untuk masing-masing tahun.
Seperti pada sebelumnya, dalam tabel ini menerapkan penggunaan window function untuk mendapatkan total cancel order tertinggi dengan menggunakan fungsi RANK() OVER (PARTITION BY <tahun>) dan ORDER BY <jumlah cancel order>. Perbedaannya adalah filtering yang digunakan dimana order_status adalah ‘canceled’ setelah itu menghitung jumlah cancel ordernya dan mencari product_category_name apa yang memiliki rank/peringkat tertinggi dan menghasilkan tabel “rank_cancel_order” seperti berikut ini.
 
![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/rank_cancel_order.PNG)
  
5.	Menggabungkan informasi-informasi yang telah didapatkan ke dalam satu tampilan tabel. 
Seperti halnya menggabungkan matrix Annual Customer Activity Growth, namun pada kali ini tidak perlu menggunakan fungsi WITH AS, dikarenakan tabel sudah tersedia dengan menggunakan fungsi CREATE TABLE sebelumnya, sehingga hanya perlu menggunakan teknik JOIN pada kolom-kolom yang dipilih dan menggunakan kolom year sebagai kunci untuk menggabungkan kolom-kolom lainnya. Menjadi satu tampilan tabel sebagai berikut. 
 
![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/matrix%20Annual%20Product%20Category%20Quality%20Analysis.PNG)
  
Dashboard Visualisasi Annual Product Category Quality Analysis  
![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/Dashboard%201%20revenue.png)
![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/Dashboard%202%20cancel%20order.png)
Insight/Interpretasi:
●	Total pendapatan perusahaan meningkat pesat dari tahun 2016 ke 2017, pada tahun 2018 juga masih terjadi peningkatan pendapatan hingga 8.451.584.
●	Kategori produk yang mendapatkan pendapat terbesar mengalami perubahan setiap tahunnya, namun pada tahun 2018 mendapatkan pendapatan yang paling tinggi dengan kategori produk yang berasal dari Health Beauty.
●	Seperti halnya pendapatan, total pemesanan yang dibatalkan juga semakin bertambah dari tahun ke tahun.
●	Seperti halnya pendapatan, jumlah pesanan yang dibatalkan juga mengalami perubahan setiap tahunnya dan kategori Health Beauty juga menjadi kategori yang pesanannya banyak dibatalkan. Kemungkinan hal ini dikarenakan kategori Health Beauty menjadi produk yang paling banyak dikeluarkan namun analisis lebih lanjut diperlukan. 

### Annual Payment Type Usage Analysis
1.	Tipe pembayaran terfavorit.
Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit. Kita dapat mengurutkan jumlah order berdasarkan payment_type dengan menggunakan fungsi ORDER BY yang diikuti setelah penggunaan fungsi ORDER BY. 

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/tipe%20pembayarn%20terfafvorit.PNG)
  
2.	Jumlah penggunaan masing-masing tipe pembayarn dari tahun ke tahun.
Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun. Karena yang diminta adalah setiap tahunnya maka untuk mempermudah perlu dibuat menjadi kolom-kolom baru setiap tahun (2016-2018) yang berisi jumlah order dan masing-masing tipe pembayarannya, untuk itu dapat menggunakan fungsi CASE WHEN dan akan menghasilkan tampilan berikut ini.

![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/Jumlah%20penggunaan%20masing-masing%20tipe%20pembayarn%20dari%20tahun%20ke%20tahun.PNG)

Visualisasi Annual Payment Type Usage Analysis
![alt text](https://github.com/ayodhyaGA/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/fig/tipe%20pembayaran.png)
 

Dari tahun ke tahun tipe pembayaran yang paling banyak digunakan adalah kartu kredit, sehingga perlu dilakukan analisis lebih lanjut bagaimana karakteristik pelanggan yang memakai kartu kredit misalkan kategori jenis produk yang diminati. Sedangkan pembayaran menggunakan kartu debit jarang digunakan pelanggan. 

## Kesimpulan 
Dari aspek pertumbuhan pelanggan atau Annual Customer Activity Growth dapat disimpulkan bawah pertumbuhan pelanggan baru terjadi pada tahun 2017 hal ini ditujukan oleh adannya peningkatan baik pada jumlag pelanggan baru dan jumlah Monthly Active User MAU. Di sisi lain terjadi sedikit penurunan terhadap jumlah pelanggan yang melakukan pembelian lebih dari satu kali pada tahun 2018. Rata-rata jumlah pesanan yang dilakukan hanya satu kali. Sedangkan dari aspek kualitas produk atau Annual Product Category Quality Analysis terjadi peningkatan total pendapatan perusahaan setiap tahunnya. Kategori produk yang mendapatkan pendapatan terbesar dan pemesanan yang paling banyak dibatalkan mengalami perubahan jenis setiap tahunnya. Kategori produk tersebut berasal dari Health Beauty. Selain itu tipe pembayaran yang paling banyak diminati dari tahun ke tahun adalah kartu kredit. 


