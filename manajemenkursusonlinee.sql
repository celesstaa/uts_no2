-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 13 Mar 2025 pada 12.14
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `manajemenkursusonlinee`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `courses`
--

INSERT INTO `courses` (`id`, `course_name`, `description`, `instructor_id`) VALUES
(1, 'Pemrograman Python', 'Kursus dasar-dasar Python untuk pemula', 5),
(2, 'Basis Data SQL', 'Belajar SQL dari dasar hingga mahir', 5),
(3, 'JavaScript Pemula', 'Belajar dasar JavaScript untuk pengembangan web interaktif', 6),
(4, 'Machine Learning Dasar', 'Pengenalan konsep machine learning dan penerapannya', 6),
(5, 'Keamanan Siber', 'Pelajari cara melindungi data dan sistem dari serangan siber', 5),
(6, 'HTML & CSS', 'Membangun website dari nol dengan HTML dan CSS', 6),
(7, 'Data Science', 'Analisis data menggunakan Python dan alat lain', 5);

-- --------------------------------------------------------

--
-- Struktur dari tabel `registrations`
--

CREATE TABLE `registrations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `name` varchar(255) NOT NULL,
  `course_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `registrations`
--

INSERT INTO `registrations` (`id`, `user_id`, `course_id`, `registration_date`, `name`, `course_name`) VALUES
(1, 1, 1, '2025-03-13 04:40:24', 'Muthia', 'Pemrograman Phyton'),
(2, 1, 3, '2025-03-13 04:40:24', 'Muthia', 'JavaScript Pemula'),
(3, 2, 2, '2025-03-13 04:40:24', 'Syifa', 'Basis Data SQL'),
(4, 2, 4, '2025-03-13 04:40:24', 'Syifa ', 'Machine Learning Dasar'),
(5, 3, 1, '2025-03-13 04:40:24', 'Naura', 'Pemrograman Phyton'),
(6, 3, 5, '2025-03-13 04:40:24', 'Naura', 'Keamanan Siber'),
(7, 4, 2, '2025-03-13 04:40:24', 'Andri Cahya', 'Basis Data SQL'),
(8, 4, 6, '2025-03-13 04:40:24', 'Andri Cahya', 'HTML & CSS'),
(9, 1, 7, '2025-03-13 04:40:24', 'Muthia', 'Data Science'),
(10, 2, 7, '2025-03-13 04:40:24', 'Syifa ', 'Data Science'),
(25, NULL, NULL, '2025-03-13 11:07:06', 'rafya', 'HTML & CSS');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `role` enum('student','instructor') NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `role`, `password`) VALUES
(1, 'Muthia', 'muthe@example.com', 'mth', 'student', '12345'),
(2, 'Syifa', 'syfa@example.com', 'syfa', 'student', '54321'),
(3, 'Naura', 'nau@example.com', 'naura', 'student', '48940'),
(4, 'Andri Cahya', 'caynda@example.com', 'cynda', 'student', '85995'),
(5, 'Dekka', 'andrek@example.com', 'dka', 'instructor', '49940'),
(6, 'Ramadhani', 'rmdhn@example.com', 'rmdni', 'instructor', '73738');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `instructor_id` (`instructor_id`);

--
-- Indeks untuk tabel `registrations`
--
ALTER TABLE `registrations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `registrations`
--
ALTER TABLE `registrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `registrations`
--
ALTER TABLE `registrations`
  ADD CONSTRAINT `registrations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `registrations_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
