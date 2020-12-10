-- Caleb Rogers -- December 10th, 2020 -- Final Project: MSGV Database Design Proposal

--
-- RESETS DATABASE --
--
DROP VIEW IF EXISTS fullBaseStaff;
DROP VIEW IF EXISTS aestheticCustomization;

DROP TABLE IF EXISTS Command_Support;
DROP TABLE IF EXISTS Research_BaseDevelopment;
DROP TABLE IF EXISTS StaffManagement;
DROP TABLE IF EXISTS Skills;
DROP TABLE IF EXISTS Missions;
DROP TABLE IF EXISTS SideOps;
DROP TABLE IF EXISTS Challenges;
DROP TABLE IF EXISTS Espionage;
DROP TABLE IF EXISTS BigBoss;
DROP TABLE IF EXISTS Loadout;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Resources;
DROP TABLE IF EXISTS MotherBase;
DROP TABLE IF EXISTS PrimaryWeapons;
DROP TABLE IF EXISTS SecondaryWeapons;
DROP TABLE IF EXISTS SupportWeapons;
DROP TABLE IF EXISTS Tools;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Vehicle;
DROP TABLE IF EXISTS Buddy;

--
-- CREATES DATABASE --
--

-- MotherBase
CREATE TABLE MotherBase (
	base_ID			  char(3)	 not null,
	emblem			  text		 not null,
	progression_level         varchar(2) 	 not null,
	base_color 		  text,
	primary key (base_ID)
);

-- Skills
CREATE TABLE Skills (
	skill_ID	char(2)	   not null,
	skill_role	text 	   not null,
	specialties 	text,
	primary key(skill_ID)
);

-- StaffManagement
CREATE TABLE StaffManagement (
	staff_ID		char(3) not null,
	base_ID			char(3) not null references MotherBase(base_ID),
	first_name		text,
	last_name		text	not null,
	dob			date	not null,		
	skill_ID		varchar	not null references Skills(skill_ID),
	primary key(staff_ID)
);

-- Command&Support_Unit
CREATE TABLE Command_Support (
	staff_ID		char(3)	not null references StaffManagement(staff_ID),
	unit_chemistry  int,
	primary key (staff_ID)
);

-- Research&BaseDevelopment_Unit
CREATE TABLE Research_BaseDevelopment (
	staff_ID		char(3)	not null references StaffManagement(staff_ID),
	unit_chemistry  int,
	primary key (staff_ID)
);

-- PrimaryWeapons
CREATE TABLE PrimaryWeapons (
	primary_weapon  text not null,
	weapon_type 	text not null,
	primary key (primary_weapon)
);

-- SecondaryWeapons
CREATE TABLE SecondaryWeapons (
	secondary_weapon text not null,
	weapon_type	 text not null,
	primary key (secondary_weapon)
);

-- SupportWeapons
CREATE TABLE SupportWeapons (
	support_weapon 	text not null,
	weapon_type	text not null,
	primary key (support_weapon)
);

-- Items
CREATE TABLE Items (
	items 		 text not null,
	item_description text,
	primary key (items)
);

-- Tools
CREATE TABLE Tools (
	tools		 text not null,
	tool_description text,
	primary key (tools)
);

-- Resources
CREATE TABLE Resources (
	base_ID			char(3) not null references MotherBase(base_ID),
	resource_name		text 	not null,
	quantity_stored 	int 	not null,
	primary key (base_ID)
);

-- Equipment
CREATE TABLE Equipment (
	equip_ID		char(3) not null,
	resource_ID		char(3) not null references Resources(base_ID),
	primary_weapon_hip	text    not null references PrimaryWeapons(primary_weapon),
	primary_weapon_back	text    not null references PrimaryWeapons(primary_weapon),
	secondary_weapon	text	not null references SecondaryWeapons(secondary_weapon),
	support_weapon		text	not null references SupportWeapons(support_weapon),
	items			text	not null references Items(items),
	tools			text	not null references Tools(tools),
	GMP_to_develop		int	not null,
	primary key (equip_ID)
);

-- Vehicle
CREATE TABLE Vehicle (
	vehicle_name	text not null,
	vehicle_type	text not null,
	vehicle_skin	text not null,
primary key (vehicle_name)
);

-- Buddy
CREATE TABLE Buddy (
	buddy_name	text not null,
	attire		text,
	primary key (buddy_name)
);

