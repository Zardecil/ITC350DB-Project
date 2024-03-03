insert into "CLASS" (ClassName, Subclass_Archetype, ClassLevel, ClassID) values ('Rogue', 'Arcane_Trickers', 1, 1);
insert into "USERS" (Username, Password, DoB, IsAdmin, UserID) values ('burrito', '1c0e6a6c7472db315acbb5091c39190ca08cfc0bd02bf3b281c21d7750aa9b93ab12f89f251b1b0e9f7a9259deb61a89290df0bf289b044e07803dc483327678', 11-01-2001, 0, 1);
insert into "RACE" (RaceName, Subrace, RaceID) values ('Dragonborn', 'Copper', 2);
insert into "BACKGROUND" (BackgroundName, BackgroundID) values ('Hermit', 1);
insert into "ACTIONS" (ActionData, ActionName, ActionID) values ('Eat A Taco', 'Eat', 1);
insert into "BACKGROUND_Predefined_Items" (Predefined_Items_ID, Predefined_Items, BackgroundID) values (1, "Tacos", 1);
insert into "CHARACTERS" (FName,LName,Creation_Date,Proficiencies,Traits,Languages,Hit_Points,UserID,RaceID,BackgroundID,Char_ID)
  values ('Burrito', 'Taco', 10-11-2111, 'burrito eating', 'traitor', 'Angelic', 5, 1,1,1,1);
insert into "SKILLS" (Acrobatics,Animal_Handling,Arcana,Athletics,Deception,History,Insight,Intimidation,Investigation,Medicine,Nature,Perception,Persuasion,Religion,Sleight_of_Hand,Stealth,Survival) 
  values (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
insert into "ABILITY_SCORE" (Dexterity,Constitution,Strength,Intelligence,Wisdom,Charisma,Char_ID) values (1,1,1,1,1,1,1);
insert into "have" (Char_ID, ActionID) values (1,1);
insert into "has" (Char_ID, ClassID) values (1,1);
