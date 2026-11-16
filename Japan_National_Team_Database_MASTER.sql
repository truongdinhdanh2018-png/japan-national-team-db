USE ll_wmarklynn;
-- File name: Japan_National_Team Database_MASTER.sql
-- Authors: William, Andres, Danh
-- Desc: SQL code for the implementation of the Japan National Football Team

-- Part 1. In included Milestone2_Normalization-2.pdf file

-- Part 2. Write SQL statements to create tables for your database application. Pick suitable data types for each attribute. For each table, specify primary key and indicate foreign key and constraints (NOT NULL, UNIQUE etc.) if any.

-- Construction of tables
CREATE TABLE IF NOT EXISTS USER (
    user_id VARCHAR(2) PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(70) NOT NULL,
    phone VARCHAR(11) NOT NULL,
    birthday DATE NOT NULL,
    hometown VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS PLAYER (
    player_id VARCHAR(2) PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    date_of_birth DATE NOT NULL,
    birthplace VARCHAR(50) NOT NULL,
    height DECIMAL(3,2) NOT NULL,
    position VARCHAR(4) NOT NULL,
    club VARCHAR(50),
    market_value VARCHAR(30) NOT NULL,
    appearances INT,
    goals INT,
    injured CHAR(1) NOT NULL
);

CREATE TABLE IF NOT EXISTS USER_FAV_PLAYER (
    user_id VARCHAR(2),
    player_id VARCHAR(2),
    PRIMARY KEY (user_id, player_id),
    FOREIGN KEY (user_id) REFERENCES USER (user_id),
    FOREIGN KEY (player_id) REFERENCES PLAYER (player_id)
);

CREATE TABLE IF NOT EXISTS MATCH_tab(
    match_id        VARCHAR(2) PRIMARY KEY ,
    venue           VARCHAR(70) NOT NULL,
    location        VARCHAR(70) NOT NULL,
    date_of_match   DATE        NOT NULL,
    scoreline       VARCHAR(10) NOT NULL,
    home_away       CHAR(1)     NOT NULL,
    opponent        VARCHAR(70) NOT NULL,
    result          CHAR(1)     NOT NULL,
    referee         VARCHAR(70) NOT NULL,
    match_type      VARCHAR(70) NOT NULL
);

CREATE TABLE IF NOT EXISTS MATCH_STATS(
    stat_id           VARCHAR(3),
    match_id          VARCHAR(2) NOT NULL,
    yellow_cards      INT NOT NULL,
    red_cards         INT NOT NULL,
    shots_on_target INT NOT NULL,
    corners           INT NOT NULL,
    offsides          INT NOT NULL,
    fouls             INT NOT NULL,
    penalties         INT NOT NULL,
    substitutions     INT NOT NULL,
    free_kicks        INT NOT NULL,
    goals             INT NOT NULL,
    PRIMARY KEY (stat_id),
    FOREIGN KEY (match_id) REFERENCES MATCH_tab(match_id)
);

CREATE TABLE IF NOT EXISTS PERFORMANCE_METRICS(
    player_id           VARCHAR(2)   NOT NULL,
    match_id            VARCHAR(2)   NOT NULL,
    distance_covered_km DECIMAL(5,2) NOT NULL,
    rating              DECIMAL(2,1) NOT NULL,
    finishing           DECIMAL(2,1) NOT NULL,
    attacking           DECIMAL(2,1) NOT NULL,
    duels               DECIMAL(2,1) NOT NULL,
    creativity          DECIMAL(2,1) NOT NULL,
    control             DECIMAL(2,1) NOT NULL,
    defending           DECIMAL(2,1) NOT NULL,
    PRIMARY KEY (player_id, match_id),
    FOREIGN KEY (player_id) REFERENCES PLAYER(player_id),
    FOREIGN KEY (match_id)  REFERENCES MATCH_tab(match_id));
    
CREATE TABLE IF NOT EXISTS Staff (
  staff_id varchar(2),
  fname varchar(50) not null,
  lname varchar(50) not null,
  role varchar(20) not null,
  age int not null,
  nationality varchar(50) not null,
  PRIMARY KEY (staff_id)
);

create table IF NOT EXISTS Match_Staff (
  staff_id VARCHAR(2),
  match_id VARCHAR(2), 
  primary key(staff_id, match_id),
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
  FOREIGN KEY (match_id) REFERENCES MATCH_tab(match_id) 
);

CREATE TABLE IF NOT EXISTS Lineup (
  lineup_id varchar(3),
  code int AUTO_INCREMENT,
  match_id VARCHAR(2) not null,
  goalkeeper varchar(2) not null,
  defender varchar(2) not null,
  midfielder varchar(2) not null,
  forward varchar(2) not null,
  PRIMARY KEY (code, lineup_id),
  foreign key (match_id) references MATCH_tab(match_id), 
  FOREIGN KEY (goalkeeper) REFERENCES PLAYER(player_id),
  FOREIGN KEY (defender) REFERENCES PLAYER(player_id),
  FOREIGN KEY (midfielder) REFERENCES PLAYER(player_id),
  FOREIGN KEY (forward) REFERENCES PLAYER(player_id)
);

CREATE TABLE IF NOT EXISTS LINEUP_INFO (
	lineup_id VARCHAR(3) PRIMARY KEY,
    match_id VARCHAR(2) NOT NULL,
    FOREIGN KEY (match_id) REFERENCES MATCH_tab(match_id)
);

CREATE table IF NOT EXISTS Formation (
  formation_id varchar(2),
  back int not null,
  midfield int not null,
  forward int not null,
  PRIMARY KEY (formation_id)
);

CREATE TABLE LINEUP_FORMATION (
	lineup_id varchar(3),
    formation_id varchar(2),
    PRIMARY KEY (lineup_id, formation_id),
    FOREIGN KEY (lineup_id) REFERENCES LINEUP_INFO (lineup_id),
    FOREIGN KEY (formation_id) REFERENCES Formation (formation_id)
);

CREATE TABLE IF NOT EXISTS Comments (
  commentID varchar(2),
  user_id VARCHAR(2) not null,
  reply_id varchar(2),
  content varchar(200) not null,
  comment_date date not null,
  likes int not null,
  PRIMARY key (commentID), 
  foreign key (user_id) references USER(user_id), 
  foreign key (reply_id) references Comments(commentID)
);

-- Part 3: Write SQL statements to populate each table in your database with at least 10 meaningful 

-- Inserting of values

-- User Table
INSERT INTO USER VALUES ('95', 'nihondaihyou12', 'shotakun@example.jp', '81598728688', '1999-09-19', 'Kanagawa');
INSERT INTO USER VALUES ('51', 'ookiyume', 'kurodakp@example.jp', '81884426873', '2012-01-22', 'Tokyo');
INSERT INTO USER VALUES ('85', 'kumakumamon4', 'kuroyanagij@example.jp', '81587952383', '1997-06-09', 'Tokyo');
INSERT INTO USER VALUES ('12', 'samuraiburusuki', 'hayahayashi@example.jp', '81562927175', '2001-02-08', 'Osaka');
INSERT INTO USER VALUES ('84', 'fanfromseattle03', 'seattleu@example.com', '12068024532', '2002-11-03', 'Seattle, US');
INSERT INTO USER VALUES ('83', 'boyfromtokyo11', 'shunsukeh@example.jp', '81937691072', '2007-06-09', 'Kyoto');
INSERT INTO USER VALUES ('47', 'softbank1', 'nakaniarunakamura@example.jp', '81138745166', '1999-09-19', 'Miyagi');
INSERT INTO USER VALUES ('92', 'rakuten01', 'hatakeyamah@example.jp', '81255548408', '2007-06-02', 'Iwate');
INSERT INTO USER VALUES ('65', 'footballislife77', 'onodak@example.jp', '81766867906', '2005-05-29', 'Iwate');
INSERT INTO USER VALUES ('75', 'ferrantorres7', 'ferrantorres@example.es', '34710028594', '2000-02-29', 'Barcelona, Spain');
INSERT INTO USER VALUES ('91', 'samuraiblue72', 'takahashiy@example.jp', '81645004553', '2009-02-14', 'Fukuoka');
INSERT INTO USER VALUES ('13', 'tsuyoichimu45', 'tsuchiyat@example.jp', '81797370645', '2011-09-04', 'Fukuoka');
INSERT INTO USER VALUES ('53', 'ookigoe44', 'hasegawai@example.jp', '81965301354', '1998-01-29', 'Tokyo');
INSERT INTO USER VALUES ('62', 'ganbatte123', 'shigahiro@example.jp', '81588145459', '2014-02-28', 'Kanagawa');
INSERT INTO USER VALUES ('33', 'ikimasunihon', 'kobayashikuuun@example.jp', '81438775523', '2005-09-12', 'Chiba');

-- Player Table
INSERT INTO PLAYER VALUES ('01', 'Zion', 'Suzuki', 24, '2002-08-21', 'Newark, New Jersey, US', 1.90, 'GK', 'Aston Villa', '€30,000,000.00', 31, 0, 'N');
INSERT INTO PLAYER VALUES ('02', 'Leo', 'Kokubo', 25, '2001-01-23', 'Chiba, Chiba, Japan', 1.93, 'GK', 'Sint-Truiden', '€5,000,000.00', 1, 0, 'N');
INSERT INTO PLAYER VALUES ('03', 'Tomoki', 'Hayakawa', 27, '1999-03-03', 'Sagamihara, Kanagawa, Japan', 1.87, 'GK', 'Kashima Antlers', '€2,000,000.00', 5, 0, 'N');
INSERT INTO PLAYER VALUES ('04', 'Ayumu', 'Seko', 26, '2000-06-07', 'Taishō-ku, Osaka, Japan', 1.85, 'DF', 'Le Havre', '€5,000,000.00', 20, 0, 'N');
INSERT INTO PLAYER VALUES ('05', 'Kō', 'Itakura', 29, '1997-01-27', 'Aoba-ku, Yokohama, Kanagawa, Japan', 1.88, 'DF', 'Borussia Mönchengladbach', '€4,000,000.00', 44, 2, 'N');
INSERT INTO PLAYER VALUES ('06', 'Hiroki', 'Ito', 27, '1999-05-12', 'Hamamatsu, Shizuoka, Japan', 1.88, 'DF', 'Bayern Munich', '€18,000,000.00', 32, 1, 'N');
INSERT INTO PLAYER VALUES ('07', 'Hayato', 'Araki', 30, '1996-08-07', 'Kadoma, Osaka, Japan', 1.86, 'DF', 'Sanfrecce Hiroshima', '€1,500,000.00', 5, 0, 'N');
INSERT INTO PLAYER VALUES ('08', 'Junnosuke', 'Suzuki', 23, '2003-07-12', 'Kakamigahara, Gifu, Japan', 1.80, 'DF', 'Copenhagen', '€3,500,000.00', 12, 0, 'Y');
INSERT INTO PLAYER VALUES ('09', 'Shuto', 'Nakano', 26, '2000-06-27', 'Ōme, Tokyo, Japan', 1.82, 'MF', 'Sanfrecce Hiroshima', '€1,400,000.00', 2, 0, 'N');
INSERT INTO PLAYER VALUES ('10', 'Satoshi', 'Tanaka', 24, '2002-08-13', 'Nagano, Nagano, Japan', 1.75, 'MF', 'Schalke 04', '€4,000,000.00', 3, 0, 'Y');
INSERT INTO PLAYER VALUES ('11', 'Yūki', 'Sōma', 29, '1997-02-25', 'Chōfu, Tokyo, Japan', 1.66, 'MF', 'Machida Zelvia', '€2,000,000.00', 22, 5, 'N');
INSERT INTO PLAYER VALUES ('12', 'Ritsu', 'Dōan', 28, '1998-06-16', 'Amagasaki, Hyogo, Japan', 1.72, 'MF', 'Eintracht Frankfurt', '€17,000,000.00', 73, 12, 'N');
INSERT INTO PLAYER VALUES ('13', 'Junya', 'Itō', 33, '1993-03-09', 'Yokosuka, Kanagawa, Japan', 1.76, 'MF', 'Genk', '€3,000,000.00', 77, 16, 'N');
INSERT INTO PLAYER VALUES ('14', 'Daichi', 'Kamada', 30, '1996-08-05', 'Iyo, Ehime, Japan', 1.80, 'MF', 'Crystal Palace', '€10,000,000.00', 57, 14, 'N');
INSERT INTO PLAYER VALUES ('15', 'Ao', 'Tanaka', 28, '1998-09-10', 'Kawasaki, Kanagawa, Japan', 1.86, 'MF', 'Leeds United', '€15,000,000.00', 45, 8, 'N');
INSERT INTO PLAYER VALUES ('16', 'Takumi', 'Minamino', 31, '1995-01-16', 'Izumisano, Osaka, Japan', 1.72, 'MF', 'AS Monaco', '€10,000,000.00', 73, 26, 'N');
INSERT INTO PLAYER VALUES ('17', 'Kuryu', 'Matsuki', 23, '2003-04-30', 'Muroran, Hokkaido, Japan', 1.80, 'MF', 'Southampton', '€3,000,000.00', 2, 1, 'N');
INSERT INTO PLAYER VALUES ('18', 'Takefusa', 'Kubo', 25, '2001-06-04', 'Asao-ku, Kawasaki, Kanagawa, Japan', 1.73, 'MF', 'Real Sociedad', '€20,000,000.00', 54, 7, 'N');
INSERT INTO PLAYER VALUES ('19', 'Kaishū', 'Sano', 25, '2000-12-30', 'Tsuyama, Okayama, Japan', 1.76, 'MF', 'Mainz 05', '€40,000,000.00', 19, 1, 'N');
INSERT INTO PLAYER VALUES ('20', 'Kodai', 'Sano', 23, '2003-09-25', 'Tsuyama, Okayama, Japan', 1.80, 'MF', 'PSV Eindhoven', '€18,000,000.00', 4, 0, 'N');
INSERT INTO PLAYER VALUES ('21', 'Kaoru', 'Mitoma', 29, '1997-05-20', 'Hita, Ōita, Japan', 1.78, 'MF', 'Brighton & Hove Albion F.C.', '€22,000,000.00', 31, 9, 'N');
INSERT INTO PLAYER VALUES ('22', 'Yuito', 'Suzuki', 25, '2001-10-25', 'Hayama, Kanagawa, Japan', 1.75, 'FW', 'SC Freiburg', '€28,000,000.00', 9, 0, 'N');
INSERT INTO PLAYER VALUES ('23', 'Ayase', 'Ueda', 28, '1998-08-28', 'Mito, Ibaraki, Japan', 1.82, 'FW', 'LOSC Lille', '€20,000,000.00', 47, 22, 'N');
INSERT INTO PLAYER VALUES ('24', 'Keito', 'Nakamura', 26, '2000-07-28', 'Abiko, Chiba, Japan', 1.81, 'MF', 'Lyon', '€12,000,000.00', 33, 11, 'N');
INSERT INTO PLAYER VALUES ('25', 'Takehiro', 'Tomiyasu', 27, '1998-11-05', 'Fukuoka, Fukuoka, Japan', 1.87, 'DF', 'Crystal Palace', '€5,000,000.00', 46, 1, 'N');
INSERT INTO PLAYER VALUES ('26', 'Daizen', 'Maeda', 29, '1997-10-20', 'Taishi, Osaka, Japan', 1.73, 'FW', 'Ipswich Town', '€13,000,000.00', 33, 5, 'N');
INSERT INTO PLAYER VALUES ('27', 'Kōki', 'Ogawa', 29, '1997-08-08', 'Yokohama, Kanagawa, Japan', 1.86, 'FW', 'Machida Zelvia', '€2,000,000.00', 18, 11, 'N');
INSERT INTO PLAYER VALUES ('28', 'Shūto', 'Machino', 27, '1999-09-30', 'Iga, Mie, Japan', 1.85, 'FW', 'Borussia Mönchengladbach', '€3,000,000.00', 15, 5, 'N');
INSERT INTO PLAYER VALUES ('29', 'Shiō', 'Fukuda', 22, '2004-04-08', 'Kanoya, Kagoshima, Japan', 1.78, 'FW', 'Karlsruher SC', '€2,000,000.00', 0, 0, 'N');
INSERT INTO PLAYER VALUES ('30', 'Tatsuhiro', 'Sakamoto', 30, '1996-10-22', 'Tokyo, Tokyo, Japan', 1.70, 'MF', 'Coventry City', '€4,500,000.00', 2, 0, 'N');

-- User_Fav_Player Table
INSERT INTO USER_FAV_PLAYER VALUES ('95', '21');
INSERT INTO USER_FAV_PLAYER VALUES ('95', '18');
INSERT INTO USER_FAV_PLAYER VALUES ('95', '23');
INSERT INTO USER_FAV_PLAYER VALUES ('51', '01');
INSERT INTO USER_FAV_PLAYER VALUES ('51', '15');
INSERT INTO USER_FAV_PLAYER VALUES ('85', '18');
INSERT INTO USER_FAV_PLAYER VALUES ('85', '25');
INSERT INTO USER_FAV_PLAYER VALUES ('85', '05');
INSERT INTO USER_FAV_PLAYER VALUES ('12', '23');
INSERT INTO USER_FAV_PLAYER VALUES ('12', '27');
INSERT INTO USER_FAV_PLAYER VALUES ('84', '14');
INSERT INTO USER_FAV_PLAYER VALUES ('84', '15');
INSERT INTO USER_FAV_PLAYER VALUES ('83', '16');
INSERT INTO USER_FAV_PLAYER VALUES ('83', '12');
INSERT INTO USER_FAV_PLAYER VALUES ('47', '21');
INSERT INTO USER_FAV_PLAYER VALUES ('47', '12');
INSERT INTO USER_FAV_PLAYER VALUES ('47', '16');
INSERT INTO USER_FAV_PLAYER VALUES ('92', '01');
INSERT INTO USER_FAV_PLAYER VALUES ('92', '22');
INSERT INTO USER_FAV_PLAYER VALUES ('65', '06');
INSERT INTO USER_FAV_PLAYER VALUES ('65', '25');
INSERT INTO USER_FAV_PLAYER VALUES ('65', '13');
INSERT INTO USER_FAV_PLAYER VALUES ('75', '18');
INSERT INTO USER_FAV_PLAYER VALUES ('91', '21');
INSERT INTO USER_FAV_PLAYER VALUES ('91', '17');
INSERT INTO USER_FAV_PLAYER VALUES ('91', '24');
INSERT INTO USER_FAV_PLAYER VALUES ('13', '12');
INSERT INTO USER_FAV_PLAYER VALUES ('13', '14');
INSERT INTO USER_FAV_PLAYER VALUES ('53', '26');
INSERT INTO USER_FAV_PLAYER VALUES ('53', '28');
INSERT INTO USER_FAV_PLAYER VALUES ('62', '18');
INSERT INTO USER_FAV_PLAYER VALUES ('62', '21');
INSERT INTO USER_FAV_PLAYER VALUES ('33', '05');
INSERT INTO USER_FAV_PLAYER VALUES ('33', '19');
INSERT INTO USER_FAV_PLAYER VALUES ('33', '20');

-- Match table
INSERT INTO MATCH_tab VALUES
('38', 'Japan National Stadium', 'Tokyo, Tokyo, Japan', '2026-10-05', '2-1', 'H', 'New Zealand', 'W', 'Muhammad Nazmi Bin Nasaruddin', 'International Friendlies'),
('29', 'Nissan Stadium', 'Yokohama, Kanagawa, Japan', '2026-10-01', '0-0(5-4)', 'H', 'Ecuador', 'W', 'Wiwat Jumpaoon', 'International Friendlies'),
('97', 'Edion Peace Wing Hiroshima', 'Hiroshima, Hiroshima, Japan', '2026-09-28', '2-1', 'H', 'Venezuela', 'W', 'Timothy Danaskos', 'International Friendlies'),
('89', 'Miyagi Stadium', 'Rifu, Miyagi, Japan', '2026-09-24', '3-1', 'H', 'Uruguay', 'W', 'Alex King', 'International Friendlies'),
('59', 'NRG Stadium', 'Houston, Texas, US', '2026-06-29', '2-1', 'W', 'Brazil', 'L', 'Maurizio Mariani', 'FIFA World Cup'),
('84', 'AT&T Stadium', 'Arlington, Texas, US', '2026-06-25', '1-1', 'H', 'Sweden', 'D', 'Ivan Barton', 'FIFA World Cup'),
('94', 'Estadio BBVA', 'Guadalupe, Nuevo León, Mexico', '2026-06-20', '0-4', 'W', 'Tunisia', 'W', 'Istvan Kovacs', 'FIFA World Cup'),
('73', 'Panasonic Stadium Suita', 'Suita, Osaka, Japan', '2026-06-01', '2-0', 'H', 'Ghana', 'W', 'Ma Ning', 'International Friendlies'),
('16', 'Wembley Stadium', 'London, England, UK', '2026-03-31', '1-1', 'W', 'England', 'D', 'Daniel Siebert', 'International Friendlies'),
('41', 'Hampden Park', 'Glasgow, Scotland, UK', '2026-03-28', '1-2', 'W', 'Scotland', 'W', 'Glenn Nyberg', 'International Friendlies');

-- Match Stats Table
INSERT INTO MATCH_STATS VALUES
('S1', '94', 1, 0, 9, 7, 2, 9, 1, 5, 12, 4),
('S2', '84', 2, 0, 4, 5, 3, 12, 0, 4, 13, 1),
('S3', '59', 3, 0, 3, 3, 1, 14, 0, 4, 10, 1),
('S4', '89', 1, 0, 7, 6, 2, 10, 1, 4, 14, 3),
('S5', '97', 2, 0, 5, 8, 3, 11, 1, 4, 12, 2),
('S6', '29', 2, 0, 4, 6, 1, 13, 0, 4, 11, 0),
('S7', '38', 0, 0, 6, 9, 4, 8, 0, 3, 9, 2),
('S8', '41', 2, 0, 6, 5, 2, 11, 0, 6, 12, 2),
('S9', '16', 1, 0, 3, 4, 3, 10, 0, 5, 13, 1),
('S10', '73', 0, 0, 7, 8, 1, 7, 1, 6, 9, 2);

-- Performance Metrics table
INSERT INTO PERFORMANCE_METRICS VALUES
-- Match 41
('01', '41', 5.14, 7.0, 2.1, 2.0, 5.5, 3.6, 5.6, 7.5),
('25', '41', 9.73, 7.2, 2.4, 3.7, 6.6, 4.9, 6.6, 7.0),
('05', '41', 10.37, 7.4, 3.2, 4.2, 6.7, 3.8, 6.3, 7.0),
('06', '41', 8.94, 6.7, 2.3, 3.9, 7.1, 5.0, 6.3, 7.8),
('04', '41', 9.50, 7.1, 2.9, 3.7, 7.9, 5.2, 6.8, 7.9),
('15', '41', 10.12, 6.7, 4.5, 5.2, 7.2, 6.7, 7.7, 6.3),
('14', '41', 11.79, 7.3, 5.7, 7.0, 6.4, 7.6, 8.1, 4.1),
('18', '41', 9.49, 7.1, 6.8, 7.1, 5.2, 7.4, 8.0, 4.6),
('12', '41', 9.61, 6.7, 5.8, 6.8, 6.2, 7.1, 7.5, 4.1),
('23', '41', 9.80, 8.0, 7.7, 7.9, 5.9, 5.5, 6.0, 2.9),
('21', '41', 11.82, 8.0, 5.5, 7.8, 5.9, 6.1, 7.1, 6.0),
('16', '41', 2.08, 7.1, 5.7, 6.8, 5.9, 7.1, 6.8, 3.3),
('26', '41', 2.05, 6.7, 4.3, 6.6, 5.8, 5.8, 6.9, 5.5),
('28', '41', 3.41, 7.0, 6.7, 6.4, 6.7, 5.7, 5.7, 2.5),
('24', '41', 3.87, 7.0, 4.3, 7.1, 6.5, 6.0, 6.2, 4.9),
('19', '41', 1.91, 7.1, 4.1, 5.8, 6.2, 7.0, 7.0, 5.9),
('08', '41', 2.29, 6.8, 2.1, 3.3, 7.0, 4.7, 6.2, 7.0),
-- Match 16
('01', '16', 5.70, 6.8, 1.0, 1.7, 5.4, 2.9, 5.5, 7.8),
('13', '16', 10.79, 6.2, 4.8, 7.3, 7.0, 6.4, 6.9, 5.9),
('25', '16', 8.85, 6.1, 2.3, 4.6, 7.5, 5.1, 5.6, 7.8),
('05', '16', 9.47, 6.8, 2.7, 4.7, 6.6, 4.6, 6.6, 8.2),
('06', '16', 9.93, 6.7, 3.4, 4.6, 7.0, 4.8, 6.9, 8.1),
('24', '16', 10.38, 6.8, 5.5, 6.9, 6.5, 6.0, 6.7, 6.0),
('12', '16', 9.51, 6.7, 7.1, 7.9, 6.1, 7.4, 7.7, 4.3),
('15', '16', 10.45, 6.9, 4.2, 6.2, 6.1, 6.9, 7.2, 6.1),
('14', '16', 11.12, 6.5, 6.6, 8.0, 5.5, 6.9, 7.1, 4.4),
('21', '16', 9.83, 6.3, 5.6, 7.0, 6.2, 6.7, 6.4, 6.0),
('23', '16', 9.82, 6.5, 7.8, 7.8, 6.9, 5.4, 6.5, 2.9),
('18', '16', 2.18, 7.0, 7.4, 8.1, 5.8, 7.9, 6.8, 3.4),
('16', '16', 3.06, 6.0, 5.7, 7.0, 5.7, 7.3, 6.8, 4.4),
('26', '16', 4.55, 6.2, 4.1, 5.8, 6.5, 5.3, 6.6, 5.6),
('19', '16', 2.67, 6.5, 3.8, 5.0, 6.4, 5.8, 7.4, 5.8),
('04', '16', 2.19, 5.8, 2.9, 3.6, 7.1, 4.4, 6.4, 7.9),
-- Match 73
('02', '73', 5.42, 6.7, 1.5, 1.6, 4.8, 3.5, 6.3, 7.1),
('05', '73', 9.09, 6.8, 3.3, 4.0, 7.4, 4.9, 6.2, 8.0),
('07', '73', 10.23, 6.6, 3.6, 4.3, 6.7, 4.4, 6.5, 8.2),
('09', '73', 9.28, 7.0, 3.5, 4.4, 7.8, 4.4, 6.5, 7.2),
('13', '73', 11.18, 7.2, 5.2, 7.1, 5.9, 6.8, 7.3, 6.5),
('15', '73', 10.70, 7.2, 4.5, 6.4, 7.3, 6.6, 6.6, 6.4),
('20', '73', 10.73, 7.2, 4.8, 5.1, 7.2, 6.2, 7.6, 6.0),
('17', '73', 10.17, 7.2, 5.9, 6.9, 5.8, 7.9, 7.9, 4.5),
('11', '73', 11.76, 6.9, 5.6, 6.2, 5.9, 6.2, 6.3, 6.1),
('27', '73', 10.96, 7.8, 8.7, 7.8, 6.1, 5.4, 6.9, 3.8),
('22', '73', 9.84, 8.1, 7.9, 7.9, 5.9, 7.2, 7.5, 4.2),
('18', '73', 3.49, 6.2, 6.8, 7.1, 5.4, 7.7, 7.2, 3.9),
('21', '73', 3.73, 6.3, 4.8, 6.4, 6.6, 6.5, 6.0, 5.5),
('23', '73', 2.16, 6.6, 7.5, 7.5, 6.1, 5.0, 5.7, 3.1),
('10', '73', 4.39, 6.3, 4.9, 4.8, 6.1, 6.1, 7.2, 6.0),
('08', '73', 2.79, 6.8, 2.1, 4.0, 6.4, 4.2, 5.7, 6.9),
('24', '73', 3.28, 6.6, 4.5, 6.4, 6.0, 5.4, 5.9, 5.7),
-- Match 94
('01', '94', 4.99, 6.6, 1.7, 1.4, 5.6, 3.3, 5.4, 7.5),
('05', '94', 8.67, 6.9, 2.4, 3.4, 7.1, 5.0, 5.8, 7.2),
('25', '94', 9.73, 7.4, 3.1, 3.9, 7.9, 3.9, 6.8, 7.3),
('06', '94', 8.86, 6.6, 2.7, 4.4, 6.8, 4.6, 6.5, 7.4),
('12', '94', 10.72, 6.6, 5.8, 7.0, 6.1, 7.5, 7.1, 4.3),
('21', '94', 10.48, 7.6, 6.2, 7.6, 5.9, 6.3, 6.6, 6.3),
('15', '94', 11.20, 6.8, 5.5, 5.3, 6.7, 7.2, 6.7, 6.5),
('14', '94', 9.40, 7.1, 6.8, 7.5, 6.3, 7.3, 7.7, 4.3),
('18', '94', 10.81, 7.7, 7.7, 8.5, 5.8, 7.8, 6.8, 4.5),
('16', '94', 10.98, 7.8, 7.3, 7.3, 5.6, 7.8, 6.7, 4.1),
('23', '94', 9.74, 8.0, 8.2, 8.4, 5.9, 5.2, 6.2, 3.7),
('13', '94', 2.03, 6.6, 4.8, 7.0, 6.4, 6.4, 6.0, 5.4),
('26', '94', 2.80, 7.0, 5.3, 6.0, 5.5, 5.5, 5.9, 5.5),
('08', '94', 3.45, 6.4, 2.0, 3.6, 6.7, 4.3, 6.6, 7.6),
('28', '94', 3.24, 6.8, 7.3, 6.3, 6.7, 5.7, 6.6, 3.3),
('24', '94', 2.90, 6.6, 4.1, 6.7, 5.4, 5.3, 5.9, 5.0),
-- Match 84
('01', '84', 5.01, 6.5, 1.0, 1.5, 4.9, 3.3, 5.3, 8.4),
('05', '84', 9.71, 6.2, 2.7, 3.8, 7.0, 4.0, 6.8, 8.3),
('25', '84', 9.44, 6.5, 2.4, 3.4, 7.0, 4.2, 6.8, 7.1),
('06', '84', 8.64, 7.0, 3.0, 3.5, 7.3, 3.8, 6.3, 8.3),
('12', '84', 11.54, 7.5, 6.9, 7.7, 5.3, 8.0, 7.4, 4.6),
('21', '84', 10.16, 6.3, 5.4, 7.5, 6.8, 6.6, 7.0, 6.1),
('15', '84', 9.89, 6.6, 4.6, 5.1, 6.1, 6.5, 6.9, 6.8),
('14', '84', 11.79, 6.5, 7.0, 8.1, 6.4, 7.4, 7.0, 3.8),
('18', '84', 9.81, 6.3, 6.6, 8.0, 6.3, 7.6, 7.6, 4.6),
('16', '84', 9.52, 6.7, 7.0, 7.8, 6.2, 7.6, 6.9, 4.6),
('23', '84', 10.16, 6.8, 8.1, 7.1, 6.3, 6.2, 6.7, 2.7),
('13', '84', 2.16, 5.9, 5.3, 6.9, 5.5, 6.4, 7.0, 5.7),
('26', '84', 2.78, 6.3, 4.2, 5.8, 6.7, 6.1, 6.3, 6.1),
('11', '84', 3.01, 6.6, 5.2, 6.1, 5.7, 5.6, 5.9, 5.6),
('22', '84', 2.53, 6.2, 5.6, 7.7, 5.3, 7.2, 7.2, 4.5),
-- Match 59
('01', '59', 5.10, 6.6, 1.5, 2.0, 5.5, 2.8, 5.9, 7.1),
('05', '59', 8.61, 6.5, 2.5, 4.0, 7.5, 4.6, 6.1, 7.6),
('25', '59', 9.60, 6.5, 2.4, 4.1, 6.8, 4.2, 6.7, 7.6),
('06', '59', 9.61, 6.5, 3.6, 3.9, 7.4, 4.5, 6.3, 7.9),
('12', '59', 10.48, 6.3, 6.4, 8.0, 6.1, 8.1, 8.0, 3.9),
('21', '59', 10.75, 6.6, 5.5, 6.3, 5.8, 6.1, 6.0, 5.4),
('15', '59', 9.49, 6.4, 5.2, 6.4, 6.3, 7.1, 7.4, 6.0),
('14', '59', 11.60, 6.7, 6.0, 8.0, 5.7, 7.6, 8.1, 4.7),
('18', '59', 9.72, 6.5, 6.7, 7.4, 5.4, 7.3, 7.7, 3.5),
('16', '59', 10.74, 7.0, 6.5, 7.7, 6.0, 7.6, 6.8, 4.9),
('23', '59', 11.35, 6.7, 6.8, 6.9, 5.8, 6.0, 6.1, 2.7),
('13', '59', 2.98, 6.3, 5.1, 6.2, 5.5, 6.5, 6.4, 5.8),
('26', '59', 2.05, 5.6, 5.0, 6.4, 5.4, 6.5, 6.5, 5.9),
('28', '59', 2.03, 6.3, 6.5, 7.4, 6.0, 5.1, 6.2, 3.5),
('24', '59', 2.55, 5.6, 4.7, 6.1, 5.5, 5.4, 5.7, 5.1),
-- Match 89
('02', '89', 4.97, 6.8, 1.9, 1.7, 5.5, 3.0, 5.8, 6.8),
('07', '89', 9.05, 6.5, 3.3, 4.1, 6.8, 4.5, 6.9, 7.0),
('04', '89', 10.07, 6.9, 3.0, 4.5, 7.1, 4.5, 6.6, 8.3),
('08', '89', 9.22, 7.2, 3.3, 4.2, 7.1, 4.3, 5.7, 7.1),
('13', '89', 9.48, 7.2, 4.7, 6.3, 5.7, 6.7, 7.1, 6.0),
('24', '89', 10.03, 6.7, 4.7, 6.7, 5.8, 6.1, 6.3, 6.4),
('19', '89', 11.83, 7.0, 4.4, 6.5, 6.5, 6.6, 6.5, 6.3),
('10', '89', 10.53, 7.0, 4.4, 5.8, 6.1, 6.5, 6.6, 6.4),
('12', '89', 9.41, 7.3, 6.9, 7.5, 5.9, 7.6, 7.8, 4.4),
('17', '89', 11.16, 7.3, 6.2, 7.2, 6.5, 7.1, 7.7, 4.4),
('28', '89', 9.41, 8.1, 8.7, 7.9, 6.7, 6.0, 5.9, 3.2),
('23', '89', 3.21, 7.6, 8.1, 7.8, 6.2, 5.8, 6.4, 3.2),
('21', '89', 2.44, 6.2, 4.2, 6.3, 5.4, 6.4, 6.4, 5.7),
('26', '89', 3.55, 6.8, 4.7, 5.8, 6.4, 6.2, 6.3, 5.5),
('06', '89', 3.65, 6.3, 3.0, 3.4, 6.3, 3.9, 6.3, 6.9),
-- Match 97
('03', '97', 5.49, 7.4, 1.5, 1.8, 5.5, 3.8, 6.4, 7.7),
('09', '97', 9.76, 6.6, 2.5, 3.7, 7.5, 4.2, 6.4, 6.9),
('05', '97', 8.71, 6.7, 3.2, 4.3, 7.4, 4.2, 6.3, 7.6),
('06', '97', 9.44, 6.6, 3.6, 3.6, 7.9, 5.1, 5.6, 7.5),
('11', '97', 11.43, 7.4, 4.9, 6.5, 5.9, 6.8, 6.2, 5.9),
('26', '97', 9.67, 7.0, 5.6, 6.3, 6.7, 6.2, 7.1, 6.1),
('15', '97', 9.90, 7.3, 4.8, 5.1, 6.1, 6.8, 7.1, 6.2),
('20', '97', 9.67, 6.8, 4.5, 6.3, 6.1, 7.2, 7.7, 6.0),
('22', '97', 11.71, 7.1, 7.0, 7.1, 5.6, 7.5, 8.1, 4.3),
('14', '97', 10.24, 7.7, 6.9, 7.3, 5.2, 8.1, 7.1, 4.8),
('27', '97', 9.95, 7.5, 8.2, 7.3, 6.2, 6.2, 6.9, 3.6),
('18', '97', 3.57, 7.0, 6.7, 7.2, 5.8, 6.7, 7.4, 3.8),
('16', '97', 3.91, 6.8, 5.8, 6.5, 6.1, 6.8, 7.1, 3.7),
('23', '97', 2.63, 6.9, 7.8, 6.6, 6.3, 5.0, 6.2, 2.8),
('19', '97', 2.27, 6.3, 4.1, 6.1, 6.5, 6.1, 7.5, 6.9),
-- Match 29
('01', '29', 5.14, 7.8, 1.1, 1.4, 5.3, 2.9, 5.6, 8.4),
('05', '29', 9.63, 7.7, 3.7, 4.1, 7.1, 4.5, 6.1, 7.4),
('25', '29', 8.71, 6.7, 3.7, 3.5, 7.2, 4.7, 6.8, 7.2),
('04', '29', 9.09, 6.7, 2.9, 3.9, 7.8, 5.0, 6.8, 6.9),
('13', '29', 9.38, 7.1, 5.6, 6.8, 6.4, 5.5, 6.4, 6.4),
('21', '29', 11.45, 7.3, 5.7, 6.4, 5.8, 5.7, 6.6, 6.1),
('15', '29', 11.75, 7.1, 5.0, 6.2, 6.7, 6.9, 6.6, 6.9),
('19', '29', 9.90, 7.3, 5.0, 5.5, 6.3, 6.5, 7.4, 6.8),
('18', '29', 9.59, 6.6, 6.4, 7.5, 5.6, 7.2, 7.5, 3.5),
('12', '29', 10.08, 6.9, 7.0, 7.6, 6.3, 7.6, 7.0, 3.8),
('23', '29', 11.80, 7.1, 7.1, 6.5, 6.4, 5.8, 6.3, 2.9),
('28', '29', 3.67, 7.0, 6.7, 6.2, 5.9, 5.2, 6.4, 2.5),
('17', '29', 4.03, 6.9, 6.1, 6.7, 6.2, 7.0, 7.5, 3.5),
('16', '29', 2.42, 6.9, 5.8, 7.7, 5.5, 6.9, 6.7, 3.8),
('07', '29', 3.66, 7.1, 2.2, 3.6, 6.5, 4.9, 5.5, 6.7),
-- Match 38
('02', '38', 4.67, 6.9, 2.1, 2.5, 5.8, 4.2, 6.6, 7.3),
('07', '38', 8.93, 7.3, 3.3, 3.3, 7.4, 4.3, 6.1, 7.4),
('09', '38', 8.90, 6.5, 2.7, 3.8, 7.8, 4.0, 6.9, 7.2),
('08', '38', 9.24, 7.2, 3.5, 3.9, 6.6, 4.5, 6.1, 8.2),
('24', '38', 9.80, 6.8, 5.6, 6.1, 6.2, 6.6, 7.0, 5.2),
('11', '38', 9.39, 6.6, 5.6, 6.5, 6.6, 6.8, 6.4, 5.5),
('10', '38', 11.79, 7.1, 4.5, 6.1, 6.5, 6.5, 6.5, 6.9),
('20', '38', 11.68, 7.1, 5.4, 5.1, 6.4, 6.8, 7.8, 7.1),
('17', '38', 10.30, 7.5, 7.1, 7.9, 6.4, 7.2, 7.8, 4.5),
('22', '38', 11.44, 7.2, 6.6, 7.2, 5.5, 7.4, 7.8, 3.6),
('27', '38', 9.81, 8.0, 7.8, 7.1, 5.7, 5.7, 6.2, 3.9),
('26', '38', 4.27, 7.1, 4.4, 5.9, 5.4, 5.9, 6.6, 5.4),
('14', '38', 2.46, 6.6, 6.3, 7.3, 5.8, 7.8, 7.3, 3.4),
('28', '38', 4.15, 6.5, 7.2, 6.7, 6.4, 4.9, 5.7, 2.5);

-- Staff Table
INSERT INTO Staff
(staff_id, fname, lname, role, age, nationality)
VALUES
('01', 'Hajime',   'Moriyasu',  'Manager',             58, 'Japan'),
('02', 'Makoto',   'Hasebe',    'Assistant Coach',     42, 'Japan'),
('03', 'Shunsuke', 'Nakamura',  'Assistant Coach',     48, 'Japan'),
('04', 'Kenichi',  'Shimokawa', 'Goalkeeping Coach',   56, 'Japan'),
('05', 'Takuya',   'Morita',    'Fitness Coach',       45, 'Japan'),
('06', 'Daisuke',  'Kuroki',    'Set Piece Coach',     39, 'Japan'),
('07', 'Lukas',    'Brandt',    'Performance Analyst', 36, 'Germany'),
('08', 'Hiroshi',  'Fujimoto',  'Team Doctor',         52, 'Japan'),
('09', 'Yusuke',   'Oshima',    'Physiotherapist',     41, 'Japan'),
('10', 'Masaru',   'Kondo',     'Kit Manager',         47, 'Japan');

-- Match_Staff Table
INSERT INTO Match_Staff
(staff_id, match_id)
VALUES
('01', '94'), ('02', '94'), ('03', '94'), ('04', '94'),
('01', '84'), ('02', '84'), ('03', '84'), ('04', '84'),
('01', '59'), ('02', '59'), ('03', '59'), ('04', '59'),
('01', '89'), ('02', '89'), ('03', '89'), ('04', '89'),
('01', '97'), ('02', '97'), ('03', '97'), ('04', '97'),
('01', '29'), ('02', '29'), ('03', '29'), ('04', '29'),
('01', '38'), ('02', '38'), ('03', '38'), ('04', '38');
 
-- Lineup Table 
INSERT INTO Lineup
(lineup_id, match_id, goalkeeper, defender, midfielder, forward)
VALUES
('L1', '94', '01', '05', '12', '18'),
('L1', '94', '01', '25', '21', '16'),
('L1', '94', '01', '06', '15', '23'),
('L1', '94', '01', '06', '14', '23'),
 
('L2', '84', '01', '05', '12', '18'),
('L2', '84', '01', '25', '21', '16'),
('L2', '84', '01', '06', '15', '23'),
('L2', '84', '01', '06', '14', '23'),
 
('L3', '59', '01', '05', '12', '18'),
('L3', '59', '01', '25', '21', '16'),
('L3', '59', '01', '06', '15', '23'),
('L3', '59', '01', '06', '14', '23'),
 
('L4', '89', '02', '07', '24', '28'),
('L4', '89', '02', '04', '19', '28'),
('L4', '89', '02', '08', '10', '28'),
('L4', '89', '02', '13', '12', '28'),
('L4', '89', '02', '13', '17', '28'),
 
('L5', '97', '03', '09', '11', '22'),
('L5', '97', '03', '05', '26', '14'),
('L5', '97', '03', '06', '15', '27'),
('L5', '97', '03', '06', '20', '27'),
 
('L6', '29', '01', '13', '21', '18'),
('L6', '29', '01', '05', '15', '23'),
('L6', '29', '01', '25', '19', '23'),
('L6', '29', '01', '04', '12', '23'),
 
('L7', '38', '02', '07', '24', '17'),
('L7', '38', '02', '09', '11', '22'),
('L7', '38', '02', '08', '10', '27'),
('L7', '38', '02', '08', '20', '27'),
 
('L8', '41', '01', '25', '15', '12'),
('L8', '41', '01', '05', '14', '23'),
('L8', '41', '01', '06', '18', '21'),
('L8', '41', '01', '04', '18', '21'),
 
('L9', '16', '01', '13', '12', '23'),
('L9', '16', '01', '25', '15', '23'),
('L9', '16', '01', '05', '14', '23'),
('L9', '16', '01', '06', '21', '23'),
('L9', '16', '01', '24', '21', '23'),
 
('L10', '73', '02', '05', '13', '27'),
('L10', '73', '02', '07', '15', '22'),
('L10', '73', '02', '09', '20', '22'),
('L10', '73', '02', '09', '17', '22'),
('L10', '73', '02', '09', '11', '22');
 
-- Formation Table
 INSERT INTO Formation (formation_id, back, midfield, forward)
VALUES
('01', 3, 6, 1),  -- 3-4-2-1
('02', 4, 5, 1),  -- 4-2-3-1
('03', 4, 3, 3),  -- 4-3-3
('04', 3, 4, 3),  -- 3-4-3
('05', 4, 4, 2),  -- 4-4-2
('06', 3, 5, 2),  -- 3-5-2
('07', 5, 4, 1),  -- 5-4-1
('08', 5, 3, 2),  -- 5-3-2
('09', 4, 2, 4),  -- 4-2-4
('10', 5, 2, 3);  -- 5-2-3

-- Comments Table
INSERT INTO Comments
(commentID, user_id, reply_id, content, comment_date, likes)
VALUES
('01', '95', NULL, 'Mitoma''s dribbling down the left wing is unreal. Every time he gets the ball one-on-one you can feel the whole stadium lean forward. Honestly the best winger Japan has ever produced!', '2026-03-20', 142),
('02', '85', '01', 'Agreed, but don''t sleep on Kubo on the right. Having two elite wingers means defenders can''t double up on either of them, and that balance is what makes our attack so dangerous.', '2026-03-20', 37),
('03', '47', '01', 'Still can''t believe that 1mm cross against Spain in 2022. Everyone thought it was out, VAR said otherwise, and Tanaka scored. Mitoma was already a legend after that one moment.', '2026-03-21', 58),
('04', '51', NULL, 'Endo as captain is the perfect choice. He stays calm under pressure, wins nearly every duel in midfield, and never stops running for the full 90 minutes. A true leader for this team.', '2026-03-25', 96),
('05', '84', '04', 'You can see how much his time at Liverpool has shaped him. His positioning is so smart now, and whenever he''s missing, the midfield looks lost and the defense gets exposed way more.', '2026-03-25', 21),
('06', '12', NULL, 'Moriyasu really needs to start Ueda up top every match. He''s the only true No. 9 we have, he holds the ball up well, and his finishing in the box has been sharp all season long.', '2026-04-02', 64),
('07', '83', '06', 'Ueda is clinical for sure, but I think Minamino''s pressing from the front fits Moriyasu''s system better. He forces mistakes high up the pitch and creates chances out of nothing.', '2026-04-02', 29),
('08', '95', '07', 'Why not play both? Ueda as the main striker with Minamino just behind him pressing and making late runs would be a great partnership. It gives us a target man and a creative spark.', '2026-04-03', 15),
('09', '92', NULL, 'Zion Suzuki has grown so much in goal over the past couple of years. He makes huge reflex saves, commands his box with confidence, and he''s surprisingly good with his feet too.', '2026-04-10', 73),
('10', '85', NULL, 'If Tomiyasu and Itakura can both stay fully fit, we''d have one of the best center back pairings in Asia. Both are strong in the air, good on the ball, and read the game really well.', '2026-04-15', 51),
('11', '65', '10', 'Injuries are always the big worry with those two. Thankfully Hiroki Ito is solid cover at the back, and he can play left back or center back, which gives the coach more options.', '2026-04-15', 12),
('12', '51', '09', 'Suzuki''s distribution has completely changed how we build from the back. His long passes to the wingers skip the press entirely. Love watching him start attacks from his own box.', '2026-04-11', 33);

-- Lineup Info Table
INSERT INTO LINEUP_INFO VALUES
('L1', '94'), 
('L2', '84'), 
('L3', '59'), 
('L4', '89'), 
('L5', '97'),
('L6', '29'), 
('L7', '38'), 
('L8', '41'), 
('L9', '16'), 
('L10', '73');

-- Lineup Formation
INSERT INTO LINEUP_FORMATION (lineup_id, formation_id)
VALUES
('L1',  '01'),  -- Tunisia
('L2',  '02'),  -- Sweden
('L3',  '07'),  -- Brazil
('L4',  '06'),  -- Uruguay
('L5',  '03'),  -- Venezuela
('L6',  '04'),  -- Ecuador
('L7',  '09'),  -- New Zealand
('L8',  '10'),  -- Scotland
('L9',  '08'),  -- England
('L10', '05');  -- Ghana

-- Part 4: Write 5 different meaningful queries on your database. Provide English description for each query (e.g. This is the SQL statement to find the number of outbox messages of each user)
-- 1) Queries involving inner join on two or more table 
-- INNER JOIN
-- This is the SQL statement to list the players (first name, last name, no. of favorites) and the number of users that have them as their favorite player
SELECT
	p.fname,
    p.lname,
    COUNT(u.player_id) AS favorites
