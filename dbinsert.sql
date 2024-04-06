insert into "CLASS" (ClassName, ClassID) values ('Rogue', 1);
insert into "USERS" (Username, Password, DoB, IsAdmin, UserID) values ('burrito', '1c0e6a6c7472db315acbb5091c39190ca08cfc0bd02bf3b281c21d7750aa9b93ab12f89f251b1b0e9f7a9259deb61a89290df0bf289b044e07803dc483327678', 11-01-2001, 0, 1);
insert into "RACE" (RaceName, RaceID) values ('Dragonborn', 2);
insert into "BACKGROUND" (BackgroundName, BackgroundID) values ('Hermit', 1);
insert into "SPELLS" (SpellLevel, SpellName, SpellID) values (2, 'Aid', 3);
insert into "CHARACTERS" (FirstName, LastName, CreationDate, Proficiencies, Traits, Languages, HitPoints, UserID, RaceID, BackgroundID, ClassID, CharacterID)
  values ('Burrito', 'Taco', 10-11-2111, 'burrito eating', 'traitor', 'Angelic', 34, 1, 1, 1, 1, 1);
insert into "SKILLS" (Acrobatics, AnimalHandling, Arcana, Athletics, Deception, History, Insight, Intimidation, Investigation, Medicine, Nature, Perception, Persuasion, Religion, SleightOfHand, Stealth, Survival) 
  values (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
insert into "ABILITYSCORE" (Dexterity,Constitution,Strength,Intelligence,Wisdom,Charisma,Char_ID) values (1,1,1,1,1,1,1);
insert into "have" (CharacterID, ActionID) values (1, 1);
