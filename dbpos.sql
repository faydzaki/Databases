-- 1. Buat database
CREATE DATABASE dbpos;

-- 2. Gunakan database
USE dbpos;

-- 3. Buat table kartu
CREATE TABLE kartu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode VARCHAR(6) UNIQUE,
    nama VARCHAR(30) NOT NULL,
    diskon DOUBLE,
    iuran DOUBLE
);

-- 4. Buat table pelanggan
CREATE TABLE pelanggan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode VARCHAR(10) UNIQUE,
    nama VARCHAR(45),
    jk CHAR(1),
    tmp_lahir VARCHAR(30),
    tgl_lahir DATE,
    email VARCHAR(45),
    kartu_id INT NOT NULL,
    FOREIGN KEY (kartu_id) REFERENCES kartu(id)
);

-- 5. Buat table pesanan
CREATE TABLE pesanan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tanggal DATE,
    total DOUBLE,
    pelanggan_id INT NOT NULL,
    FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(id)
);

-- 6. Buat table pembayaran
CREATE TABLE pembayaran (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nokuitansi VARCHAR(10) UNIQUE,
    tanggal DATE,
    jumlah DOUBLE,
    ke INT,
    pesanan_id INT NOT NULL,
    FOREIGN KEY (pesanan_id) REFERENCES pesanan(id)
);

-- 7. Buat table jenis_produk
CREATE TABLE jenis_produk (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(45)
);

-- 8. Buat table produk
CREATE TABLE produk (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode VARCHAR(10) UNIQUE,
    nama VARCHAR(100) NOT NULL,
    harga_beli DOUBLE,
    harga_jual DOUBLE,
    stok INT DEFAULT 0,
    min_stok INT DEFAULT 0,
    jenis_produk_id INT NOT NULL,
    vendor_id INT,
    FOREIGN KEY (jenis_produk_id) REFERENCES jenis_produk(id),
    FOREIGN KEY (vendor_id) REFERENCES vendor(id)
);

-- 9. Buat table pesanan_items
CREATE TABLE pesanan_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pesanan_id INT NOT NULL,
    produk_id INT NOT NULL,
    qty INT NOT NULL,
    harga DOUBLE,
    FOREIGN KEY (pesanan_id) REFERENCES pesanan(id),
    FOREIGN KEY (produk_id) REFERENCES produk(id)
);

-- 10. Buat table vendor
CREATE TABLE vendor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode VARCHAR(10) UNIQUE,
    nama VARCHAR(100) NOT NULL,
    alamat VARCHAR(255),
    kota VARCHAR(50),
    kontak VARCHAR(50),
    telpon VARCHAR(20)
);

-- 11. Buat table pembelian
CREATE TABLE pembelian (
    id INT AUTO_INCREMENT PRIMARY KEY,
    no_faktur VARCHAR(20) UNIQUE,
    tanggal DATE,
    jumlah DOUBLE,
    vendor_id INT NOT NULL,
    FOREIGN KEY (vendor_id) REFERENCES vendor(id)
);