FROM PLAYER AS p
JOIN USER_FAV_PLAYER AS u
	ON p.player_id = u.player_id
    GROUP BY u.player_id; 
    
-- 2) Queries involving aggregate functions, such as SUM, COUNT, AVG etc.
-- AGGREGATE FUNCTION
-- After the retirement of previous team captain, Wataru Endo, Coach Moriyasu would like to select a new captain. Coach Moriyasu would like someone senior i.e. most appearances to captain the team. Which player(s) should he consider?
-- This is the SQL statement to find the player(s) (fname, lname, appearances)with the most appearances on the Japanese national team.
SELECT fname, lname, appearances FROM PLAYER WHERE appearances = (SELECT MAX(appearances) FROM PLAYER);

-- 3) Queries involving subqueries
-- SUBQUERY
-- What was Keito Nakamura's Player Rating for the World Cup match against Tunisia?
-- This is the SQL statement to find the player rating for Keito Nakamura in the World Cup match against Tunisia
SELECT * FROM PERFORMANCE_METRICS WHERE player_id = (
	SELECT player_id FROM PLAYER WHERE fname = 'Keito' AND lname = 'Nakamura'
    ) AND 
    match_id = (
		SELECT match_id FROM MATCH_tab WHERE opponent = 'Tunisia' AND match_type = 'FIFA World Cup'
    ); 
     
