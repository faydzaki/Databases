-- Buat database
CREATE DATABASE dbpos;
USE dbpos;

-- Tabel jenis_produk
CREATE TABLE jenis_produk (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(45) DEFAULT NULL
) ENGINE=InnoDB;

INSERT INTO jenis_produk VALUES
(1,'elektronik'),
(2,'furniture'),
(3,'makanan'),
(4,'minuman'),
(5,'komputer');

-- Tabel kartu
CREATE TABLE kartu (
  id INT AUTO_INCREMENT PRIMARY KEY,
  kode VARCHAR(6) UNIQUE,
  nama VARCHAR(45),
  diskon DOUBLE,
  iuran DOUBLE
) ENGINE=InnoDB;

INSERT INTO kartu VALUES
(1,'GOLD','Gold Utama',0.05,100000),
(2,'PLAT','Platinum Jaya',0.1,150000),
(3,'SLV','Silver',0.025,50000),
(4,'NO','Non Member',0,0);

-- Tabel pelanggan
CREATE TABLE pelanggan (
  id INT AUTO_INCREMENT PRIMARY KEY,
  kode VARCHAR(10),
  nama VARCHAR(45),
  jk CHAR(1),
  tmp_lahir VARCHAR(30),
  tgl_lahir DATE,
  email VARCHAR(45),
  kartu_id INT NOT NULL,
  FOREIGN KEY (kartu_id) REFERENCES kartu(id)
) ENGINE=InnoDB;

CREATE INDEX idx_nama_pelanggan ON pelanggan(nama);
CREATE INDEX idx_tgllahir_pelanggan ON pelanggan(tgl_lahir);

INSERT INTO pelanggan VALUES
(1,'C001','Agung Sedayu','L','Solo','2010-01-01','sedayu@gmail.com',1),
(2,'C002','Pandan Wangi','P','Yogyakarta','1950-01-01','wangi@gmail.com',2),
(3,'C003','Sekar Mirah','P','Kediri','1983-02-20','mirah@yahoo.com',1),
(4,'C004','Swandaru Geni','L','Kediri','1981-01-04','swandaru@yahoo.com',4),
(5,'C005','Pradabashu','L','Pati','1985-04-02','prada85@gmail.com',2),
(6,'C006','Gayatri Dwi','P','Jakarta','1987-11-28','gaya87@gmail.com',1),
(7,'C007','Dewi Gyat','P','Jakarta','1988-12-01','giyat@gmail.com',1),
(8,'C008','Andre Haru','L','Surabaya','1990-07-15','andre.haru@gmail.com',4),
(9,'C009','Ahmad Hasan','L','Surabaya','1992-10-15','ahasan@gmail.com',4),
(10,'C010','Cassanndra','P','Belfast','1990-11-20','casa90@gmail.com',1);

-- Tabel pesanan
CREATE TABLE pesanan (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tanggal DATE,
  total DOUBLE,
  pelanggan_id INT NOT NULL,
  FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(id)
) ENGINE=InnoDB;

INSERT INTO pesanan VALUES
(1,'2015-11-04',9720000,1),
(2,'2015-11-04',17500,3),
(3,'2015-11-04',0,6),
(4,'2015-11-04',0,7),
(5,'2015-11-04',0,10),
(6,'2015-11-04',0,2),
(7,'2015-11-04',0,5),
(8,'2015-11-04',0,4),
(9,'2015-11-04',0,8),
(10,'2015-11-04',0,9);

-- Tabel pembayaran
CREATE TABLE pembayaran (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nokuitansi VARCHAR(10) UNIQUE,
  tanggal DATE,
  jumlah DOUBLE,
  ke INT,
  pesanan_id INT NOT NULL,
  FOREIGN KEY (pesanan_id) REFERENCES pesanan(id)
) ENGINE=InnoDB;

-- (tidak ada data pembayaran di dump)

-- Tabel produk
CREATE TABLE produk (
  id INT AUTO_INCREMENT PRIMARY KEY,
  kode VARCHAR(10) UNIQUE,
  nama VARCHAR(45),
  harga_beli DOUBLE,
  harga_jual DOUBLE,
  stok INT,
  min_stok INT,
  jenis_produk_id INT NOT NULL,
  FOREIGN KEY (jenis_produk_id) REFERENCES jenis_produk(id)
) ENGINE=InnoDB;

INSERT INTO produk VALUES
(1,'TV01','Televisi 21 inch',3500000,5040000,5,2,1),
(2,'TV02','Televisi 40 inch',5500000,7440000,4,2,1),
(3,'K001','Kulkas 2 pintu',3500000,4680000,6,2,1),
(4,'M001','Meja Makan',500000,600000,4,3,2),
(5,'TK01','Teh Kotak',3000,3500,6,10,4),
(6,'PC01','PC Desktop HP',7000000,9600000,9,2,5),
(7,'TB01','Teh Botol',2000,2500,53,10,4),
(8,'AC01','Notebook Acer',8000000,10800000,7,2,5),
(9,'LN01','Notebook Lenovo',9000000,12000000,9,2,5),
(10,'L004','Laptop HP',12000000,13000000,20,5,5);

