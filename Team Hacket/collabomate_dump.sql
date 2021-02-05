-- MySQL dump 10.13  Distrib 5.7.31, for Win64 (x86_64)
--
-- Host: localhost    Database: collabomate
-- ------------------------------------------------------
-- Server version	5.7.31-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `open_project_actions`
--

DROP TABLE IF EXISTS `open_project_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `open_project_actions` (
  `action_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `actor_id` int(11) NOT NULL,
  `action_type` varchar(100) NOT NULL,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`action_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `open_project_actions`
--

LOCK TABLES `open_project_actions` WRITE;
/*!40000 ALTER TABLE `open_project_actions` DISABLE KEYS */;
INSERT INTO `open_project_actions` VALUES (1,2,2,'collaborate','Added to Co-Founder'),(2,2,1,'collaborate','Added to Co-Founder'),(3,2,3,'collaborate','Added to Co-Founder'),(4,2,4,'comment','great initiative'),(5,3,1,'collaborate','Added to Co-Founder'),(6,2,1,'comment','WOW'),(7,2,2,'comment','Amazing'),(8,3,1,'comment','wow. nice thought'),(9,3,1,'collaborate','Added to Co-Founder');
/*!40000 ALTER TABLE `open_project_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `open_projects`
--

DROP TABLE IF EXISTS `open_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `open_projects` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `links` varchar(255) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `open_projects`
--

LOCK TABLES `open_projects` WRITE;
/*!40000 ALTER TABLE `open_projects` DISABLE KEYS */;
INSERT INTO `open_projects` VALUES (1,'Life problem dumpster, a complain app or site','Life is not easy, thing can get overwhelmed at one point in life, it can be stressful and effect your daily life, but you don\'t have anyone to listen to, or you just need someone to talk to or text to. An app that will allow people to complain about their life problem and receive an advice or talk thing out to relief their stress problem. Like they can post random issue than receive an advice or talk like crisis text or call, but it can be under anonymous. Its can be anything from work to relationship, crisis line is great but it can be too late to help a person, when a person is already under too much pressure. To prevent those pressure blow off, it needs to resolve in the early stage. So, an app like that can be use in school, workplace, and relationships, the creator can hire a good listener, patience, counselor, or expert in health care. An app like that can help the mind a lot, we have physical health same with the mind, mind and body need to be take good care for a better relationship and better life.','',1,'2021-02-04 23:22:35'),(2,'Environment protection','The problem is that we do not have public awareness and alertness to create sensitivity towards climate change and environment protection. So, I have a idea to generate public awareness and create sensitivity. We can learn from social media, it is empowering tool. I propose that we should develop an App - Prakriti { A social media App}. The model of the app should be like Facebook, where environmental loving people posting their work. Today, a person planted a tree and posted the same on App. Like one saw pollution and shared the post. This can pressurize governments to do more as well as it can create peoples movement.','',2,'2021-02-04 23:24:54'),(3,'Mood Based Chat rooms','Select a chat room based on your mood - like Party - Lonely - Excited and chat with people going through similar emotions. App is loaded with relevant GIFs , reply suggestions etc. to make the conversations interesting','',3,'2021-02-05 00:06:27'),(4,'Easiest way to meet someone','You see a women sitting alone in a pub. Who is she? You asking. Does she waits for someone? Does she planning a trip around? Looking for accommodation or job? Is she single even? But mainly, does she wants to be approached? If she is online and filled all her info into the app, and you have the same app installed, you can find her - you can search the nearest persons online to you. After that, the introduction is much more easier.','',1,'2021-02-05 03:40:26');
/*!40000 ALTER TABLE `open_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `linkedin` varchar(100) DEFAULT NULL,
  `github` varchar(100) DEFAULT NULL,
  `skills` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `links` varchar(255) DEFAULT NULL,
  `registration_number` varchar(11) DEFAULT NULL,
  `batch` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (1,'Yuvraj Dagur','2019pietcsyuvraj196@poornima.org','https://linkedin.com/in/yuvraj-dagur','https://github.com/thatfreakcoder','Python, Machine Learning, Web Development, Full Stack development','pbkdf2:sha256:150000$vjUTdwGl$e4fbff03d8f6bcb423661a4e7a3f848de465b9a2ff059008837e04f45bad0ccb',NULL,'PIET19CS196',2023),(2,'Yash Sankhla','2019pietcsyash192@poornima.org','https://www.linkedin.com/in/yash-sankhla-3506691a8/','https://github.com/yashsankhla21','Python, Web Dev, Ansible, Hadoop, AWS','pbkdf2:sha256:150000$jtdtvZpx$b09da3d7b28327122704adaa6f8788b8b8e82b9ea775da5c207ab02534ff85cd',NULL,'piet19cs192',2023),(3,'Vidhi Doshi','2019pietcsvidhi183@poornima.org','https://www.linkedin.com/in/vidhi-doshi-735b451a9','https://github.com/Asubtlecoderrr','Python, Ansible, Github, Web Development','pbkdf2:sha256:150000$B9dscnR9$6741fddefcfd00e882cd0e101135fa7512b099f509bd43fa34085c53c96dd359',NULL,'piet19cs183',2023),(4,'Parth Rathore','2018pietcsparth111@poornima.org','https://www.linkedin.com/in/parthrathore/','https://github.com/','python, mysql, javascript, html, css, react','pbkdf2:sha256:150000$FKdY7f7H$260ddf7565c3da382d533458b6028facd681a819153ffd956ead69935a3b10d0',NULL,'PIET18CS111',2022);
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `success_stories`
--

DROP TABLE IF EXISTS `success_stories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `success_stories` (
  `story_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `body` varchar(255) DEFAULT NULL,
  `participants` varchar(100) DEFAULT NULL,
  `posted_on` datetime DEFAULT NULL,
  `links` varchar(255) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`story_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `success_stories`
--

LOCK TABLES `success_stories` WRITE;
/*!40000 ALTER TABLE `success_stories` DISABLE KEYS */;
/*!40000 ALTER TABLE `success_stories` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-06  1:00:20
