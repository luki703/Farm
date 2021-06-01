-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 01 Cze 2021, 22:27
-- Wersja serwera: 10.4.18-MariaDB
-- Wersja PHP: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `farm`
--
CREATE DATABASE IF NOT EXISTS `farm` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `farm`;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(64) NOT NULL,
  `password` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `admin`
--

INSERT INTO `admin` (`id`, `login`, `password`) VALUES
(1, 'admin', '$argon2i$v=19$m=65536,t=4,p=1$UEM1YmJtUWZFQVFNd2RXNg$Vpj4zxtjbZTWDRNtrGW5n8Azwb0nhDcNPaZCaUp5TTU');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `animal`
--

CREATE TABLE IF NOT EXISTS `animal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `weight` float NOT NULL,
  `dateOfBirth` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `animal`
--

INSERT INTO `animal` (`id`, `name`, `weight`, `dateOfBirth`) VALUES
(1, 'Krowa', 1000, '2019-05-01'),
(2, 'Krowa', 890, '2021-05-06'),
(3, 'Świnia', 500, '1112-03-18'),
(5, 'Koń', 500, '2021-02-03');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `employee`
--

CREATE TABLE IF NOT EXISTS `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(128) NOT NULL,
  `lastName` varchar(256) NOT NULL,
  `login` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `occupation` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `employee`
--

INSERT INTO `employee` (`id`, `firstName`, `lastName`, `login`, `password`, `occupation`) VALUES
(11, 'Andrzej', 'Kapusta', 'andrzejk', '$argon2i$v=19$m=65536,t=4,p=1$Lkc1UlNoODBpcVFyTnJBSQ$dqg5weorKw7bpMfFmhjaTJWbcMrc/shJ6kh7OuYoXVE', 'Kierownik'),
(12, 'Stefan', 'Ogórek', 'stefano', '$argon2i$v=19$m=65536,t=4,p=1$VnhFSU02TlJSam9YUHRjTA$Yz7Q1zI0krB8/r/849hSNInyBvClpeaRtM+jtW17aPA', 'Hodowca świń'),
(16, 'Janusz', 'Cebula', 'jcebul', '$argon2i$v=19$m=65536,t=4,p=1$aHZSbFU2WG9NQnU3Y3kxWg$8F/s0AtNdsk4xXHCFL0u+TAALgI+vRk3ATkRZVV6eUM', 'Junior Web Developer'),
(17, 'Janusz', 'Kapusta', 'Jkapo', '$argon2i$v=19$m=65536,t=4,p=1$My5tbk1OL3NtdHZadHdGbA$hNqMremq4bNDJjg4XWjJsd1zJhv5A59CHlWUpji2pCE', 'Brat kierownika');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `note`
--

CREATE TABLE IF NOT EXISTS `note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_Id` int(11) NOT NULL,
  `animal_Id` int(11) NOT NULL,
  `title` varchar(24) NOT NULL,
  `content` text NOT NULL,
  `createDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `employeeId` (`employee_Id`,`animal_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `note`
--

INSERT INTO `note` (`id`, `employee_Id`, `animal_Id`, `title`, `content`, `createDate`) VALUES
(1, 11, 1, 'Dziwne zachowanie', 'tekst', '2021-05-23 15:48:19'),
(2, 0, 2, 'to jest krowa nr2', 'tresc krowa 2', '2021-05-25 20:42:18'),
(13, 0, 2, 'dfsf', 'ssfsf', '2021-05-26 16:28:59'),
(15, 0, 1, 'test2077', 'teskst 2077', '2021-06-01 09:28:35'),
(16, 0, 1, 'test3', 'sdfsdf', '2021-06-01 18:49:48'),
(17, 0, 1, 'dfsf', 'ssfsf', '2021-06-01 19:14:36'),
(18, 0, 1, 'test3', 'sdfsdf', '2021-06-01 19:16:09'),
(19, 0, 5, 'test3', 'sdfsdf', '2021-06-01 19:30:21'),
(20, 0, 1, 'test3', 'ssfsf', '2021-06-01 19:34:07'),
(21, 0, 1, 'dfsf', 'ssfsf', '2021-06-01 19:56:36'),
(22, 0, 2, 'to jest krowa nr2', 'jkapo', '2021-06-01 20:02:05'),
(23, 16, 1, 'test3', 'glupi test', '2021-06-01 20:24:32');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `vetvisit`
--

