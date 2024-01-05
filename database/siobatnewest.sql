-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Jan 2024 pada 10.32
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `siobat`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `daftar_poli`
--

CREATE TABLE `daftar_poli` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_pasien` int(10) UNSIGNED NOT NULL,
  `id_jadwal` int(10) UNSIGNED NOT NULL,
  `keluhan` text NOT NULL,
  `no_antrian` int(10) UNSIGNED NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `daftar_poli`
--

INSERT INTO `daftar_poli` (`id`, `id_pasien`, `id_jadwal`, `keluhan`, `no_antrian`, `tanggal`) VALUES
(1, 13, 2, 'Jantungku berdebar kencang dok, dag dig dug', 1, '2024-01-05 09:05:01'),
(2, 14, 4, 'jantungku juga berdebar dok, hehe:)', 1, '2024-01-05 09:06:11'),
(3, 15, 2, 'arteri jantungku pecah dok, evakuasi saya!', 2, '2024-01-05 09:07:04'),
(4, 27, 4, 'Jantung Blahaj tertombak:(', 2, '2024-01-05 09:11:04');

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_periksa`
--

CREATE TABLE `detail_periksa` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_periksa` int(10) UNSIGNED NOT NULL,
  `id_obat` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `detail_periksa`
--

INSERT INTO `detail_periksa` (`id`, `id_periksa`, `id_obat`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 2),
(5, 5, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokter`
--

CREATE TABLE `dokter` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_hp` varchar(50) NOT NULL,
  `id_poli` int(10) UNSIGNED NOT NULL,
  `nip` int(11) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `dokter`
--

INSERT INTO `dokter` (`id`, `nama`, `alamat`, `no_hp`, `id_poli`, `nip`, `password`) VALUES
(1, 'dr. Bram', 'jalan ga tau', '083424212321', 1, 903218321, '$2y$10$R1Cx/1p6VWxeT.uW6/GLpO6ydqEri079O3vAMCBzS0NUzq00bnQ4.'),
(2, 'dr. Heartman', 'Heartman\'s Lab', '08639284892', 2, 903218117, '$2y$10$gguvWIkx7qoNCgCmtLDj8upxPVRZGaD3yTjgEpSHDr.G8i7nb8nGO'),
(3, 'dr. Sulfat', 'jalan Ngeslepet Sulfat', '087927482648', 2, 903218116, '$2y$10$JzoGTNmaKlymZ4Ycqmgq5evwp51FlXTYXBx..itZpKSoZzdaS9Gxa');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal_periksa`
--

CREATE TABLE `jadwal_periksa` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_dokter` int(10) UNSIGNED NOT NULL,
  `hari` enum('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu') NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `jadwal_periksa`
--

INSERT INTO `jadwal_periksa` (`id`, `id_dokter`, `hari`, `jam_mulai`, `jam_selesai`) VALUES
(1, 1, 'Senin', '13:00:00', '15:00:00'),
(2, 2, 'Selasa', '10:00:00', '12:00:00'),
(3, 3, 'Kamis', '22:16:00', '12:19:00'),
(4, 2, 'Rabu', '20:00:00', '22:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `obat`
--

CREATE TABLE `obat` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama_obat` varchar(50) NOT NULL,
  `kemasan` varchar(35) NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `obat`
--

