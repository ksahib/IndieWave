-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 14, 2024 at 03:56 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `indiewave`
--

-- --------------------------------------------------------

--
-- Table structure for table `album`
--

CREATE TABLE `album` (
  `album_id` varchar(64) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `cover_art` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `artist_name` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `album`
--

INSERT INTO `album` (`album_id`, `name`, `cover_art`, `price`, `artist_name`) VALUES
('6734ccee0b4cf', 'dum', '6734ccee0ab15', 17.20, 'Upodeshta'),
('6734cf378b6b9', 'we Are Nahid', '6734cf378b208', 20.24, 'Upodeshta'),
('673551242d404', 'meh', '673551242c07c', 12.00, 'Upodeshta');

-- --------------------------------------------------------

--
-- Table structure for table `artist`
--

CREATE TABLE `artist` (
  `artist_name` varchar(60) NOT NULL,
  `follower_count` int(11) DEFAULT NULL,
  `profile_pic` varchar(100) DEFAULT NULL,
  `about` varchar(500) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artist`
--

INSERT INTO `artist` (`artist_name`, `follower_count`, `profile_pic`, `about`, `email`) VALUES
('sahib', 0, '67340d49e0807', 'exhausted', 'gil45'),
('Upodeshta', 0, '67343b7f2860b', 'ffdgfhfg', 'Artoria');

-- --------------------------------------------------------

--
-- Table structure for table `follows`
--

CREATE TABLE `follows` (
  `artist_name` varchar(60) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `tag` varchar(20) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `image_id` varchar(100) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `image_type` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`image_id`, `image_url`, `image_type`) VALUES
('67340d49e0807', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731464523/a1avsd23btp9ug8hrhva.png', 'profile_pic'),
('67343b7f2860b', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731476352/ipdzpucjr4qfwfqhxals.png', 'profile_pic'),
('6734ccee0ab15', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731513036/gxr0oveotbchhjhxc8jh.jpg', 'cover_art'),
('6734cf378b208', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731514167/eorwlrtzlk8ts83zbvtj.jpg', 'cover_art'),
('673551242c07c', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731547427/pnvzfg9lc7p6spsm85lh.jpg', 'cover_art'),
('default', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731329463/profile_pic/lhjg1rgm4a0c4uedtyzk.jpg', 'profile_pic');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `token_id` varchar(500) NOT NULL,
  `email` varchar(32) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT curtime(),
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_used` timestamp NOT NULL DEFAULT curtime()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`token_id`, `email`, `created_at`, `expires_at`, `last_used`) VALUES
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzE0MjUyMTYsImV4cCI6MTczNDAxNzIxNiwiZGF0YSI6eyJlbWFpbCI6ImdpbDQ1IiwidW5pcXVlIjoiNjczMzczYzBlOTY3ZiJ9fQ.rgW1wUzX_iEKNq9gydIBDjt6yG-MmT56zEgKRhOdfYw', 'gil45', '2024-11-12 15:26:56', '2024-12-12 10:26:56', '2024-11-12 15:26:56'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzE0MzAxMjYsImV4cCI6MTczMTQ3MzMyNiwiZGF0YSI6eyJlbWFpbCI6ImdpbDQ1IiwidW5pcXVlIjoiNjczMzg2ZWUwM2RhZCJ9fQ.GtrEozjTUDlGgCPdHvxowVzc5TFbGSg6vvI8Z-wZyKg', 'gil45', '2024-11-12 16:48:46', '2024-11-12 23:48:46', '2024-11-12 16:48:46'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzE0NzYzMTEsImV4cCI6MTczMTUxOTUxMSwiZGF0YSI6eyJlbWFpbCI6IkFydG9yaWEiLCJ1bmlxdWUiOiI2NzM0M2I1NzU5ZGIxIn19.6tP1I_53J1ABc0ScO7iNp_H2sW6qClbj8hlxbvqkudc', 'Artoria', '2024-11-13 05:38:31', '2024-11-13 12:38:31', '2024-11-13 05:38:31'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzE1NDM5MTQsImV4cCI6MTczMTU4NzExNCwiZGF0YSI6eyJlbWFpbCI6IkFydG9yaWEiLCJ1bmlxdWUiOiI2NzM1NDM2YTMxZGMzIn19.TygHrYrV3Rj671CHkgwTV3MdJ6WgGqFBmDyl0iRQRoY', 'Artoria', '2024-11-14 00:25:14', '2024-11-14 07:25:14', '2024-11-14 00:25:14'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEwOTQzMTksImV4cCI6MTczMzY4NjMxOSwiZGF0YSI6eyJlbWFpbCI6ImdpbDMiLCJ1bmlxdWUiOiI2NzJlNjcyZjVmYzhhIn19.FFctZl3vDCfWAIdM6uijU-A4T-Mhx1ki5pRSz1NN77A', 'gil3', '2024-11-08 19:31:59', '2024-12-08 14:31:59', '2024-11-08 19:31:59'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEwOTUwMDIsImV4cCI6MTczMzY4NzAwMiwiZGF0YSI6eyJlbWFpbCI6ImdpbDIiLCJ1bmlxdWUiOiI2NzJlNjlkYTAwZGRmIn19.lX-HATApqJ8yQl2YDPEXz69obZrQJZmtGs4RDRPpQ_A', 'gil2', '2024-11-08 19:43:22', '2024-12-08 14:43:22', '2024-11-08 19:43:22'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEzMzE3NDcsImV4cCI6MTczMzkyMzc0NywiZGF0YSI6eyJlbWFpbCI6InNhbXBsZUBleGFtcGxlLmNvbSIsInVuaXF1ZSI6IjY3MzIwNmEzZDFhYjYifX0.czEptwujQAYDrYaX9vWQmiNkiDnjaRVWmKnh8XEAyUE', 'sample@example.com', '2024-11-11 13:29:07', '2024-12-11 08:29:07', '2024-11-11 13:29:07'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEzNzM2OTQsImV4cCI6MTczMTQxNjg5NCwiZGF0YSI6eyJlbWFpbCI6ImdpbDQ1IiwidW5pcXVlIjoiNjczMmFhN2VhNTBmZCJ9fQ.6LAar6JZsuxKAHGPEUbY2IavaKwrZqDPkx1cZ_rCgSQ', 'gil45', '2024-11-12 01:08:14', '2024-11-12 08:08:14', '2024-11-12 01:08:14'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEzNzM5MTksImV4cCI6MTczMTQxNzExOSwiZGF0YSI6eyJlbWFpbCI6ImdpbDQ1IiwidW5pcXVlIjoiNjczMmFiNWYyMjliMSJ9fQ.XRz8YT2C9aqH2GOnnODadGRgg8u3gpCgFQwVuuqIkvE', 'gil45', '2024-11-12 01:11:59', '2024-11-12 08:11:59', '2024-11-12 01:11:59'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEzNzM5ODYsImV4cCI6MTczMTQxNzE4NiwiZGF0YSI6eyJlbWFpbCI6ImdpbDQ1IiwidW5pcXVlIjoiNjczMmFiYTJiNWI3MyJ9fQ.F1fxMi2ECNHiC60iEPeHANr4rHHEav7cYFadaCifg9Y', 'gil45', '2024-11-12 01:13:06', '2024-11-12 08:13:06', '2024-11-12 01:13:06'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEzNzUyNjQsImV4cCI6MTczMTQxODQ2NCwiZGF0YSI6eyJlbWFpbCI6ImdpbDQ1IiwidW5pcXVlIjoiNjczMmIwYTBjYTkwYSJ9fQ.YgEU2iQCkP2UJ8oRPraAPrGePchizRsNOExHXG7F7-o', 'gil45', '2024-11-12 01:34:24', '2024-11-12 08:34:24', '2024-11-12 01:34:24');

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

CREATE TABLE `tracks` (
  `track_id` varchar(64) NOT NULL,
  `track_name` varchar(60) DEFAULT NULL,
  `tag` varchar(20) DEFAULT NULL,
  `length` time DEFAULT NULL,
  `track_url` varchar(100) DEFAULT NULL,
  `album_id` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `email` varchar(60) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `profile_pic` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`email`, `name`, `password`, `profile_pic`) VALUES
('Artoria', 'saber', '$2y$10$jqmGQv6yR1N6GbtIXf8UNeVHC5y/5FLhm.Y2o5h6dJNDotEwSReq.', 'default'),
('dum@gmail.com', 'sds', '$2y$10$saZ3wpXTe5xcJ9TfdsCU1uYtzjdrffI5lsH/Om24d1nZ/ZElTKNjW', NULL),
('dummy2@example.com', 'dummy', '$2y$10$g3dskRp5Q5OsikDnlBhYuO2D3HaQ8fqtIfDRSe.ykycnMYv1Ytxhy', NULL),
('dummy@example.com', 'dummy', '$2y$10$UumjSHu5UVNUgTJR9dnTvOApM4z3XayRB67KDnPPnvDctrZ1f1J1K', NULL),
('emiya', 'emiya', '$2y$10$ivOAEoHkXASdHiV0mSjPTuAj6i0PADL.dsq4/lj3f45bJ8XK260x2', 'default'),
('fgh@gmail.com', 'qwe', '$2y$10$.pCBDE3nmf6vaqk4BAFdnOq8jFqKITRxOPXCq8nVd1g2ruz1hbgge', NULL),
('gil2', 'gil2', '$2y$10$FkAHedlBMyNT/aztrwF.IuYzpjWjdFAF8UCSR5kyAE.UfCF098iPy', NULL),
('gil3', 'gil3', '$2y$10$ZRzrqvOtl3iQJfY5jxnlfusqiCH4GTJ2foLiwdVUJ1omCHFcxWwxW', NULL),
('gil45', 'gilgamesh', '$2y$10$RAvw2KD2fQggqNS3Im.7p.mkH2ZM2O7o7pcaLc4rCSACrUdnDPYke', 'default'),
('gil@example.com', 'gil', '$2y$10$2ouz5GCe64xVmjgKZZKe4ubAKtS0itW68CGzXhzzE10mURnIG28Zi', NULL),
('rin@example.com', 'rin', '$2y$10$pqkOVdju893l9lFahlqRb.c/HLw34RXVOUmlf5Hi1SgIS.hwbDvmG', NULL),
('sabre@example.com', 'sabre', '$2y$10$9UERlvXk/0mTm6PrWc5inurL2ZUkBve5HE0MUwOmSAfefWmEYKQzG', NULL),
('sahib@gmail.com', 'sahib', '$2y$10$ZHaudkUPP2SL/vd742DrnuGAoxo20MjJKPOyQ4fw9SZJJ6t5hu4o6', NULL),
('sam@example.com', 'dummy', '$2y$10$4KASazqDdvQhOBfqqc3QYeiw8MgfhYoZaqJdy4YLlCi0un1SUxRPK', NULL),
('samiha345@gmail.com', 'samiha', '$2y$10$vUx4X8KExsG1cCOxL7bgD.fuBk.ePJehoKYIgOYE.twohfVLeRlVy', NULL),
('samiha@gmail.com', 'samiha', '$2y$10$9XZtr0D4MLl4q.IjmJRE4u6r.iE9CsgS70BzAvetI3G9N0B8hvd.2', NULL),
('sample@example.com', 'sample', '$2y$10$E62eAdm.0qzpQtbStYTqFuv/7HjQi67KFi2OYFFxVDo3hfS3alYsS', 'default'),
('test345@example.com', 'user345', '$2y$10$LrgGByWlW7Cq/JElICKhpe9cFJkHF4A6/08uI3Qu61I6SCx78g0lO', NULL),
('test34@example.com', 'Test User34', '$2y$10$2qjpEgjxU5sT.Of5ayOPTudd40CG2LG9vGoZ/Jm5KQaQ7WsdYE6EW', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`album_id`),
  ADD KEY `cover_art` (`cover_art`),
  ADD KEY `artist_name` (`artist_name`);

--
-- Indexes for table `artist`
--
ALTER TABLE `artist`
  ADD PRIMARY KEY (`artist_name`),
  ADD KEY `email` (`email`),
  ADD KEY `profile_pic` (`profile_pic`);

--
-- Indexes for table `follows`
--
ALTER TABLE `follows`
  ADD KEY `artist_name` (`artist_name`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`tag`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `email_fk` (`email`);

--
-- Indexes for table `tracks`
--
ALTER TABLE `tracks`
  ADD PRIMARY KEY (`track_id`),
  ADD KEY `tag` (`tag`),
  ADD KEY `album_id` (`album_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`email`),
  ADD KEY `profile_pic` (`profile_pic`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `album`
--
ALTER TABLE `album`
  ADD CONSTRAINT `album_ibfk_1` FOREIGN KEY (`cover_art`) REFERENCES `images` (`image_id`),
  ADD CONSTRAINT `album_ibfk_2` FOREIGN KEY (`artist_name`) REFERENCES `artist` (`artist_name`);

--
-- Constraints for table `artist`
--
ALTER TABLE `artist`
  ADD CONSTRAINT `email` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
  ADD CONSTRAINT `profile_pic` FOREIGN KEY (`profile_pic`) REFERENCES `images` (`image_id`);

--
-- Constraints for table `follows`
--
ALTER TABLE `follows`
  ADD CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`artist_name`) REFERENCES `artist` (`artist_name`),
  ADD CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`email`) REFERENCES `users` (`email`);

--
-- Constraints for table `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `email_fk` FOREIGN KEY (`email`) REFERENCES `users` (`email`);

--
-- Constraints for table `tracks`
--
ALTER TABLE `tracks`
  ADD CONSTRAINT `tracks_ibfk_1` FOREIGN KEY (`tag`) REFERENCES `genre` (`tag`),
  ADD CONSTRAINT `tracks_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`profile_pic`) REFERENCES `images` (`image_id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `delete_expired_rows` ON SCHEDULE EVERY 1 MINUTE STARTS '2024-11-11 22:47:41' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM session
  WHERE NOW() > expires_at$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