CREATE TABLE IF NOT EXISTS `vetvisit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `animal_Id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `cause` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `animal_Id` (`animal_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `vetvisit`
--

INSERT INTO `vetvisit` (`id`, `animal_Id`, `date`, `cause`) VALUES
(1, 2, '2021-05-28 23:06:11', 'Brudne zęby'),
(17, 1, '2021-05-20 19:25:00', '321'),
(18, 1, '2021-05-27 19:37:00', 'tekst'),
(19, 1, '2021-05-19 19:40:00', 'tak sobie');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `workschedule`
--

CREATE TABLE IF NOT EXISTS `workschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shiftStart` date NOT NULL,
  `status` text NOT NULL,
  `shiftTimeStart` time NOT NULL,
  `shiftTimeEnd` time NOT NULL,
  `employeeId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employeeId` (`employeeId`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `workschedule`
--

INSERT INTO `workschedule` (`id`, `shiftStart`, `status`, `shiftTimeStart`, `shiftTimeEnd`, `employeeId`) VALUES
(20, '2021-05-24', '1', '08:00:00', '16:00:00', 11),
(21, '2021-05-24', '0', '06:45:00', '16:45:00', 12),
(22, '2021-05-25', '0', '06:45:00', '16:45:00', 12),
(24, '2021-05-27', '0', '06:45:00', '16:45:00', 12),
(25, '2021-05-28', '0', '06:45:00', '16:45:00', 12),
(31, '2021-05-31', '0', '19:36:00', '23:39:00', 16),
(32, '2021-06-01', '0', '19:36:00', '23:39:00', 16),
(33, '2021-06-02', '0', '19:36:00', '23:39:00', 16),
(34, '2021-06-03', '0', '19:36:00', '23:39:00', 16),
(35, '2021-06-04', '0', '19:36:00', '23:39:00', 16),
(36, '2021-06-02', '1', '21:37:00', '23:37:00', 17),
(37, '2021-06-03', '1', '21:37:00', '23:37:00', 17),
(38, '2021-06-04', '1', '21:37:00', '23:37:00', 17),
(39, '2021-06-05', '1', '21:37:00', '23:37:00', 17),
(40, '2021-06-06', '1', '21:37:00', '23:37:00', 17),
(41, '2021-06-07', '1', '21:37:00', '23:37:00', 17),
(42, '2021-06-08', '1', '21:37:00', '23:37:00', 17),
(43, '2021-06-09', '1', '21:37:00', '23:37:00', 17),
(44, '2021-06-10', '1', '21:37:00', '23:37:00', 17),
(45, '2021-06-11', '0', '21:37:00', '23:37:00', 17),
(46, '2021-06-12', '1', '21:37:00', '23:37:00', 17),
(47, '2021-06-13', '0', '21:37:00', '23:37:00', 17),
(48, '2021-06-14', '0', '21:37:00', '23:37:00', 17),
(49, '2021-06-15', '0', '21:37:00', '23:37:00', 17),
(50, '2021-06-16', '1', '21:37:00', '23:37:00', 17),
(51, '2021-06-17', '0', '21:37:00', '23:37:00', 17),
(52, '2021-06-18', '0', '21:37:00', '23:37:00', 17),
(53, '2021-06-19', '0', '21:37:00', '23:37:00', 17),
(54, '2021-06-20', '1', '21:37:00', '23:37:00', 17),
(55, '2021-06-21', '0', '21:37:00', '23:37:00', 17),
(56, '2021-06-22', '1', '21:37:00', '23:37:00', 17),
(57, '2021-06-23', '0', '21:37:00', '23:37:00', 17),
(58, '2021-06-24', '0', '21:37:00', '23:37:00', 17);

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `workschedule`
--
ALTER TABLE `workschedule`
  ADD CONSTRAINT `workschedule_ibfk_1` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
