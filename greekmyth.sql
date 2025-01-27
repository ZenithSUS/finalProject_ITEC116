-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 22, 2024 at 01:48 PM
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
-- Database: `greekmyth`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `activity_id` int(11) NOT NULL,
  `post_id` varchar(36) DEFAULT NULL,
  `comment_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) NOT NULL,
  `activity` varchar(225) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`activity_id`, `post_id`, `comment_id`, `user_id`, `activity`, `timestamp`) VALUES
(269, 'e5def715-afb4-11ef-b843-7c05075eb45f', NULL, 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'created a post with title Hello Everyone', '2024-12-01 07:21:36'),
(270, NULL, '674c12c685f9f', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'commennted on a post titled Hello Everyone', '2024-12-01 07:39:50'),
(271, '7fcbd401-afb7-11ef-b843-7c05075eb45f', NULL, 'b2348003-afb6-11ef-b843-7c05075eb45f', 'created a post with title DeezNuts in Zeus discussion', '2024-12-01 07:40:13'),
(272, '929b05df-b2b8-11ef-a194-7c05075eb45f', NULL, 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'created a post with title Hot God in Athena discussion', '2024-12-05 03:25:27'),
(273, 'e4201f31-b6b4-11ef-ba98-7c05075eb45f', NULL, 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'created a post with title Hello World! in Athena discussion', '2024-12-10 05:09:11'),
(274, NULL, '6757ce9c1152b', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'commennted on a post titled Hot God', '2024-12-10 05:16:12'),
(275, NULL, '6757d0e711389', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'commennted on a post titled Hello World!', '2024-12-10 05:25:59'),
(276, '8bfb2587-b6b7-11ef-ba98-7c05075eb45f', NULL, 'b2348003-afb6-11ef-b843-7c05075eb45f', 'created a post with title New God Adam in ZenithSUS discussion', '2024-12-10 05:28:11'),
(277, 'd6e2e6a2-b6b7-11ef-ba98-7c05075eb45f', NULL, 'b2348003-afb6-11ef-b843-7c05075eb45f', 'created a post with title New God Yasuo', '2024-12-10 05:30:17'),
(278, NULL, '6757d224160c8', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'commennted on a post titled DeezNuts', '2024-12-10 05:31:16'),
(279, NULL, '6757d23022722', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'replied to a comment titled DeezNuts', '2024-12-10 05:31:28'),
(280, '393e5747-b78c-11ef-8962-7c05075eb45f', NULL, '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'created a post with title Do you know the wae', '2024-12-11 06:50:35'),
(281, '141c1b49-b791-11ef-8962-7c05075eb45f', NULL, '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'created a post with title Do you know the wae in Zeus discussion', '2024-12-11 07:25:22');

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` varchar(36) NOT NULL,
  `username` varchar(225) NOT NULL,
  `email` varchar(225) NOT NULL,
  `password` varchar(225) NOT NULL,
  `image_src` varchar(225) DEFAULT NULL,
  `token` varchar(225) DEFAULT NULL,
  `verified` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `username`, `email`, `password`, `image_src`, `token`, `verified`) VALUES
