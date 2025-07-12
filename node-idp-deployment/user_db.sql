-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 28, 2024 at 09:12 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `user_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `clusters`
--

CREATE TABLE `clusters` (
  `id` int(11) NOT NULL,
  `clusterName` varchar(255) DEFAULT NULL,
  `nodePoolName` varchar(255) DEFAULT NULL,
  `nodePoolSize` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL,
  `scm_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clusters`
--

INSERT INTO `clusters` (`id`, `clusterName`, `nodePoolName`, `nodePoolSize`, `user_id`, `created_at`, `updated_at`, `status`, `scm_id`) VALUES
(1, 'c1', 'p1', 1, 2, '2024-10-23 07:56:36', '2024-10-23 07:56:36', 1, 11);

-- --------------------------------------------------------

--
-- Table structure for table `scm_configurations`
--

CREATE TABLE `scm_configurations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `git_url` varchar(255) NOT NULL,
  `branch` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `scm_configurations`
--

INSERT INTO `scm_configurations` (`id`, `name`, `git_url`, `branch`, `created_at`) VALUES
(1, 'Repo1', 'https://github.com/mahesh4434/GcpDevops', 'main', '2024-07-24 10:00:34'),
(5, 'Application1', 'https://github.com/ABHISHEK-KUMAR-14022001/node-todo-cicd.git', 'master', '2024-07-31 10:20:19'),
(8, 'IDP Node JS App', 'http://git.intelliswift.com/DevOps_Internal/DevopsInternal_Project.git', 'idp_infra', '2024-08-05 11:05:41'),
(9, 'repo111', 'https://github.com/mahesh4434/GcpDevops', 'main', '2024-08-09 10:29:16'),
(10, 'abc', 'https://github.com/mahesh4434/GcpDevops', 'idp_infra', '2024-08-12 08:38:16'),
(11, 'NodeApp', 'http://git.intelliswift.com/DevOps_Internal/DevopsInternal_Project.git', 'idp_infra', '2024-10-22 11:42:24'),
(12, 'new_app', 'http://git.intelliswift.com/DevOps_Internal/DevopsInternal_Project.git', 'idp_infra', '2024-10-23 10:02:11');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(2, 'admin', '$2a$10$IBL/TJdM7iR7W7NJo0KONubYEX.MvOKD4hNSTYqOd8.pXG6ioKR2e'),
(3, 'saili', '$2a$10$vZaGebQvYLoPp5S71lON8uB/Z9o.zNce93yHnXENGMlWjCKz16h.S'),
(4, 'admin1', '$2a$10$w1uTBcvF1SHGqKcxYToIqOAwZbvacsgVwnK9ZSrG5pRy9pfU123Me'),
(5, 'saili123', '$2a$10$LUJ3W2R4FT6hfs5m1Zqi0eFWccpa/MJa1HIFsTGuShZvy0tjmX0z6');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clusters`
--
ALTER TABLE `clusters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_scm` (`scm_id`);

--
-- Indexes for table `scm_configurations`
--
ALTER TABLE `scm_configurations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clusters`
--
ALTER TABLE `clusters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `scm_configurations`
--
ALTER TABLE `scm_configurations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clusters`
--
ALTER TABLE `clusters`
  ADD CONSTRAINT `clusters_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_scm` FOREIGN KEY (`scm_id`) REFERENCES `scm_configurations` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
