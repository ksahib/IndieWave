-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2024 at 04:08 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `indiewave`
--

-- --------------------------------------------------------

--
-- Table structure for table `album`
--

CREATE TABLE `album` (
  `album_id` varchar(64) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `cover_art` varchar(100) DEFAULT NULL,
  `artist_name` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `album`
--

INSERT INTO `album` (`album_id`, `name`, `cover_art`, `artist_name`) VALUES
('6734ccee0b4cf', 'dum', '6734ccee0ab15', 'Upodeshta'),
('673639b9cb661', 'Ok Computer', '673639b9caf0f', 'Upodeshta'),
('6738a77934eea', 'Life In a Bubble', '6738a77934b94', 'Upodeshta'),
('6738b049bcdfc', 'Life', '6738b049bc845', 'Upodeshta'),
('6738bac0e6522', 'Bubble', '6738bac0e612c', 'Upodeshta'),
('6738bbbdd85a8', 'asdf', '6738bbbdd81dd', 'Upodeshta'),
('6738bce470937', 'dsf', '6738bce470505', 'Upodeshta'),
('6738bd9f625a2', 'sadsf', '6738bd9f60a77', 'Upodeshta'),
('6738be316adce', 'asdas', '6738be316a964', 'Upodeshta'),
('6738be6b57939', 'asd', '6738be6b57605', 'Upodeshta'),
('6738bea095500', 'asdfdf', '6738bea09512d', 'Upodeshta'),
('6738bfa1bf545', 'dasfsfg', '6738bfa1bf19e', 'Upodeshta'),
('673b57f2da8dd', 'Aeforia', '673b57f2da48c', 'Upodeshta'),
('673b610885372', 'Euphoria', '673b610885013', 'Upodeshta'),
('673b65b7be5c9', 'Aerith', '673b65b7be1a8', 'Upodeshta'),
('673bcf18c7972', 'Aerith2', '673bcf18c7262', 'Upodeshta'),
('673bd3de988e8', 'Aerith3', '673bd3de984b0', 'Upodeshta'),
('67432ebdb9b22', 'Never To Be Released', '67432ebdb9631', 'Memories Of Nowhere'),
('674331664048c', 'A Moon Shaped Pool', '674331664016e', 'Radiohead'),
('67439ba2b378e', 'Creepin', '67439ba2b28eb', 'The Weeknd'),
('67439c7bbeb64', 'The House Of Balloons', '67439c7bbe82d', 'The Weeknd'),
('675100191c07a', 'Metallica', '675100191bcc7', 'Metallica'),
('67510530b7a68', 'A Foot In the Door', '67510530b77ef', 'Pink Floyd'),
('675106de21033', 'Chena Jogot', '675106de20c43', 'Vibe'),
('675108b84eed0', '1996', '675108b84ec2b', 'Indalo'),
('67510af5c6507', 'Hyena Express', '67510af5c6150', 'Shonar Bangla Circus'),
('67510ba1bafec', 'Husn', '67510ba1bad82', 'Anuv Jain'),
('675115bd1cf75', 'In The Starry Night', '675115bd1cd15', 'Aimer'),
('6751170d48cda', 'Escalate', '6751170d48a43', 'Aimer');

-- --------------------------------------------------------

--
-- Table structure for table `artist`
--

CREATE TABLE `artist` (
  `artist_name` varchar(60) NOT NULL,
  `profile_pic` varchar(100) DEFAULT NULL,
  `about` varchar(5000) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artist`
--

INSERT INTO `artist` (`artist_name`, `profile_pic`, `about`, `email`) VALUES
('Aimer', '675115ac0a90e', 'Aimer is a Japanese singer and songwriter renowned for her ethereal voice and emotive music that transcends genres. Debuting in 2011 with her single \"Rokutousei no Yoru,\" Aimer quickly gained recognition for her unique vocal tone and ability to evoke deep emotion. Her music blends elements of pop, rock, and jazz, often characterized by haunting melodies and poetic lyrics.Aimer has contributed to numerous anime soundtracks, with iconic tracks like \"Brave Shine\" (from Fate/stay night: Unlimited Blade Works) and \"Zankyou Sanka\" (from Demon Slayer), solidifying her global appeal. Her albums, such as Daydream and Walpurgis, showcase her versatility and artistic growth.Beloved for her artistry and authenticity, Aimer continues to captivate fans worldwide, leaving an indelible mark on the contemporary Japanese music scene.', 'aimer@gmail.com'),
('Anuv Jain', '67510b95371e8', 'Anuv Jain is an Indian singer-songwriter and indie artist celebrated for his soulful melodies and heartfelt lyrics. Hailing from Ludhiana, Anuv began his musical journey as a self-taught musician, gaining widespread recognition with his debut single \"Baarishein\" in 2016. Known for his soothing voice and poetic storytelling, his songs often explore themes of love, longing, and self-discovery.Anuv’s hits like \"Riha,\" \"Mishri,\" and \"Alag Aasmaan\" have earned him a dedicated fanbase, resonating deeply with young listeners across the globe. His minimalist yet emotionally rich compositions, paired with his down-to-earth persona, have made him a prominent figure in the Indian indie music scene.With millions of streams on platforms like Spotify and YouTube, Anuv Jain continues to captivate audiences with his ability to turn raw emotions into timeless music.', 'anuv@gmail.com'),
('Indalo', '6751088e325ec', 'Indalo is a Bangladeshi rock band formed in 2012, known for their distinctive blend of alternative rock and introspective lyrics. The band’s music often explores themes of life, love, and existential musings, resonating deeply with modern audiences. Indalo’s unique sound combines melodic guitar riffs, soulful vocals, and a progressive approach to songwriting, earning them a loyal fan base in Bangladesh\'s indie and rock music scene. With notable singles like \"Chhobi\" and \"Only Hope\", Indalo continues to push creative boundaries, cementing their place as one of the most innovative acts in contemporary Bangladeshi music.', 'indalo@gmail.com'),
('Memories Of Nowhere', '67432dbb9b960', 'Emerging from the shadows of Dhaka, Memories Of Nowhere is a haunting post-rock duo that crafts melancholic soundscapes. Their music, a blend of cinematic instrumentation and raw emotion, feels like a journey through forgotten memories and distant horizons.\n\nFormed in an abandoned theater, the duo\'s spontaneous collaboration gave birth to a unique sound. Driven by swelling guitars, brooding atmospheres, and intricate rhythms, their music paints a picture of beauty within despair. Influenced by both nature\'s grandeur and modern solitude, their sound is vast and intimate.\n\nTheir debut album, Never To Be Released, is a mournful exploration of loss, longing, and solitude. Tracks like Starry Death build layers of instrumentation into emotional crescendos, leaving listeners in a dreamlike haze.\n\nMemories Of Nowhere\'s music speaks directly to the soul, offering solace in the sound of emptiness. Perfect for fans of Mogwai, Explosions in the Sky, and Godspeed You! Black Emperor, their art is an ode to the beauty in darkness.', 'mon@gmail.com'),
('Metallica', '67510008d9980', 'Metallica is a legendary American heavy metal band formed in 1981 in Los Angeles by drummer Lars Ulrich and vocalist/guitarist James Hetfield. Known for their aggressive sound, intricate compositions, and genre-defining contributions to heavy metal, Metallica rose to prominence with albums like Ride the Lightning (1984), Master of Puppets (1986), and their self-titled \"Black Album\" (1991), which includes hits like \"Enter Sandman\" and \"Nothing Else Matters.\" Over their career, they have sold over 125 million records worldwide, earned nine Grammy Awards, and remain one of the most influential and successful bands in rock history.', 'metallica@gmail.com'),
('Pink Floyd', '6751051247653', 'Pink Floyd is a legendary British rock band formed in 1965, renowned for their groundbreaking music, philosophical lyrics, and stunning live performances. Pioneers of progressive and psychedelic rock, the band achieved international fame with concept albums like The Dark Side of the Moon (1973), Wish You Were Here (1975), and The Wall (1979). Known for their deep explorations of human emotion, society, and existential themes, Pink Floyd\'s innovative use of sound effects, elaborate instrumentation, and visual storytelling has left an indelible mark on music history. Founding members included Syd Barrett, Roger Waters, Richard Wright, and Nick Mason, with David Gilmour joining later. Their influence extends far beyond music, inspiring countless artists and fans across generations.', 'floyd@gmail.com'),
('Radiohead', '67433138e8149', 'Hailing from Abingdon, Oxfordshire, Radiohead is an English rock band renowned for their innovative and boundary-pushing music. Formed in 1985, the band consists of Thom Yorke (vocals, guitar, piano), Jonny Greenwood (lead guitar, keyboards), Colin Greenwood (bass), Ed O’Brien (guitar, backing vocals), and Philip Selway (drums, percussion).\n\nRadiohead achieved international fame with their 1992 debut single, \"Creep,\" a brooding anthem of alienation. Their subsequent albums, including The Bends (1995) and OK Computer (1997), solidified their reputation as a leading band of their generation. OK Computer, in particular, is hailed as a landmark album for its exploration of technology, alienation, and dystopia.\n\nIn 2000, Radiohead released Kid A, a radical departure into experimental electronic sounds and abstract song structures. This reinvention cemented their status as pioneers willing to challenge the conventions of popular music. Subsequent albums like Amnesiac (2001), In Rainbows (2007), and A Moon Shaped Pool (2016) showcase their ability to evolve while maintaining their signature emotional depth and sonic innovation.\n\nRenowned for their electrifying live performances and Thom Yorke\'s haunting vocals, Radiohead continues to influence countless artists. They are celebrated not just for their artistic achievements but also for their commitment to environmental activism and progressive distribution methods.\n\nWith numerous accolades, including inductions into the Rock and Roll Hall of Fame in 2019, Radiohead’s music remains vital and transformative, bridging the emotional and the experimental, the personal and the political.', 'radio.head@gmail.com'),
('Shonar Bangla Circus', '67510aa3108ec', 'Shonar Bangla Circus is a dynamic and influential Bangladeshi rock band known for their experimental sound and thought-provoking lyrics. Formed in the mid-2000s, the band quickly made a name for themselves with their unique fusion of alternative rock, progressive elements, and socially conscious themes.Their debut album, Circus Er Pitikas (2007), showcased their ability to blend intricate musical arrangements with sharp commentary on societal issues, earning them a devoted fanbase. Songs like \"Dekho Manush\" and \"Dhushor Bhabna\" became iconic for their introspective tone and vibrant energy.Over the years, Circus has continued to push creative boundaries, solidifying their place as one of the most innovative acts in the Bangladeshi music scene. Their music not only entertains but also inspires listeners to reflect on life\'s complexities and challenges.', 'sbc@gmail.com'),
('The Weeknd', '67439b082854c', 'The Weeknd (born Abel Makkonen Tesfaye on February 16, 1990) is a Canadian singer, songwriter, and record producer known for his innovative blend of R&B, pop, and electronic music. Emerging from Toronto\'s underground music scene in the early 2010s, The Weeknd gained global recognition with his mixtapes House of Balloons, Thursday, and Echoes of Silence, which introduced his signature falsetto vocals and haunting, atmospheric production.With a career marked by groundbreaking albums like Starboy, ', 'wk@gmail.com'),
('Upodeshta', '67343b7f2860b', 'ffdgfhfg', 'Artoria'),
('Vibe', '675106c81e300', 'Vibe is a renowned Bangladeshi rock band that emerged in the early 2000s, captivating audiences with their unique blend of alternative rock and grunge-inspired music. Known for their emotive lyrics and dynamic soundscapes, Vibe quickly gained popularity with tracks like \"Opekkha\" and \"Chena Jogot,\" which became anthems for the youth of Bangladesh.Their debut album, Chena Jogot (2007), solidified their status in the Bangladeshi music scene, combining introspective themes with powerful guitar-driven melodies. Despite a limited discography, Vibe\'s music continues to resonate with fans, embodying the spirit of a generation seeking meaning and identity through art.Though the band remains relatively low-profile in recent years, their legacy endures as a symbol of creativity and passion in the Bangladeshi rock music landscape.', 'vibe@gmail.com');

-- --------------------------------------------------------

--
-- Stand-in structure for view `feed`
-- (See below for the actual view)
--
CREATE TABLE `feed` (
`artist_name` varchar(60)
,`album_id` varchar(64)
,`track_id` varchar(64)
,`followers` bigint(21)
,`likes` bigint(21)
,`streams` bigint(21)
,`release_date` date
);

-- --------------------------------------------------------

--
-- Table structure for table `follows`
--

CREATE TABLE `follows` (
  `artist_name` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `follows`
--

INSERT INTO `follows` (`artist_name`, `email`) VALUES
('Aimer', 'aimer@gmail.com'),
('Indalo', 'aimer@gmail.com'),
('Memories Of Nowhere', 'Artoria'),
('Radiohead', 'Artoria'),
('Radiohead', 'gil45'),
('The Weeknd', 'Artoria'),
('The Weeknd', 'metallica@gmail.com'),
('Upodeshta', 'Artoria'),
('Upodeshta', 'emiya'),
('Vibe', 'aimer@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `tag` varchar(20) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`tag`, `description`) VALUES
('Blues', 'Known for its melancholic melodies and themes of hardship, often featuring guitars and harmonicas.'),
('Classical', 'Rooted in Western liturgical and secular music traditions, emphasizing orchestral and instrumental c'),
('Country', 'Features storytelling lyrics, acoustic instruments, and themes of life, love, and hardships.'),
('Electronic', 'Focuses on digitally produced beats and melodies, often used in dance and club settings.'),
('Hip-Hop', 'Combines rhythmic speech (rapping) with beats and samples from other genres.'),
('Jazz', 'Known for its swing and blue notes, improvisation, and complex harmonies.'),
('Pop', 'A genre of popular music with catchy melodies and lyrics appealing to a wide audience.'),
('R&B', 'Rhythm and Blues blends soulful vocals with funk, hip-hop, and pop influences.'),
('Reggae', 'Originating in Jamaica, characterized by a slow tempo, offbeat rhythms, and socially conscious lyric'),
('Rock', 'Characterized by strong beats, electric guitars, and powerful vocals.');

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `image_id` varchar(100) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `image_type` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`image_id`, `image_url`, `image_type`) VALUES
('67340d49e0807', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731464523/a1avsd23btp9ug8hrhva.png', 'profile_pic'),
('67343b7f2860b', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731476352/ipdzpucjr4qfwfqhxals.png', 'profile_pic'),
('6734ccee0ab15', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731513036/gxr0oveotbchhjhxc8jh.jpg', 'cover_art'),
('6734cf378b208', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731514167/eorwlrtzlk8ts83zbvtj.jpg', 'cover_art'),
('673551242c07c', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731547427/pnvzfg9lc7p6spsm85lh.jpg', 'cover_art'),
('673639b9caf0f', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731606971/dpolmlawszqnggfiikec.jpg', 'cover_art'),
('6736c94216409', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731643715/lmzo9inq6htm2td3louy.jpg', 'cover_art'),
('6736dbac39e0c', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731648429/bej0xvbs22njrufec84b.jpg', 'cover_art'),
('6736dbe23e9ce', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731648483/immqm61bk6lz8rgc4yv5.jpg', 'cover_art'),
('6736dc41465a2', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731648578/p4av7lchqibj201geltv.jpg', 'cover_art'),
('6736dcafd4822', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731648689/z3lpfidhgizgmplovslj.jpg', 'cover_art'),
('6736e397830f3', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731650456/bzo6um7pockyltozmsyh.jpg', 'cover_art'),
('6736e3a05c970', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731650465/kqtzytayvwuoovcmpjjn.jpg', 'cover_art'),
('6736e4f75490b', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731650808/md0ikz5zre0oymjqc6q8.jpg', 'cover_art'),
('6736e75a4fd82', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731651417/eyxajjcoo00eglms5zso.jpg', 'cover_art'),
('6736e8471f30a', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731651654/ohktkyfzhvvr2nleb2zn.jpg', 'cover_art'),
('6736fe4b71e76', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731657291/acm5kadem8mcfx2jdwbd.jpg', 'profile_pic'),
('673703f5c7fa9', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731658741/ccvwvvmcvjhpjtytfmrz.jpg', 'cover_art'),
('6737054c2aac8', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731659083/fignxuhhgnihlujezv4a.jpg', 'cover_art'),
('6737068e805b6', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731659405/hg7rsrybxsr4a9yummmd.jpg', 'cover_art'),
('673731858ff05', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731670405/eihjmqtacx569z9ihnxi.jpg', 'cover_art'),
('6737327667894', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731670645/nhwqm6jv9ch2lai0lcib.jpg', 'cover_art'),
('67380a3cb3f99', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731725885/f6nejqcaxxwjlo7dlasc.webp', 'cover_art'),
('67383bdaae0ae', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731738587/tvgxhneekmvmkzec00ba.webp', 'cover_art'),
('67383c6bebafa', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731738732/kjmm6oifcitlch8tyjvx.webp', 'cover_art'),
('67383ce83af00', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731738856/lldwpavhzgrqrcnllwyn.webp', 'cover_art'),
('6738444b2345f', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731740747/qzihr20jwayoww1eujny.webp', 'cover_art'),
('673845883372e', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731741064/xzqaphx5culx9dfu2ine.webp', 'cover_art'),
('673846d927afc', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731741401/la4hwwutczrzas2eh6mq.webp', 'cover_art'),
('673847ea486e5', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731741675/jgtxsfjaidtplxbls1s2.webp', 'cover_art'),
('673849b2b6bf5', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731742131/pgucnl17tlqtmi6besi0.webp', 'cover_art'),
('67384aded88e9', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731742431/nlcoqxavagoklck6lyis.webp', 'cover_art'),
('67384b3fd49ce', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731742528/sdntsdyvj9ffmkoiipz9.webp', 'cover_art'),
('67384bc1c70c1', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731742658/tpoh2wrhkvgnms8sbcga.webp', 'cover_art'),
('673896e8792c9', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731761897/ylkudr3mui9lcp2knnjx.webp', 'cover_art'),
('6738a77934b94', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731766137/rrxqyyyztbksiajtpnhe.webp', 'cover_art'),
('6738b049bc845', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731768394/j4bfulc08xzhfezkh06x.webp', 'cover_art'),
('6738bac0e612c', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731771073/qnznnv8twdk224hnu3xh.webp', 'cover_art'),
('6738bbbdd81dd', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731771326/s0pscxh8icftj4x2exub.webp', 'cover_art'),
('6738bce470505', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731771621/ctsk0ivvdytg8i2uootu.webp', 'cover_art'),
('6738bd9f60a77', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731771808/l5j7qoftyubpqjk2t9ls.webp', 'cover_art'),
('6738be316a964', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731771954/kzs0gxvhpisulga9qjmn.webp', 'cover_art'),
('6738be6b57605', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731772012/ea2f8soqsqeqxt9tuvud.webp', 'cover_art'),
('6738bea09512d', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731772065/evx18mx67cpigzmktujy.webp', 'cover_art'),
('6738bfa1bf19e', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731772322/s4t1o9vhyi89c1vs1xbs.webp', 'cover_art'),
('673b57f2da48c', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731942387/istkmk10ccomjc4lrmzy.webp', 'cover_art'),
('673b610885013', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731944714/yq69cex5bgauezstf76w.webp', 'cover_art'),
('673b65b7be1a8', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731945913/gnw2am0uac0vgwt0fzvz.webp', 'cover_art'),
('673bcf18c7262', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731972890/ozjof8i7we2nflfzlthx.webp', 'cover_art'),
('673bd3de984b0', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731974112/ljtwu60uc7e7sznvgv0e.webp', 'cover_art'),
('6741263fca34b', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731651417/eyxajjcoo00eglms5zso.jpg', 'profile_pic'),
('6741266b8c41e', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731651417/eyxajjcoo00eglms5zso.jpg', 'profile_pic'),
('6741274f79e08', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731651417/eyxajjcoo00eglms5zso.jpg', 'profile_pic'),
('67432dbb9b960', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1732455873/abxwzsv1snmheq3ke5jq.jpg', 'profile_pic'),
('67432e24a013b', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1732455978/yacrlrojqmndzcy6uqon.jpg', 'profile_pic'),
('67432ebdb9631', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733366343/download_2_atksyt.png', 'cover_art'),
('67433138e8149', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1732456767/d5aqtmxiuq1ykuyq5spj.png', 'profile_pic'),
('674331664016e', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1732456812/zgz3xxfhqnk7qyvi1vj7.jpg', 'cover_art'),
('67439b082854c', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1732483854/eyn2x6lpxsmolspmxdnl.jpg', 'profile_pic'),
('67439ba2b28eb', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1732484008/zrzvumwgpld1wvsnkc9k.webp', 'cover_art'),
('67439c7bbe82d', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1732484226/iarxmrfbocpg7iqbd8ek.jpg', 'cover_art'),
('675001dda5115', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733296606/ofx8f0jzzgfskedvg7qv.jpg', 'cover_pic'),
('6750032debd72', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733296942/sxuoyzijo0nubfj17jed.jpg', 'cover_pic'),
('6750651f13dfa', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733322016/cc9geat0sownukcilwoo.jpg', 'profile_pic'),
('675065eaadd8d', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733322220/lndvn2s3unizdwudcrfj.jpg', 'profile_pic'),
('67506744a83ae', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733322566/yyatqqex2bmunzqxqkmr.jpg', 'profile_pic'),
('6750fd161ae6e', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733360919/ayxjvjjjotmjl8dxcuml.jpg', 'profile_pic'),
('6750fdf64004e', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733361143/fnsel2gdmvej2lnjqxjp.jpg', 'profile_pic'),
('6750fe3684319', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733361208/mhu05vws6upz3ntdjbon.webp', 'profile_pic'),
('6750ff2652945', '674331c3ae39chttps://res.cloudinary.com/doonwj6hd/image/upload/v1733361208/mhu05vws6upz3ntdjbon.webp', 'profile_pic'),
('6750ff545a8fa', '674331c3ae39chttps://res.cloudinary.com/doonwj6hd/image/upload/v1733361208/mhu05vws6upz3ntdjbon.webp', 'profile_pic'),
('6750ffc607ea4', '674331c3ae39chttps://res.cloudinary.com/doonwj6hd/image/upload/v1733361208/mhu05vws6upz3ntdjbon.webp', 'profile_pic'),
('67510008d9980', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733361674/jcay4wpkp509uhamcodo.jpg', 'profile_pic'),
('675100191bcc7', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733361690/s9rupugzmxoaotlpn4xl.jpg', 'cover_art'),
('675102c07919e', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733362370/x3i8eioozalhsusogyiq.webp', 'profile_pic'),
('675104a2960ef', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733362852/sn3dl0lj4fpfcw7hbnnb.jpg', 'profile_pic'),
('675104b7f3640', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733362872/hmuqpo1vmhlxhq9tfocf.jpg', 'profile_pic'),
('6751051247653', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733362962/tkzp9b1iwczbtxqof1rb.jpg', 'profile_pic'),
('67510530b77ef', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733362994/dxsugytexoxsnosx6tiz.jpg', 'cover_art'),
('675106ae818e7', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733363376/u3km7crynsighevbovkt.jpg', 'profile_pic'),
('675106c81e300', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733363401/xesfgulpqyquw6ihzhnd.jpg', 'profile_pic'),
('675106de20c43', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733363423/zawjmwblqnhrjdjy8au5.jpg', 'cover_art'),
('6751074ec7dcf', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733363536/if06dpps2hnygs4rq7oj.jpg', 'profile_pic'),
('6751075c46782', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733363549/ngr2zjarqbsifqhtzcau.jpg', 'profile_pic'),
('6751088e325ec', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733363855/sotog7bkdcu78bq5idlz.jpg', 'profile_pic'),
('675108b84ec2b', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733363897/cleuguspdsc96t6zgj5t.jpg', 'cover_art'),
('67510aa3108ec', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733364388/vgfq4suhzxaenuo4lgg0.jpg', 'profile_pic'),
('67510ae2390d1', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733364451/uuh3gujxjlh3rclt5dcb.jpg', 'profile_pic'),
('67510af5c6150', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733364471/mveb5fghcowaeowhp43n.jpg', 'cover_art'),
('67510b64660b2', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733364582/mzaqcauit0yfvmufgevc.jpg', 'profile_pic'),
('67510b95371e8', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733364630/upw279a0lqa4zj2hmaw5.jpg', 'profile_pic'),
('67510ba1bad82', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733364643/zvtl9a3bzo85jjgylqvd.jpg', 'cover_art'),
('675115ac0a90e', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733367213/hnwp4fwd7yoltdxfmdmo.jpg', 'profile_pic'),
('675115bd1cd15', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733367230/yxp92nv3aed2v3cmehqn.jpg', 'cover_art'),
('6751170d48a43', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1733367566/h3wlvns9fuldecakq6q3.jpg', 'cover_art'),
('default', 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731329463/profile_pic/lhjg1rgm4a0c4uedtyzk.jpg', 'profile_pic');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `email` varchar(60) NOT NULL,
  `track_id` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`email`, `track_id`) VALUES
('Artoria', '67432f493655f'),
('Artoria', '674331c3ae39c'),
('Artoria', '67439c307a4b1'),
('emiya', '674331c3ae39c'),
('gil3', '674331c3ae39c'),
('gil45', '674331c3ae39c'),
('wk@gmail.com', '674331c3ae39c'),
('wk@gmail.com', '67439c307a4b1');

-- --------------------------------------------------------

--
-- Table structure for table `playlists`
--

CREATE TABLE `playlists` (
  `playlist_id` varchar(64) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `cover_pic` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `playlists`
--

INSERT INTO `playlists` (`playlist_id`, `email`, `name`, `cover_pic`) VALUES
('6750032dec088', 'Artoria', 'winter', '6750032debd72');

-- --------------------------------------------------------

--
-- Table structure for table `queue`
--

CREATE TABLE `queue` (
  `playlist_id` varchar(64) DEFAULT NULL,
  `track_id` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `queue`
--

INSERT INTO `queue` (`playlist_id`, `track_id`) VALUES
('6750032dec088', '673d5b1341b60');

-- --------------------------------------------------------

--
-- Table structure for table `released`
--

CREATE TABLE `released` (
  `artist_name` varchar(60) DEFAULT NULL,
  `album_id` varchar(64) DEFAULT NULL,
  `release_date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `released`
--

INSERT INTO `released` (`artist_name`, `album_id`, `release_date`) VALUES
('Upodeshta', '6738a77934eea', '2024-11-22'),
('Radiohead', '674331664048c', '2024-11-24'),
('Memories Of Nowhere', '67432ebdb9b22', '2024-11-24'),
('The Weeknd', '67439c7bbeb64', '2024-11-25'),
('The Weeknd', '67439ba2b378e', '2024-11-25'),
('Metallica', '675100191c07a', '2024-12-05'),
('Pink Floyd', '67510530b7a68', '2024-12-05'),
('Indalo', '675108b84eed0', '2024-12-05'),
('Shonar Bangla Circus', '67510af5c6507', '2024-12-05'),
('Anuv Jain', '67510ba1bafec', '2024-12-05'),
('Vibe', '675106de21033', '2024-12-05'),
('Aimer', '675115bd1cf75', '2024-12-05'),
('Aimer', '6751170d48cda', '2024-12-05');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `token_id` varchar(500) NOT NULL,
  `email` varchar(32) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT curtime(),
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_used` timestamp NOT NULL DEFAULT curtime()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`token_id`, `email`, `created_at`, `expires_at`, `last_used`) VALUES
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzE0MjUyMTYsImV4cCI6MTczNDAxNzIxNiwiZGF0YSI6eyJlbWFpbCI6ImdpbDQ1IiwidW5pcXVlIjoiNjczMzczYzBlOTY3ZiJ9fQ.rgW1wUzX_iEKNq9gydIBDjt6yG-MmT56zEgKRhOdfYw', 'gil45', '2024-11-12 15:26:56', '2024-12-12 10:26:56', '2024-11-12 15:26:56'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzE5NDIzMTAsImV4cCI6MTczNDUzNDMxMCwiZGF0YSI6eyJlbWFpbCI6IkFydG9yaWEiLCJ1bmlxdWUiOiI2NzNiNTdhNjFmNDEzIn19.DYYh4R78qtVCFiRNNIdtyZZ-8k_FiTP3P7OrBg7CiRE', 'Artoria', '2024-11-18 15:05:10', '2024-12-18 10:05:10', '2024-11-18 15:05:10'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEwOTQzMTksImV4cCI6MTczMzY4NjMxOSwiZGF0YSI6eyJlbWFpbCI6ImdpbDMiLCJ1bmlxdWUiOiI2NzJlNjcyZjVmYzhhIn19.FFctZl3vDCfWAIdM6uijU-A4T-Mhx1ki5pRSz1NN77A', 'gil3', '2024-11-08 19:31:59', '2024-12-08 14:31:59', '2024-11-08 19:31:59'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEwOTUwMDIsImV4cCI6MTczMzY4NzAwMiwiZGF0YSI6eyJlbWFpbCI6ImdpbDIiLCJ1bmlxdWUiOiI2NzJlNjlkYTAwZGRmIn19.lX-HATApqJ8yQl2YDPEXz69obZrQJZmtGs4RDRPpQ_A', 'gil2', '2024-11-08 19:43:22', '2024-12-08 14:43:22', '2024-11-08 19:43:22'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzEzMzE3NDcsImV4cCI6MTczMzkyMzc0NywiZGF0YSI6eyJlbWFpbCI6InNhbXBsZUBleGFtcGxlLmNvbSIsInVuaXF1ZSI6IjY3MzIwNmEzZDFhYjYifX0.czEptwujQAYDrYaX9vWQmiNkiDnjaRVWmKnh8XEAyUE', 'sample@example.com', '2024-11-11 13:29:07', '2024-12-11 08:29:07', '2024-11-11 13:29:07'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI0NTY1OTAsImV4cCI6MTczNTA0ODU5MCwiZGF0YSI6eyJlbWFpbCI6InJhZGlvLmhlYWRAZ21haWwuY29tIiwidW5pcXVlIjoiNjc0MzMwOGVhNDA5OCJ9fQ.lcrR2Lu7sKO0NThDTp6uVxBY25CiRydtNg5bJVtXFBU', 'radio.head@gmail.com', '2024-11-24 13:56:30', '2024-12-24 08:56:30', '2024-11-24 13:56:30'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI2MTQ2ODYsImV4cCI6MTczNTIwNjY4NiwiZGF0YSI6eyJlbWFpbCI6IkFydG9yaWEiLCJ1bmlxdWUiOiI2NzQ1OWExZTAwM2RhIn19.Ty3UOvBDHM7khr2tmLe4dDXVf_hqVAQJChm_3I5pG1I', 'Artoria', '2024-11-26 09:51:26', '2024-12-26 04:51:26', '2024-11-26 09:51:26'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzI2MzI2MTMsImV4cCI6MTczNTIyNDYxMywiZGF0YSI6eyJlbWFpbCI6ImdpbDQ1IiwidW5pcXVlIjoiNjc0NWUwMjU4ZGE5MCJ9fQ.QRyTSG3jgtm5_FS628wp9kkrpsbWi2LO6NS6hWbUABQ', 'gil45', '2024-11-26 14:50:13', '2024-12-26 09:50:13', '2024-11-26 14:50:13'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzIwNjE3NTAsImV4cCI6MTczNDY1Mzc1MCwiZGF0YSI6eyJlbWFpbCI6IkFydG9yaWEiLCJ1bmlxdWUiOiI2NzNkMmEzNjkwM2E5In19.AKEt_ky3C9DoQYgGsER0YZyWtgN2NmzfOMx70ObWGGs', 'Artoria', '2024-11-20 00:15:50', '2024-12-19 19:15:50', '2024-11-20 00:15:50'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzIyNTc1MjcsImV4cCI6MTczNDg0OTUyNywiZGF0YSI6eyJlbWFpbCI6IkFydG9yaWEiLCJ1bmlxdWUiOiI2NzQwMjZmNzEwOWIzIn19.vLVYwtpn9T5XUUleqw43g0Ytc0NR4ja7lqFcPaxIjyE', 'Artoria', '2024-11-22 06:38:47', '2024-12-22 01:38:47', '2024-11-22 06:38:47'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzMzMjA4MTAsImV4cCI6MTczNTkxMjgxMCwiZGF0YSI6eyJlbWFpbCI6IkFydG9yaWEiLCJ1bmlxdWUiOiI2NzUwNjA2YThmOGY2In19.Uts27QuwMBegtbQZ6P06U74uTQ9ZIoFU2CSQv8vZoIA', 'Artoria', '2024-12-04 14:00:10', '2025-01-03 09:00:10', '2024-12-04 14:00:10'),
('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzMzNjcxMjMsImV4cCI6MTczMzQxMDMyMywiZGF0YSI6eyJlbWFpbCI6ImFpbWVyQGdtYWlsLmNvbSIsInVuaXF1ZSI6IjY3NTExNTUzOTE2M2IifX0.u2x1G9wji7BffxhIcpD-w2kS67Gc4zpQze05J08Nrso', 'aimer@gmail.com', '2024-12-05 02:52:03', '2024-12-05 09:52:03', '2024-12-05 02:52:03');

-- --------------------------------------------------------

--
-- Table structure for table `streams`
--

CREATE TABLE `streams` (
  `email` varchar(60) DEFAULT NULL,
  `track_id` varchar(64) DEFAULT NULL,
  `streamed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `streams`
--

INSERT INTO `streams` (`email`, `track_id`, `streamed_at`) VALUES
('Artoria', '67439cab9f2b1', '2024-11-26 13:52:15'),
('Artoria', '67432f493655f', '2024-11-26 13:52:15'),
('Artoria', '67432f493655f', '2024-11-26 13:52:15'),
('Artoria', '67432f872123b', '2024-11-26 13:52:15'),
('Artoria', '67432f872123b', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '67432f493655f', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '67432f493655f', '2024-11-26 13:52:15'),
('Artoria', '67432f872123b', '2024-11-26 13:52:15'),
('Artoria', '67439cab9f2b1', '2024-11-26 13:52:15'),
('Artoria', '67432f872123b', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '673d5b1341b60', '2024-11-26 13:52:15'),
('Artoria', '67432f872123b', '2024-11-26 13:52:15'),
('Artoria', '673d5b1341b60', '2024-11-26 13:52:15'),
('Artoria', '67439cab9f2b1', '2024-11-26 13:52:15'),
('Artoria', '67432f872123b', '2024-11-26 13:52:15'),
('Artoria', '67432f493655f', '2024-11-26 13:52:15'),
('Artoria', '67432f493655f', '2024-11-26 13:52:15'),
('Artoria', '673d5b1341b60', '2024-11-26 13:52:15'),
('Artoria', '67432f493655f', '2024-11-26 13:52:15'),
('Artoria', '673d5b1341b60', '2024-11-26 13:52:15'),
('Artoria', '67432f493655f', '2024-11-26 13:52:15'),
('Artoria', '67432f872123b', '2024-11-26 13:52:15'),
('Artoria', '67439cab9f2b1', '2024-11-26 13:52:15'),
('Artoria', '67439c307a4b1', '2024-11-26 13:52:15'),
('Artoria', '67432f872123b', '2024-11-26 13:52:15'),
('Artoria', '67439cab9f2b1', '2024-11-26 13:52:15'),
('Artoria', '67439cab9f2b1', '2024-11-26 13:52:15'),
('Artoria', '674331c3ae39c', '2024-11-26 13:52:15'),
('Artoria', '67439cab9f2b1', '2024-11-26 13:52:15'),
('Artoria', '67439cab9f2b1', '2024-11-26 13:59:07'),
('gil45', '674331c3ae39c', '2024-11-26 20:50:27'),
('gil45', '674331c3ae39c', '2024-11-26 20:55:09'),
('gil45', '674331c3ae39c', '2024-11-26 20:55:27'),
('gil45', '674331c3ae39c', '2024-11-29 13:19:26'),
('Artoria', '674331c3ae39c', '2024-11-29 17:14:58'),
('Artoria', '674331c3ae39c', '2024-11-29 17:15:50'),
('Artoria', '674331c3ae39c', '2024-11-29 17:28:27'),
('Artoria', '673d5b1341b60', '2024-11-29 17:30:46'),
('Artoria', '674331c3ae39c', '2024-11-29 17:31:44'),
('Artoria', '673d5b1341b60', '2024-11-29 17:39:22'),
('Artoria', '67439c307a4b1', '2024-11-29 17:39:53'),
('Artoria', '67432f493655f', '2024-11-29 17:40:02'),
('Artoria', '67439c307a4b1', '2024-11-29 17:41:46'),
('Artoria', '67432f493655f', '2024-11-29 17:41:51'),
('Artoria', '67439cab9f2b1', '2024-11-29 17:42:02'),
('Artoria', '674331c3ae39c', '2024-11-29 17:42:09'),
('Artoria', '67432f493655f', '2024-11-29 17:47:03'),
('Artoria', '674331c3ae39c', '2024-11-29 17:51:11'),
('Artoria', '674331c3ae39c', '2024-11-29 19:14:58'),
('Artoria', '674331c3ae39c', '2024-11-29 19:20:53'),
('Artoria', '674331c3ae39c', '2024-11-29 19:21:02'),
('Artoria', '674331c3ae39c', '2024-11-29 19:21:09'),
('Artoria', '674331c3ae39c', '2024-11-29 19:21:20'),
('Artoria', '674331c3ae39c', '2024-11-29 19:21:31'),
('Artoria', '674331c3ae39c', '2024-11-29 19:25:17'),
('Artoria', '674331c3ae39c', '2024-11-29 19:25:27'),
('Artoria', '674331c3ae39c', '2024-11-29 19:29:38'),
('Artoria', '674331c3ae39c', '2024-11-29 19:29:52'),
('Artoria', '674331c3ae39c', '2024-11-29 19:30:05'),
('Artoria', '674331c3ae39c', '2024-11-29 19:36:25'),
('Artoria', '674331c3ae39c', '2024-11-29 19:36:37'),
('Artoria', '674331c3ae39c', '2024-11-29 19:36:48'),
('Artoria', '674331c3ae39c', '2024-11-29 20:04:40'),
('Artoria', '674331c3ae39c', '2024-11-29 20:04:48'),
('Artoria', '674331c3ae39c', '2024-11-29 20:06:02'),
('Artoria', '674331c3ae39c', '2024-11-29 20:06:10'),
('Artoria', '674331c3ae39c', '2024-12-02 11:02:03'),
('Artoria', '674331c3ae39c', '2024-12-02 11:02:12'),
('Artoria', '67439c307a4b1', '2024-12-02 11:04:26'),
('Artoria', '67432f872123b', '2024-12-02 11:07:50'),
('Artoria', '67432f872123b', '2024-12-02 11:07:54'),
('Artoria', '67439c307a4b1', '2024-12-02 11:07:59'),
('Artoria', '67432f493655f', '2024-12-02 11:08:08'),
('Artoria', '67432f493655f', '2024-12-02 11:08:33'),
('Artoria', '67432f493655f', '2024-12-02 11:08:45'),
('Artoria', '67439c307a4b1', '2024-12-04 00:20:01'),
('Artoria', '674331c3ae39c', '2024-12-04 02:38:38'),
('Artoria', '674331c3ae39c', '2024-12-04 02:39:11'),
('Artoria', '674331c3ae39c', '2024-12-04 02:41:02'),
('Artoria', '674331c3ae39c', '2024-12-04 08:42:34'),
('Artoria', '67439c307a4b1', '2024-12-04 08:46:39'),
('Artoria', '674331c3ae39c', '2024-12-04 11:09:09'),
('Artoria', '674331c3ae39c', '2024-12-04 11:52:26'),
('Artoria', '673d5b1341b60', '2024-12-04 13:24:16'),
('Artoria', '673d5b1341b60', '2024-12-04 13:24:26'),
('Artoria', '674331c3ae39c', '2024-12-04 22:57:41'),
('Artoria', '674331c3ae39c', '2024-12-05 06:58:00'),
('metallica@gmail.com', '67439c307a4b1', '2024-12-05 07:04:22'),
('Artoria', '675106fcbab7b', '2024-12-05 08:43:17'),
('Artoria', '675106fcbab7b', '2024-12-05 08:43:26'),
('Artoria', '6751071b6e84d', '2024-12-05 08:47:29'),
('aimer@gmail.com', '67510b12dcea9', '2024-12-05 09:01:06'),
('aimer@gmail.com', '6751166116d9a', '2024-12-05 09:01:27'),
('aimer@gmail.com', '6751173585dfc', '2024-12-05 09:01:52'),
('aimer@gmail.com', '6751166116d9a', '2024-12-05 09:01:57'),
('aimer@gmail.com', '6751173585dfc', '2024-12-05 09:02:09'),
('aimer@gmail.com', '6751173585dfc', '2024-12-05 09:02:11'),
('aimer@gmail.com', '6751173585dfc', '2024-12-05 09:02:15'),
('aimer@gmail.com', '6751166116d9a', '2024-12-05 09:02:49'),
('aimer@gmail.com', '6751071b6e84d', '2024-12-05 09:03:52'),
('aimer@gmail.com', '6751071b6e84d', '2024-12-05 09:04:36'),
('aimer@gmail.com', '6751071b6e84d', '2024-12-05 09:05:00'),
('aimer@gmail.com', '675108d86ea02', '2024-12-05 09:06:18'),
('aimer@gmail.com', '675108d86ea02', '2024-12-05 09:06:30'),
('aimer@gmail.com', '675108d86ea02', '2024-12-05 09:06:46');

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

CREATE TABLE `tracks` (
  `track_id` varchar(64) NOT NULL,
  `track_name` varchar(60) DEFAULT NULL,
  `tag` varchar(20) DEFAULT NULL,
  `track_url` varchar(100) DEFAULT NULL,
  `album_id` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tracks`
--

INSERT INTO `tracks` (`track_id`, `track_name`, `tag`, `track_url`, `album_id`) VALUES
('673d5b1341b60', 'New Riff', 'Rock', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1732074261/hkhkxh6uficlvhczkt5v.mp3', '6738a77934eea'),
('67432f493655f', 'Starry Death', 'Rock', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1732456268/lmcocnh27uduvi4xs3s5.wav', '67432ebdb9b22'),
('67432f872123b', 'Crunch', 'Rock', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1732456331/lsoza3lveazqbfu5t6nf.wav', '67432ebdb9b22'),
('674331c3ae39c', 'Afterthought', 'Rock', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1732456905/dcv03tuuphizq3o3t0s7.mp3', '674331664048c'),
('67439c307a4b1', 'Creepin', 'R&B', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1732484150/ti1g7u9o2hh8zgujdncc.mp3', '67439ba2b378e'),
('67439cab9f2b1', 'Wicked Games', 'R&B', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1732484272/sqioc7gs6c44ycbbrhgx.mp3', '67439c7bbeb64'),
('6751003cd93d0', 'Enter Sandman', 'Rock', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733361726/wioegpyzgzbnnlaeqdxt.mp3', '675100191c07a'),
('6751005fc1f30', 'Nothing Else Matters', 'Rock', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733361761/mpnwj7hs175fssypsisd.mp3', '675100191c07a'),
('67510551cd7b0', 'Comfortably Numb', 'Rock', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733363027/s3q0vxhibcskkqx53txw.mp3', '67510530b7a68'),
('675106fcbab7b', 'Shopnodev', 'Rock', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733363454/rlhw8qyqncd3oh3fd54s.mp3', '675106de21033'),
('6751071b6e84d', 'Chena Jogot', 'Rock', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733363484/lm0j3fdaobh9vf1xmcse.mp3', '675106de21033'),
('675108d86ea02', 'Ekanto Golaap', 'Rock', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733363929/gnhqur4tkum2wgtr7hqw.mp3', '675108b84eed0'),
('67510b12dcea9', 'Epitaph', 'Reggae', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733364500/khe8a9aem9gr8qe3btbi.mp3', '67510af5c6507'),
('67510bcf51b60', 'Husn', 'Pop', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733364688/nyrgbdb9fevwy4tavrdl.mp3', '67510ba1bafec'),
('6751166116d9a', 'I beg you', 'Pop', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733367392/t4artzeimqscqixjp9au.flac', '675115bd1cf75'),
('675116a70f177', 'Hanabiratachi No March', 'Pop', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733367463/ilvsa11udfzlmtevlfnq.flac', '675115bd1cf75'),
('675116c9927ad', 'Sailing', 'Pop', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733367497/okpcpj1gpngpqlpk2wps.flac', '675115bd1cf75'),
('6751173585dfc', 'Mine', 'Pop', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733367605/zbsnunokpwqaixngh844.flac', '6751170d48cda'),
('67511754e5be9', 'Polaris', 'Pop', 'https://res.cloudinary.com/doonwj6hd/video/upload/v1733367636/cumjssitrxjwkdnusqng.flac', '6751170d48cda');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `email` varchar(60) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `profile_pic` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`email`, `name`, `password`, `profile_pic`) VALUES
('aimer@gmail.com', 'Aimer', '$2y$10$6uPwt0Zkwbt/3gOKtLHtiOmDVMO2W86NxkEHi0MC8WXUChjjIVpQ2', 'default'),
('anuv@gmail.com', 'Anuv Jain', '$2y$10$TUZ0shItG/oyU.67mmTshO66NvdT5cQqrNYgRC8BiOGU2HKtCbnpS', '67510b64660b2'),
('Artoria', 'saber', '$2y$10$jqmGQv6yR1N6GbtIXf8UNeVHC5y/5FLhm.Y2o5h6dJNDotEwSReq.', '67506744a83ae'),
('dum@gmail.com', 'sds', '$2y$10$saZ3wpXTe5xcJ9TfdsCU1uYtzjdrffI5lsH/Om24d1nZ/ZElTKNjW', NULL),
('dummy2@example.com', 'dummy', '$2y$10$g3dskRp5Q5OsikDnlBhYuO2D3HaQ8fqtIfDRSe.ykycnMYv1Ytxhy', NULL),
('dummy@example.com', 'dummy', '$2y$10$UumjSHu5UVNUgTJR9dnTvOApM4z3XayRB67KDnPPnvDctrZ1f1J1K', NULL),
('emiya', 'emiya', '$2y$10$ivOAEoHkXASdHiV0mSjPTuAj6i0PADL.dsq4/lj3f45bJ8XK260x2', 'default'),
('fgh@gmail.com', 'qwe', '$2y$10$.pCBDE3nmf6vaqk4BAFdnOq8jFqKITRxOPXCq8nVd1g2ruz1hbgge', NULL),
('floyd@gmail.com', 'Pink Floyd', '$2y$10$0lLvp9RvTW5MHfC5f0nmO.fqDbJraSqR9atxK9SluLgZszYGx78Tu', '675104b7f3640'),
('gil2', 'gil2', '$2y$10$FkAHedlBMyNT/aztrwF.IuYzpjWjdFAF8UCSR5kyAE.UfCF098iPy', NULL),
('gil3', 'gil3', '$2y$10$ZRzrqvOtl3iQJfY5jxnlfusqiCH4GTJ2foLiwdVUJ1omCHFcxWwxW', NULL),
('gil45', 'gilgamesh', '$2y$10$RAvw2KD2fQggqNS3Im.7p.mkH2ZM2O7o7pcaLc4rCSACrUdnDPYke', '675065eaadd8d'),
('gil@example.com', 'gil', '$2y$10$2ouz5GCe64xVmjgKZZKe4ubAKtS0itW68CGzXhzzE10mURnIG28Zi', NULL),
('indalo@gmail.com', 'Indalo', '$2y$10$mjIULvikmY9E8bP3Aenc2eLbLc1H9LCYL/H8ywhVQoD6BOQMN8lZq', 'default'),
('metallica@gmail.com', 'Metallica', '$2y$10$OcucTRImSaxNn7D3NWKzKOvJaL9kaxsE7/eAZyatMKgYcBgN0e1Qe', '675102c07919e'),
('mon@gmail.com', 'sadik', '$2y$10$IK0dye9A6LsEgTLXDVyZk.oClvYnpD3VggGRXq5xK43x4eBFz3B4W', 'default'),
('radio.head@gmail.com', 'Radiohead', '$2y$10$Ajc.aqUeUQMJFds9QmyDn.MGhpREDO8y4eQCXQz4agmxQ00xfKrJO', 'default'),
('rin@example.com', 'rin', '$2y$10$pqkOVdju893l9lFahlqRb.c/HLw34RXVOUmlf5Hi1SgIS.hwbDvmG', NULL),
('sabre@example.com', 'sabre', '$2y$10$9UERlvXk/0mTm6PrWc5inurL2ZUkBve5HE0MUwOmSAfefWmEYKQzG', NULL),
('sahib@gmail.com', 'sahib', '$2y$10$ZHaudkUPP2SL/vd742DrnuGAoxo20MjJKPOyQ4fw9SZJJ6t5hu4o6', NULL),
('sam@example.com', 'dummy', '$2y$10$4KASazqDdvQhOBfqqc3QYeiw8MgfhYoZaqJdy4YLlCi0un1SUxRPK', NULL),
('samiha345@gmail.com', 'samiha', '$2y$10$vUx4X8KExsG1cCOxL7bgD.fuBk.ePJehoKYIgOYE.twohfVLeRlVy', NULL),
('samiha@gmail.com', 'samiha', '$2y$10$9XZtr0D4MLl4q.IjmJRE4u6r.iE9CsgS70BzAvetI3G9N0B8hvd.2', NULL),
('sample@example.com', 'sample', '$2y$10$E62eAdm.0qzpQtbStYTqFuv/7HjQi67KFi2OYFFxVDo3hfS3alYsS', 'default'),
('sbc@gmail.com', 'Shonar Bangla Circus', '$2y$10$qhlchwPv2/.AHhTbQFn8K.mbZ9kSqkhUuSeLPSqHQ9DMJ204bHX.a', 'default'),
('test345@example.com', 'user345', '$2y$10$LrgGByWlW7Cq/JElICKhpe9cFJkHF4A6/08uI3Qu61I6SCx78g0lO', NULL),
('test34@example.com', 'Test User34', '$2y$10$2qjpEgjxU5sT.Of5ayOPTudd40CG2LG9vGoZ/Jm5KQaQ7WsdYE6EW', NULL),
('vibe@gmail.com', 'Vibe', '$2y$10$xYoygPiyrCpJK3JDU8bscezMWMJW45FeAvov.sdykdGe71CCNIhiG', '6751075c46782'),
('wk@gmail.com', 'Abel', '$2y$10$0gnxp/.YDvQoLxKO1MIf1OvXuRENMUdX/KCsLypSaSZOY6a8UwCtK', 'default');

-- --------------------------------------------------------

--
-- Table structure for table `user_feed`
--

CREATE TABLE `user_feed` (
  `email` varchar(60) NOT NULL,
  `artist_name` varchar(60) DEFAULT NULL,
  `album_id` varchar(64) DEFAULT NULL,
  `track_id` varchar(64) NOT NULL,
  `followers` int(11) DEFAULT 0,
  `likes` int(11) DEFAULT 0,
  `streams` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_feed`
--

INSERT INTO `user_feed` (`email`, `artist_name`, `album_id`, `track_id`, `followers`, `likes`, `streams`, `created_at`) VALUES
('aimer@gmail.com', 'Aimer', '675115bd1cf75', '6751166116d9a', 1, 0, 3, '2024-12-05 03:03:10'),
('aimer@gmail.com', 'Aimer', '675115bd1cf75', '675116a70f177', 1, 0, 0, '2024-12-05 03:03:10'),
('aimer@gmail.com', 'Aimer', '675115bd1cf75', '675116c9927ad', 1, 0, 0, '2024-12-05 03:03:10'),
('aimer@gmail.com', 'Aimer', '6751170d48cda', '6751173585dfc', 1, 0, 4, '2024-12-05 03:03:10'),
('aimer@gmail.com', 'Aimer', '6751170d48cda', '67511754e5be9', 1, 0, 0, '2024-12-05 03:03:10'),
('Artoria', 'Upodeshta', '6738a77934eea', '673d5b1341b60', 2, 0, 5, '2024-12-05 03:03:10'),
('Artoria', 'Memories Of Nowhere', '67432ebdb9b22', '67432f493655f', 1, 1, 7, '2024-12-05 03:03:10'),
('Artoria', 'Memories Of Nowhere', '67432ebdb9b22', '67432f872123b', 1, 0, 3, '2024-12-05 03:03:10'),
('Artoria', 'Radiohead', '674331664048c', '674331c3ae39c', 2, 5, 39, '2024-12-05 03:03:10'),
('Artoria', 'The Weeknd', '67439ba2b378e', '67439c307a4b1', 2, 2, 8, '2024-12-05 03:03:10'),
('Artoria', 'The Weeknd', '67439c7bbeb64', '67439cab9f2b1', 2, 0, 3, '2024-12-05 03:03:10'),
('emiya', 'Upodeshta', '6738a77934eea', '673d5b1341b60', 2, 0, 5, '2024-12-05 03:03:10'),
('gil45', 'Radiohead', '674331664048c', '674331c3ae39c', 2, 5, 39, '2024-12-05 03:03:10'),
('metallica@gmail.com', 'The Weeknd', '67439ba2b378e', '67439c307a4b1', 2, 2, 8, '2024-12-05 03:03:10'),
('metallica@gmail.com', 'The Weeknd', '67439c7bbeb64', '67439cab9f2b1', 2, 0, 3, '2024-12-05 03:03:10');

-- --------------------------------------------------------

--
-- Structure for view `feed`
--
DROP TABLE IF EXISTS `feed`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `feed`  AS SELECT `r`.`artist_name` AS `artist_name`, `r`.`album_id` AS `album_id`, `t`.`track_id` AS `track_id`, coalesce(count(distinct `f`.`email`),0) AS `followers`, coalesce(count(distinct `l`.`email`),0) AS `likes`, coalesce(count(distinct concat(`s`.`email`,'-',`s`.`track_id`,'-',`s`.`streamed_at`)),0) AS `streams`, `r`.`release_date` AS `release_date` FROM ((((`released` `r` join `tracks` `t` on(`r`.`album_id` = `t`.`album_id`)) left join `follows` `f` on(`r`.`artist_name` = `f`.`artist_name`)) left join `likes` `l` on(`t`.`track_id` = `l`.`track_id`)) left join `streams` `s` on(`t`.`track_id` = `s`.`track_id`)) GROUP BY `r`.`artist_name`, `r`.`album_id`, `t`.`track_id` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`album_id`),
  ADD KEY `cover_art` (`cover_art`),
  ADD KEY `artist_name` (`artist_name`);

--
-- Indexes for table `artist`
--
ALTER TABLE `artist`
  ADD PRIMARY KEY (`artist_name`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `email_3` (`email`),
  ADD KEY `email` (`email`),
  ADD KEY `profile_pic` (`profile_pic`);

--
-- Indexes for table `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`artist_name`,`email`),
  ADD KEY `artist_name` (`artist_name`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`tag`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`email`,`track_id`),
  ADD KEY `track_id` (`track_id`);

--
-- Indexes for table `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`playlist_id`),
  ADD KEY `email` (`email`),
  ADD KEY `cover_pic` (`cover_pic`);

--
-- Indexes for table `queue`
--
ALTER TABLE `queue`
  ADD KEY `playlist_id` (`playlist_id`),
  ADD KEY `track_id` (`track_id`);

--
-- Indexes for table `released`
--
ALTER TABLE `released`
  ADD UNIQUE KEY `album_id` (`album_id`),
  ADD KEY `artist_name` (`artist_name`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `email_fk` (`email`);

--
-- Indexes for table `streams`
--
ALTER TABLE `streams`
  ADD KEY `email` (`email`),
  ADD KEY `track_id` (`track_id`);

--
-- Indexes for table `tracks`
--
ALTER TABLE `tracks`
  ADD PRIMARY KEY (`track_id`),
  ADD KEY `tag` (`tag`),
  ADD KEY `album_id` (`album_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`email`),
  ADD KEY `profile_pic` (`profile_pic`);

--
-- Indexes for table `user_feed`
--
ALTER TABLE `user_feed`
  ADD PRIMARY KEY (`email`,`track_id`),
  ADD KEY `artist_name_fk` (`artist_name`),
  ADD KEY `album_id_fk` (`album_id`),
  ADD KEY `track_id_fk` (`track_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `album`
--
ALTER TABLE `album`
  ADD CONSTRAINT `album_ibfk_1` FOREIGN KEY (`cover_art`) REFERENCES `images` (`image_id`),
  ADD CONSTRAINT `album_ibfk_2` FOREIGN KEY (`artist_name`) REFERENCES `artist` (`artist_name`);

--
-- Constraints for table `artist`
--
ALTER TABLE `artist`
  ADD CONSTRAINT `email` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
  ADD CONSTRAINT `profile_pic` FOREIGN KEY (`profile_pic`) REFERENCES `images` (`image_id`);

--
-- Constraints for table `follows`
--
ALTER TABLE `follows`
  ADD CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`artist_name`) REFERENCES `artist` (`artist_name`),
  ADD CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`email`) REFERENCES `users` (`email`);

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE NO ACTION,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`track_id`) ON DELETE NO ACTION;

--
-- Constraints for table `playlists`
--
ALTER TABLE `playlists`
  ADD CONSTRAINT `cover_pic` FOREIGN KEY (`cover_pic`) REFERENCES `images` (`image_id`),
  ADD CONSTRAINT `playlists_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`);

