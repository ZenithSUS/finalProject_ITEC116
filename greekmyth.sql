-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2025 at 02:41 PM
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
(363, '95c8dc12-dcb8-11ef-96dd-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'created a post with title The is a second test post in Aphrodite discussion', '2025-01-27 14:11:21'),
(364, '95c8dc12-dcb8-11ef-96dd-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'created a post with title The is a second test post in Aphrodite discussion', '2025-01-27 14:11:22'),
(367, '354e6eb4-dcbf-11ef-96dd-7c05075eb45f', NULL, 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 'created a post with title Hello Goddsssss in Apollo discussion', '2025-01-27 14:58:46'),
(372, NULL, '6797a9e8b458b', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'commennted on a post titled The is a second test post', '2025-01-27 15:44:41'),
(376, 'c9ce5f2d-df8c-11ef-b0d2-7c05075eb45f', NULL, '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'created a post with title Hello GreekMyth in Zeus discussion', '2025-01-31 04:35:24'),
(377, '1b8609f4-df8d-11ef-b0d2-7c05075eb45f', NULL, '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'created a post with title This is a dummy post in Artemis discussion', '2025-01-31 04:37:41'),
(379, NULL, '679c5414f069a', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'commennted on a post titled This is a dummy post', '2025-01-31 04:39:49'),
(395, NULL, '679c57e5d7cea', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'commennted on a post titled This is a dummy post', '2025-01-31 04:56:05'),
(397, NULL, '679d99d2373f2', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'commennted on a post titled The is a second test post', '2025-02-01 03:49:38'),
(398, NULL, '679d9a55b4ddc', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'replied to a comment titled The is a second test post', '2025-02-01 03:51:50'),
(399, NULL, '679d9a75bbed4', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'commennted on a post titled The is a second test post', '2025-02-01 03:52:22'),
(406, NULL, '679e1fda83274', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 'commennted on a post titled Zeus is too OP in this World', '2025-02-01 13:21:30'),
(407, NULL, '679e226ee73ff', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'commennted on a post titled Zeus is too OP in this World', '2025-02-01 13:32:31'),
(408, NULL, '679e228c510d1', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'replied to a comment titled Zeus is too OP in this World', '2025-02-01 13:33:00'),
(409, NULL, '679e236ba15c1', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'replied to a comment titled Zeus is too OP in this World', '2025-02-01 13:36:43');

-- --------------------------------------------------------

--
-- Table structure for table `admin_settings`
--

CREATE TABLE `admin_settings` (
  `admin_id` varchar(36) NOT NULL,
  `dark_mode` int(10) NOT NULL DEFAULT 0,
  `font_style` varchar(30) NOT NULL DEFAULT 'fonts1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_settings`
--

INSERT INTO `admin_settings` (`admin_id`, `dark_mode`, `font_style`) VALUES
('3149ec6e-c60e-11ef-8986-7c05075eb45f', 1, 'fonts3'),
('4a5f77c0-c337-11ef-864c-7c05075eb45f', 1, 'fonts2'),
('651e5364-c607-11ef-8986-7c05075eb45f', 1, 'fonts2'),
('aad38520-b88f-11ef-88fc-7c05075eb45f', 0, 'fonts1'),
('c10d8b3f-cb4f-11ef-856e-7c05075eb45f', 1, 'fonts2');

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
('3149ec6e-c60e-11ef-8986-7c05075eb45f', 'ZenithIsGod!', 'zenith@gmail.com', '$2y$10$kIw8ooCFUhBszjKIHEl0C.DztgnKyaKukyn25DjTWCDE9QgY1mbAu', '67718d3cec6104.27214304.png', NULL, 0),
('4a5f77c0-c337-11ef-864c-7c05075eb45f', 'ZenZen!', 'zen@gmail.com', '$2y$10$fIUwxMO86i.8Ak97pQO0/.YKt67r2opl7BUtEWT4iZc/jPHQ/UwHq', '677376a3593ab4.23381516.jpg', '224f450d140f791eebe9d14096baf3b19576976ba757fc2e2b3e183dfe73d2e0', 1),
('651e5364-c607-11ef-8986-7c05075eb45f', 'Chou!!', 'chou@gmail.com', '$2y$10$zdoXrTJ2ohrO0HsMfXK5BefilZ9xufkwBSBFHlqSCB3qrpclMZdh.', '677181d56c81a6.02665576.jpg', NULL, 0),
('aad38520-b88f-11ef-88fc-7c05075eb45f', 'ZenithSUS', 'admin2@gmail.com', '$2y$10$zILK0pdKGNaQeZQKcHG6GuZQrqtdw5aeJs.2BpTwSQYTSE.6f/tgO', NULL, NULL, 0),
('c10d8b3f-cb4f-11ef-856e-7c05075eb45f', 'ZenithZUZ!', 'merinojc25@gmail.com', '$2y$10$1Bk2IXbX24wly5sV08CyAOdW9bAfRpP6Jit96l04moRrLYmrAv3QK', '679ce3227f6e91.26686938.jpg', 'db382246662afa6954c941cfa6f56fa83d09d5bab1156eace71351ea4372511c', 1);

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
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` int(10) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `post_id`, `parent_comment`, `author`, `content`, `likes`, `dislikes`, `created_at`, `status`) VALUES
('6797a9e8b458b', '95c8dc12-dcb8-11ef-96dd-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'This is disliked comment', 1, 0, '2025-01-27 23:44:40', 1),
('679c5414f069a', '1b8609f4-df8d-11ef-b0d2-7c05075eb45f', NULL, '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'Hw', 1, 0, '2025-01-31 12:39:48', 1),
('679c57e5d7cea', '1b8609f4-df8d-11ef-b0d2-7c05075eb45f', NULL, '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'asasd', 0, 0, '2025-01-31 12:56:05', 1),
('679d99d2373f2', '95fa0fb6-dcb8-11ef-96dd-7c05075eb45f', NULL, '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'HEH', 0, 0, '2025-02-01 11:49:38', 1),
('679d9a55b4ddc', '95c8dc12-dcb8-11ef-96dd-7c05075eb45f', '6797a9e8b458b', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'Comment child', 1, 0, '2025-02-01 11:51:49', 1),
('679d9a75bbed4', '95c8dc12-dcb8-11ef-96dd-7c05075eb45f', NULL, '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'Sample Comment', 0, 1, '2025-02-01 11:52:21', 1),
('679da1538b40f', 'ebde88b9-dfe1-11ef-b604-7c05075eb45f', NULL, '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'Sample Comment', 0, 0, '2025-02-01 12:21:39', 1),
('679da17652bc0', 'c9ce5f2d-df8c-11ef-b0d2-7c05075eb45f', NULL, '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'Sample', 0, 0, '2025-02-01 12:22:14', 1),
('679da28646347', 'c9ce5f2d-df8c-11ef-b0d2-7c05075eb45f', '679da17652bc0', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'Sample Comment', 0, 0, '2025-02-01 12:26:46', 1),
('679da318ce85c', 'ebc05455-dfe1-11ef-b604-7c05075eb45f', NULL, 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 'WATAHHHH', 0, 0, '2025-02-01 12:29:12', 1),
('679e1fda83274', 'fc155d48-e096-11ef-9b1c-7c05075eb45f', NULL, 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 'Comment COMMENTTTTT', 0, 0, '2025-02-01 21:21:30', 1),
('679e226ee73ff', 'fc155d48-e096-11ef-9b1c-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'Yes too OP', 1, 0, '2025-02-01 21:32:30', 1),
('679e228c510d1', 'fc155d48-e096-11ef-9b1c-7c05075eb45f', '679e226ee73ff', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'AHHHH', 0, 1, '2025-02-01 21:33:00', 1),
('679e236ba15c1', 'fc155d48-e096-11ef-9b1c-7c05075eb45f', '679e226ee73ff', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'EH?', 0, 0, '2025-02-01 21:36:43', 1);

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
('0c127258-df8d-11ef-b0d2-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '2025-01-31 04:37:15'),
('0c194ec5-df8d-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '2025-01-31 04:37:15'),
('b920b0a7-e09f-11ef-9b1c-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '2025-02-01 13:23:28'),
('b92ba6e0-e09f-11ef-9b1c-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '2025-02-01 13:23:28'),
('e48679d7-df8f-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '2025-01-31 04:57:37'),
('e494379d-df8f-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '2025-01-31 04:57:38'),
('e817535f-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '2025-01-31 04:36:15'),
('e8265133-df8c-11ef-b0d2-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '2025-01-31 04:36:15');

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
('1038ff83-df8d-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'pending', '2025-01-31 04:37:22'),
('1426914b-e0a2-11ef-9b1c-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', 'pending', '2025-02-01 13:40:20');

-- --------------------------------------------------------

--
-- Table structure for table `greeks`
--

CREATE TABLE `greeks` (
  `greek_id` varchar(36) NOT NULL,
  `name` varchar(36) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(225) DEFAULT NULL,
  `creator` varchar(36) DEFAULT '',
  `status` int(10) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `greeks`
--

INSERT INTO `greeks` (`greek_id`, `name`, `description`, `image_url`, `creator`, `status`) VALUES
('0db1bfad-2ba8-11ef-a131-7c05075eb45f', 'Hermes', 'Hermes, the quick-witted Greek god of trade, thieves, travelers, sports, athletes, and border crossings, is often portrayed as a young, athletic man wearing a winged hat and sandals. He is known for his cunning and mischievous nature, as well as his role as the messenger of the gods. Hermes is also associated with fertility, luck, and wealth, and is often depicted carrying a caduceus, a winged staff entwined with two serpents.', 'HERMES.webp', 'Default', 1),
('1c87d062-2ba3-11ef-a131-7c05075eb45f', 'Hades', 'Hades, in ancient Greek religion, is the god of the underworld. He was a son of the Titans Cronus and Rhea and the brother of Zeus, Poseidon, and Hera. Hades ruled alongside his queen, Persephone, over the dead, although he was not typically a judge or responsible for torturing the guilty—tasks assigned to the Furies', 'HADES.webp', 'Default', 1),
('28f5caa3-e097-11ef-9b1c-7c05075eb45f', 'Test God', 'This is a Greek God test', '679e11f258d643.23730576.png', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 1),
('2adbfbd3-2ba2-11ef-a131-7c05075eb45f', 'Apollo', 'Apollo, one of the Twelve Olympians in Greek mythology, is the son of Zeus and Leto, and the twin brother of Artemis. He embodies a multitude of roles: the god of healing, medicine, archery, music, dance, poetry, prophecy, knowledge, light, and the sun. Apollo is also the leader of the Muses', 'APOLLO.webp', 'Default', 1),
('2b013a64-2ba0-11ef-a131-7c05075eb45f', 'Aphrodite', 'Aphrodite, the ancient Greek goddess of sexual love and beauty, is closely associated with Venus in Roman mythology. According to Hesiod’s Theogony, she emerged from the white foam created by the severed genitals of Uranus (Heaven) after his son Cronus threw them into the sea. Aphrodite was widely worshipped as a goddess of the sea, seafaring, love, and fertility. While her public cult was generally solemn, she occasionally presided over marriage. Notably, she had mortal lovers, including the Trojan shepherd Anchises (with whom she became the mother of Aeneas) and the youth Adonis.', 'APHRODITE.webp', 'Default', 1),
('44c24fcc-2ba4-11ef-a131-7c05075eb45f', 'Artemis', 'Artemis, in ancient Greek religion and mythology, is the goddess of the hunt, the wilderness, wild animals, nature, vegetation, childbirth, care of children, and chastity. She was often said to roam the forests and mountains, attended by her entourage of nymphs. Artemis is the daughter of Zeus and Leto, and the twin sister of Apollo. She was very protective of her and her priestesses innocence.', 'ARTEMIS.webp', 'Default', 1),
('5e965592-2ba6-11ef-a131-7c05075eb45f', 'Poseidon', 'Poseidon, in Greek mythology, is the god of the sea, earthquakes, and horses. He is one of the Twelve Olympians, the major deities of the Greek pantheon. Often depicted with a trident, Poseidon is known for his tempestuous nature, capable of both fury and benevolence. He is considered a protector of seafarers and a creator of storms and floods. In Roman mythology, he is identified with Neptune.', 'POSEIDON.webp', 'Default', 1),
('8d2d3e82-2ba4-11ef-a131-7c05075eb45f', 'Athena', 'Athena, in Greek religion, is the city protectress, goddess of war, handicraft, and practical reason. The Romans identified her with Minerva. Unlike Ares, the god of war who represents mere bloodlust, Athena embodies the intellectual and civilized side of war, emphasizing justice and skill. She was also associated paradoxically with peace and handicrafts, particularly spinning and weaving. Majestic and stern, Athena surpassed all others in her domains.', 'ATHENA.webp', 'Default', 1),
('8e3c6da0-2ba3-11ef-a131-7c05075eb45f', 'Ares', 'Ares, the Greek god of war, is one of the Twelve Olympians. He is often depicted as a fierce and bloodthirsty warrior. Ares is the son of Zeus and Hera, and his siblings include Athena, Apollo, and Hermes. In Greek mythology, he is associated with violence, conflict, and the brutality of war', 'ARES.webp', 'Default', 1),
('b9da2016-2ba7-11ef-a131-7c05075eb45f', 'Demeter', 'Demeter, the revered Greek goddess of agriculture, grain, and fertility, holds a prominent position in Greek mythology and the hearts of ancient people. As the giver of life and sustenance, her influence extended far beyond the fields, touching upon the very cycles of life, death, and rebirth. Demeter is often depicted as a mature woman, her presence radiating warmth and abundance. She is adorned with symbols of her dominion, such as sheaves of wheat, a cornucopia overflowing with fruits and grains, or a torch symbolizing enlightenment and knowledge.\r\n\r\nDemeter\'s significance is deeply intertwined with the Eleusinian Mysteries, secretive rituals centered around the myth of her daughter Persephone\'s abduction by Hades, the god of the underworld. This tragic event plunged Demeter into grief, causing the earth to wither and die. However, upon Persephone\'s eventual return, the world bloomed anew, signifying the renewal of life and the cyclical nature of the seasons. The Eleusinian Mysteries offered initiates a glimpse into these profound concepts, promising a blessed afterlife and fostering a sense of connection to the divine.', 'DEMETER.webp', 'Default', 1),
('b9da2cb2-2ba7-11ef-a131-7c05075eb45f', 'Dionysius', 'Dionysus, the enigmatic and captivating Greek god of wine, revelry, theater, and religious ecstasy, holds a unique place in the pantheon of Greek deities. Often depicted as a youthful and exuberant figure, adorned with ivy wreaths and holding a thyrsus (a pinecone-tipped staff), Dionysus embodies the spirit of uninhibited joy, transformation, and the blurring of boundaries between the human and divine.\r\n\r\nHis origins are shrouded in mystery, with various myths attributing his birthplace to different regions. Some tales claim he is a foreign god who arrived in Greece from the East, bringing with him the knowledge of viticulture and the intoxicating power of wine. Others describe him as the son of Zeus and the mortal Semele, who perished due to Hera\'s jealousy. Regardless of his origin, Dionysus quickly became a beloved figure, celebrated for his ability to liberate people from their inhibitions and connect them to the primal forces of nature.', 'DIONYSIUS.webp', 'Default', 1),
('ca83fe57-dfbc-11ef-b604-7c05075eb45f', 'DaeWae', 'DaeWae', '679ca39598c3e8.38281414.jpg', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 1),
('cae89f13-e044-11ef-b06e-7c05075eb45f', 'Sample God', 'Sample Description', '679d87c1cca2a5.86079182.jpg', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 1),
('cec09d13-2b9d-11ef-a131-7c05075eb45f', 'Zeus', 'Zeus, the sky and thunder god in ancient Greek mythology, rules as the king of the gods on Mount Olympus. As the chief Greek deity, he is considered the protector and father of all gods and humans. Zeus is often depicted as an older man with a beard, and his symbols include the lightning bolt and the eagle. He was notorious for his numerous divine and heroic offspring, including Apollo, Artemis, Hermes, and Heracles. His traditional weapon is the thunderbolt, and he is equated with the Roman god Jupiter.', 'ZEUS.webp', 'Default', 1),
('eb824654-2ba6-11ef-a131-7c05075eb45f', 'Hera', 'Hera, the queen of Olympus in Greek mythology, is the goddess of marriage, women, family, and childbirth. She is the wife and sister of Zeus, the king of the gods. While revered for her role as a protector of women, Hera is also known for her jealous and vengeful nature, often directed towards Zeus\'s lovers and their offspring. Her stories are filled with drama, passion, and divine retribution, making her a compelling figure in ancient Greek lore.', 'HERA.webp', 'Default', 1);

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
('67979f29d798e', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '95fa0fb6-dcb8-11ef-96dd-7c05075eb45f', NULL, '2025-01-27 22:58:49', 'like'),
('67979f387644b', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '95c8dc12-dcb8-11ef-96dd-7c05075eb45f', NULL, '2025-01-27 22:59:04', 'like'),
('6797a9de29d65', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '95c8dc12-dcb8-11ef-96dd-7c05075eb45f', NULL, '2025-01-27 23:44:30', 'dislike'),
('6797a9ec9e917', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', NULL, '6797a9e8b458b', '2025-01-27 23:44:44', 'like'),
('679c53a163de3', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '1b8609f4-df8d-11ef-b0d2-7c05075eb45f', NULL, '2025-01-31 12:37:53', 'like'),
('679c541cefe90', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', NULL, '679c5414f069a', '2025-01-31 12:39:56', 'like'),
('679d9a5bddb85', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', NULL, '679d9a55b4ddc', '2025-02-01 11:51:55', 'like'),
('679d9a7a04ab5', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', NULL, '679d9a75bbed4', '2025-02-01 11:52:26', 'dislike'),
('679da169c17f0', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'c9ce5f2d-df8c-11ef-b0d2-7c05075eb45f', NULL, '2025-02-01 12:22:01', 'like'),
('679e13f8ab548', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 'fc155d48-e096-11ef-9b1c-7c05075eb45f', NULL, '2025-02-01 20:30:48', 'dislike'),
('679e140233d6a', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '06086f9b-e045-11ef-b06e-7c05075eb45f', NULL, '2025-02-01 20:30:58', 'like'),
('679e140d43ff3', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 'd4c06719-e097-11ef-9b1c-7c05075eb45f', NULL, '2025-02-01 20:31:09', 'like'),
('679e227e7ebf2', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', NULL, '679e226ee73ff', '2025-02-01 21:32:46', 'like'),
('679e22908710e', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', NULL, '679e228c510d1', '2025-02-01 21:33:04', 'dislike'),
('679e23a533607', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'ebde88b9-dfe1-11ef-b604-7c05075eb45f', NULL, '2025-02-01 21:37:41', 'like'),
('679e23bd6cde7', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'fc155d48-e096-11ef-9b1c-7c05075eb45f', NULL, '2025-02-01 21:38:05', 'like');

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
('06086f9b-e045-11ef-b06e-7c05075eb45f', 'Sample Post', 'Sample Content', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 1, 0, NULL, 1, '2025-02-01 10:34:13', '2025-02-01 10:34:13'),
('1b8609f4-df8d-11ef-b0d2-7c05075eb45f', 'This is a dummy post', 'DUMMYYYYY!!', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 1, 0, '44c24fcc-2ba4-11ef-a131-7c05075eb45f', 1, '2025-01-31 12:37:41', '2025-01-31 12:37:41'),
('354e6eb4-dcbf-11ef-96dd-7c05075eb45f', 'Hello Goddsssss', '', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 1, 0, '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', 1, '2025-01-27 22:58:46', '2025-01-27 22:58:46'),
('95c8dc12-dcb8-11ef-96dd-7c05075eb45f', 'The is a second test post', 'Test', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 1, 1, '2b013a64-2ba0-11ef-a131-7c05075eb45f', 1, '2025-01-27 22:11:21', '2025-01-27 22:11:21'),
('95fa0fb6-dcb8-11ef-96dd-7c05075eb45f', 'The is a second test post', 'Test', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 1, 0, '2b013a64-2ba0-11ef-a131-7c05075eb45f', 1, '2025-01-27 22:11:22', '2025-01-27 22:11:22'),
('bddffee1-e097-11ef-9b1c-7c05075eb45f', 'Test Post', 'This is a test post', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 0, 0, '28f5caa3-e097-11ef-9b1c-7c05075eb45f', 1, '2025-02-01 20:26:20', '2025-02-01 20:26:20'),
('c9ce5f2d-df8c-11ef-b0d2-7c05075eb45f', 'Hello GreekMyth', 'Hello', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 1, 0, 'cec09d13-2b9d-11ef-a131-7c05075eb45f', 1, '2025-01-31 12:35:24', '2025-01-31 12:35:24'),
('d4c06719-e097-11ef-9b1c-7c05075eb45f', 'DaeWae is the Wae', 'Where\'s mah queen?', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 1, 0, 'ca83fe57-dfbc-11ef-b604-7c05075eb45f', 1, '2025-02-01 20:26:58', '2025-02-01 20:26:58'),
('dd07162d-e09c-11ef-9b1c-7c05075eb45f', 'Test Post', 'Test Content', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 0, 0, '28f5caa3-e097-11ef-9b1c-7c05075eb45f', 1, '2025-02-01 21:03:00', '2025-02-01 21:03:00'),
('ebc05455-dfe1-11ef-b604-7c05075eb45f', 'WATAHHH', 'sadsadsa', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 0, 0, 'eb824654-2ba6-11ef-a131-7c05075eb45f', 1, '2025-01-31 22:44:50', '2025-01-31 22:44:50'),
('ebde88b9-dfe1-11ef-b604-7c05075eb45f', 'WATAHHH', 'sadsadsa', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 1, 0, 'eb824654-2ba6-11ef-a131-7c05075eb45f', 1, '2025-01-31 22:44:50', '2025-01-31 22:44:50'),
('fc155d48-e096-11ef-9b1c-7c05075eb45f', 'Zeus is too OP in this World', 'Too Stronk', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 1, 1, 'cec09d13-2b9d-11ef-a131-7c05075eb45f', 1, '2025-02-01 20:20:55', '2025-02-01 20:20:55');

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
('04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'Dummy', 'dummy@gmail.com', '$2y$10$0ujOoI4wHemQun7Fy5wEVOG3XYyI869jevTBRErFDU951pUrip6qO', '679c51c23431e4.96615624.jpg', 'dummy account', '64ad8a4f63e5259c5a43ad24851069bd', '2025-01-31 12:29:54'),
('09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', 'GODzilla', 'godZilla@gmail.com', '$2y$10$HnCc.GN8wwuPg8kcgcuaWORh1s.1Zb9lSbOhQM4kstZFha3nwkL8C', '679e2432f31953.48157738.jpg', 'GODZILLLAAAA!!!!!', '2548f533c6e3b728eeb5dcfb942bb8b3', '2025-02-01 21:40:03'),
('2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'Administrator', 'test@gmail.com', '$2y$10$pGQwAcLY.xsdYEo/hHLXd.Yh8V.4Bp/GACzB/PtdPeUHWw7VAn/1y', '6795eb081dfa93.80781122.jpg', '', '0ffcb1423a3aa3292dbb4e833f34789a', '2025-01-26 15:57:25'),
('6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'DaeWae', 'daewae@gmail.com', '$2y$10$qwiRzVzo.FvT/Vnvusen4evl1.8AI1mDJUK4IjrZ8Y1mafxEtrIYS', '679c527074af13.52069371.jpg', 'Dae Wae is the Wae', '2f5c535f7c2ad45244159c9633705d29', '2025-01-31 12:32:48'),
('8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', 'ImStronkGod', 'stronk@gmail.com', '$2y$10$eNyR7mwlgsD9xXmcvxgkx.AEyOmxpqPAT61VeZgzOqpwJBqim2/ae', '679e129e787045.75339839.png', 'Stronk Boi!!!', '2e7d8dd69e7ed105dbddbe40d3e3efcf', '2025-02-01 20:25:02'),
('c628eca1-afb4-11ef-b843-7c05075eb45f', 'Zenith', 'zenithzuz@gmail.com', '$2y$10$2jPOiKuBvptyg9NYNEFgGuLa2qByh4lCVa7CXm9ZXMuVik7dVv/je', '674c0e64eb8210.77141986.jpg', 'Hello Guys\r\n', '5edf873c0896aa55046e8f1a6fbeecba', '2024-12-01 15:20:42'),
('e18a6c51-c60b-11ef-8986-7c05075eb45f', 'ChouIsOP', 'chou@gmail.com', '$2y$10$bLe57XMAXc111tQnLaubmeQo/GZ2Keuh.6tVKxSZHv1ncRqVNia.2', '6771897dc58b42.49403452.jpg', 'WATAHHHH', '4050a88956f715f399744758c2140a48', '2024-12-30 01:39:40'),
('f4241b78-df91-11ef-b0d2-7c05075eb45f', 'Testaccount', 'testaccount@gmail.com', '$2y$10$rrVYxhcopV5AfrSzl6Yy6.5GFhKPPzG/BPCp73i9D5JhzDdSluYPS', '679e13ee35ec22.82134501.jpg', 'sample bio', '0ec9dd20731db2f1f5b52b00437b2412', '2025-01-31 13:12:23');

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
('050f17dd-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2025-01-31 12:29:54'),
('0515e0f9-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2025-01-31 12:29:54'),
('051e299b-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2025-01-31 12:29:54'),
('0526d8bb-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '2b013a64-2ba0-11ef-a131-7c05075eb45f', '2025-01-31 12:29:54'),
('0530e475-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2025-01-31 12:29:54'),
('0537ca3b-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2025-01-31 12:29:54'),
('053e7999-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2025-01-31 12:29:54'),
('054c0ca8-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2025-01-31 12:29:54'),
('058e58bc-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2025-01-31 12:29:55'),
('059f2d43-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2025-01-31 12:29:55'),
('05a97a66-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2025-01-31 12:29:55'),
('05b0ec90-df8c-11ef-b0d2-7c05075eb45f', '04f033c5-df8c-11ef-b0d2-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2025-01-31 12:29:55'),
('0a03e29f-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2025-02-01 21:40:03'),
('0a113265-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2025-02-01 21:40:03'),
('0a23c573-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2025-02-01 21:40:03'),
('0a4e4fb0-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', '2b013a64-2ba0-11ef-a131-7c05075eb45f', '2025-02-01 21:40:03'),
('0a56b17f-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2025-02-01 21:40:03'),
('0a5d9459-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2025-02-01 21:40:03'),
('0a67a697-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2025-02-01 21:40:03'),
('0a71dd34-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2025-02-01 21:40:03'),
('0a7bf615-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2025-02-01 21:40:04'),
('0a89c2ec-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2025-02-01 21:40:04'),
('0ab0897b-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2025-02-01 21:40:04'),
('0ab77669-e0a2-11ef-9b1c-7c05075eb45f', '09e9e14c-e0a2-11ef-9b1c-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2025-02-01 21:40:04'),
('2906a6e1-e097-11ef-9b1c-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '28f5caa3-e097-11ef-9b1c-7c05075eb45f', '2025-02-01 20:22:10'),
('2ea9b3eb-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2025-01-26 15:57:25'),
('2ebdd129-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('2ecf0c89-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('2eda4ea7-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '2b013a64-2ba0-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('2ee0f685-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('2efdd069-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('2f02d1fa-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('2f080292-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('2f0d0b8c-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('2f176098-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('2f1c52ed-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('2f23e507-dbbb-11ef-a666-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2025-01-26 15:57:26'),
('6ce971ab-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2025-01-31 12:32:48'),
('6cf713bf-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2025-01-31 12:32:48'),
('6d07e25e-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2025-01-31 12:32:48'),
('6d0ecde6-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '2b013a64-2ba0-11ef-a131-7c05075eb45f', '2025-01-31 12:32:48'),
('6d17227a-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2025-01-31 12:32:49'),
('6d1e0391-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2025-01-31 12:32:49'),
('6d2ff6f8-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2025-01-31 12:32:49'),
('6d6f56c4-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2025-01-31 12:32:49'),
('6d803239-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2025-01-31 12:32:49'),
('6d965e17-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2025-01-31 12:32:49'),
('6d9ed969-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2025-01-31 12:32:49'),
('6da91e48-df8c-11ef-b0d2-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2025-01-31 12:32:49'),
('8fa4cbf0-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2025-02-01 20:25:02'),
('8fad425f-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2025-02-01 20:25:02'),
('8fb81b32-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2025-02-01 20:25:02'),
('8fc19b6b-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', '2b013a64-2ba0-11ef-a131-7c05075eb45f', '2025-02-01 20:25:02'),
('8fcf14b3-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2025-02-01 20:25:02'),
('8fd94dc9-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2025-02-01 20:25:02'),
('8fe6cf31-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2025-02-01 20:25:03'),
('8ff2c65c-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2025-02-01 20:25:03'),
('8ffe8e13-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2025-02-01 20:25:03'),
('900fcb7c-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2025-02-01 20:25:03'),
('902c4aa1-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2025-02-01 20:25:03'),
('9062b36a-e097-11ef-9b1c-7c05075eb45f', '8f9e8bfa-e097-11ef-9b1c-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2025-02-01 20:25:03'),
('c6362c4e-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2024-12-01 15:20:42'),
('c66dd316-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2024-12-01 15:20:42'),
('c6935e8d-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6bbf5d1-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6c96ecb-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6d3a491-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6eed24a-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c6f8e26a-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c7032bf0-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2024-12-01 15:20:43'),
('c70b8e08-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2024-12-01 15:20:44'),
('c715d2ea-afb4-11ef-b843-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2024-12-01 15:20:44'),
('ca9d7fb2-dfbc-11ef-b604-7c05075eb45f', '6ccdd1cc-df8c-11ef-b0d2-7c05075eb45f', 'ca83fe57-dfbc-11ef-b604-7c05075eb45f', '2025-01-31 18:19:01'),
('cb042def-e044-11ef-b06e-7c05075eb45f', 'c628eca1-afb4-11ef-b843-7c05075eb45f', 'cae89f13-e044-11ef-b06e-7c05075eb45f', '2025-02-01 10:32:34'),
('e1982115-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2024-12-30 01:39:40'),
('e1a5a493-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2024-12-30 01:39:40'),
('e1d008b5-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2024-12-30 01:39:40'),
('e1df32bc-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2024-12-30 01:39:40'),
('e1e5e334-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2024-12-30 01:39:40'),
('e1ecc646-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2024-12-30 01:39:40'),
('e209a741-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2024-12-30 01:39:41'),
('e2157652-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2024-12-30 01:39:41'),
('e21faed7-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2024-12-30 01:39:41'),
('e229cdd6-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2024-12-30 01:39:41'),
('e2325ca2-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2024-12-30 01:39:41'),
('f431a2db-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '0db1bfad-2ba8-11ef-a131-7c05075eb45f', '2025-01-31 13:12:23'),
('f43bc1a6-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '1c87d062-2ba3-11ef-a131-7c05075eb45f', '2025-01-31 13:12:23'),
('f462b77f-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '2adbfbd3-2ba2-11ef-a131-7c05075eb45f', '2025-01-31 13:12:23'),
('f48292a4-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '2b013a64-2ba0-11ef-a131-7c05075eb45f', '2025-01-31 13:12:23'),
('f489ef0b-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2025-01-31 13:12:23'),
('f4924a27-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2025-01-31 13:12:23'),
('f49aaa40-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2025-01-31 13:12:23'),
('f49fee1f-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2025-01-31 13:12:23'),
('f4a84a3b-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2025-01-31 13:12:23'),
('f4ad7725-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2025-01-31 13:12:24'),
('f4b95bfd-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2025-01-31 13:12:24'),
('f4c1aaac-df91-11ef-b0d2-7c05075eb45f', 'f4241b78-df91-11ef-b0d2-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2025-01-31 13:12:24');

-- --------------------------------------------------------

--
-- Table structure for table `verification_codes`
--

CREATE TABLE `verification_codes` (
  `id` varchar(36) NOT NULL,
  `email` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indexes for table `admin_settings`
--
ALTER TABLE `admin_settings`
  ADD PRIMARY KEY (`admin_id`);

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
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `greek_id` (`greek_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `verification_codes`
--
ALTER TABLE `verification_codes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=410;

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
-- Constraints for table `admin_settings`
--
ALTER TABLE `admin_settings`
  ADD CONSTRAINT `admin_settings_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
