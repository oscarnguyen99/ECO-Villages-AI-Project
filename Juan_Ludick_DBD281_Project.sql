		USE master
GO
if exists (select * from sysdatabases where name='DBAirline') ----Uses sysdatabases And master to check if DBAirline already exists and drops it if it does.
		drop database DBAirline
go
	
	

	---Creates Database DBAirline

DECLARE @device_directory NVARCHAR(520)
SELECT @device_directory = SUBSTRING(filename, 1, CHARINDEX(N'master.mdf', LOWER(filename)) - 1)
FROM master.dbo.sysaltfiles WHERE dbid = 1 AND fileid = 1

EXECUTE (N'CREATE DATABASE DBAirline
  ON PRIMARY (NAME = N''DBAirline'', FILENAME = N''' + @device_directory + N'DBAirline.mdf''),
  FILEGROUP SECONDARY(NAME = N''DBAirline_Backup'', FILENAME = N''' + @device_directory + N'DBAirline_Backup.ndf'')
  LOG ON (NAME = N''Northwind_log'',  FILENAME = N''' + @device_directory + N'DBAirline.ldf'')')
go

ALTER DATABASE Northwind SET AUTO_SHRINK ON 
ALTER DATABASE Northwind SET RECOVERY SIMPLE
GO


	SET QUOTED_IDENTIFIER ON
	go

	SET ANSI_NULLS ON
    go



	--Create database DBAirline
	--ON Primary
	--( name =DBAirline,
	--FileName ='\\DBAirline.mdf',
	--size =12mb,
	--MAXSIZE = unlimited,
	--FILEGROWTH = 10% 
	--),
	--FILEGROUP SECONDARY
	--(
	--Name = DBAirline_Backup,
	--Filename = '\\DBAirline_Backup.ndf',
	--Size = 20MB,
	--MAXSIZE = unlimited,
	--FILEGROWTH = 10% 
	--)
	--LOG ON
	--(
	--Name = DBAirline_Log,
	--Filename = '\\DBAirline.ldf',
	--Size = 10MB,
	--MAXSIZE = 1GB,
	--FILEGROWTH = 5MB
	--);
	--go




	use DBAirline
	go

	----Tables

	CREATE TABLE Customers
	(
	customer_id int NOT NULL identity(1,1)  PRIMARY KEY,
	customer_First_name varchar(50) NOT NULL,
	customer_Last_name varchar(50) NOT NULL,
	ID_Number varchar(13) unique not null,
	Gender varChar(1) not null Default('U'),
	Email_Address varchar(320),
	Phone varchar(25) Not Null
	
	
	);
	go

	CREATE TABLE Bookings
	(
	Booking_ID int NOT NULL identity(1,1)  Primary key,
	Flight_Details varchar(50) not null,
	Seat_Number int unique not null,
	Price money not null,
	Customer_ID int NOT NULL  Foreign KEY References Customers(Customer_ID)
	);
	go



	CREATE TABLE Waiting_List
	(
	Waiting_ID int Not Null identity(1,1)  PRIMARY KEY,
	Booking_ID int NOT NULL  Foreign key references Bookings(Booking_ID)
	);
	go

	CREATE TABLE Planes
	(
	Plane_id int NOT NULL identity(1,1)  PRIMARY KEY,
	Plane_name varchar(50) NOT NULL,
	Plane_model varchar(50) Not null,
	);
	go

	alter table planes
	add trips int not null Default(0)

	go


	Create TABLE Services_
    (
	Service_id int NOT NULL identity(1,1) Primary KEY,
	service_Details char(50) NOT NULL
	
	);

	go





	CREATE TABLE Employees
	(
	Employee_id int NOT NULL identity(1,1) PRIMARY KEY,
	First_name varchar(50) NOT NULL,
	Last_name varchar(50) NOT NULL,
	Title varchar(50) Not null,
	Phone varchar(25) Not Null,
	Gender varChar(1) Default('U'),
	ID_Number varchar(13) unique not null,
	salary money not null,
	

	);
	go

	CREATE TABLE Emp_schedule
	(
	Employee_Flight_id int not null  identity(1,1) Primary key,
	Flight_Details varchar(50) not null,
	Time_of_Departure datetime,
	Time_of_arrival datetime,
	Employee_id int not null Foreign key References Employees(Employee_id),
	);
	go

	CREATE TABLE Maintenance
	(
	Maintenance_id int NOT NULL identity(1,1)  PRIMARY KEY,
	Employee_ID int not null Foreign key references Employees(Employee_id),
	Plane_ID int not null Foreign key references Planes(Plane_id),
	Maintenance_Last_performed datetime,
	Maintenance_Cost money not null
	);
	go

	CREATE TABLE Employee_services
	(
	Service_id int NOT NULL Foreign key references Services_(service_id),
	Employee_ID int not null Foreign key references Employees(Employee_id),
	Service_Availability Varchar(30) not null,
	
	);

	go

	CREATE TABLE Flight
	(
	Flight_id int NOT NULL identity(1,1)  PRIMARY KEY,
	Flight_Location varchar(50) not null,
	Booking_ID int NOT NULL   Foreign KEY References Bookings(Booking_ID),
	Employee_Flight_id int not null   Foreign key References emp_schedule(Employee_Flight_Id),
	Plane_ID int NOT NULL   foreign key references Planes(Plane_id),
	Time_of_Departure datetime,
	Time_of_arrival datetime
	
	);


	
	go
	

	---Security
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------




 use DBAirline
go

Create LOGIN User_login1 with Password ='Password'
go


use DBAirline
go

Create User user1 for Login User_login1
go

Create LOGIN Emp_login1 with Password ='Password'
go


use DBAirline
go

Create User Employee_1 for Login Emp_login1
go





 	Create Schema Usr Authorization dbo
	GO


	 go

	 	 use DBAirline
	go
	     Alter Schema Usr transfer [dbo].[Customers]
	 go

	 	 use DBAirline
	 go
	     Alter Schema Usr transfer [dbo].[Bookings]
	 go

	   Alter Schema Usr transfer [dbo].[Waiting_List]
	 go
	 	 
	 use DBAirline
	go

	 Create Role Managers Authorization dbo
	 GO


	 Grant Select, Update,Insert,Delete,Execute on Schema :: dbo to Managers
	 go


	 Alter role Managers 
	 Add Member Employee_1
	 go

	  Create Role Users Authorization dbo
	 GO


	 Grant Select, Update,Insert on Schema :: Usr to Users
	 go

	 Deny Update on table ::  to Users
	 go

	 Alter role Users 
	 Add Member user1 
	 go

	 CREATE  INDEX "Title" ON "dbo"."Employees"("Title")
GO
 
 	CREATE  INDEX "Plane_model" ON "dbo"."Planes"("Plane_model")
GO

 	CREATE  INDEX "Booking_ID" ON "Usr"."Bookings"("Booking_ID")
GO

	CREATE  INDEX "Customer_ID" ON "Usr"."Bookings"("Customer_ID")
GO





 --Population
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


  ---INSERTS INTO Planes
  use DBAirline
  go

 Insert into Planes(Plane_model,Plane_name,trips)

 Values('787-9 1/400','Aeromexico Boeing',5),
       ('A350-900','Airbus A380 House Livery',4),
	   ('A340-500',' Airbus',8),
	   ('A340-600',' Airbus',10),
	   ('747-8','Boeing',7),
	    ('A380plus','Airbus',1)
	  
go
	  
  use DBAirline
  go

 Select * from Planes
 go


 ---Insert into customers
 USE [DBAirline]
GO

INSERT INTO [Usr].[Customers]
           ([customer_First_name]
           ,[customer_Last_name]
           ,[ID_Number]
           ,[Gender]
		   ,[Email_Address]
           ,[Phone]
           
           )
     VALUES
         ('Juan','Ludick','9812225055083','U','ludickjuan@gmail.com','0845879611'

	),
	('Kurt','Nobrain','2001014800086','M','exleadsingerofaband@gmail.com','0123544201'

	),
	('Martin','Leather','2001015800085','M','deadactivistlol123@gmail.com','0554689212'
	
	),
	('Sia','Furler','2009055800089','U','theunkonownartistwithwhitehair@gmail.com','0346595468'

	),
	('Corey','Taylor','2910055800088','M','ihavetwobandslol@gmail.com','03216496854'

	),
	('Sean','Mendalev','2912065659088','M','imdatingalatinafromagirlgroupthatbrokeup@gmail.com','0369459865'
	
	),
	('Azure','Auraelia','2902105659085','F','bruhwhyisthismyname@gmail.com','0996641379'

	),
	('Danielle','Cannot','2909075800086','F','yahoo@gmail.com','0465269852'

	),
	('James','Moriaty','5406175800089','M','gotkilkledbymynemisislol@gmail.com','0776653321'


	),
	('Sherlock','Holmies','9904195800085','M','ikilledmynemisislol@gmail.com','0699666993'


	),
	('Cindy','Ludick','9909094800185','U','Cindyludick@gmail.com','0845879611'


	)

	
GO

Select * from [Usr].[Customers]

---INSERT TO Bookings
  
  USE [DBAirline]
GO



	DECLARE @RandomDate datetime
DECLARE @fromDate datetime = '2018-04-07'

SELECT 
    @RandomDate = (DATEADD(day, ROUND(DATEDIFF(day, @fromDate, @fromDate) 
* RAND(CHECKSUM(NEWID())), 5), DATEADD(second, CHECKSUM(NEWID()) % 24000, @fromDate))) 

	INSERT INTO [Usr].[Bookings]
			   ([Flight_Details]
			   ,[Seat_Number]
			   ,[Price],
			   [Customer_ID]
			   )
		 VALUES
			   ('FL911',70,420,1
			  ),
				('FLSeptemberBravo',69,420,2
			  ),
				('FLRomeoAlpha',40,420,3
			  ),
				('FLAlphaOne',13,550,4
			  ),
				('FLCorona',22,676,5
			  ),
				('FLNovemberBeta',14,778,6
			  ),
				('FLDeltaNine',7,980,7
			  ),
			  ('FLBetaBlackWater',5,1000,8
			  )


GO

Select *from [Usr].[Bookings]
go


 ---INSERTS INTO EMPLOYEES

  use DBAirline
  go

	Insert into Employees(First_name,Last_name,Title,Phone,Gender,ID_Number,salary) 
	Values
	('Tiaan','Jacobs','Pilot','0823328491','U','9912225055083',60000

	),
	('Etienne','Hores','Pilot','0845879611','U','3946962490402',20000

	),
	('Jason','Boniface','Pilot','0123456789','U','1462111129407',60000
	
	),
	('Robert','Patterson','Pilot','0987654321','M','0674876976495',32000

	),
	('Regina','Wajowski','Pilot','0123987654','F','6788270075087',60000

	),
	('Willy','Stroker','Pilot','0665452218','U','1436854587986',17500
	
	),
	('Jeanette','Doe','Pilot','0125948821','F','4575598299627',55000

	),
	('Lovemore','Sibanda','Pilot','0823328491','M','5851339213953',45000

	),
	('Charles','Beckham','Steward','0331568459','M','1543561567508',12500


	),
	('Tina','Turner','Steward','0225659999','F','7244585655784',19000


	),
	('Ma','Madea','Steward','01236549281','U','5605962638125',12000


	),
	('George','Bush','Steward','0147539645','M','6576882616271',10000


	),
	('Trevor','Jones','Steward','0357459663','M','6504729765145',17500


	),
	('Nina','Roberts','Steward','0115456699','F','0495973518271',16000


	),
	('Johan','Ramaphosa','Steward','0420696885','M','3046993311556',13000


	),
	('Christopher','Robin','Steward','0556453521','M','8420436718594',13500


	),
	('Winnie','Pooh','Steward','0112526965','F','4380335231367',22000


	),
	('Kim','Jonson','Steward','0653266321','U','9275094656419',14500


	),
	('Abe','Helfer','Steward','0159688512','M','0191053117382',15800


	),
	('Ghengis','Khan','Steward','0229865321','U','0474657596214',10000


	),
	('Atilla','Hunterson','Steward','0698856612','F','7717191075653',16950


	),
	('Vlad','Tepesche','Steward','0365421548','M','7493303075529',11111


	),
	('Joan','Arch','Steward','0825478642','F','3574806076108',20000


	),
	('Dorothy','Oz','Steward','0465791358','F','6372302932209',12050


	),
	('Belle','Delphine','Steward','0225481986','U','1180115975672',11690


	),
	('Yoda','Layhehoo','Steward','0652159865','M','4409209150778',18500


	),
	
	('Freddie','Fasbear','Steward','0552569845','U','6474928961505',14000


	),
	('Stephan','Notwakin','Steward','0569851249','U','3208071444198',20000


	),
	('Gabe','Itches','Steward','0776549812','F','3055532216133',16540


	),
	('Fredd','Le Staire','Steward','0691256432','M','7010024867675',19000


	),
	('Jacob','Zoomer','Steward','0543689451','M','7627878324786',21000


	)
	,
	('Fixer','Uupper','Maintenance','0682496426','M','2916745735572',20000


	),
	('Ben','Lauden','Maintenance','0396584621','M','6686309147466',25000


	),
	('El','Quisha','Maintenance','0122588462','F','5420306710653',30000


	),
	('Ei','Cys','Maintenance','0689463312','U','9152472205653',35000


	)
	go


	Select * 
	from Employees
	
	go

	---Insert into Emp_schedule
	DECLARE @RandomDate datetime
DECLARE @fromDate datetime = '2018-04-07'

SELECT 
    @RandomDate = (DATEADD(day, ROUND(DATEDIFF(day, @fromDate, @fromDate) 
* RAND(CHECKSUM(NEWID())), 5), DATEADD(second, CHECKSUM(NEWID()) % 24000, @fromDate))) 



	Insert into Emp_schedule(Employee_id,Flight_Details,Time_of_Departure,Time_of_arrival)
	Values    (1,'FL911',@RandomDate,@RandomDate+1
			  ),
				(5,'FLSeptemberBravo',@RandomDate ,@RandomDate +0.99
			  ),
				(6,'FLRomeoAlpha',@RandomDate -0.5,@RandomDate 
			  ),
				(12,'FLAlphaOne',@RandomDate ,@RandomDate +1.52 
			  ),
				(9,'FLCorona',@RandomDate -1 ,@RandomDate 
			  ),
				(18,'FLNovemberBeta',@RandomDate-2 ,@RandomDate 
			  ),
				(22,'FLDeltaNine',@RandomDate -3 ,@RandomDate 
			  ),
			  (30,'FLBetaBlackWater',@RandomDate+0.01 ,@RandomDate +0.02
			  )

	go



	Select * from Emp_schedule
	go


	---Insert into Maintenance
		DECLARE @RandomDate datetime
DECLARE @fromDate datetime = '2018-04-07'

SELECT 
    @RandomDate = (DATEADD(day, ROUND(DATEDIFF(day, @fromDate, @fromDate) 
* RAND(CHECKSUM(NEWID())), 5), DATEADD(second, CHECKSUM(NEWID()) % 24000, @fromDate))) 



	Insert into Maintenance(Employee_ID,Plane_ID,Maintenance_Last_Performed,Maintenance_Cost)
	Values(32,1,@RandomDate+2,4000),
	      (34,2,@RandomDate+3,5000),
		  (33,6,@RandomDate-4,13000),
		  (35,2,@RandomDate,3000),
		  (32,3,@RandomDate-1,4000)
	
	go


Select * from Maintenance
	go


	---Insest into Services
	Insert into Services_(service_Details)
	Values('Sales'),
	      ('Food_Distribution'),
		  ('Safety'),
		  ('Entertainment'),
		  ('Cleaning')

	go


	---Insest into Employee Services
	insert into Employee_services(Employee_ID,Service_id,Service_Availability)
	Values(9,5,'Avalable'),
	      (10,5,'Avalable'),
		  (13,5,'Avalable'),
		  (15,5,'Avalable'),
		  (11,4,'Avalable'),
		  (12,3,'Avalable'),
		  (14,3,'Avalable'),
		  (14,2,'Avalable'),
		  (16,2,'Avalable'),
		  (18,2,'Avalable'),
		  (17,1,'Avalable'),
		  (20,1,'Avalable'),
		  (19,1,'Avalable')

	go
	
	----INSERT INTO FLIGHT
	
	DECLARE @RandomDate datetime
DECLARE @fromDate datetime = '2018-04-07'

SELECT 
    @RandomDate = (DATEADD(day, ROUND(DATEDIFF(day, @fromDate, @fromDate) 
* RAND(CHECKSUM(NEWID())), 5), DATEADD(second, CHECKSUM(NEWID()) % 24000, @fromDate))) 

	insert into Flight(Booking_ID,Flight_Location,Plane_ID,Employee_Flight_id,Time_of_Departure,Time_of_arrival)
	Values(1,'New_York',1,1,@RandomDate,@RandomDate),
	      (3,'South_Africa',1,2,@RandomDate,@RandomDate),
		  (4,'Turkmenistan',4,3,@RandomDate,@RandomDate),
		  (1,'New_York',1,9,@RandomDate,@RandomDate),
		  (4,'Turkmenistan',4,4,@RandomDate,@RandomDate),
		  (6,'Istanbul',5,5,@RandomDate,@RandomDate),
		  (6,'Istanbul',5,6,@RandomDate,@RandomDate),
		  (5,'Japan',6,8,@RandomDate,@RandomDate)
	go 


	---Views:



	---The view to see all the customer bookings and flights
Create view VCustomer_Booking
as
 Select b.Booking_ID,cus.customer_First_name,Cus.customer_Last_name,cus.Gender,b.Flight_Details,Price,f.Flight_Location,f.Time_of_Departure,f.Time_of_arrival,f.Plane_ID
from [Usr].[Bookings] b inner join [Usr].[Customers] cus on cus.customer_id=b.Booking_ID
                inner join Flight f  on b.Booking_ID =f.Booking_ID
Where b.[Customer_ID]  in(Select customer_id from [Usr].[Customers] ) and b.Booking_ID in(Select Booking_ID from Flight)

go

Select * from [dbo].[VCustomer_Booking]
go


---To see all the employees on each flight and what services they offer
use DBAirline
go

Create view VEmp_Flight
as
Select E.Employee_id,E.First_name,E.Last_name,Esv.Service_id,S.service_Details,Esv.Service_Availability,es.Employee_Flight_id,es.Flight_Details,Es.Time_of_Departure,Es.Time_of_arrival
from Employees E inner join Emp_schedule Es on E.Employee_id=Es.Employee_id
                 inner join  Flight f on Es.Employee_Flight_id=f.Employee_Flight_id
				 inner join   Employee_services Esv on E.Employee_id =Esv.Employee_ID
				 inner join    Services_ S on esv.Service_id=S.Service_id
Where E.[Employee_id]  in(Select Employee_id from Emp_schedule ) and Es.Employee_Flight_id  in(Select f.[Employee_Flight_id]  from Flight) and 
      E.[Employee_id]  in(Select Employee_id from Employee_services ) And Esv.[Service_id] in (Select Service_id from Services_)
go

Select * from [dbo].[VEmp_Flight]
go


----View to see all the costs



Create view Vcost
as
Select Sum(Price) as'Total_Income_of_tickets',Sum(salary) as'Total_Salaries_paid',Sum(Maintenance_Cost) as'Total_Maintenance_Cost',Sum(Price-(salary+Maintenance_Cost)) As 'Total_ made_or_lost',Maintenance_Last_performed
From [Usr].[Bookings] b inner join Flight f on b.Booking_ID = f.Booking_ID
                inner join Emp_schedule Esc on f.Employee_Flight_id=Esc.Employee_Flight_id
				inner join Employees E on E.Employee_id=Esc.Employee_id
				inner join Maintenance M on E.Employee_id=M.Employee_ID 
Where b.Booking_ID in (Select Booking_ID from Flight) And E.Employee_id in(Select Employee_ID from Emp_schedule) And E.Employee_id in(Select Employee_ID from Maintenance)

group by Maintenance_Last_performed
go

Select * from [dbo].[Vcost]
go


----View TO see all Customers That are in the waiting table
Create view VCustomer_Wait
AS
Select c.customer_id,c.customer_First_name,c.customer_Last_name,b.Booking_ID,wl.Waiting_ID
from [Usr].[Customers] c inner join [Usr].[Bookings] b on c.customer_id=b.Customer_ID
                 inner join [Usr].[Waiting_List] wl on wl.Booking_ID=b.Booking_ID
Where b.Booking_ID in (Select Booking_ID from [Usr].[Waiting_List]) or b.Booking_ID is null
go

Select * from [dbo].[VCustomer_Wait]
go


-----View to see all planes and their maninance and the employees who did the mantanance
Create view Vplane
AS
Select  P.Plane_id,p.Plane_model,p.Plane_name,p.trips as 'Trips Made',M.Maintenance_id,M.Maintenance_Cost,M.Maintenance_Last_performed,M.Employee_ID,E.First_name+' '+E.Last_name as 'Full Name'
From Planes p inner join Maintenance M on p.Plane_id =M.Plane_ID
              inner join Employees E on E.Employee_id=M.Employee_ID
			  Where E.Employee_ID in(Select Employee_ID from Maintenance) and p.Plane_ID in (Select Plane_id from Maintenance)
go

Select * from [dbo].[Vplane]
go


------ EMployee and their Schedules
Create view VEMP_Sch
AS
Select E.Employee_id,E.First_name,E.Last_name,E.Title,ES.Employee_Flight_id,ES.Flight_Details,ES.Time_of_arrival,ES.Time_of_Departure
From Employees E inner join Emp_schedule ES on E.Employee_id=ES.Employee_id
Where E.Employee_id in (Select Employee_id from Emp_schedule)

go

Select * from [dbo].[VEMP_Sch]
go


Create view vEmployee_Pilot
AS
Select * from Employees
Where Title like 'Pilot'

go

Select * from  
[dbo].[vEmployee_Pilot]
go

Create view vEmployee_Steward
AS
Select * from Employees
Where Title like 'Steward'

go

Select * from  
[dbo].[vEmployee_Steward]
go




Create view vEmployee_Maintenance
AS
Select * from Employees
Where Title like 'Maintenance'

go

Select * from  
[dbo].[vEmployee_Maintenance]
go


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---Procedures:



---To insert parameterised values
Create procedure pBook       --This is a procedure that inserts into the bookings table By getting the values from the user.It was working but it started to bug out so i don't know how to fix it 
(@FlightDetails varchar(30),
@SeatNum int,
@Price money,
@CusID int )
AS
Begin
		DECLARE @RandomDate datetime
DECLARE @fromDate datetime = '2018-04-07'

SELECT 
    @RandomDate = (DATEADD(day, ROUND(DATEDIFF(day, @fromDate, @fromDate) 
* RAND(CHECKSUM(NEWID())), 5), DATEADD(second, CHECKSUM(NEWID()) % 24000, @fromDate))) 



Insert into [Usr].[Bookings](Customer_ID,Flight_Details,Price,Seat_Number)
Values(@CusID,@FlightDetails,@Price,@SeatNum)
End

go




---Procedure to display VCustomer_Booking
Create Procedure pVcustomer_BooKing
AS
Begin
Declare @Cname varchar(30),@CLname varchar(30),@Gender varchar(1),@FD varchar(30),@FLocation varchar(30)

 Select @Cname= customer_First_name,@CLname= customer_Last_name,@Gender=Gender,@FD=Flight_Details,@FLocation=Flight_Location
from [dbo].[VCustomer_Booking]

Print 'Name: '+@Cname+'-------'+'Surname: '+@CLname+'------'+'Gender: '+@Gender+'--------'+'Flight_Details: '+@FD+'----------'+'Flight_Location: '+@FLocation


End
go

execute pVcustomer_BooKing
go





--Procedure to delete A booking
create proc pDElBooking                                           --This is an automated procedure that deletes a booking from the booking table 
(@Bid int)
AS
Begin
Delete [Usr].[Bookings] where [Usr].[Bookings].Booking_ID=@Bid
End

---------------------------------------------The procedure was working and then it just stopped so i dont't know what is it's problem




exec pBook 'FlNewBlue',29,720,8 ---TO insert  into Bookings as a User


Insert into [Usr].[Bookings](Customer_ID,Flight_Details,Price,Seat_Number)
Values(10,'FlNewBlue',720,6)

select * from [Usr].[Bookings]
Go


---Triger on booking
Create trigger tBooking
ON [Usr].[Bookings]
for insert
AS 
  BEGIN
	Declare @NumBookings int =( Select COUNT(Bookings.Customer_ID) from [Usr].[Bookings])
Declare @BKnum int,@count int=0
Print @NumBookings
                              -----------------------I created a Trigger that both inserts,truncates the waiting list and also deletes the record from bookings.
if @NumBookings<10
Begin
Print 'Success'

end
Else
Begin
Select @NumBookings=COUNT(Booking_ID) From [Usr].[Bookings] 
SET @BKnum =@NumBookings


Insert into [Usr].[Waiting_List](Booking_ID)
Values(@BKnum)

Select @count=Count(Waiting_ID) from [Usr].[Waiting_List]


if @count =10
begin
Truncate table [Usr].[Waiting_List]


end

Print 'Fail'
Select * from [Usr].[Waiting_List]



BEGIN TRY 


exec pDElBooking @BKnum
end try 

BEGIN catch
Print'There is a desyncnorization of Primary and foreign Key values if you execute pDElBooking'
end catch 

End 
  END




GO



	select *
		From Usr.Customers
	go





Create proc pInEmp  --Procedure_INsert_Employee  
	(@First_name varchar(20),
	@Last_name varchar(20),
	@Title varchar(20),
	@Phone varchar(10),
	@Gender varchar(1),
	@ID_Number varchar(13),
	@salary money)
AS
Begin
    


	

		if @Gender is null OR @Gender !='M' AND @Gender !='F' And @Gender !='U'
		   begin
		   Set @Gender='U'
		   End

		   if @ID_Number not in (Select ID_Number from [dbo].[Employees])
		   begin

			 Insert Into [dbo].[Employees](First_name,Last_name,Title,Phone,Gender,ID_Number,salary)
			 Values(@First_name,@Last_name,@Title,@Phone,@Gender,@ID_Number,@salary)

			  End
			  else
			  begin
			  Print 'It already exists'
			  End


	 Select *  from [dbo].[Employees] 
ENd

---'Barrac','Obama','Pilot','0740692979','G','64125257854024',38000

Exec pInEmp 'Steve','Jobs','Pilot','0770892979','G','64123657854024',38050
go





----Procedure to Update employees
create proc pUPEmp 
	(@Emp_ID int,
	@First_name varchar(20),
	@Last_name varchar(20),
	@Title varchar(20),
	@Phone varchar(10),
	@Gender varchar(1),
	@ID_Number varchar(13),
	@salary money)
AS
Begin
    
	

	

		if @Gender is null OR @Gender !='M' AND @Gender !='F' And @Gender !='U'
		   begin
		   Set @Gender='U'
		   End

		  

			 Update [dbo].[Employees]
			 Set First_name=@First_name,Last_name=@Last_name,Title=@Title,Phone=@Phone,Gender=@Gender,salary=@salary
			 Where @Emp_ID = Employee_id

			 
			


	 Select *  from [dbo].[Employees] 
End



go

 Select *  from [dbo].[Employees] 
Exec pUPEmp 37,'Steve','Jobs','Pilot','0770892979','G','64123657854024',38000
go






----Procedure to Update Customers  
create proc pUPCUS 
	(@Cus_ID int,
	@First_name varchar(20),
	@Last_name varchar(20),
	@ID_Number varchar(13),
	@Gender varchar(1),
	@Email Varchar (320),
	@Phone varchar(10)
	)
AS
Begin
    
	

	

		if @Gender is null OR @Gender !='M' AND @Gender !='F' And @Gender !='U'
		   begin
		   Set @Gender='U'
		   End

		  

			 Update [Usr].[Customers]
			 Set customer_First_name=@First_name,customer_Last_name=@Last_name,ID_Number=@ID_Number,Gender=@Gender,Email_Address=@Email,Phone=@Phone
			 Where @Cus_ID = customer_id

			 
			


	  Select *  from [Usr].[Customers]
End



go


Exec pUPCUS 9,'Steve','Wozniak','64123657854024','G','GotRobbedByJobs@gmail.com','0760492379'
go




----Procedure to Insert into Planes  
create proc pINPlane 
	(
	@Plane_name varchar(20),
	@Plane_model varchar(20),
	@trips int
	
	)
AS
Begin
    


			 Insert into [dbo].[Planes](Plane_name,Plane_model,trips)
			 Values( @Plane_name,@Plane_model,@trips)
			 

			 
			


	  Select *  from [dbo].[Planes]
End



go


Exec pINPlane' AirTaxi','A340-550',9
go







----Procedure to Update Planes  
create proc pUPPlane 
	(@Plane_ID int,
	@Plane_name varchar(20),
	@Plane_model varchar(20),
	@trips int
	
	)
AS
Begin
      

			 Update [dbo].[Planes]
			 Set Plane_name=@Plane_name,Plane_model=@Plane_model,trips=@trips
			 Where @Plane_ID = Plane_id

			 
			


	  Select *  from [dbo].[Planes]
End



go


Exec pUPPlane 3,' Airbus','A340-500',9
go



----Procedure to Update Serivces  
create proc pUPPServices 
	(@Service_id int,
	@service_Details varchar(20)	
	)
AS
Begin
      

			 Update [dbo].[Services_]
			 Set service_Details=@service_Details
			 Where @Service_id = Service_id

			 
			


	  Select *  from [dbo].[Services_]
End



go


Exec pUPPServices 3,' Massages'
go



----Procedure to Insert a Serivce  
Create proc pInServices 
	(
	@service_Details varchar(20)	
	)
AS
Begin
      

			 Insert into [dbo].[Services_]
			 Values(@service_Details)

			 
			


	  Select *  from [dbo].[Services_]
End



go


Exec pInServices ' Massages'
go


Create proc pDelService
 (@Service_id int,
 @Employee_ID int
 )
 As
   Begin
    if @Service_id not in (Select Service_id from Services_)
	  Begin
	   Print'=============================================================='
	  Print 'That is not a valid Service ID'
	   Print'=============================================================='
	  End
	  Else if @Employee_ID not in (Select Employee_ID from Employees)
	  Begin
	  PRint'=============================================================='
	  Print 'That is not a valid Employee ID'
	  Print'=============================================================='
	  End
	  else
	  Begin

	   Delete [dbo].[Services_]
	   Where @Service_id=Service_id  

	   Delete [dbo].[Employee_services]
	   Where @Service_id=Service_id


	   Select Employee_ID,Es.Service_id,service_Details,Service_Availability  from [dbo].[Employee_services] Es inner join [dbo].[Services_] s on Es.Service_id=s.Service_id
      end
   End
go

------Employee_ID-----Service_ID
Exec pDelService 5,9
go


----Procedure to Insert a Employee_Serivce  record
Create proc pInEMpServices 
	(@Service_id int,
	@Employee_ID int,
	@Service_Availability varchar(20)	
	)
AS
Begin
      
	  if @Service_id not in (Select Service_id from Services_)
	  Begin
	   Print'=============================================================='
	  Print 'That is not a valid Service ID'
	   Print'=============================================================='
	  End
	  Else if @Employee_ID not in (Select Employee_ID from Employees)
	  Begin
	  PRint'=============================================================='
	  Print 'That is not a valid Employee ID'
	  Print'=============================================================='
	  End
	  else
	  Begin
	  	    Insert into [dbo].[Employee_services](Employee_ID,Service_id,Service_Availability)
			 Values(@Employee_ID,@Service_id,@Service_Availability)
		
		Select Employee_ID,Es.Service_id,service_Details,Service_Availability  from [dbo].[Employee_services] Es inner join [dbo].[Services_] s on Es.Service_id=s.Service_id
		end
End



go
use DBAirline
Go

Exec pInEMpServices 2,65, 'Avalable'
go







----Procedure to Update Employee_Serivces  
Create proc pUPEMPServices 
	(@Service_id int,
	@Employee_ID int,
	@Service_Availability varchar(20)	
	)
AS
Begin
      
	   if @Service_id not in (Select Service_id from Services_)
	  Begin
	   Print'=============================================================='
	  Print 'That is not a valid Service ID'
	   Print'=============================================================='
	  End
	  Else if @Employee_ID not in (Select Employee_ID from Employees)
	  Begin
	  PRint'=============================================================='
	  Print 'That is not a valid Employee ID'
	  Print'=============================================================='
	  End
	  else
	  begin
			 Update [dbo].[Employee_services]
			 Set Employee_ID=@Employee_ID,Service_Availability=@Service_Availability
			 Where @Service_id = Service_id
	 	

			  Select Employee_ID,Es.Service_id,service_Details,Service_Availability  from [dbo].[Employee_services] Es inner join [dbo].[Services_] s on Es.Service_id=s.Service_id

	  end
End



go

-----Service_ID--------Employee_ID--------Avalable/not Avalable

Exec pUPEMPServices 21,6,'Avalable'
go
















--Trigger to check if a employee already exists and if not to  add one
Create trigger trUpdate_Emp 
ON [dbo].[Employees]
After Insert
As
Begin

Declare @count int

Select @count=Count(Employee_id) from [dbo].[Employees]

Select Employee_id,First_name,Last_name from[dbo].[Employees] where Employee_id = @count






End