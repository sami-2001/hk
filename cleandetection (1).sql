-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2024 at 01:16 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cleandetection`
--

-- --------------------------------------------------------

--
-- Table structure for table `classification`
--

CREATE TABLE `classification` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `status` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classification`
--

INSERT INTO `classification` (`id`, `created_at`, `status`) VALUES
(3, '2024-05-18 16:17:36', 1),
(4, '2024-05-18 16:30:38', 1),
(5, '2024-05-18 16:32:23', 1),
(6, '2024-05-18 16:39:35', 1),
(7, '2024-05-18 16:47:31', 1),
(8, '2024-05-18 17:50:48', 1);

-- --------------------------------------------------------

--
-- Table structure for table `classificationdetails`
--

CREATE TABLE `classificationdetails` (
  `id` int(11) NOT NULL,
  `classificationId` int(11) DEFAULT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `type` enum('clean','unclean','invalid') DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classificationdetails`
--

INSERT INTO `classificationdetails` (`id`, `classificationId`, `image_name`, `type`, `created_at`) VALUES
(1, 3, 'AGON8207.jpg', 'clean', '2024-05-18 16:17:36'),
(2, 3, 'AGON8208.jpg', 'clean', '2024-05-18 16:17:36'),
(3, 3, 'DLOP8246.jpg', 'clean', '2024-05-18 16:17:36'),
(4, 3, 'DLOP8250.jpg', 'clean', '2024-05-18 16:17:36'),
(5, 3, 'DLOP8260.jpg', 'clean', '2024-05-18 16:17:36'),
(6, 3, 'GHOP8248.jpg', 'clean', '2024-05-18 16:17:36'),
(7, 3, 'KUON8179.jpg', 'clean', '2024-05-18 16:17:36'),
(8, 3, 'KUON8181.jpg', 'clean', '2024-05-18 16:17:36'),
(9, 3, 'KUON8184.jpg', 'clean', '2024-05-18 16:17:36'),
(10, 3, 'KUON8185.jpg', 'clean', '2024-05-18 16:17:36'),
(11, 3, 'LUON8166.jpg', 'clean', '2024-05-18 16:17:36'),
(12, 3, 'LUON8167.jpg', 'clean', '2024-05-18 16:17:36'),
(13, 3, 'LUON8169.jpg', 'clean', '2024-05-18 16:17:36'),
(14, 3, 'LUON8170.jpg', 'clean', '2024-05-18 16:17:36'),
(15, 3, 'LUON8172.jpg', 'clean', '2024-05-18 16:17:36'),
(16, 3, 'LUON8173.jpg', 'clean', '2024-05-18 16:17:36'),
(17, 3, 'NKON8113.jpg', 'clean', '2024-05-18 16:17:36'),
(18, 3, 'PUON8061.jpg', 'clean', '2024-05-18 16:17:36'),
(19, 3, 'PUON8080.jpg', 'clean', '2024-05-18 16:17:36'),
(20, 3, 'PUON8091.jpg', 'clean', '2024-05-18 16:17:36'),
(21, 3, 'PUON8116.jpg', 'clean', '2024-05-18 16:17:36'),
(22, 3, 'PUOP8220.jpg', 'clean', '2024-05-18 16:17:36'),
(23, 3, 'TROP8231.jpg', 'clean', '2024-05-18 16:17:36'),
(24, 3, 'AGON8210.jpg', 'unclean', '2024-05-18 16:17:36'),
(25, 3, 'AGON8213.jpg', 'unclean', '2024-05-18 16:17:36'),
(26, 3, 'LUON8165.jpg', 'unclean', '2024-05-18 16:17:36'),
(27, 3, 'LUON8171.jpg', 'unclean', '2024-05-18 16:17:36'),
(28, 3, 'MUON8121.jpg', 'unclean', '2024-05-18 16:17:36'),
(29, 3, 'NAON8102.jpg', 'unclean', '2024-05-18 16:17:36'),
(30, 3, 'UPON8195.jpg', 'unclean', '2024-05-18 16:17:36'),
(31, 3, 'UPON8196.jpg', 'unclean', '2024-05-18 16:17:36'),
(32, 3, 'KUON8183.jpg', 'invalid', '2024-05-18 16:17:36'),
(33, 4, 'AGON8207.jpg', 'clean', '2024-05-18 16:30:38'),
(34, 4, 'AGON8208.jpg', 'clean', '2024-05-18 16:30:38'),
(35, 4, 'DLOP8246.jpg', 'clean', '2024-05-18 16:30:38'),
(36, 4, 'DLOP8250.jpg', 'clean', '2024-05-18 16:30:38'),
(37, 4, 'DLOP8260.jpg', 'clean', '2024-05-18 16:30:38'),
(38, 4, 'GHOP8248.jpg', 'clean', '2024-05-18 16:30:38'),
(39, 4, 'KUON8179.jpg', 'clean', '2024-05-18 16:30:38'),
(40, 4, 'KUON8181.jpg', 'clean', '2024-05-18 16:30:38'),
(41, 4, 'KUON8184.jpg', 'clean', '2024-05-18 16:30:38'),
(42, 4, 'KUON8185.jpg', 'clean', '2024-05-18 16:30:38'),
(43, 4, 'LUON8166.jpg', 'clean', '2024-05-18 16:30:38'),
(44, 4, 'LUON8167.jpg', 'clean', '2024-05-18 16:30:38'),
(45, 4, 'LUON8169.jpg', 'clean', '2024-05-18 16:30:38'),
(46, 4, 'LUON8170.jpg', 'clean', '2024-05-18 16:30:38'),
(47, 4, 'LUON8172.jpg', 'clean', '2024-05-18 16:30:38'),
(48, 4, 'LUON8173.jpg', 'clean', '2024-05-18 16:30:38'),
(49, 4, 'NKON8113.jpg', 'clean', '2024-05-18 16:30:38'),
(50, 4, 'PUON8061.jpg', 'clean', '2024-05-18 16:30:38'),
(51, 4, 'PUON8080.jpg', 'clean', '2024-05-18 16:30:38'),
(52, 4, 'PUON8091.jpg', 'clean', '2024-05-18 16:30:38'),
(53, 4, 'PUON8116.jpg', 'clean', '2024-05-18 16:30:38'),
(54, 4, 'PUOP8220.jpg', 'clean', '2024-05-18 16:30:38'),
(55, 4, 'TROP8231.jpg', 'clean', '2024-05-18 16:30:38'),
(56, 4, 'AGON8210.jpg', 'unclean', '2024-05-18 16:30:38'),
(57, 4, 'AGON8213.jpg', 'unclean', '2024-05-18 16:30:38'),
(58, 4, 'LUON8165.jpg', 'unclean', '2024-05-18 16:30:38'),
(59, 4, 'LUON8171.jpg', 'unclean', '2024-05-18 16:30:38'),
(60, 4, 'MUON8121.jpg', 'unclean', '2024-05-18 16:30:38'),
(61, 4, 'NAON8102.jpg', 'unclean', '2024-05-18 16:30:38'),
(62, 4, 'UPON8195.jpg', 'unclean', '2024-05-18 16:30:38'),
(63, 4, 'UPON8196.jpg', 'unclean', '2024-05-18 16:30:38'),
(64, 4, 'KUON8183.jpg', 'invalid', '2024-05-18 16:30:38'),
(65, 5, 'AGON8207.jpg', 'clean', '2024-05-18 16:32:23'),
(66, 5, 'AGON8208.jpg', 'clean', '2024-05-18 16:32:23'),
(67, 5, 'DLOP8246.jpg', 'clean', '2024-05-18 16:32:23'),
(68, 5, 'DLOP8250.jpg', 'clean', '2024-05-18 16:32:23'),
(69, 5, 'DLOP8260.jpg', 'clean', '2024-05-18 16:32:23'),
(70, 5, 'GHOP8248.jpg', 'clean', '2024-05-18 16:32:23'),
(71, 5, 'KUON8179.jpg', 'clean', '2024-05-18 16:32:23'),
(72, 5, 'KUON8181.jpg', 'clean', '2024-05-18 16:32:23'),
(73, 5, 'KUON8184.jpg', 'clean', '2024-05-18 16:32:23'),
(74, 5, 'KUON8185.jpg', 'clean', '2024-05-18 16:32:23'),
(75, 5, 'LUON8166.jpg', 'clean', '2024-05-18 16:32:23'),
(76, 5, 'LUON8167.jpg', 'clean', '2024-05-18 16:32:23'),
(77, 5, 'LUON8169.jpg', 'clean', '2024-05-18 16:32:23'),
(78, 5, 'LUON8170.jpg', 'clean', '2024-05-18 16:32:23'),
(79, 5, 'LUON8172.jpg', 'clean', '2024-05-18 16:32:23'),
(80, 5, 'LUON8173.jpg', 'clean', '2024-05-18 16:32:23'),
(81, 5, 'NKON8113.jpg', 'clean', '2024-05-18 16:32:23'),
(82, 5, 'PUON8061.jpg', 'clean', '2024-05-18 16:32:23'),
(83, 5, 'PUON8080.jpg', 'clean', '2024-05-18 16:32:23'),
(84, 5, 'PUON8091.jpg', 'clean', '2024-05-18 16:32:23'),
(85, 5, 'PUON8116.jpg', 'clean', '2024-05-18 16:32:23'),
(86, 5, 'PUOP8220.jpg', 'clean', '2024-05-18 16:32:23'),
(87, 5, 'TROP8231.jpg', 'clean', '2024-05-18 16:32:23'),
(88, 5, 'AGON8210.jpg', 'unclean', '2024-05-18 16:32:23'),
(89, 5, 'AGON8213.jpg', 'unclean', '2024-05-18 16:32:23'),
(90, 5, 'LUON8165.jpg', 'unclean', '2024-05-18 16:32:23'),
(91, 5, 'LUON8171.jpg', 'unclean', '2024-05-18 16:32:23'),
(92, 5, 'MUON8121.jpg', 'unclean', '2024-05-18 16:32:23'),
(93, 5, 'NAON8102.jpg', 'unclean', '2024-05-18 16:32:23'),
(94, 5, 'UPON8195.jpg', 'unclean', '2024-05-18 16:32:23'),
(95, 5, 'UPON8196.jpg', 'unclean', '2024-05-18 16:32:23'),
(96, 5, 'KUON8183.jpg', 'invalid', '2024-05-18 16:32:23'),
(97, 6, 'AGON8207.jpg', 'clean', '2024-05-18 16:39:35'),
(98, 6, 'AGON8208.jpg', 'clean', '2024-05-18 16:39:35'),
(99, 6, 'DLOP8246.jpg', 'clean', '2024-05-18 16:39:35'),
(100, 6, 'DLOP8250.jpg', 'clean', '2024-05-18 16:39:35'),
(101, 6, 'DLOP8260.jpg', 'clean', '2024-05-18 16:39:35'),
(102, 6, 'GHOP8248.jpg', 'clean', '2024-05-18 16:39:35'),
(103, 6, 'KUON8179.jpg', 'clean', '2024-05-18 16:39:35'),
(104, 6, 'KUON8181.jpg', 'clean', '2024-05-18 16:39:35'),
(105, 6, 'KUON8184.jpg', 'clean', '2024-05-18 16:39:35'),
(106, 6, 'KUON8185.jpg', 'clean', '2024-05-18 16:39:35'),
(107, 6, 'LUON8166.jpg', 'clean', '2024-05-18 16:39:35'),
(108, 6, 'LUON8167.jpg', 'clean', '2024-05-18 16:39:35'),
(109, 6, 'LUON8169.jpg', 'clean', '2024-05-18 16:39:35'),
(110, 6, 'LUON8170.jpg', 'clean', '2024-05-18 16:39:35'),
(111, 6, 'LUON8172.jpg', 'clean', '2024-05-18 16:39:35'),
(112, 6, 'LUON8173.jpg', 'clean', '2024-05-18 16:39:35'),
(113, 6, 'NKON8113.jpg', 'clean', '2024-05-18 16:39:35'),
(114, 6, 'PUON8061.jpg', 'clean', '2024-05-18 16:39:35'),
(115, 6, 'PUON8080.jpg', 'clean', '2024-05-18 16:39:35'),
(116, 6, 'PUON8091.jpg', 'clean', '2024-05-18 16:39:35'),
(117, 6, 'PUON8116.jpg', 'clean', '2024-05-18 16:39:35'),
(118, 6, 'PUOP8220.jpg', 'clean', '2024-05-18 16:39:35'),
(119, 6, 'TROP8231.jpg', 'clean', '2024-05-18 16:39:35'),
(120, 6, 'AGON8210.jpg', 'unclean', '2024-05-18 16:39:35'),
(121, 6, 'AGON8213.jpg', 'unclean', '2024-05-18 16:39:35'),
(122, 6, 'LUON8165.jpg', 'unclean', '2024-05-18 16:39:35'),
(123, 6, 'LUON8171.jpg', 'unclean', '2024-05-18 16:39:35'),
(124, 6, 'MUON8121.jpg', 'unclean', '2024-05-18 16:39:35'),
(125, 6, 'NAON8102.jpg', 'unclean', '2024-05-18 16:39:35'),
(126, 6, 'UPON8195.jpg', 'unclean', '2024-05-18 16:39:35'),
(127, 6, 'UPON8196.jpg', 'unclean', '2024-05-18 16:39:35'),
(128, 6, 'KUON8183.jpg', 'invalid', '2024-05-18 16:39:35'),
(129, 7, 'AGON8207.jpg', 'clean', '2024-05-18 16:47:31'),
(130, 7, 'AGON8208.jpg', 'clean', '2024-05-18 16:47:31'),
(131, 7, 'DLOP8246.jpg', 'clean', '2024-05-18 16:47:31'),
(132, 7, 'DLOP8250.jpg', 'clean', '2024-05-18 16:47:31'),
(133, 7, 'DLOP8260.jpg', 'clean', '2024-05-18 16:47:31'),
(134, 7, 'GHOP8248.jpg', 'clean', '2024-05-18 16:47:31'),
(135, 7, 'KUON8179.jpg', 'clean', '2024-05-18 16:47:31'),
(136, 7, 'KUON8181.jpg', 'clean', '2024-05-18 16:47:31'),
(137, 7, 'KUON8184.jpg', 'clean', '2024-05-18 16:47:31'),
(138, 7, 'KUON8185.jpg', 'clean', '2024-05-18 16:47:31'),
(139, 7, 'LUON8166.jpg', 'clean', '2024-05-18 16:47:31'),
(140, 7, 'LUON8167.jpg', 'clean', '2024-05-18 16:47:31'),
(141, 7, 'LUON8169.jpg', 'clean', '2024-05-18 16:47:31'),
(142, 7, 'LUON8170.jpg', 'clean', '2024-05-18 16:47:31'),
(143, 7, 'LUON8172.jpg', 'clean', '2024-05-18 16:47:31'),
(144, 7, 'LUON8173.jpg', 'clean', '2024-05-18 16:47:31'),
(145, 7, 'NKON8113.jpg', 'clean', '2024-05-18 16:47:31'),
(146, 7, 'PUON8061.jpg', 'clean', '2024-05-18 16:47:31'),
(147, 7, 'PUON8080.jpg', 'clean', '2024-05-18 16:47:31'),
(148, 7, 'PUON8091.jpg', 'clean', '2024-05-18 16:47:31'),
(149, 7, 'PUON8116.jpg', 'clean', '2024-05-18 16:47:31'),
(150, 7, 'PUOP8220.jpg', 'clean', '2024-05-18 16:47:31'),
(151, 7, 'TROP8231.jpg', 'clean', '2024-05-18 16:47:31'),
(152, 7, 'AGON8210.jpg', 'unclean', '2024-05-18 16:47:31'),
(153, 7, 'AGON8213.jpg', 'unclean', '2024-05-18 16:47:31'),
(154, 7, 'LUON8165.jpg', 'unclean', '2024-05-18 16:47:31'),
(155, 7, 'LUON8171.jpg', 'unclean', '2024-05-18 16:47:31'),
(156, 7, 'MUON8121.jpg', 'unclean', '2024-05-18 16:47:31'),
(157, 7, 'NAON8102.jpg', 'unclean', '2024-05-18 16:47:31'),
(158, 7, 'UPON8195.jpg', 'unclean', '2024-05-18 16:47:31'),
(159, 7, 'UPON8196.jpg', 'unclean', '2024-05-18 16:47:31'),
(160, 7, 'KUON8183.jpg', 'invalid', '2024-05-18 16:47:31'),
(161, 8, 'SECNG225.jpg', 'clean', '2024-05-18 17:50:48'),
(162, 8, 'SECNH251.jpg', 'clean', '2024-05-18 17:50:48'),
(163, 8, 'SECNH288.jpg', 'clean', '2024-05-18 17:50:48'),
(164, 8, 'SECNH289.jpg', 'clean', '2024-05-18 17:50:48'),
(165, 8, 'SECNH532.jpg', 'clean', '2024-05-18 17:50:48'),
(166, 8, 'SECNH558.jpg', 'clean', '2024-05-18 17:50:48'),
(167, 8, 'SECNH842.jpg', 'clean', '2024-05-18 17:50:48'),
(168, 8, 'SECNH845.jpg', 'clean', '2024-05-18 17:50:48'),
(169, 8, 'SECNH871.jpg', 'clean', '2024-05-18 17:50:48'),
(170, 8, 'SECNT131.jpg', 'clean', '2024-05-18 17:50:48'),
(171, 8, 'SECPR387.jpg', 'clean', '2024-05-18 17:50:48'),
(172, 8, 'SECPR388.jpg', 'clean', '2024-05-18 17:50:48'),
(173, 8, 'SECPR451.jpg', 'clean', '2024-05-18 17:50:48'),
(174, 8, 'SECPR553.jpg', 'clean', '2024-05-18 17:50:48'),
(175, 8, 'SECPR554.jpg', 'clean', '2024-05-18 17:50:48'),
(176, 8, 'SECPS731.jpg', 'clean', '2024-05-18 17:50:48'),
(177, 8, 'SECPS732.jpg', 'clean', '2024-05-18 17:50:48'),
(178, 8, 'SECPS733.jpg', 'clean', '2024-05-18 17:50:48'),
(179, 8, 'SECPS736.jpg', 'clean', '2024-05-18 17:50:48'),
(180, 8, 'SECPS737.jpg', 'clean', '2024-05-18 17:50:48'),
(181, 8, 'SECPS743.jpg', 'clean', '2024-05-18 17:50:48'),
(182, 8, 'SECPS744.jpg', 'clean', '2024-05-18 17:50:48'),
(183, 8, 'SECPT137.jpg', 'clean', '2024-05-18 17:50:48'),
(184, 8, 'SECPT139.jpg', 'clean', '2024-05-18 17:50:48'),
(185, 8, 'SECPT142.jpg', 'clean', '2024-05-18 17:50:48'),
(186, 8, 'SECPT144.jpg', 'clean', '2024-05-18 17:50:48'),
(187, 8, 'SECPT155.jpg', 'clean', '2024-05-18 17:50:48'),
(188, 8, 'SECNH317.jpg', 'unclean', '2024-05-18 17:50:48'),
(189, 8, 'SECPR389.jpg', 'unclean', '2024-05-18 17:50:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `classification`
--
ALTER TABLE `classification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `classificationdetails`
--
ALTER TABLE `classificationdetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `classificationId` (`classificationId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `classification`
--
ALTER TABLE `classification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `classificationdetails`
--
ALTER TABLE `classificationdetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `classificationdetails`
--
ALTER TABLE `classificationdetails`
  ADD CONSTRAINT `classificationdetails_ibfk_1` FOREIGN KEY (`classificationId`) REFERENCES `classification` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
