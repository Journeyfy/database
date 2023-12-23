-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Creato il: Dic 23, 2023 alle 15:54
-- Versione del server: 8.0.21
-- Versione PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `journeyfy`
--
CREATE DATABASE IF NOT EXISTS `journeyfy` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `journeyfy`;

-- --------------------------------------------------------

--
-- Struttura della tabella `blog`
--

DROP TABLE IF EXISTS `blog`;
CREATE TABLE IF NOT EXISTS `blog` (
  `idBlog` char(36) NOT NULL,
  `idUser` char(36) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `createdOnUtc` datetime NOT NULL,
  PRIMARY KEY (`idBlog`),
  KEY `fk_blog_user_idUser` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `blogarticle`
--

DROP TABLE IF EXISTS `blogarticle`;
CREATE TABLE IF NOT EXISTS `blogarticle` (
  `idBlogArticle` int NOT NULL AUTO_INCREMENT,
  `idBlog` char(36) NOT NULL,
  `article` text,
  PRIMARY KEY (`idBlogArticle`),
  KEY `fk_blogarticle_blog_idBlog` (`idBlog`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `blogmedia`
--

DROP TABLE IF EXISTS `blogmedia`;
CREATE TABLE IF NOT EXISTS `blogmedia` (
  `idBlogMedia` int NOT NULL AUTO_INCREMENT,
  `idBlog` char(36) NOT NULL,
  `media` blob NOT NULL,
  PRIMARY KEY (`idBlogMedia`),
  KEY `fk_blogmedia_blog_idBlog` (`idBlog`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `destination`
--

DROP TABLE IF EXISTS `destination`;
CREATE TABLE IF NOT EXISTS `destination` (
  `idDestination` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `popularity` tinyint DEFAULT NULL,
  PRIMARY KEY (`idDestination`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `destinationcoverimage`
--

DROP TABLE IF EXISTS `destinationcoverimage`;
CREATE TABLE IF NOT EXISTS `destinationcoverimage` (
  `idDestination` int NOT NULL,
  `image` blob,
  PRIMARY KEY (`idDestination`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `todo`
--

DROP TABLE IF EXISTS `todo`;
CREATE TABLE IF NOT EXISTS `todo` (
  `idTodo` int NOT NULL AUTO_INCREMENT,
  `idDestination` int NOT NULL,
  `type` int NOT NULL,
  `mapLink` varchar(255) DEFAULT NULL,
  `openAt` varchar(255) DEFAULT NULL,
  `closeAt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idTodo`),
  KEY `fk_todo_destination_idDestination` (`idDestination`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `todorequest`
--

DROP TABLE IF EXISTS `todorequest`;
CREATE TABLE IF NOT EXISTS `todorequest` (
  `idRequest` char(36) NOT NULL,
  `status` int NOT NULL,
  `requestType` int NOT NULL,
  `idTodo` int DEFAULT NULL,
  `idUser` char(36) NOT NULL,
  `idDestination` int NOT NULL,
  `todoType` int NOT NULL,
  `mapLink` varchar(255) DEFAULT NULL,
  `openAt` varchar(255) DEFAULT NULL,
  `closeAt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idRequest`),
  KEY `fk_todorequest_todo_idTodo` (`idTodo`),
  KEY `fk_todorequest_user_idUser` (`idUser`),
  KEY `fk_todorequest_destination_idDestination` (`idDestination`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `idUser` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `idRole` int NOT NULL,
  `registeredOnUtc` datetime NOT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `blog`
--
ALTER TABLE `blog`
  ADD CONSTRAINT `fk_blog_user_idUser` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`);

--
-- Limiti per la tabella `blogarticle`
--
ALTER TABLE `blogarticle`
  ADD CONSTRAINT `fk_blogarticle_blog_idBlog` FOREIGN KEY (`idBlog`) REFERENCES `blog` (`idBlog`);

--
-- Limiti per la tabella `blogmedia`
--
ALTER TABLE `blogmedia`
  ADD CONSTRAINT `fk_blogmedia_blog_idBlog` FOREIGN KEY (`idBlog`) REFERENCES `blog` (`idBlog`);

--
-- Limiti per la tabella `destinationcoverimage`
--
ALTER TABLE `destinationcoverimage`
  ADD CONSTRAINT `fk_destinationcoverimage_destination_idDestination` FOREIGN KEY (`idDestination`) REFERENCES `destination` (`idDestination`);

--
-- Limiti per la tabella `todo`
--
ALTER TABLE `todo`
  ADD CONSTRAINT `fk_todo_destination_idDestination` FOREIGN KEY (`idDestination`) REFERENCES `destination` (`idDestination`);

--
-- Limiti per la tabella `todorequest`
--
ALTER TABLE `todorequest`
  ADD CONSTRAINT `fk_todorequest_destination_idDestination` FOREIGN KEY (`idDestination`) REFERENCES `destination` (`idDestination`),
  ADD CONSTRAINT `fk_todorequest_todo_idTodo` FOREIGN KEY (`idTodo`) REFERENCES `todo` (`idTodo`),
  ADD CONSTRAINT `fk_todorequest_user_idUser` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