-- 4) GROUP BY and HAVING
-- This is the SQL statement to find players who have performance data in more than one match and an average rating of at least 7, showing their name, number of matches, and average rating, sorted from highest average to lowest.
SELECT 
	p.fname, 
    p.lname, 
    COUNT(pm.match_id) AS matches_count, 
    AVG(pm.rating) AS AVG_rating
FROM PERFORMANCE_METRICS pm
JOIN PLAYER p 
    ON pm.player_id = p.player_id
GROUP BY p.player_id, p.fname, p.lname
HAVING COUNT(pm.match_id) > 1 AND AVG(pm.rating) >= 7.0
ORDER BY avg_rating DESC;

-- LEFT OUTER JOIN/RIGHT OUT JOIN
-- 5) This is the SQL statement to list every player with their position and the number of matches they have performance data for, including players with no data (shown as 0), sorted from most matches to fewest.
SELECT 
	p.fname, 
    p.lname, 
    p.position, 
    COUNT(pm.match_id) as matches_count
FROM PLAYER p
LEFT JOIN PERFORMANCE_METRICS pm 
ON p.player_id = pm.player_id
GROUP BY p.player_id, p.fname, p.lname, p.position
ORDER BY matches_count DESC, p.lname;

-- This is the SQL statement to list every midfielder (MF) players (first name, last name), including those who have not made an appearance in recent matches, and their performances in the matches (distance, rating, finishing, attacking, duels, creativity, control, defending)
SELECT
	p.fname,
    p.lname,
    pm.distance_covered_km,
    pm.rating,
    pm.finishing,
    pm.attacking,
    pm.duels,
    pm.creativity,
    pm.control,
    pm.defending
