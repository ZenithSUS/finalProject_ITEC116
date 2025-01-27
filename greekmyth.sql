-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 27, 2025 at 04:39 AM
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
(324, '64d91674-c72a-11ef-8716-7c05075eb45f', NULL, 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 'created a post with title asdasdasd', '2024-12-31 03:50:37'),
(331, 'fabc4465-dbb8-11ef-a666-7c05075eb45f', NULL, '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'created a post with title AHHHH in ZenithSUS discussion', '2025-01-26 07:41:40'),
(332, 'dc515497-dbc1-11ef-a666-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'created a post with title AHHHH in Poseidon discussion', '2025-01-26 08:45:14'),
(333, 'dc515497-dbc1-11ef-a666-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'created a post with title AHHHH in Poseidon discussion', '2025-01-26 08:45:15'),
(334, NULL, '6795f62e42d0d', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'commennted on a post titled AHHHH', '2025-01-26 08:45:34'),
(335, NULL, '6795f638de400', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'replied to a comment titled AHHHH', '2025-01-26 08:45:45'),
(336, NULL, '6795f6b059816', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'commennted on a post titled AHHHH', '2025-01-26 08:47:44'),
(339, NULL, '6795f6b168515', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'commennted on a post titled AHHHH', '2025-01-26 08:47:45'),
(340, NULL, '6795f72bb83f9', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'commennted on a post titled AHHHH', '2025-01-26 08:49:47'),
(351, NULL, '6795f7dd7ebc5', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'commennted on a post titled AHHHH', '2025-01-26 08:52:45'),
(352, NULL, '6795f7f24449d', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'commennted on a post titled AHHHH', '2025-01-26 08:53:06'),
(356, NULL, '6795f7f3909d3', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'commennted on a post titled AHHHH', '2025-01-26 08:53:07');

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
('4a5f77c0-c337-11ef-864c-7c05075eb45f', 'ZenZen!', 'zen@gmail.com', '$2y$10$fIUwxMO86i.8Ak97pQO0/.YKt67r2opl7BUtEWT4iZc/jPHQ/UwHq', '677376a3593ab4.23381516.jpg', NULL, 0),
('651e5364-c607-11ef-8986-7c05075eb45f', 'Chou!!', 'chou@gmail.com', '$2y$10$zdoXrTJ2ohrO0HsMfXK5BefilZ9xufkwBSBFHlqSCB3qrpclMZdh.', '677181d56c81a6.02665576.jpg', NULL, 0),
('aad38520-b88f-11ef-88fc-7c05075eb45f', 'ZenithSUS', 'admin2@gmail.com', '$2y$10$zILK0pdKGNaQeZQKcHG6GuZQrqtdw5aeJs.2BpTwSQYTSE.6f/tgO', NULL, NULL, 0),
('c10d8b3f-cb4f-11ef-856e-7c05075eb45f', 'ZenithZUZ!', 'merinojc25@gmail.com', '$2y$10$MzpIzvVfNxUbZW6F61gg..D0cdpbpTujz27W.JMcx.QVvmRoN74FC', '6796f9d15267a3.07257343.jpg', NULL, 0);

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
('6795f62e42d0d', 'dcafa621-dbc1-11ef-a666-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'Insasaasdsadasd', 0, 0, '2025-01-26 16:45:34', 1),
('6795f638de400', 'dcafa621-dbc1-11ef-a666-7c05075eb45f', '6795f62e42d0d', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'EH?', 0, 0, '2025-01-26 16:45:44', 1),
('6795f6b059816', 'dcafa621-dbc1-11ef-a666-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'asdsadas', 1, 0, '2025-01-26 16:47:44', 1),
('6795f6b168515', 'dcafa621-dbc1-11ef-a666-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'asdsadas', 0, 0, '2025-01-26 16:47:45', 1),
('6795f72bb83f9', 'dcafa621-dbc1-11ef-a666-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'sadsa', 0, 0, '2025-01-26 16:49:47', 1),
('6795f7dd7ebc5', 'dcafa621-dbc1-11ef-a666-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'asdsadd', 0, 0, '2025-01-26 16:52:45', 1),
('6795f7f24449d', 'dcafa621-dbc1-11ef-a666-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'HELLO', 0, 0, '2025-01-26 16:53:06', 1),
('6795f7f3909d3', 'dcafa621-dbc1-11ef-a666-7c05075eb45f', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'HELLO', 0, 0, '2025-01-26 16:53:07', 1);

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
('dccc7ecb-c60c-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '2024-12-29 17:46:41'),
('dcd51a27-c60c-11ef-8986-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '2024-12-29 17:46:41'),
('f950cf00-dc52-11ef-a6ce-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '2025-01-27 02:03:59'),
('f95e8de8-dc52-11ef-a6ce-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '2025-01-27 02:04:00');

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
('2adbfbd3-2ba2-11ef-a131-7c05075eb45f', 'Apollo', 'Apollo, one of the Twelve Olympians in Greek mythology, is the son of Zeus and Leto, and the twin brother of Artemis. He embodies a multitude of roles: the god of healing, medicine, archery, music, dance, poetry, prophecy, knowledge, light, and the sun. Apollo is also the leader of the Muses', 'APOLLO.webp', 'Default', 1),
('2b013a64-2ba0-11ef-a131-7c05075eb45f', 'Aphrodite', 'Aphrodite, the ancient Greek goddess of sexual love and beauty, is closely associated with Venus in Roman mythology. According to Hesiod’s Theogony, she emerged from the white foam created by the severed genitals of Uranus (Heaven) after his son Cronus threw them into the sea. Aphrodite was widely worshipped as a goddess of the sea, seafaring, love, and fertility. While her public cult was generally solemn, she occasionally presided over marriage. Notably, she had mortal lovers, including the Trojan shepherd Anchises (with whom she became the mother of Aeneas) and the youth Adonis.', 'APHRODITE.webp', 'Default', 1),
('44c24fcc-2ba4-11ef-a131-7c05075eb45f', 'Artemis', 'Artemis, in ancient Greek religion and mythology, is the goddess of the hunt, the wilderness, wild animals, nature, vegetation, childbirth, care of children, and chastity. She was often said to roam the forests and mountains, attended by her entourage of nymphs. Artemis is the daughter of Zeus and Leto, and the twin sister of Apollo. She was very protective of her and her priestesses innocence.', 'ARTEMIS.webp', 'Default', 1),
('4556df07-dc53-11ef-a6ce-7c05075eb45f', 'Sample God', 'This is a sample God', NULL, '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 1),
('5e965592-2ba6-11ef-a131-7c05075eb45f', 'Poseidon', 'Poseidon, in Greek mythology, is the god of the sea, earthquakes, and horses. He is one of the Twelve Olympians, the major deities of the Greek pantheon. Often depicted with a trident, Poseidon is known for his tempestuous nature, capable of both fury and benevolence. He is considered a protector of seafarers and a creator of storms and floods. In Roman mythology, he is identified with Neptune.', 'POSEIDON.webp', 'Default', 1),
('7fbab8f7-c60c-11ef-8986-7c05075eb45f', 'ChouGod', 'Speed Defines the Winner!', 'chou.jpg', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 1),
('8d2d3e82-2ba4-11ef-a131-7c05075eb45f', 'Athena', 'Athena, in Greek religion, is the city protectress, goddess of war, handicraft, and practical reason. The Romans identified her with Minerva. Unlike Ares, the god of war who represents mere bloodlust, Athena embodies the intellectual and civilized side of war, emphasizing justice and skill. She was also associated paradoxically with peace and handicrafts, particularly spinning and weaving. Majestic and stern, Athena surpassed all others in her domains.', 'ATHENA.webp', 'Default', 1),
('8e3c6da0-2ba3-11ef-a131-7c05075eb45f', 'Ares', 'Ares, the Greek god of war, is one of the Twelve Olympians. He is often depicted as a fierce and bloodthirsty warrior. Ares is the son of Zeus and Hera, and his siblings include Athena, Apollo, and Hermes. In Greek mythology, he is associated with violence, conflict, and the brutality of war', 'ARES.webp', 'Default', 1),
('9caa80f6-c5f2-11ef-8d27-7c05075eb45f', 'ZenithSUS', 'Zenith is Sigma!', 'anime_profile.jpg', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 1),
('b9da2016-2ba7-11ef-a131-7c05075eb45f', 'Demeter', 'Demeter, the revered Greek goddess of agriculture, grain, and fertility, holds a prominent position in Greek mythology and the hearts of ancient people. As the giver of life and sustenance, her influence extended far beyond the fields, touching upon the very cycles of life, death, and rebirth. Demeter is often depicted as a mature woman, her presence radiating warmth and abundance. She is adorned with symbols of her dominion, such as sheaves of wheat, a cornucopia overflowing with fruits and grains, or a torch symbolizing enlightenment and knowledge.\r\n\r\nDemeter\'s significance is deeply intertwined with the Eleusinian Mysteries, secretive rituals centered around the myth of her daughter Persephone\'s abduction by Hades, the god of the underworld. This tragic event plunged Demeter into grief, causing the earth to wither and die. However, upon Persephone\'s eventual return, the world bloomed anew, signifying the renewal of life and the cyclical nature of the seasons. The Eleusinian Mysteries offered initiates a glimpse into these profound concepts, promising a blessed afterlife and fostering a sense of connection to the divine.', 'DEMETER.webp', 'Default', 1),
('b9da2cb2-2ba7-11ef-a131-7c05075eb45f', 'Dionysius', 'Dionysus, the enigmatic and captivating Greek god of wine, revelry, theater, and religious ecstasy, holds a unique place in the pantheon of Greek deities. Often depicted as a youthful and exuberant figure, adorned with ivy wreaths and holding a thyrsus (a pinecone-tipped staff), Dionysus embodies the spirit of uninhibited joy, transformation, and the blurring of boundaries between the human and divine.\r\n\r\nHis origins are shrouded in mystery, with various myths attributing his birthplace to different regions. Some tales claim he is a foreign god who arrived in Greece from the East, bringing with him the knowledge of viticulture and the intoxicating power of wine. Others describe him as the son of Zeus and the mortal Semele, who perished due to Hera\'s jealousy. Regardless of his origin, Dionysus quickly became a beloved figure, celebrated for his ability to liberate people from their inhibitions and connect them to the primal forces of nature.', 'DIONYSIUS.webp', 'Default', 1),
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
('67736dbd49955', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '64d91674-c72a-11ef-8716-7c05075eb45f', NULL, '2024-12-31 12:06:21', 'like'),
('6795e372f1bb9', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '67ca0483-c66c-11ef-9020-7c05075eb45f', NULL, '2025-01-26 15:25:38', 'like'),
('6795e75fabedf', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'fabc4465-dbb8-11ef-a666-7c05075eb45f', NULL, '2025-01-26 15:42:23', 'like'),
('6795f62005f5e', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'dcafa621-dbc1-11ef-a666-7c05075eb45f', NULL, '2025-01-26 16:45:20', 'like'),
('6795f73ada758', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', NULL, '6795f6b059816', '2025-01-26 16:50:02', 'like'),
('6796ddbda6a54', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'dc515497-dbc1-11ef-a666-7c05075eb45f', NULL, '2025-01-27 09:13:33', 'like');

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
('64d91674-c72a-11ef-8716-7c05075eb45f', 'asdasdasd', 'asdsad', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 1, 0, NULL, 1, '2024-12-31 11:50:36', '2024-12-31 11:50:36'),
('67ca0483-c66c-11ef-9020-7c05075eb45f', 'sadasdsad', 'asdasdasdasd', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 1, 0, '7fbab8f7-c60c-11ef-8986-7c05075eb45f', 1, '2024-12-30 13:10:37', '2024-12-30 13:10:37'),
('dc515497-dbc1-11ef-a666-7c05075eb45f', 'AHHHH', 'AHHHHH', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 1, 0, '5e965592-2ba6-11ef-a131-7c05075eb45f', 1, '2025-01-26 16:45:14', '2025-01-26 16:45:14'),
('dcafa621-dbc1-11ef-a666-7c05075eb45f', 'AHHHH', 'AHHHHH', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 1, 0, '5e965592-2ba6-11ef-a131-7c05075eb45f', 1, '2025-01-26 16:45:14', '2025-01-26 16:45:14'),
('fabc4465-dbb8-11ef-a666-7c05075eb45f', 'AHHHH', 'OMSIMS', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 1, 0, '9caa80f6-c5f2-11ef-8d27-7c05075eb45f', 1, '2025-01-26 15:41:39', '2025-01-26 15:41:39');

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
('2e9e00c7-dbbb-11ef-a666-7c05075eb45f', 'Administrator', 'test@gmail.com', '$2y$10$pGQwAcLY.xsdYEo/hHLXd.Yh8V.4Bp/GACzB/PtdPeUHWw7VAn/1y', '6795eb081dfa93.80781122.jpg', '', '0ffcb1423a3aa3292dbb4e833f34789a', '2025-01-26 15:57:25'),
('c628eca1-afb4-11ef-b843-7c05075eb45f', 'Zenith', 'jeranmerino147@gmail.com', '$2y$10$2jPOiKuBvptyg9NYNEFgGuLa2qByh4lCVa7CXm9ZXMuVik7dVv/je', '674c0e64eb8210.77141986.jpg', 'Hello Guys\r\n', '5edf873c0896aa55046e8f1a6fbeecba', '2024-12-01 15:20:42'),
('e18a6c51-c60b-11ef-8986-7c05075eb45f', 'ChouIsOP', 'chou@gmail.com', '$2y$10$bLe57XMAXc111tQnLaubmeQo/GZ2Keuh.6tVKxSZHv1ncRqVNia.2', '6771897dc58b42.49403452.jpg', 'WATAHHHH', '4050a88956f715f399744758c2140a48', '2024-12-30 01:39:40');

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
('17e18c19-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '44c24fcc-2ba4-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('17ebcdeb-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '5e965592-2ba6-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('17f56276-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '8d2d3e82-2ba4-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('17fe765d-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '8e3c6da0-2ba3-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('180525d5-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'b9da2016-2ba7-11ef-a131-7c05075eb45f', '2024-12-10 13:39:15'),
('1815b229-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'b9da2cb2-2ba7-11ef-a131-7c05075eb45f', '2024-12-10 13:39:16'),
('182051b8-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'cec09d13-2b9d-11ef-a131-7c05075eb45f', '2024-12-10 13:39:16'),
('1828b412-b6b9-11ef-ba98-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2024-12-10 13:39:16'),
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
('4565613f-dc53-11ef-a6ce-7c05075eb45f', '2e9e00c7-dbbb-11ef-a666-7c05075eb45f', '4556df07-dc53-11ef-a6ce-7c05075eb45f', '2025-01-27 10:06:07'),
('7fe311f3-c60c-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', '7fbab8f7-c60c-11ef-8986-7c05075eb45f', '2024-12-30 01:44:05'),
('8519b5b2-c60d-11ef-8986-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '7fbab8f7-c60c-11ef-8986-7c05075eb45f', '2024-12-30 01:51:24'),
('9ce8cb34-c5f2-11ef-8d27-7c05075eb45f', '1779c872-b6b9-11ef-ba98-7c05075eb45f', '9caa80f6-c5f2-11ef-8d27-7c05075eb45f', '2024-12-29 22:38:47'),
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
('e2325ca2-c60b-11ef-8986-7c05075eb45f', 'e18a6c51-c60b-11ef-8986-7c05075eb45f', 'eb824654-2ba6-11ef-a131-7c05075eb45f', '2024-12-30 01:39:41');

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
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=358;

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
