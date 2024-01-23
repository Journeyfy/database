SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `idBlog` char(36) NOT NULL,
  `idUser` char(36) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `createdOnUtc` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `blogarticle`;
CREATE TABLE `blogarticle` (
  `idBlogArticle` int NOT NULL,
  `idBlog` char(36) NOT NULL,
  `article` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `blogmedia`;
CREATE TABLE `blogmedia` (
  `idBlogMedia` int NOT NULL,
  `idBlog` char(36) NOT NULL,
  `media` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `destination`;
CREATE TABLE `destination` (
  `idDestination` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `popularity` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `destinationcoverimage`;
CREATE TABLE `destinationcoverimage` (
  `idDestination` int NOT NULL,
  `image` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `suggestion`;
CREATE TABLE `suggestion` (
  `idSuggestion` int NOT NULL,
  `idDestination` int NOT NULL,
  `type` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mapLink` varchar(255) DEFAULT NULL,
  `openAt` varchar(255) DEFAULT NULL,
  `closeAt` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `suggestionrequest`;
CREATE TABLE `suggestionrequest` (
  `idRequest` char(36) NOT NULL,
  `status` int NOT NULL,
  `requestType` int NOT NULL,
  `idSuggestion` int DEFAULT NULL,
  `idUser` char(36) NOT NULL,
  `idDestination` int NOT NULL,
  `suggestionType` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `mapLink` varchar(255) DEFAULT NULL,
  `openAt` varchar(255) DEFAULT NULL,
  `closeAt` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `idUser` char(36) NOT NULL,
  `firstName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lastName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `idRole` int NOT NULL,
  `picture` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `registeredOnUtc` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `blog`
  ADD PRIMARY KEY (`idBlog`),
  ADD KEY `fk_blog_user_idUser` (`idUser`);

ALTER TABLE `blogarticle`
  ADD PRIMARY KEY (`idBlogArticle`),
  ADD KEY `fk_blogarticle_blog_idBlog` (`idBlog`);

ALTER TABLE `blogmedia`
  ADD PRIMARY KEY (`idBlogMedia`),
  ADD KEY `fk_blogmedia_blog_idBlog` (`idBlog`);

ALTER TABLE `destination`
  ADD PRIMARY KEY (`idDestination`);

ALTER TABLE `destinationcoverimage`
  ADD PRIMARY KEY (`idDestination`);

ALTER TABLE `suggestion`
  ADD PRIMARY KEY (`idSuggestion`),
  ADD KEY `fk_suggestion_destination_idDestination` (`idDestination`) USING BTREE;

ALTER TABLE `suggestionrequest`
  ADD PRIMARY KEY (`idRequest`),
  ADD KEY `fk_suggestionrequest_destination_idDestination` (`idDestination`) USING BTREE,
  ADD KEY `fk_suggestionrequest_user_idUser` (`idUser`) USING BTREE,
  ADD KEY `fk_suggestionrequest_suggestion_idSuggestion` (`idSuggestion`) USING BTREE;

ALTER TABLE `user`
  ADD PRIMARY KEY (`idUser`),
  ADD UNIQUE KEY `email` (`email`);


ALTER TABLE `blogarticle`
  MODIFY `idBlogArticle` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `blogmedia`
  MODIFY `idBlogMedia` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `destination`
  MODIFY `idDestination` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `suggestion`
  MODIFY `idSuggestion` int NOT NULL AUTO_INCREMENT;


ALTER TABLE `blog`
  ADD CONSTRAINT `fk_blog_user_idUser` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`);

ALTER TABLE `blogarticle`
  ADD CONSTRAINT `fk_blogarticle_blog_idBlog` FOREIGN KEY (`idBlog`) REFERENCES `blog` (`idBlog`);

ALTER TABLE `blogmedia`
  ADD CONSTRAINT `fk_blogmedia_blog_idBlog` FOREIGN KEY (`idBlog`) REFERENCES `blog` (`idBlog`);

ALTER TABLE `destinationcoverimage`
  ADD CONSTRAINT `fk_destinationcoverimage_destination_idDestination` FOREIGN KEY (`idDestination`) REFERENCES `destination` (`idDestination`);

ALTER TABLE `suggestion`
  ADD CONSTRAINT `fk_suggestion_destination_idDestination` FOREIGN KEY (`idDestination`) REFERENCES `destination` (`idDestination`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `suggestionrequest`
  ADD CONSTRAINT `fk_suggestionrequest_destination_idDestination` FOREIGN KEY (`idDestination`) REFERENCES `destination` (`idDestination`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_suggestionrequest_suggestion_idSuggestion` FOREIGN KEY (`idSuggestion`) REFERENCES `suggestion` (`idSuggestion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_suggestionrequest_user_idUser` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