-- Loadout
CREATE TABLE Loadout (
	loadout_ID  	char(3) not null,
	equip_ID	char(3) not null references Equipment(equip_ID),
	vehicle_name 	text 	not null references Vehicle(vehicle_name),
	buddy_name	text 	not null references Buddy(buddy_name),
	primary key (loadout_ID)
);

-- BigBoss
CREATE TABLE BigBoss (
	snake_ID	char(2) not null,
	loadout_ID  	char(2) not null references Loadout(loadout_ID),
	prosthetic_arm	text,
	uniform		text,
	primary key (snake_ID)
);

-- Espionage
CREATE TABLE Espionage (
	snake_ID 	char(3) not null references BigBoss(snake_ID),
	drop_time_24hr  int  	not null,
	drop_location	text 	not null,
	primary key (snake_ID)
);

-- Missions
CREATE TABLE Missions (
	mission_title 	text 	not null,
	snake_ID 	char(3) not null references Espionage(snake_ID),
	GMP_reward	int,
	primary key (mission_title)
);

-- SideOps
CREATE TABLE SideOps (
	side_ops_title 	text 	not null,
	snake_ID 	char(3) not null references Espionage(snake_ID),
	GMP_reward	int,
	primary key (side_ops_title)
);

-- Challenges
CREATE TABLE Challenges (
	challenge_num		int 	not null,
	challenge_description 	text 	not null,
	snake_ID 		char(3) not null references Espionage(snake_ID),
	GMP_reward		int,
	primary key (challenge_num)
);

--
-- POPULATES DATABASE --
--

-- MotherBase
INSERT INTO MotherBase
(base_ID, emblem, progression_level, base_color)
VALUES
('B01','diamond_dogs','A','yellow'),
('B02','XOF','B-','purple'),
('B03','rogue_coyote','C+','red');

-- Skills
INSERT INTO Skills
(skill_ID, skill_role, specialties)
VALUES
('S1','sneaking/deployment','rescuer'),
('S2','medical','chemist'),
('S3','technical','elite_engineer'),
('S4','recon','arms_dealer'),
('S5','sneaking/deployment','scout'),
('S6','recon','surveyor'),
('S7','sneaking/deployment','gambler');

-- StaffManagement
INSERT INTO StaffManagement
(staff_ID, base_ID, first_name, last_name, dob, skill_ID)
VALUES
('M11','B03','Alan','Labouseur','1970-01-23','S3'),
('M22','B01','Venom','Snake', '1932-04-15','S1'),
('M33','B02','Huey','Emmerich','1945-10-05','S4'),
('M44','B01','sniper','Quiet','1951-06-22','S5'),
('M55','B03','Hideo','Kojima','1963-08-24','S2'),
('M66','B01','Benedict','Miller','1937-06-13','S6'),
('M77','B01','Revolver','Ocelot','1930-02-27','S7'),
('M88','B02','Skull','Face','1900-12-25','S4');

-- Command&Support_Unit
INSERT INTO Command_Support
(staff_ID, unit_chemistry)
VALUES
('M22',99),
('M44',37),
('M66',89),
('M77',90),
('M88',95);

-- Research&BaseDevelopmentUnit
INSERT INTO Research_BaseDevelopment
(staff_ID, unit_chemistry)
VALUES
('M11',86),
('M33',68),
('M55',81),
('M77',90);

-- PrimaryWeapons
INSERT INTO PrimaryWeapons
(primary_weapon, weapon_type)
VALUES
('AM_MRS-4','assult_rifle'),
('SVG-76','assult_rifle'),
('S100','shotgun'),
('ISANDO_RGL-220','grenade_launcher'),
('BRENNAN_LRS-46','sniper_rifle'),
('sinful_butterfly','sniper_rifle'),
('LPG-61','light_machine_gun');

-- SecondaryWeapons
INSERT INTO SecondaryWeapons
(secondary_weapon, weapon_type)
VALUES
('WU_S.PISTOL','handgun'),
('WU_S333','handgun'),
('MACHT_37','submachine_gun');

-- SupportWeapons
INSERT INTO SupportWeapons
(support_weapon, weapon_type)
VALUES
('decoy','throwable_weapon'),
('hand_grenade','throwable_weapon'),
('flare_grenade','throwable_weapon'),
('C-4','placed_weapon'),
('M21_D-MINE','placed_weapon');

-- Items
INSERT INTO Items
(items, item_description)
VALUES
('phantom_cigar','speeds perception of time'),
('NVG','night vision goggles'),
('C.BOX','cardboard box to hide');

