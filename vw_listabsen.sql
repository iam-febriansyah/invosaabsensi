CREATE OR REPLACE VIEW vw_listabsen as

SELECT a.idabsensi, u.iduser, u.nama_depan, u.nama_belakang, a.tanggal, a.jam, a.latitude, a.longitude, a.lokasi, a.in_out, a.is_wfh FROM `users` u
inner join absensi a ON a.iduser = u.iduser