--
-- Constraints for table `queue`
--
ALTER TABLE `queue`
  ADD CONSTRAINT `queue_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`playlist_id`) ON DELETE NO ACTION,
  ADD CONSTRAINT `queue_ibfk_2` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`track_id`) ON DELETE NO ACTION;

--
-- Constraints for table `released`
--
ALTER TABLE `released`
  ADD CONSTRAINT `released_ibfk_1` FOREIGN KEY (`artist_name`) REFERENCES `artist` (`artist_name`) ON DELETE NO ACTION,
  ADD CONSTRAINT `released_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`) ON DELETE NO ACTION;

--
-- Constraints for table `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `email_fk` FOREIGN KEY (`email`) REFERENCES `users` (`email`);

--
-- Constraints for table `streams`
--
ALTER TABLE `streams`
  ADD CONSTRAINT `streams_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
  ADD CONSTRAINT `streams_ibfk_2` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`track_id`);

--
-- Constraints for table `tracks`
--
ALTER TABLE `tracks`
  ADD CONSTRAINT `tracks_ibfk_1` FOREIGN KEY (`tag`) REFERENCES `genre` (`tag`),
  ADD CONSTRAINT `tracks_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`profile_pic`) REFERENCES `images` (`image_id`);

--
-- Constraints for table `user_feed`
--
ALTER TABLE `user_feed`
  ADD CONSTRAINT `album_id_fk` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `artist_name_fk` FOREIGN KEY (`artist_name`) REFERENCES `artist` (`artist_name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_feed_email` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `track_id_fk` FOREIGN KEY (`track_id`) REFERENCES `tracks` (`track_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `delete_expired_rows` ON SCHEDULE EVERY 1 MINUTE STARTS '2024-11-11 22:47:41' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM session
  WHERE NOW() > expires_at$$

CREATE DEFINER=`root`@`localhost` EVENT `populate_user_feed` ON SCHEDULE EVERY 10 MINUTE STARTS '2024-11-24 08:53:10' ON COMPLETION NOT PRESERVE ENABLE DO INSERT INTO user_feed (email, artist_name, album_id, track_id, followers, likes, streams)
SELECT 
    ordered_data.email,
    ordered_data.artist_name,
    ordered_data.album_id,
    ordered_data.track_id,
    ordered_data.followers,
    ordered_data.likes,
    ordered_data.streams
FROM (
    SELECT 
        fo.email,
        f.artist_name,
        f.album_id,
        f.track_id,
        COALESCE(f.followers, 0) AS followers,
        COALESCE(f.likes, 0) AS likes,
        COALESCE(f.streams, 0) AS streams,
        f.release_date
    FROM 
        feed f
    JOIN 
        follows fo ON f.artist_name = fo.artist_name
    WHERE 
        fo.email IS NOT NULL
    ORDER BY 
        f.release_date DESC
) AS ordered_data
ON DUPLICATE KEY UPDATE
    followers = VALUES(followers),
    likes = VALUES(likes),
    streams = VALUES(streams),
    created_at = CURRENT_TIMESTAMP$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