-- Tools
INSERT INTO Tools
(tools, tool_description)
VALUES
('INT-SCOPE','variable-magnification binoculars'),
('iDROID','portable data device'),
('fulton_device','battlefield extraction');

-- Resources
INSERT INTO Resources
(base_ID, resource_name, quantity_stored)
VALUES
('B01','GMP',1475000),
('B02','GMP',2100000),
('B03','GMP',1015000);

-- Equipment
INSERT INTO Equipment
(equip_ID, resource_ID, primary_weapon_hip, primary_weapon_back, secondary_weapon, support_weapon, items, tools, GMP_to_develop)
VALUES
('E11','B01','AM_MRS-4','BRENNAN_LRS-46','WU_S.PISTOL','decoy','phantom_cigar','iDROID',750000),
('E22','B01','SVG-76','sinful_butterfly','MACHT_37','M21_D-MINE','C.BOX','INT-SCOPE',1250000),
('E33','B01','S100','ISANDO_RGL-220','WU_S333','flare_grenade','NVG','fulton_device',900000);

-- Vehicle
INSERT INTO Vehicle
(vehicle_name, vehicle_type, vehicle_skin)
VALUES
('APE_T-41LV','four_wheel_drive','standard_camo'),
('BOAR-53CT','truck','desert_camo'),
('ZHUK_RS-Z0','wheeled_AFV','red_variant'),
('STOUT_IFV-FS','wheeled_AFV','black_variant'),
('UTH-66_BLACKFOOT','helicopter','standard_camo');

-- Buddy
INSERT INTO Buddy
(buddy_name, attire)
VALUES
('D-Horse','battle_dress'),
('D-Dog','eyepatch'),
('Quiet','naked'),
('D-Walker','CCCP-WG_Type-C');

-- Loadout
INSERT INTO Loadout
(loadout_ID, equip_ID, vehicle_name, buddy_name)
VALUES
('L1','E11','APE_T-41LV','D-Dog'),
('L2', 'E22','ZHUK_RS-Z0','Quiet'),
('L3','E33','UTH-66_BLACKFOOT','D-Horse'),
('L4', 'E11','STOUT_IFV-FS','D-Walker');

-- BigBoss
INSERT INTO BigBoss
(snake_ID, loadout_ID, prosthetic_arm, uniform)
VALUES
('S1','L1','bionic_arm','desert_fox'),
('S2','L2','stun _arm','woodland'),
('S3','L2','blast_arm','olive_drab'),
('S4','L4','rocket_arm','tiger_stripe'),
('S5','L3','hand_of_jehuty','wetwork');

-- Espionage
INSERT INTO Espionage
(snake_ID, drop_time_24hr, drop_location)
VALUES
('S1',0600,'Da Shago Kallai'),
('S2',1800,'Da Ghwandai Khar'),
('S3',1200,'Qarya Askhra Ee'),
('S4',0000,'Aabe Shifap Ruins');

-- Misssions
INSERT INTO Missions
(mission_title, snake_ID, GMP_reward)
VALUES
('metallic_archaea','S2',720000),
('the_white_mamba','S3',650000),
('footprints_of_the_phantom','S2',570000),
('hellbound','S4',600000);

-- SideOps
INSERT INTO SideOps
(side_ops_title, snake_ID, GMP_reward)
VALUES
('extract_highly_skilled_soldier','S1',300000),
('eliminate_heavy_infantry','S1',250000),
('extract_legendary_gunsmith','S4',300000),
('secure_UA-Drone_blueprint','S3',20000);

-- Challenges
INSERT INTO Challenges
(challenge_num, challenge_description, snake_ID, GMP_reward)
VALUES
(1,'performed_400_total_Fulton_extractions','S3',150000),
(2,'Obtained the codename "FOX"','S2',170000),
(3,'Achieved a single successful FOB infiltration in FOB missions','S2',200000);

--
-- SAMPLE DATA QUERIES --
--

SELECT * FROM MotherBase;
SELECT * FROM Skills;
SELECT * FROM StaffManagement;
SELECT * FROM Command_Support;
SELECT * FROM Research_BaseDevelopment;
SELECT * FROM PrimaryWeapons;
SELECT * FROM SecondaryWeapons;
SELECT * FROM SupportWeapons;
SELECT * FROM Items;
SELECT * FROM Tools;
SELECT * FROM Resources;
SELECT * FROM Equipment;
SELECT * FROM Vehicle;
SELECT * FROM Buddy;
SELECT * FROM Loadout;
SELECT * FROM BigBoss;
SELECT * FROM Espionage;
SELECT * FROM Missions;
SELECT * FROM SideOps;
SELECT * FROM Challenges;

