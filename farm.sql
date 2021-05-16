-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 16 Maj 2021, 19:11
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `animal`
--

INSERT INTO `animal` (`id`, `name`, `weight`, `dateOfBirth`) VALUES
(1, 'Krowa', 1000, '2019-05-01');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `employee`
--

INSERT INTO `employee` (`id`, `firstName`, `lastName`, `login`, `password`, `occupation`) VALUES
(6, 'e', 'e', 'e', 'e', 'e'),
(7, 'a', 'a', 'a', '$argon2i$v=19$m=65536,t=4,p=1$QWdRU2VzT0Yza0JUeHE0eg$65zFS/banFVPRw1mIhPlCuyuUkYVmcwkYixb9qGv8dQ', 'a'),
(8, 'a', 'a', 'a', '$argon2i$v=19$m=65536,t=4,p=1$WGVNQWdCbjVMYmtPSklvZg$6+r9EcCrxJ9tIcfIVp674MJRQAwieFBRfIH12VqruTk', 'a'),
(9, 'r', 'r', 'r', '$argon2i$v=19$m=65536,t=4,p=1$NU1IRERvWU1zOFY5WU9yLg$YMtjS47EMZvHThb29QrBfglWieMmTWCeP+3KcIHnDQI', 'r');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