FROM PLAYER as p
LEFT JOIN PERFORMANCE_METRICS as pm
	ON p.player_id = pm.player_id
WHERE p.position = 'MF'; 

-- Part 5: Provide three SQL statements, each demonstrating one distinct advanced database feature, chosen from indexes, triggers, views, or stored procedures. Also provide English description for each SQL.
-- stored procedure (User inputs player first name and last name to get the players goals and appearences (Assumption: User always types in the correct player name):    
DROP PROCEDURE IF EXISTS Player_Goals_Appearances;
DELIMITER //
create PROCEDURE Player_Goals_Appearances (
  in fname varchar(50),
  in lname varchar(50),
  out p_goals int,
  out p_appearances int
)
Begin
  select goals, appearances
  into p_goals, p_appearances
  from PLAYER
  where PLAYER.fname = fname and PLAYER.lname = lname;

END //

-- Using stored procedure 'Player_Goals_Appearances' to retrieve the goals and appearances for player Daichi Kamada
set @fname = 'Daichi';
set @lname = 'Kamada';
call Player_Goals_Appearances(@fname, @lname, @goals, @appearences);
select @goals, @appearences;


-- View
-- This SQL statement creates view Player_Ratings which lists the players (first name, last name), the matches they were in (opponent), and their rating for that particular match.
CREATE VIEW Player_Ratings AS
SELECT
    PLAYER.fname,
    PLAYER.lname,
    MATCH_tab.opponent,
    PERFORMANCE_METRICS.rating
FROM PLAYER
JOIN PERFORMANCE_METRICS
    ON PLAYER.player_id = PERFORMANCE_METRICS.player_id
JOIN MATCH_tab
    ON PERFORMANCE_METRICS.match_id = MATCH_tab.match_id;

SELECT *
FROM Player_Ratings;

-- Trigger
-- This is the SQL statement for creating a trigger that checks the user's age prior to inserting into the Comments table; User must be 17 or older to be able to post comments.
DELIMITER //

CREATE TRIGGER Check_User_Age
BEFORE INSERT ON Comments
FOR EACH ROW
BEGIN
    DECLARE user_age INT;

    SELECT YEAR(NEW.comment_date) - YEAR(birthday)
    INTO user_age
    FROM USER
    WHERE user_id = NEW.user_id;

    IF user_age <= 16 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Users 16 or younger cannot post comments.';
    END IF;
END //

DELIMITER ;

-- Insert attempt for user whose age <= 16; rejected
INSERT INTO Comments VALUES ('13', '62', NULL, 'I think Keito Nakamura should start in the game against Brazil this month', '2026-9-11', 0);

-- Insert attempt for user whose age > 16; accepted
INSERT INTO Comments VALUES ('13', '95', NULL, 'I prefer having Minamino in the midfield. Midfield is in total control whenever Minamino is on the field. Great leadership as well.', '2026-9-11', 12);