--
-- VIEWS --
--

-- fullBaseStaff
CREATE OR REPLACE VIEW fullBaseStaff AS 
SELECT Staff.first_name, Staff.last_name, Staff.dob, Skills.skill_role, Skills.specialties, 
		Staff.skill_ID, MB.emblem as MotherBase, MB.base_ID, coalesce(CS.staff_ID, 'none') as Command_Support_Unit,
		coalesce(CS.unit_chemistry, 0) as CS_Unit_Chemistry, coalesce(RBD.staff_ID, 'none') as Research_BaseDevelopment_Unit, 
		coalesce(RBD.unit_chemistry, 0) as RBD_Unit_Chemistry
FROM MotherBase MB
INNER JOIN StaffManagement Staff on MB.base_ID = Staff.base_ID
INNER JOIN Skills on Skills.skill_ID = Staff.skill_ID
LEFT OUTER JOIN Command_Support CS on CS.staff_ID = Staff.staff_ID
LEFT OUTER JOIN Research_BaseDevelopment RBD on RBD.staff_ID = Staff.staff_ID;

-- aestheticCustomization
CREATE OR REPLACE VIEW aestheticCustomization AS
SELECT BB.snake_ID, BB.uniform, BB.prosthetic_arm, V.vehicle_name, V.vehicle_skin, Bud.buddy_name, Bud.attire
FROM BigBoss BB
INNER JOIN Loadout LO on LO.loadout_ID = BB.loadout_ID
INNER JOIN Vehicle V on V.vehicle_name = LO.vehicle_name
INNER JOIN Buddy Bud on Bud.buddy_name = LO.buddy_name;

--
-- REPORTS --
--

-- calculateStaffChemistry
SELECT avg(n)::numeric(10,2)
FROM (SELECT AVG(unit_chemistry) FROM Command_Support 
      UNION ALL
      SELECT AVG(unit_chemistry) FROM Research_BaseDevelopment) t(n);
	   
-- missionsDuringDay
SELECT Esp.snake_ID, Esp.drop_time_24hr, Miss.mission_title, Miss.GMP_reward, SO.side_ops_title, SO.GMP_reward, C.challenge_description, C.GMP_reward, Esp.drop_location
FROM Espionage Esp
INNER JOIN Missions Miss on Miss.snake_ID = Esp.snake_ID
INNER JOIN SideOps SO on SO.snake_ID = Esp.snake_ID
INNER JOIN Challenges C on C.snake_ID = Esp.snake_ID
where 0600 < Esp.drop_time_24hr and Esp.drop_time_24hr <= 1800;

--
-- Stored Procedures --
--

-- use_weapon
CREATE OR REPLACE FUNCTION use_weapon(text) RETURNS
	TABLE (equip_ID char(3)) AS
$$
DECLARE 
	primaryWeapon ALIAS FOR $1;
BEGIN
	RETURN QUERY
		SELECT Equip.equip_ID
		FROM Equipment Equip
		INNER JOIN PrimaryWeapons PWH on PWH.primary_weapon = Equip.primary_weapon_hip
		INNER JOIN PrimaryWeapons PWB on PWB.primary_weapon = Equip.primary_weapon_back
		WHERE
			PWH.primary_weapon = primaryWeapon OR 
			PWB.primary_weapon = primaryWeapon;
END;
$$
LANGUAGE plpgsql;

SELECT *
FROM use_weapon('sinful_butterfly');

-- find_mission
CREATE OR REPLACE FUNCTION find_mission(char(2)) RETURNS
	TABLE (mission_title text) AS
$$
DECLARE 
	snakeID ALIAS FOR $1;
BEGIN
	RETURN QUERY
		SELECT Miss.mission_title
		FROM Missions Miss
		INNER JOIN Espionage Esp on Esp.snake_ID = Miss.snake_ID
		INNER JOIN BigBoss BB on BB.snake_ID = Esp.snake_ID
		WHERE BB.snake_ID = snakeID;
END;
$$
LANGUAGE plpgsql;

SELECT *
FROM find_mission('S2');

--
-- TRIGGERS --
--

-- check_primary_type
CREATE OR REPLACE FUNCTION check_primary_type()
	RETURNS TRIGGER AS $$
