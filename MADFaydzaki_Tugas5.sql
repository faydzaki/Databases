use dbpos;

DELIMITER $$

CREATE PROCEDURE pro_naikan_harga(
    IN p_jenis_produk INT,
    IN p_persen INT
)
BEGIN
    UPDATE produk
    SET harga_jual = harga_jual + (harga_jual * p_persen / 100)
    WHERE jenis_produk_id = p_jenis_produk;
END $$

DELIMITER ;

CALL pro_naikan_harga(1, 10);

SELECT id, kode, nama, harga_jual FROM produk WHERE jenis_produk_id = 1;

DELIMITER $$

CREATE FUNCTION umur(tgl_lahir DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE hasil INT;
    SET hasil = TIMESTAMPDIFF(YEAR, tgl_lahir, CURDATE());
    RETURN hasil;
END $$

DELIMITER ;

SELECT nama, tgl_lahir, umur(tgl_lahir) AS umur FROM pelanggan;

DELIMITER $$

CREATE FUNCTION kategori_harga(harga DOUBLE)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE kategori VARCHAR(20);

    IF harga < 500000 THEN
        SET kategori = 'Murah';
    ELSEIF harga >= 500000 AND harga < 3000000 THEN
        SET kategori = 'Sedang';
    ELSEIF harga >= 3000000 AND harga < 10000000 THEN
        SET kategori = 'Mahal';
    ELSE
        SET kategori = 'Sangat Mahal';
    END IF;

    RETURN kategori;
END $$

DELIMITER ;

SELECT kode, nama, harga_jual, kategori_harga(harga_jual) AS kategori FROM produk;

ALTER TABLE pembayaran 
ADD status_pembayaran VARCHAR(25);

DELIMITER $$

CREATE TRIGGER cek_pembayaran
BEFORE INSERT ON pembayaran
FOR EACH ROW
BEGIN
    DECLARE total_bayar DOUBLE;
    DECLARE total_pesanan DOUBLE;

    SELECT IFNULL(SUM(jumlah),0) INTO total_bayar
    FROM pembayaran WHERE pesanan_id = NEW.pesanan_id;

    SELECT total INTO total_pesanan
    FROM pesanan WHERE id = NEW.pesanan_id;

    IF total_bayar + NEW.jumlah >= total_pesanan THEN
        SET NEW.status_pembayaran = 'Lunas';
    ELSE
        SET NEW.status_pembayaran = 'Belum Lunas';
    END IF;
END $$

DELIMITER ;

INSERT INTO pembayaran (nokuitansi, tanggal, jumlah, ke, pesanan_id)
VALUES ('KWI001', '2025-10-02', 5000000, 1, 1);

SELECT * FROM pembayaran;

DELIMITER $$

CREATE PROCEDURE kurangi_stok(
    IN p_produk_id INT,
    IN p_qty INT
)
BEGIN
    UPDATE produk
    SET stok = stok - p_qty
    WHERE id = p_produk_id;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trig_kurangi_stok
AFTER INSERT ON pesanan_items
FOR EACH ROW
BEGIN
    CALL kurangi_stok(NEW.produk_id, NEW.qty);
END $$

DELIMITER ;

INSERT INTO pesanan_items (produk_id, pesanan_id, qty, harga)
VALUES (1, 2, 1, 5040000);

SELECT id, kode, nama, stok FROM produk WHERE id = 1;




