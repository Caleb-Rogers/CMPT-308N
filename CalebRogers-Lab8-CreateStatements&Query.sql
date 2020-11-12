-- Caleb Rogers -- November 9th, 2020 -- Lab 8: Normalization Two

DROP TABLE IF EXISTS ActorPhysical;
DROP TABLE IF EXISTS MovieSales;
DROP TABLE IF EXISTS MovieCast;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Address;

-- Create Statements --
-- Address --
CREATE TABLE Address (
	zip integer NOT NULL,
	cityOfZip text,
	stateOfZip text,
 PRIMARY KEY(zip)
);

-- People --
CREATE TABLE People (
	pid char(5) NOT NULL,
	firstName text,
	lastName text NOT NULL,
	bday date,
	spouseFn text,
	spouseLN text,
	addr1 text NOT NULL,
	addr2 text,
	zip integer NOT NULL references Address(zip),
 PRIMARY KEY(pid)
);

-- Directors --
CREATE TABLE Directors (
	pid char(5) NOT NULL references People(pid),
	directorAnniDate date,
	directorSchool text,
	favLensMaker text,
 PRIMARY KEY(pid)
);

-- Actors --
CREATE TABLE Actors (
	pid char(5) NOT NULL references People(pid),
	actorAnniDate date,
	favColor text,
 PRIMARY KEY(pid)
);

-- ActorPhysical --
CREATE TABLE ActorPhysical (
	actorID char(5) NOT NULL references Actors(pid),
	eyeColor text,
	hairColor text,
	height integer,
	weight integer,
 PRIMARY KEY(actorID)
);

-- Movies --
CREATE TABLE Movies (
	movieID char(5) NOT NULL,
	movieName text,
	releaseYR integer,
	MPAA integer,
 PRIMARY KEY(movieID)
);

-- MovieCast --
CREATE TABLE MovieCast (
	actorID char(5) NOT NULL references Actors(pid),
	directorID char(5) NOT NULL references Directors(pid),
	movieID char(5) NOT NULL references Movies(movieID),
 PRIMARY KEY(actorID, directorID)
);

-- MovieSales --
CREATE TABLE MovieSales (
	salesID char(5) NOT NULL references Movies(movieID),
	domesticSales integer,
	foreignSales integer,
	DVD_BluRaySales integer,
 PRIMARY KEY(salesID)
);


-- Query to show all the directors with whom actor “Roger Moore” has work --
select firstName,lastName
from people
where pid in (select pid
	      from directors
	      where pid in (select directorID
			    from movieCast
		            where actorID in (select pid
			                      from actors
			                      where pid in (select pid
							    from people
							    where lastName = 'Moore' and firstname = 'Roger'))));