('14781496-bc92-11ef-821c-7c05075eb45f', 'ZenZen!', 'zen@gmail.com', '$2y$10$DlTwWFdOfHYth3bagK7eae7AxCypE/UxrS121O59Q9dyJvrAdJvtS', '6761a38a889468.84705412.jpg', '01c72f702d89e21f96d9eef733ad4c1f651bc4acf7c4e09ec789e485d092128b', 1),
('aad38520-b88f-11ef-88fc-7c05075eb45f', 'ZenithSUS', 'admin2@gmail.com', '$2y$10$zILK0pdKGNaQeZQKcHG6GuZQrqtdw5aeJs.2BpTwSQYTSE.6f/tgO', NULL, NULL, 0),
('f648bd9c-b44c-11ef-8671-7c05075eb45f', 'Admin', 'admin@gmail.com', '$2y$10$IfebmCNLf/aQukTotaCpWeUib/sLNlDHl58hkRw3PU8cRiEYIm.di', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` varchar(36) NOT NULL,
  `post_id` varchar(36) NOT NULL,
  `parent_comment` varchar(36) DEFAULT NULL,
  `author` varchar(36) NOT NULL,
  `content` text NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `dislikes` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `post_id`, `parent_comment`, `author`, `content`, `likes`, `dislikes`, `created_at`) VALUES
('674c12c685f9f', 'e5def715-afb4-11ef-b843-7c05075eb45f', NULL, 'b2348003-afb6-11ef-b843-7c05075eb45f', 'Nice', 1, 0, '2024-12-01 15:39:50'),
('6757ce9c1152b', '929b05df-b2b8-11ef-a194-7c05075eb45f', NULL, 'b2348003-afb6-11ef-b843-7c05075eb45f', 'sad', 0, 0, '2024-12-10 13:16:12'),
('6757d0e711389', 'e4201f31-b6b4-11ef-ba98-7c05075eb45f', NULL, 'b2348003-afb6-11ef-b843-7c05075eb45f', 'Hello', 0, 0, '2024-12-10 13:25:59'),
('6757d224160c8', '7fcbd401-afb7-11ef-b843-7c05075eb45f', NULL, 'b2348003-afb6-11ef-b843-7c05075eb45f', 'I agree me', 1, 0, '2024-12-10 13:31:16'),
('6757d23022722', '7fcbd401-afb7-11ef-b843-7c05075eb45f', '6757d224160c8', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'HELLL YEAHHH!!!', 1, 0, '2024-12-10 13:31:28');

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE `friends` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `friend_id` varchar(36) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `friends`
--

INSERT INTO `friends` (`id`, `user_id`, `friend_id`, `created_at`) VALUES
('0429bafa-b789-11ef-8962-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '2024-12-11 06:27:38'),
('04356047-b789-11ef-8962-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '2024-12-11 06:27:38'),
('68b73145-b2b8-11ef-a194-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '2024-12-05 03:24:17'),
('68bdda1e-b2b8-11ef-a194-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', '2024-12-05 03:24:17');

-- --------------------------------------------------------

--
-- Table structure for table `friend_requests`
--

CREATE TABLE `friend_requests` (
  `id` varchar(36) NOT NULL,
  `requester_id` varchar(36) NOT NULL,
  `requestee_id` varchar(36) NOT NULL,
  `status` enum('pending','accepted','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `friend_requests`
--

INSERT INTO `friend_requests` (`id`, `requester_id`, `requestee_id`, `status`, `created_at`) VALUES
('52144d80-b793-11ef-8962-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'pending', '2024-12-11 07:41:24');

-- --------------------------------------------------------

--
-- Table structure for table `greeks`
--

CREATE TABLE `greeks` (
  `greek_id` varchar(36) NOT NULL,
  `name` varchar(36) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(225) DEFAULT NULL,
  `creator` varchar(36) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `greeks`
--

INSERT INTO `greeks` (`greek_id`, `name`, `description`, `image_url`, `creator`) VALUES
('0db1bfad-2ba8-11ef-a131-7c05075eb45f', 'Hermes', 'Hermes, the quick-witted Greek god of trade, thieves, travelers, sports, athletes, and border crossings, is often portrayed as a young, athletic man wearing a winged hat and sandals. He is known for his cunning and mischievous nature, as well as his role as the messenger of the gods. Hermes is also associated with fertility, luck, and wealth, and is often depicted carrying a caduceus, a winged staff entwined with two serpents.', 'HERMES.webp', 'Default'),
('1c87d062-2ba3-11ef-a131-7c05075eb45f', 'Hades', 'Hades, in ancient Greek religion, is the god of the underworld. He was a son of the Titans Cronus and Rhea and the brother of Zeus, Poseidon, and Hera. Hades ruled alongside his queen, Persephone, over the dead, although he was not typically a judge or responsible for torturing the guilty—tasks assigned to the Furies', 'HADES.webp', 'Default'),
('2adbfbd3-2ba2-11ef-a131-7c05075eb45f', 'Apollo', 'Apollo, one of the Twelve Olympians in Greek mythology, is the son of Zeus and Leto, and the twin brother of Artemis. He embodies a multitude of roles: the god of healing, medicine, archery, music, dance, poetry, prophecy, knowledge, light, and the sun. Apollo is also the leader of the Muses', 'APOLLO.webp', 'Default'),
('2b013a64-2ba0-11ef-a131-7c05075eb45f', 'Aphrodite', 'Aphrodite, the ancient Greek goddess of sexual love and beauty, is closely associated with Venus in Roman mythology. According to Hesiod’s Theogony, she emerged from the white foam created by the severed genitals of Uranus (Heaven) after his son Cronus threw them into the sea. Aphrodite was widely worshipped as a goddess of the sea, seafaring, love, and fertility. While her public cult was generally solemn, she occasionally presided over marriage. Notably, she had mortal lovers, including the Trojan shepherd Anchises (with whom she became the mother of Aeneas) and the youth Adonis.', 'APHRODITE.webp', 'Default'),
('44c24fcc-2ba4-11ef-a131-7c05075eb45f', 'Artemis', 'Artemis, in ancient Greek religion and mythology, is the goddess of the hunt, the wilderness, wild animals, nature, vegetation, childbirth, care of children, and chastity. She was often said to roam the forests and mountains, attended by her entourage of nymphs. Artemis is the daughter of Zeus and Leto, and the twin sister of Apollo. She was very protective of her and her priestesses innocence.', 'ARTEMIS.webp', 'Default'),
('54af2d80-b78c-11ef-8962-7c05075eb45f', 'Do you know the wae', 'DA WAEEEE DA WAEEEE <br />\r\nDA WAEEEE DA WAEEEE <br />\r\nDA WAEEEE DA WAEEEE <br />\r\nDA WAEEEE DA WAEEEE <br />\r\nDA WAEEEE DA WAEEEE <br />\r\nDA WAEEEE DA WAEEEE <br />\r\nDA WAEEEE DA WAEEEE ', 'DaWey.jpg', '1779c872-b6b9-11ef-ba98-7c05075eb45f'),
('5e965592-2ba6-11ef-a131-7c05075eb45f', 'Poseidon', 'Poseidon, in Greek mythology, is the god of the sea, earthquakes, and horses. He is one of the Twelve Olympians, the major deities of the Greek pantheon. Often depicted with a trident, Poseidon is known for his tempestuous nature, capable of both fury and benevolence. He is considered a protector of seafarers and a creator of storms and floods. In Roman mythology, he is identified with Neptune.', 'POSEIDON.webp', 'Default'),
('8d2d3e82-2ba4-11ef-a131-7c05075eb45f', 'Athena', 'Athena, in Greek religion, is the city protectress, goddess of war, handicraft, and practical reason. The Romans identified her with Minerva. Unlike Ares, the god of war who represents mere bloodlust, Athena embodies the intellectual and civilized side of war, emphasizing justice and skill. She was also associated paradoxically with peace and handicrafts, particularly spinning and weaving. Majestic and stern, Athena surpassed all others in her domains.', 'ATHENA.webp', 'Default'),
('8e3c6da0-2ba3-11ef-a131-7c05075eb45f', 'Ares', 'Ares, the Greek god of war, is one of the Twelve Olympians. He is often depicted as a fierce and bloodthirsty warrior. Ares is the son of Zeus and Hera, and his siblings include Athena, Apollo, and Hermes. In Greek mythology, he is associated with violence, conflict, and the brutality of war', 'ARES.webp', 'Default'),
('b9da2016-2ba7-11ef-a131-7c05075eb45f', 'Demeter', 'Demeter, the revered Greek goddess of agriculture, grain, and fertility, holds a prominent position in Greek mythology and the hearts of ancient people. As the giver of life and sustenance, her influence extended far beyond the fields, touching upon the very cycles of life, death, and rebirth. Demeter is often depicted as a mature woman, her presence radiating warmth and abundance. She is adorned with symbols of her dominion, such as sheaves of wheat, a cornucopia overflowing with fruits and grains, or a torch symbolizing enlightenment and knowledge.\r\n\r\nDemeter\'s significance is deeply intertwined with the Eleusinian Mysteries, secretive rituals centered around the myth of her daughter Persephone\'s abduction by Hades, the god of the underworld. This tragic event plunged Demeter into grief, causing the earth to wither and die. However, upon Persephone\'s eventual return, the world bloomed anew, signifying the renewal of life and the cyclical nature of the seasons. The Eleusinian Mysteries offered initiates a glimpse into these profound concepts, promising a blessed afterlife and fostering a sense of connection to the divine.', 'DEMETER.webp', 'Default'),
('b9da2cb2-2ba7-11ef-a131-7c05075eb45f', 'Dionysius', 'Dionysus, the enigmatic and captivating Greek god of wine, revelry, theater, and religious ecstasy, holds a unique place in the pantheon of Greek deities. Often depicted as a youthful and exuberant figure, adorned with ivy wreaths and holding a thyrsus (a pinecone-tipped staff), Dionysus embodies the spirit of uninhibited joy, transformation, and the blurring of boundaries between the human and divine.\r\n\r\nHis origins are shrouded in mystery, with various myths attributing his birthplace to different regions. Some tales claim he is a foreign god who arrived in Greece from the East, bringing with him the knowledge of viticulture and the intoxicating power of wine. Others describe him as the son of Zeus and the mortal Semele, who perished due to Hera\'s jealousy. Regardless of his origin, Dionysus quickly became a beloved figure, celebrated for his ability to liberate people from their inhibitions and connect them to the primal forces of nature.', 'DIONYSIUS.webp', 'Default'),
('cec09d13-2b9d-11ef-a131-7c05075eb45f', 'Zeus', 'Zeus, the sky and thunder god in ancient Greek mythology, rules as the king of the gods on Mount Olympus. As the chief Greek deity, he is considered the protector and father of all gods and humans. Zeus is often depicted as an older man with a beard, and his symbols include the lightning bolt and the eagle. He was notorious for his numerous divine and heroic offspring, including Apollo, Artemis, Hermes, and Heracles. His traditional weapon is the thunderbolt, and he is equated with the Roman god Jupiter.', 'ZEUS.webp', 'Default'),
('eb824654-2ba6-11ef-a131-7c05075eb45f', 'Hera', 'Hera, the queen of Olympus in Greek mythology, is the goddess of marriage, women, family, and childbirth. She is the wife and sister of Zeus, the king of the gods. While revered for her role as a protector of women, Hera is also known for her jealous and vengeful nature, often directed towards Zeus\'s lovers and their offspring. Her stories are filled with drama, passion, and divine retribution, making her a compelling figure in ancient Greek lore.', 'HERA.webp', 'Default'),
('edd19956-b6b5-11ef-ba98-7c05075eb45f', 'ZenithSUS', 'I\'m built different', NULL, 'b2348003-afb6-11ef-b843-7c05075eb45f');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `like_id` varchar(36) NOT NULL,
  `liker` varchar(36) NOT NULL,
  `post_id` varchar(36) DEFAULT NULL,
  `comment_id` varchar(36) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `vote_type` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`like_id`, `liker`, `post_id`, `comment_id`, `timestamp`, `vote_type`) VALUES
('674c0e82121e4', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'e5def715-afb4-11ef-b843-7c05075eb45f', NULL, '2024-12-01 15:21:38', 'like'),
('674c12c164ece', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'e5def715-afb4-11ef-b843-7c05075eb45f', NULL, '2024-12-01 15:39:45', 'like'),
('674c12cbb90e1', 'b2348003-afb6-11ef-b843-7c05075eb45f', NULL, '674c12c685f9f', '2024-12-01 15:39:55', 'like'),
('6757d0eeb9782', 'b2348003-afb6-11ef-b843-7c05075eb45f', '929b05df-b2b8-11ef-a194-7c05075eb45f', NULL, '2024-12-10 13:26:06', 'like'),
('6757d0f2657c5', 'b2348003-afb6-11ef-b843-7c05075eb45f', '10f8139c-b6b5-11ef-ba98-7c05075eb45f', NULL, '2024-12-10 13:26:10', 'dislike'),
('6757d0faefd6c', 'b2348003-afb6-11ef-b843-7c05075eb45f', '7fcbd401-afb7-11ef-b843-7c05075eb45f', NULL, '2024-12-10 13:26:18', 'like'),
('6757d1026485b', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'e4201f31-b6b4-11ef-ba98-7c05075eb45f', NULL, '2024-12-10 13:26:26', 'like'),
('6757d2284b6c9', 'b2348003-afb6-11ef-b843-7c05075eb45f', NULL, '6757d224160c8', '2024-12-10 13:31:20', 'like'),
('6757d2342b0c7', 'b2348003-afb6-11ef-b843-7c05075eb45f', NULL, '6757d23022722', '2024-12-10 13:31:32', 'like'),
('6759363e80a27', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '393e5747-b78c-11ef-8962-7c05075eb45f', NULL, '2024-12-11 14:50:38', 'like'),
('6759b562eb65b', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '8bfb2587-b6b7-11ef-ba98-7c05075eb45f', NULL, '2024-12-11 23:53:06', 'like');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` varchar(36) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `author` varchar(36) NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `dislikes` int(11) NOT NULL DEFAULT 0,
  `greek_group` varchar(36) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `title`, `content`, `author`, `likes`, `dislikes`, `greek_group`, `status`, `created_at`, `updated_at`) VALUES
