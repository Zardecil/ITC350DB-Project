CREATE TABLE CLASS
(
  ClassName VARCHAR(50) UNIQUE NOT NULL,
  Subclass__Archetype VARCHAR(50) NOT NULL,
  ClassLevel INT NOT NULL,
  ClassID SERIAL PRIMARY KEY
);
CREATE TABLE USERS
(
  Username VARCHAR(20) UNIQUE NOT NULL,
  Password VARCHAR(50) NOT NULL,
  DoB DATE NOT NULL,
  IsAdmin Bool NOT NULL,
  UserID SERIAL PRIMARY KEY
);
CREATE TABLE RACE
(
  RaceName VARCHAR(50) UNIQUE NOT NULL,
  Subrace VARCHAR(50) NOT NULL,
  RaceID SERIAL PRIMARY KEY
);
CREATE TABLE BACKGROUND
(
  BackgroundName VARCHAR(50) UNIQUE NOT NULL,
  BackgroundID SERIAL PRIMARY KEY
);
CREATE TABLE ACTIONS
(
  ActionData VARCHAR(200) NOT NULL,
  ActionName VARCHAR(50) NOT NULL,
  ActionID SERIAL PRIMARY KEY
);
CREATE TABLE BACKGROUND_Predefined_Items
(
  Predefined_Items_ID SERIAL PRIMARY KEY,
  Predefined_Items VARCHAR(300) NOT NULL,
  BackgroundID BIGINT unsigned NOT NULL,
  FOREIGN KEY (BackgroundID) REFERENCES BACKGROUND(BackgroundID)
);
CREATE TABLE CHARACTERS
(
  FName VARCHAR(50) NOT NULL,
  LName VARCHAR(50),
  Creation_Date date NOT NULL,
  Proficiencies VARCHAR(300) NOT NULL,
  Traits VARCHAR(300) NOT NULL,
  Languages VARCHAR(300) NOT NULL,
  Hit_Points INT NOT NULL,
  UserID BIGINT unsigned NOT NULL,
  RaceID BIGINT unsigned NOT NULL,
  BackgroundID BIGINT unsigned NOT NULL,
  Char_ID SERIAL PRIMARY KEY,
  FOREIGN KEY (UserID) REFERENCES USERS(UserID),
  FOREIGN KEY (RaceID) REFERENCES RACE(RaceID),
  FOREIGN KEY (BackgroundID) REFERENCES BACKGROUND(BackgroundID)
);
CREATE TABLE SKILLS
(
  Acrobatics INT NOT NULL,
  Animal_Handling INT NOT NULL,
  Arcana INT NOT NULL,
  Athletics INT NOT NULL,
  Deception INT NOT NULL,
  History INT NOT NULL,
  Insight INT NOT NULL,
  Intimidation INT NOT NULL,
  Investigation INT NOT NULL,
  Medicine INT NOT NULL,
  Nature INT NOT NULL,
  Perception INT NOT NULL,
  Persuasion INT NOT NULL,
  Religion INT NOT NULL,
  Sleight_of_Hand INT NOT NULL,
  Stealth INT NOT NULL,
  Survival INT NOT NULL,
  Char_ID SERIAL PRIMARY KEY,
  FOREIGN KEY (Char_ID) REFERENCES CHARACTERS(Char_ID)
);
CREATE TABLE ABILITY_SCORE
(
  Dexterity INT NOT NULL,
  Constitution INT NOT NULL,
  Strength INT NOT NULL,
  Intelligence INT NOT NULL,
  Wisdom INT NOT NULL,
  Charisma INT NOT NULL,
  Char_ID SERIAL PRIMARY KEY,
  FOREIGN KEY (Char_ID) REFERENCES CHARACTERS(Char_ID)
);
CREATE TABLE have
(
  Char_ID BIGINT unsigned NOT NULL,
  ActionID BIGINT unsigned NOT NULL,
  FOREIGN KEY (Char_ID) REFERENCES CHARACTERS(Char_ID),
  FOREIGN KEY (ActionID) REFERENCES ACTIONS(ActionID)
);
CREATE TABLE has
(
  Char_ID BIGINT unsigned NOT NULL,
  ClassID BIGINT unsigned NOT NULL,
  FOREIGN KEY (Char_ID) REFERENCES CHARACTERS(Char_ID),
  FOREIGN KEY (ClassID) REFERENCES CLASS(ClassID)
);
