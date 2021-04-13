	USE master
GO
if exists (select * from sysdatabases where name='EcoDorp') ----Uses sysdatabases And master to check if EcoDorp already exists and drops it if it does.
		drop database EcoDorp
go

	---Creates Database DBAirline

DECLARE @device_directory NVARCHAR(520)
SELECT @device_directory = SUBSTRING(filename, 1, CHARINDEX(N'master.mdf', LOWER(filename)) - 1)
FROM master.dbo.sysaltfiles WHERE dbid = 1 AND fileid = 1

EXECUTE (N'CREATE DATABASE EcoDorp
  ON PRIMARY (NAME = N''EcoDorp'', FILENAME = N''' + @device_directory + N'EcoDorp.mdf''),
  FILEGROUP SECONDARY(NAME = N''EcoDorp_Backup'', FILENAME = N''' + @device_directory + N'EcoDorp_Backup.ndf'')
  LOG ON (NAME = N''EcoDorp_log'',  FILENAME = N''' + @device_directory + N'EcoDorp.ldf'')')
go

ALTER DATABASE EcoDorp SET AUTO_SHRINK ON 
ALTER DATABASE EcoDorp SET RECOVERY SIMPLE
GO


	SET QUOTED_IDENTIFIER ON
	go

	SET ANSI_NULLS ON
    go

	use EcoDorp
	go

	----Tables

	CREATE TABLE Users
	(
	UserID int NOT NULL identity(1,1)  PRIMARY KEY,
	User_First_name varchar(50) NOT NULL,
	User_Last_name varchar(50) NOT NULL,
	UserStatus varchar(50) Not NULL,
	Email_Address varchar(50) NOT NULL,
	Login_Date DateTime Not Null
	);
	go

	Create Table SensorData
	(
	SensorID int NOT NULL identity(1,1)  PRIMARY KEY,
	RoomType varchar(50) NOT NULL,
	DT  DateTime NOT NULL,
	Relitive_Humidity Float NOT NULL,
	PM2_5 Float NOT NULL,
	TVOC int NOT NULL, 
	CO2 int NOT NULL, 
	CO int NOT NULL, 
	AirPressure Float NOT NULL,
	Ozone int NOT NULL, 
	NO2 Float NOT NULL,
	VirusIndex int NOT NULL,
	);
	go

	CREATE TABLE UsersHealthCondition
	(
	UserID int NOT NULL identity(1,1) FOREIGN KEY (UserID) REFERENCES Users(UserID),
	Condition varchar(50) NOT NULL,
	);
	go

	CREATE TABLE UsersSensorData
	(
	UserID int NOT NULL identity(1,1) FOREIGN KEY (UserID) REFERENCES Users(UserID),
	SensorID int NOT NULL FOREIGN KEY (SensorID) REFERENCES SensorData(SensorID),
	);
	go

	CREATE TABLE AQIndex
	(
	AQIndex int NOT NULL identity(1,1)  PRIMARY KEY,
	SensorID int NOT NULL FOREIGN KEY (SensorID) REFERENCES SensorData(SensorID),
	);
	go

	CREATE TABLE Suggestion
	(
	UserID int NOT NULL  FOREIGN KEY (UserID) REFERENCES Users(UserID),
	Advice varchar(255) NOT NULL,
	AQIndex int NOT NULL  FOREIGN KEY (AQIndex) REFERENCES AQIndex(AQIndex),
	AdviceID int NOT NULL identity(1,1) PRIMARY KEY,
	);
	go

	CREATE TABLE UserSuggestion
	(
	UserID int NOT NULL identity(1,1) FOREIGN KEY (UserID) REFERENCES Users(UserID),
	AdviceID int NOT NULL  FOREIGN KEY (AdviceID) REFERENCES Suggestion(AdviceID),
	);
	go

	CREATE TABLE SuggestionAQI
	(
	UserID int NOT NULL  FOREIGN KEY (UserID) REFERENCES Users(UserID),
	Advice varchar(255) NOT NULL,
	AQIndex int NOT NULL FOREIGN KEY (AQIndex) REFERENCES AQIndex(AQIndex),
	AdviceID int NOT NULL identity(1,1) FOREIGN KEY (AdviceID) REFERENCES Suggestion(AdviceID),
	);
	go

	---
	
	 CREATE  INDEX "User_First_name" ON "dbo"."Users"("User_First_name")
GO
 
 	CREATE  INDEX "SensorID" ON "dbo"."SensorData"("SensorID")
GO

 	CREATE  INDEX "UserID" ON "dbo"."UsersHealthCondition"("UserID")
GO

	CREATE  INDEX "UserID" ON "dbo"."UsersSensorData"("UserID")
GO

	CREATE  INDEX "AQIndex" ON "dbo"."AQIndex"("AQIndex")
GO

CREATE  INDEX "AdviceID" ON "dbo"."Suggestion"("AdviceID")
GO

CREATE  INDEX "UserID" ON "dbo"."UserSuggestion"("UserID")
GO
CREATE  INDEX "AdviceID" ON "dbo"."SuggestionAQI"("AdviceID")
GO