INSERT INTO `obat` (`id`, `nama_obat`, `kemasan`, `harga`) VALUES
(1, 'sulfats', 'plastic', 27000),
(2, 'folat', 'gelas', 32000),
(3, 'asam', 'kaplet', 33000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pasien`
--

CREATE TABLE `pasien` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_ktp` varchar(255) NOT NULL,
  `no_hp` varchar(50) NOT NULL,
  `no_rm` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pasien`
--

INSERT INTO `pasien` (`id`, `nama`, `alamat`, `no_ktp`, `no_hp`, `no_rm`) VALUES
(13, 'DieHard', 'Perumahan Kandri', '$2y$10$LbfOP5M2AA2bMPSiJJ1k4uvFrLTUFZ2KVFxwYJozfv1nlMlsayvWa', '087737941843', '2023-12-24-1'),
(14, 'Yosh', 'fsdfdsa', '$2y$10$vFiarqgeeFRwNrmhAqdnY.788WZhEpHLkMkYYpfLkAvOPRPCTpz1a', '09321783217', '2023-12-24-2'),
(15, 'Jackie', 'oewqfoidsoafdsaofjsaod', '$2y$10$uwo9y0pRD44s2XyvQL/HAeH9f1rzJ5XTarWwA4OLHB6rhDib3nBnO', '081342131231', '2023-12-24-3'),
(16, 'Hola', 'los amigos', '$2y$10$72fx6GsoaMw57HwefNdCjuB.8AFuK7lvmNe..2oHhlt7Fm3OStxqW', '086321321345', '2023-12-24-4'),
(17, 'Johnatan', 'jalan jalan jalan', '$2y$10$kIdVv/C5r8G9oR1L4RU1VuVzrVX.1CT2bpzX6OSyy0jIV0IoeSCIO', '086328283232', '2023-12-24-5'),
(19, 'takeDown', 'Jl.takeDown', '$2y$10$qlGwAyKmSVRXwealLHu3bOruUfGBDvI0Fi627dRss/ipbOg8INm5.', '0873216732176', '2023-12-26-6'),
(21, 'toekijo', 'jalan.toekijo 123', '$2y$10$i.cLhFu7hBz0dOj5CB3KIu61AhUq8WHNZVrnnE3Qjt1PYkkX3ip/S', '08321321312', '2023-12-31-8'),
(22, 'Cliff', 'Perumahan Kandri Pesona Asri Blok G1/15 RT06/RW04, Kelurahan Kandri', '$2y$10$BAhhgcUwq4J0kvh/NERMz.Hvx4AVyiXHCe6WXqqF8ijYJZmmhXSbO', '087737941843', '2023-12-31-9'),
(23, 'CliffUnger', 'bobohoooooooooooooo', '$2y$10$TouXmEjErGaM1mQ50ENwfOEhUvdIXiD23/K/ZGjBJGDLiprEJ9wLq', '0832178932', '2023-12-31-10'),
(24, 'generate', 'alamatsample', '$2y$10$tLdRnI4fOd2y4tOrJKbLz.dSy8m8/G8TJdcLq/bnNdvF8FUAdLhSG', '0863727172321', '202312-10'),
(25, 'hola boy', 'jl. hola boy891273', '$2y$10$2w9E.Km0r/XVgU59tD77aOJKNswVyfmIjFFS494cESAt/BpzdS6iO', '083562123335', '2024-01-04-11'),
(26, 'boyke', 'jl. boyke732', '$2y$10$CwNDQHJhgyRFrZNt5qjks.ld/XwH0cG2976S.86LQX0R0qnrK2mBm', '0834798212', '2024-01-04-12'),
(27, 'Blahaj', 'Lautan Blahaj', '$2y$10$CgWOHaDrKPMyYAdFQgOkkOd2TBaXrO1jLTXHUkHgDrVe7TbGBpJo.', '08321217842', '2024-01-05-13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `periksa`
--

CREATE TABLE `periksa` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_daftar_poli` int(10) UNSIGNED NOT NULL,
  `tgl_periksa` datetime NOT NULL,
  `catatan` text NOT NULL,
  `biaya_periksa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `periksa`
--

INSERT INTO `periksa` (`id`, `id_daftar_poli`, `tgl_periksa`, `catatan`, `biaya_periksa`) VALUES
(1, 4, '2024-01-05 10:13:14', 'Blahaj, ini diminum obatnya, semoga lekas sembuh', 177000),
(2, 4, '2024-01-05 10:13:14', 'Blahaj, ini diminum obatnya, semoga lekas sembuh', 182000),
(3, 1, '2024-01-05 10:15:24', 'Tenangkan dirimu DieHardman', 183000),
(4, 3, '2024-01-05 10:16:48', 'Halo Mas Jackie, Hati - Hati di Jalan', 182000),
(5, 2, '2024-01-05 10:18:58', 'Maaf mas Yosh, tadi saya pilih kasih, Blahaj duluan. Kasian nyari nemo masih belum nemu:)', 177000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `poli`
--

CREATE TABLE `poli` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama_poli` varchar(25) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `poli`
--

INSERT INTO `poli` (`id`, `nama_poli`, `keterangan`) VALUES
(1, 'poli gigi', 'sakit gigi berlubang'),
(2, 'poli jantung', 'sakit serangan jantung'),
(4, 'poliandri', 'ok:)'),
(5, 'polimandi', 'halo king');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `username`, `password`) VALUES
(1, 'rayhand', '$2y$10$Vm8PKNcH1y8NbRGb6uGCmuAMR21aAQHOVeK3HbkfUws50bgOSL5Ha'),
(2, 'tukinem', '$2y$10$DajdmG5k4yWMql5Q8TVg6.137mKzNsTNAXZYjHaZuKts//malkKby'),
(3, 'soekamti', '$2y$10$2dCwMy6aUh7ZdsNFJWpdUeBGBE.7hwxEqETKBfEnnNpQtuq./QZ/.');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `daftar_poli`
--
ALTER TABLE `daftar_poli`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_jadwal` (`id_jadwal`);

--
-- Indeks untuk tabel `detail_periksa`
--
ALTER TABLE `detail_periksa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_periksa` (`id_periksa`),
  ADD KEY `id_obat` (`id_obat`);

--
-- Indeks untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_poli` (`id_poli`);

