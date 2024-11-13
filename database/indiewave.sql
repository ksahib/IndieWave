-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 13, 2024 at 03:22 AM
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
('6733f63484067', 'debut', 'default', 9.99, 'gotcha'),
('6733f65309965', 'debut', 'default', 9.99, 'gotcha'),
('6733f6554f47f', 'debut', 'default', 9.99, 'gotcha');

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
('Artist Name', 0, 'default', 'Passion', 'Blablabla'),
('Artist1 Name', 0, 'default', 'Passion', 'Blablabla'),
('Artist14 Name', 0, 'default', 'Passion', 'Blablabla'),
('gotcha', 0, 'default', 'Purr', 'emiya'),
('gotcha1', 0, 'default', 'Purr', 'dum@gmail.com'),
('gotcha101', 0, 'default', 'Lucky Lucky', 'emiya'),
('ME', 0, 'default', 'Psion', 'Blablabla');

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
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEwOTQzMTksImV4cCI6MTczMzY4NjMxOSwiZGF0YSI6eyJlbWFpbCI6ImdpbDMiLCJ1bmlxdWUiOiI2NzJlNjcyZjVmYzhhIn19.FFctZl3vDCfWAIdM6uijU-A4T-Mhx1ki5pRSz1NN77A', 'gil3', '2024-11-08 19:31:59', '2024-12-08 14:31:59', '2024-11-08 19:31:59'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEwOTUwMDIsImV4cCI6MTczMzY4NzAwMiwiZGF0YSI6eyJlbWFpbCI6ImdpbDIiLCJ1bmlxdWUiOiI2NzJlNjlkYTAwZGRmIn19.lX-HATApqJ8yQl2YDPEXz69obZrQJZmtGs4RDRPpQ_A', 'gil2', '2024-11-08 19:43:22', '2024-12-08 14:43:22', '2024-11-08 19:43:22'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEzODY3MTcsImV4cCI6MTczMTQyOTkxNywiZGF0YSI6eyJlbWFpbCI6InNhaGliNSIsInVuaXF1ZSI6IjY3MzJkZDVkNDdjNTIifX0.GNYLtOnxfcsD6A8jL9vT86UEIHrLYgScFyuaZB_mytU', 'sahib5', '2024-11-12 04:45:17', '2024-11-12 11:45:17', '2024-11-12 04:45:17');

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
('Blablabla', 'Artist Name', '$2y$10$PwPz61rgc3y.tBtoX6A5S.Ai1Rdc3ia5kwucVAxNi3G9LMySZsR7q', 'default'),
('dum@gmail.com', 'sds', '$2y$10$saZ3wpXTe5xcJ9TfdsCU1uYtzjdrffI5lsH/Om24d1nZ/ZElTKNjW', NULL),
('dummy2@example.com', 'dummy', '$2y$10$g3dskRp5Q5OsikDnlBhYuO2D3HaQ8fqtIfDRSe.ykycnMYv1Ytxhy', NULL),
('dummy@example.com', 'dummy', '$2y$10$UumjSHu5UVNUgTJR9dnTvOApM4z3XayRB67KDnPPnvDctrZ1f1J1K', NULL),
('emiya', 'emiya', '$2y$10$ivOAEoHkXASdHiV0mSjPTuAj6i0PADL.dsq4/lj3f45bJ8XK260x2', 'default'),
('fgh@gmail.com', 'qwe', '$2y$10$.pCBDE3nmf6vaqk4BAFdnOq8jFqKITRxOPXCq8nVd1g2ruz1hbgge', NULL),
('gil2', 'gil2', '$2y$10$FkAHedlBMyNT/aztrwF.IuYzpjWjdFAF8UCSR5kyAE.UfCF098iPy', NULL),
('gil3', 'gil3', '$2y$10$ZRzrqvOtl3iQJfY5jxnlfusqiCH4GTJ2foLiwdVUJ1omCHFcxWwxW', NULL),
('gil@example.com', 'gil', '$2y$10$2ouz5GCe64xVmjgKZZKe4ubAKtS0itW68CGzXhzzE10mURnIG28Zi', NULL),
('rin@example.com', 'rin', '$2y$10$pqkOVdju893l9lFahlqRb.c/HLw34RXVOUmlf5Hi1SgIS.hwbDvmG', NULL),
('sabre@example.com', 'sabre', '$2y$10$9UERlvXk/0mTm6PrWc5inurL2ZUkBve5HE0MUwOmSAfefWmEYKQzG', NULL),
('sahib0', 'sahib', '$2y$10$s28xxPL7wGO3BcrI6MJycefPA8PCldTDxjzTiTW0P6Uw3ugPWi3EW', 'default'),
('sahib1', 'sahib', '$2y$10$cfBMyJT0VmGNpa82HzZUl.Jnb8Tl9hMmwJ/MK2g9bYRCejcrqQN.e', 'default'),
('sahib10', 'sahib', '$2y$10$qJo2rwTt7XSbE.o349vl/.7rS5bnfKr35U4c36NCISTd87k66mMp6', 'default'),
('sahib35', 'sahib', '$2y$10$BxpLkkNw0ijIRNjPZ/0Y/u4.ATl9I8ea9YpbxsJzGdyBz6IygWFD6', 'default'),
('sahib5', 'sahib', '$2y$10$YAUYNU9bUSU56CiFfUKL0OQ5RprXWRhEvhj1K5hlb1bYvDuTUNIqC', 'default'),
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