-- Tabel pesanan_items
CREATE TABLE pesanan_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  produk_id INT NOT NULL,
  pesanan_id INT NOT NULL,
  qty INT,
  harga DOUBLE,
  FOREIGN KEY (produk_id) REFERENCES produk(id),
  FOREIGN KEY (pesanan_id) REFERENCES pesanan(id)
) ENGINE=InnoDB;

INSERT INTO pesanan_items VALUES
(1,1,1,1,5040000),
(2,3,1,1,4680000),
(3,5,2,5,3500),
(6,5,3,10,3500),
(7,1,3,1,5040000),
(9,5,5,10,3500),
(10,5,6,20,3500);

-- Tabel vendor
CREATE TABLE vendor (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nomor VARCHAR(4) UNIQUE NOT NULL,
  nama VARCHAR(40) NOT NULL,
  kota VARCHAR(30),
  kontak VARCHAR(40)
) ENGINE=InnoDB;

INSERT INTO vendor VALUES
(1,'V001','PT Guna Samudra','Surabaya','Ali Nurdin'),
(2,'V002','PT Pondok C9','Depok','Putri Ramadhani'),
(3,'V003','CV Jaya Raya Semesta','Jakarta','Dwi Rahayu'),
(4,'V004','PT Lekulo X','Kebumen','Mbambang G'),
(5,'V005','PT IT Prima','Jakarta','David W');

-- Tabel pembelian
CREATE TABLE pembelian (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tanggal DATE,
  nomor VARCHAR(10) UNIQUE,
  produk_id INT,
  jumlah INT,
  harga DOUBLE,
  vendor_id INT,
  FOREIGN KEY (produk_id) REFERENCES produk(id),
  FOREIGN KEY (vendor_id) REFERENCES vendor(id)
) ENGINE=InnoDB;

INSERT INTO pembelian VALUES
(1,'2019-10-10','P001',1,2,3500000,1),
(2,'2019-11-20','P002',2,5,5500000,2),
(3,'2019-12-12','P003',2,5,5400000,1),
(4,'2020-01-20','P004',7,200,1800,3),
(5,'2020-01-20','P005',5,100,2300,3);

CREATE VIEW pesanan_pelanggan_kartu AS
SELECT pesanan.id, pesanan.tanggal, pesanan.total,
       pelanggan.kode, pelanggan.nama,
       kartu.nama AS nama_kartu, kartu.diskon
FROM pesanan
INNER JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
INNER JOIN kartu ON pelanggan.kartu_id = kartu.id;
SELECT * FROM pesanan_pelanggan_kartu;

CREATE VIEW pembelian_produk_vendor AS
SELECT pembelian.id, pembelian.tanggal, pembelian.nomor,
       pembelian.jumlah, pembelian.harga,
       produk.nama AS nama_produk,
       vendor.nama AS nama_vendor,
       vendor.kontak
FROM pembelian
INNER JOIN produk ON pembelian.produk_id = produk.id
INNER JOIN vendor ON pembelian.vendor_id = vendor.id;
SELECT * FROM pembelian_produk_vendor;


CREATE VIEW pesanan_pelanggan_produk AS
SELECT pesanan.id, pesanan.tanggal, pesanan.total,
       pelanggan.nama AS nama_pelanggan,
       produk.kode, produk.nama AS nama_produk,
       jenis_produk.nama AS jenis_produk,
       pesanan_items.qty, produk.harga_jual
FROM pesanan
INNER JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
INNER JOIN pesanan_items ON pesanan.id = pesanan_items.pesanan_id
INNER JOIN produk ON pesanan_items.produk_id = produk.id
INNER JOIN jenis_produk ON produk.jenis_produk_id = jenis_produk.id;
SELECT * FROM pesanan_pelanggan_produk;

START TRANSACTION;

INSERT INTO produk (kode, nama, harga_beli, harga_jual, stok, min_stok, jenis_produk_id) VALUES
('PRD001','Printer Canon',1500000,2000000,10,2,5),
('PRD002','Headset JBL',500000,750000,15,3,1),
('PRD003','Meja Belajar',350000,500000,20,5,2);

UPDATE produk SET stok = 40 WHERE kode = 'PRD001';
SELECT id, kode, nama, stok FROM produk WHERE kode = 'PRD001';

INSERT INTO pembayaran (id, nokuitansi, tanggal, jumlah, ke, pesanan_id)
VALUES (1, 'KW001', '2025-10-01', 200000, 1, 1);
SELECT * FROM pembayaran;

SAVEPOINT sebelum_hapus_pembayaran;

DELETE FROM pembayaran WHERE id = 1;
SELECT * FROM pembayaran;

ROLLBACK TO SAVEPOINT sebelum_hapus_pembayaran;
SELECT * FROM pembayaran;

UPDATE kartu SET iuran = 50000 WHERE id = 2;
SELECT * FROM kartu WHERE id = 2;

COMMIT;

SELECT * FROM produk WHERE kode = 'PRD001';
SELECT * FROM pembayaran;
SELECT * FROM kartu WHERE id = 2;