--
-- Indeks untuk tabel `jadwal_periksa`
--
ALTER TABLE `jadwal_periksa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_dokter` (`id_dokter`);

--
-- Indeks untuk tabel `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `periksa`
--
ALTER TABLE `periksa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `periksa_ibfk_1` (`id_daftar_poli`);

--
-- Indeks untuk tabel `poli`
--
ALTER TABLE `poli`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `daftar_poli`
--
ALTER TABLE `daftar_poli`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `detail_periksa`
--
ALTER TABLE `detail_periksa`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `jadwal_periksa`
--
ALTER TABLE `jadwal_periksa`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `obat`
--
ALTER TABLE `obat`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT untuk tabel `periksa`
--
ALTER TABLE `periksa`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `poli`
--
ALTER TABLE `poli`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `daftar_poli`
--
ALTER TABLE `daftar_poli`
  ADD CONSTRAINT `daftar_poli_ibfk_3` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id`),
  ADD CONSTRAINT `daftar_poli_ibfk_4` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal_periksa` (`id`);

--
-- Ketidakleluasaan untuk tabel `detail_periksa`
--
ALTER TABLE `detail_periksa`
  ADD CONSTRAINT `detail_periksa_ibfk_1` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id`),
  ADD CONSTRAINT `detail_periksa_ibfk_2` FOREIGN KEY (`id_periksa`) REFERENCES `periksa` (`id`);

--
-- Ketidakleluasaan untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD CONSTRAINT `dokter_ibfk_1` FOREIGN KEY (`id_poli`) REFERENCES `poli` (`id`);

--
-- Ketidakleluasaan untuk tabel `jadwal_periksa`
--
ALTER TABLE `jadwal_periksa`
  ADD CONSTRAINT `jadwal_periksa_ibfk_1` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id`);

--
-- Ketidakleluasaan untuk tabel `periksa`
--
ALTER TABLE `periksa`
  ADD CONSTRAINT `periksa_ibfk_1` FOREIGN KEY (`id_daftar_poli`) REFERENCES `daftar_poli` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;