('10f8139c-b6b5-11ef-ba98-7c05075eb45f', 'I\'m unstoppable', 'HELL YEAHHHH!!!', 'b2348003-afb6-11ef-b843-7c05075eb45f', 0, 1, '5e965592-2ba6-11ef-a131-7c05075eb45f', 1, '2024-12-10 13:10:26', '2024-12-10 13:10:26'),
('141c1b49-b791-11ef-8962-7c05075eb45f', 'Do you know the wae', 'RSFDSAFDA', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 0, 0, 'cec09d13-2b9d-11ef-a131-7c05075eb45f', 1, '2024-12-11 15:25:21', '2024-12-11 15:25:21'),
('393e5747-b78c-11ef-8962-7c05075eb45f', 'Do you know the wae', 'DA WAEEEE<br />\r\n<br />\r\nDA WAEEEE <br />\r\n<br />\r\nDA WAEEEE <br />\r\n<br />\r\nDA WAEEEE  ', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 1, 0, NULL, 1, '2024-12-11 14:50:35', '2024-12-11 14:50:35'),
('6b588798-b964-11ef-97f9-7c05075eb45f', 'I\'m Stronger than I thought', 'HAHAHAHSDHASD', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 0, 0, NULL, 1, '2024-12-13 23:10:42', '2024-12-13 23:10:42'),
('7fcbd401-afb7-11ef-b843-7c05075eb45f', 'DeezNuts', 'Zeus is Gay', 'b2348003-afb6-11ef-b843-7c05075eb45f', 1, 0, 'cec09d13-2b9d-11ef-a131-7c05075eb45f', 1, '2024-12-01 15:40:12', '2024-12-01 15:40:12'),
('8bfb2587-b6b7-11ef-ba98-7c05075eb45f', 'New God Adam', 'Hehehehehe', 'b2348003-afb6-11ef-b843-7c05075eb45f', 1, 0, 'edd19956-b6b5-11ef-ba98-7c05075eb45f', 1, '2024-12-10 13:28:11', '2024-12-10 13:28:11'),
('929b05df-b2b8-11ef-a194-7c05075eb45f', 'Hot God', 'HEHEHEHEHEHEHEHEHE<br />\r\n<br />\r\nHEHEHEHEHEH', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 2, 0, '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', 1, '2024-12-05 11:25:27', '2024-12-05 11:25:27'),
('d6e2e6a2-b6b7-11ef-ba98-7c05075eb45f', 'New God Yasuo', 'Wasagi!!!', 'b2348003-afb6-11ef-b843-7c05075eb45f', 0, 0, NULL, 1, '2024-12-10 13:30:17', '2024-12-10 13:30:17'),
('e4201f31-b6b4-11ef-ba98-7c05075eb45f', 'Hello World!', 'sadsad', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 1, 0, '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', 1, '2024-12-10 13:09:10', '2024-12-10 13:09:10'),
('e5def715-afb4-11ef-b843-7c05075eb45f', 'Hello Everyone', 'HELLO WORLD!', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 2, 0, NULL, 1, '2024-12-01 15:21:35', '2024-12-01 15:21:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` varchar(36) NOT NULL,
  `username` varchar(225) NOT NULL,
  `email` varchar(225) NOT NULL,
  `password` varchar(225) NOT NULL,
  `profile_pic` varchar(225) DEFAULT NULL,
  `bio` varchar(36) DEFAULT NULL,
  `token` varchar(225) NOT NULL,
  `joined_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `profile_pic`, `bio`, `token`, `joined_at`) VALUES
('1779c872-b6b9-11ef-ba98-7c05075eb45f', 'DaeWae', 'wae@gmail.com', '$2y$10$cmoncP0/5U.qa7G3jMV6WekH03KIy7xOsL3R4gDVBuKXqbTGwT9cK', '6757d4100ddb15.67686393.jpg', 'DAAAA WAEEEEEE', '21c88b075c140ce9b2773e1d8ed0a56f', '2024-12-10 13:39:15'),
('b2348003-afb6-11ef-b843-7c05075eb45f', 'GreekGod', 'greek@gmail.com', '$2y$10$vddAyFSwIImHrabWo1M24erjXQB.2UN4hX4RlM/HdtRLyxHdN0n4u', '674c118b035ed0.53181050.png', '', '0dea752a69a37c627f2612165e2f4eeb', '2024-12-01 15:34:28'),
('c628eca1-afb4-11ef-b843-7c05075eb45f', 'Zenith', 'test@gmail.com', '$2y$10$2jPOiKuBvptyg9NYNEFgGuLa2qByh4lCVa7CXm9ZXMuVik7dVv/je', '674c0e64eb8210.77141986.jpg', 'Hello Guys\r\n', '5edf873c0896aa55046e8f1a6fbeecba', '2024-12-01 15:20:42');

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `greek_id` varchar(36) NOT NULL,
  `date_joined` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_groups`
--

INSERT INTO `user_groups` (`id`, `user_id`, `greek_id`, `date_joined`) VALUES
('1782db71-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('1798bc79-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('17ad181f-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('17c43141-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '2b013a64-2ba0-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('17e18c19-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('17ebcdeb-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('17f56276-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('17fe765d-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('180525d5-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('1815b229-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2024-12-10 13:39:16'),
('182051b8-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2024-12-10 13:39:16'),
('1828b412-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2024-12-10 13:39:16'),
('54c1768f-b78c-11ef-8962-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '54af2d80-b78c-11ef-8962-7c05075eb45f', '2024-12-11 14:51:21'),
('b24ef0ad-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2024-12-01 15:34:28'),
('b2557eba-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2024-12-01 15:34:28'),
('b25c6b90-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2024-12-01 15:34:28'),
('b28f5302-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', '2b013a64-2ba0-11ef-a131-7c05075eb45f', '2024-12-01 15:34:28'),
('b2a534df-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2024-12-01 15:34:28'),
('b2ac203f-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2024-12-01 15:34:28'),
('b2b2ca01-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2024-12-01 15:34:28'),
('b2b9b167-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2024-12-01 15:34:28'),
('b2c2124b-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2024-12-01 15:34:28'),
('b2c8f0c0-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2024-12-01 15:34:29'),
('b2cfa765-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2024-12-01 15:34:29'),
('b2d683f0-afb6-11ef-b843-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2024-12-01 15:34:29'),
('c6362c4e-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2024-12-01 15:20:42'),
('c66dd316-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2024-12-01 15:20:42'),
('c6935e8d-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6afa6c1-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '2b013a64-2ba0-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6bbf5d1-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6c96ecb-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6d3a491-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6eed24a-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6f8e26a-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c7032bf0-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c70b8e08-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2024-12-01 15:20:44'),
('c715d2ea-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2024-12-01 15:20:44'),
('ede26d0b-b6b5-11ef-ba98-7c05075eb45f', 'b2348003-afb6-11ef-b843-7c05075eb45f', 'edd19956-b6b5-11ef-ba98-7c05075eb45f', '2024-12-10 13:16:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `activities_ibfk_3` (`user_id`);

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `token` (`token`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `comments_fk2` (`parent_comment`),
  ADD KEY `comments_fk3` (`post_id`),
  ADD KEY `comments_fk1` (`author`);

--
-- Indexes for table `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`id`),
  ADD KEY `friends_ibfk_3` (`user_id`),
  ADD KEY `friends_ibfk_4` (`friend_id`);

--
-- Indexes for table `friend_requests`
--
ALTER TABLE `friend_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `friend_requests_ibfk_1` (`requester_id`),
  ADD KEY `friend_requests_ibfk_2` (`requestee_id`);

--
-- Indexes for table `greeks`
--
ALTER TABLE `greeks`
  ADD PRIMARY KEY (`greek_id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`like_id`),
  ADD KEY `likes_ibfk_1` (`liker`),
  ADD KEY `likes_ibfk_2` (`post_id`),
  ADD KEY `likes_ibfk_3` (`comment_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `posts_ibfk_1` (`author`),
  ADD KEY `posts_ibfk_2` (`greek_group`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `greek_id` (`greek_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=283;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `activities_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `activities_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_fk1` FOREIGN KEY (`author`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_fk2` FOREIGN KEY (`parent_comment`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_fk3` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE;

--
-- Constraints for table `friends`
--
ALTER TABLE `friends`
  ADD CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`friend_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `friend_requests`
--
ALTER TABLE `friend_requests`
  ADD CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`requester_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`requestee_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`liker`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_ibfk_3` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`greek_group`) REFERENCES `greeks` (`greek_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD CONSTRAINT `user_groups_ibfk_1` FOREIGN KEY (`greek_id`) REFERENCES `greeks` (`greek_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_groups_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