BEGIN
	IF exists (SELECT Equip.primary_weapon_hip
			    FROM Equipment Equip
			    where primary_weapon_hip in (select primary_weapon
							 from PrimaryWeapons
							 where weapon_type = 'grenade_launcher'
							 or weapon_type = 'sniper_rifle'
							 or weapon_type = 'light_machine_gun')) 
		THEN
			RAISE EXCEPTION 'Cannot holster a large weapon on the hip. Insert the weapon so that it is holstered on the back.';
			RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER check_primary_type AFTER INSERT ON Equipment
FOR EACH ROW EXECUTE PROCEDURE check_primary_type();

INSERT INTO Equipment
(equip_ID, resource_ID, primary_weapon_hip, primary_weapon_back, secondary_weapon, support_weapon, items, tools, GMP_to_develop)
VALUES
('E44','B01','LPG-61','ISANDO_RGL-220','WU_S333','hand_grenade','NVG','INT-SCOPE',800000);

-- cantKillBoss
CREATE OR REPLACE FUNCTION cantKillBoss()
RETURNS TRIGGER AS
$$
BEGIN
	IF OLD.first_name = 'Venom' and OLD.last_name = 'Snake'
	THEN RAISE EXCEPTION 'Cannot remove Big Boss, he is our leader!';
	END IF;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER cantKillBoss
BEFORE DELETE ON StaffManagement
FOR EACH ROW EXECUTE PROCEDURE cantKillBoss();

DELETE FROM StaffManagement Staff
WHERE Staff.last_name = 'Snake';

--
-- REVOKES AND GRANTS SECURITY ROLES --
--

CREATE ROLE big_boss;
CREATE ROLE ranked_member;
CREATE ROLE staff_member;

REVOKE ALL ON ALL TABLES IN SCHEMA public from big_boss;
REVOKE ALL ON ALL TABLES IN SCHEMA public from ranked_member;
REVOKE ALL ON ALL TABLES IN SCHEMA public from staff_member;

GRANT ALL ON ALL TABLES IN SCHEMA public to big_boss;

GRANT SELECT, INSERT, UPDATE, DELETE ON StaffManagement to ranked_member;
GRANT SELECT, INSERT, UPDATE, DELETE ON Skills to ranked_member;
GRANT SELECT, INSERT, UPDATE, DELETE ON Command_Support to ranked_member;
GRANT SELECT, INSERT, UPDATE, DELETE ON Research_BaseDevelopment to ranked_member;
GRANT SELECT, UPDATE ON MotherBase to ranked_member;
GRANT SELECT, UPDATE ON Resources to ranked_member;
GRANT SELECT, UPDATE ON Equipment to ranked_member;
GRANT SELECT, INSERT, UPDATE, DELETE ON PrimaryWeapons to ranked_member;
GRANT SELECT, INSERT, UPDATE, DELETE ON SecondaryWeapons to ranked_member;
GRANT SELECT, INSERT, UPDATE, DELETE ON SupportWeapons to ranked_member;
GRANT SELECT, INSERT, UPDATE, DELETE ON Tools to ranked_member;
GRANT SELECT, INSERT, UPDATE, DELETE ON Items to ranked_member;
GRANT SELECT ON Loadout to ranked_member;
GRANT SELECT ON Vehicle to ranked_member;
GRANT SELECT ON Buddy to ranked_member;
GRANT SELECT ON BigBoss to ranked_member;
GRANT SELECT ON Espionage to ranked_member;
GRANT SELECT ON Missions to ranked_member;
GRANT SELECT ON SideOps to ranked_member;
GRANT SELECT ON Challenges to ranked_member;

GRANT SELECT, UPDATE ON StaffManagement to staff_member;
GRANT SELECT ON Skills to staff_member;
GRANT SELECT, UPDATE ON Command_Support to staff_member;
GRANT SELECT, UPDATE ON Research_BaseDevelopment to staff_member;
GRANT SELECT ON MotherBase to staff_member;
GRANT SELECT ON Resources to staff_member;
GRANT SELECT ON Equipment to staff_member;
GRANT SELECT ON PrimaryWeapons to staff_member;
GRANT SELECT ON SecondaryWeapons to staff_member;
GRANT SELECT ON SupportWeapons to staff_member;
GRANT SELECT ON Items to staff_member;
GRANT SELECT ON Tools to staff_member;
GRANT SELECT ON Loadout to staff_member;
GRANT SELECT ON Vehicle to staff_member;
GRANT SELECT ON Buddy to staff_member;
