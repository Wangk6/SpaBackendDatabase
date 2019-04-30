--Kevin Wang
--Backend Spa Database Design

CREATE TABLE tblPServiceName (
	ServiceNameID INT NOT NULL IDENTITY PRIMARY KEY
   ,ServiceName VARCHAR(50) NOT NULL
   ,ServiceDescription VARCHAR(MAX) NOT NULL
);

CREATE TABLE tblPServiceTime (
	ServiceTimeID INT NOT NULL IDENTITY PRIMARY KEY
   ,ServiceNameID INT REFERENCES tblPServiceName (ServiceNameID)
   ,Hours DECIMAL(3, 2) NOT NULL
);

CREATE TABLE tblPServicePrice (
	ServicePriceID INT NOT NULL IDENTITY PRIMARY KEY
   ,ServiceTimeID INT REFERENCES tblPServiceTime (ServiceTimeID)
   ,Price MONEY NOT NULL
);

CREATE TABLE tblPMembershipPackage (
	PackageID INT NOT NULL IDENTITY PRIMARY KEY
   ,ServiceTimeID INT REFERENCES tblPServiceTime (ServiceTimeID)
   ,Quantity INT NOT NULL
   ,Total MONEY NOT NULL
);

CREATE TABLE tblPMembers (
	MemberID INT NOT NULL IDENTITY PRIMARY KEY
   ,FirstName VARCHAR(20) NOT NULL
   ,LastName VARCHAR(20) NOT NULL
   ,DateOfBirth DATE NULL
   ,Phone VARCHAR(20) NOT NULL
   ,Email VARCHAR(40) NULL
   ,Remaining INT NOT NULL
   ,PackageID INT REFERENCES tblPMembershipPackage (PackageID)
);

CREATE TABLE tblPWorkers (
	WorkerID INT NOT NULL IDENTITY PRIMARY KEY
   ,FirstName VARCHAR(20) NOT NULL
   ,LastName VARCHAR(20) NOT NULL
   ,StreetNum VARCHAR(10) NOT NULL
   ,StreetName VARCHAR(40) NOT NULL
   ,StreetName2 VARCHAR(40) NULL
   ,City VARCHAR(30) NOT NULL
   ,State CHAR(2) NOT NULL
   ,Zip CHAR(10) NOT NULL
   ,Phone VARCHAR(12) NOT NULL
   ,Email VARCHAR(40) NULL
   ,DateOfHire DATE NOT NULL
   ,MonthsOfExperience INT NOT NULL
);

CREATE TABLE tblPAppointment (
	AppointmentID INT NOT NULL IDENTITY PRIMARY KEY
   ,FirstName VARCHAR(20) NOT NULL
   ,Phone VARCHAR(12) NOT NULL
   ,ServicePriceID INT REFERENCES tblPServicePrice (ServicePriceID)
   ,NumOfPeople INT NOT NULL
   ,Appt_Date DATETIME NOT NULL
   ,WorkerID INT NULL REFERENCES tblPWorkers (WorkerID)
   ,Status VARCHAR(12) NOT NULL
);

CREATE TABLE tblPServiceLog (
	ServiceLogID INT NOT NULL IDENTITY PRIMARY KEY
   ,AppointmentID INT NULL REFERENCES tblPAppointment (AppointmentID)
   ,FirstName VARCHAR(20) NULL
   ,Phone VARCHAR(12) NULL
   ,TimeStarted DATETIME NOT NULL DEFAULT GETDATE()
   ,TimeFinished DATETIME NULL
   ,ServicePriceID INT REFERENCES tblPServicePrice (ServicePriceID)
   ,Room VARCHAR(10) NULL
   ,WorkerID INT NOT NULL REFERENCES tblPWorkers (WorkerID)
   ,PaymentType VARCHAR(15) NULL
   ,MemberID INT NULL REFERENCES tblPMembers (MemberID)
   ,PaidStatus VARCHAR(10) NULL DEFAULT 'UNPAID'
);

CREATE TABLE tblPServiceComplete (
	ServiceCompID INT NOT NULL IDENTITY PRIMARY KEY
   ,AppointmentID INT NULL REFERENCES tblPAppointment (AppointmentID)
   ,FirstName VARCHAR(20) NULL
   ,Phone VARCHAR(12) NULL
   ,TimeStarted DATETIME NOT NULL DEFAULT GETDATE()
   ,TimeFinished DATETIME NOT NULL
   ,ServicePriceID INT REFERENCES tblPServicePrice (ServicePriceID)
   ,Room VARCHAR(10) NOT NULL
   ,WorkerID INT NOT NULL REFERENCES tblPWorkers (WorkerID)
   ,PaymentType VARCHAR(15) NOT NULL
   ,MemberID INT NULL REFERENCES tblPMembers (MemberID)
   ,PaidStatus VARCHAR(10) NOT NULL
);


--Insert Into Tables

INSERT INTO tblPServiceName (ServiceName, ServiceDescription)
	VALUES ('Foot Reflexology', 'Foot massage that works on the critical points on the hands and feet')
	, ('Organic Oil Bodywork', 'A bodywork using soothing natural oils to relax the muscles with hot stone')
	, ('Aromatherapy Bodywork', 'A bodywork with the inhalation and application of pure essential oils with hot stone')
	, ('Combination', 'Foot and bodywork')
	, ('Couple Aromatherapy Bodywork', 'Couples essential oil bodywork with hot stone')
	, ('Stress Relieving Massage', 'Head, scalp & face massage')
	, ('Stomach Massage', 'Stomach massage to help digestion')
	, ('Breast Health Care', 'Woman only - Promotes the blood circulation, protect women breast disease prevention');


INSERT INTO tblPServiceTime (ServiceNameID, Hours)
	VALUES (1, .5)
	, (1, 1)
	, (1, 1.5)
	, (2, .5)
	, (2, 1)
	, (2, 1.5)
	, (2, 2)
	, (3, 1)
	, (3, 1.5)
	, (3, 2)
	, (4, 1)
	, (4, 1.5)
	, (4, 1.25)
	, (5, 1.25)
	, (6, .5)
	, (6, .75)
	, (7, .25)
	, (7, .5)
	, (8, 1.33);

INSERT INTO tblPServicePrice (ServiceTimeID, Price)
	VALUES (1, 20)
	, (2, 30)
	, (3, 48)
	, (4, 30)
	, (5, 55)
	, (6, 75)
	, (7, 95)
	, (8, 65)
	, (9, 85)
	, (10, 105)
	, (11, 50)
	, (12, 75)
	, (13, 95)
	, (14, 140)
	, (15, 35)
	, (16, 45)
	, (17, 20)
	, (18, 35)
	, (19, 80);

INSERT INTO tblPMembershipPackage (ServiceTimeID, Quantity, Total)
	VALUES (2, 6, 160)
	, (6, 3, 210)
	, (5, 6, 290)
	, (9, 3, 240);

INSERT INTO tblPMembers (FirstName, LastName, DateOfBirth, Phone, Email, Remaining, PackageID)
	VALUES ('John', 'Jones', '4-22-1998', '516-555-1111', 'JohnJones@gmail.com', 6, 1)
	, ('Jimmy', 'Carls', '12-13-1994', '516-555-2222', 'Jimmy@gmail.com', 3, 2)
	, ('Chelsea', 'Stevens', '8-18-1993', '516-555-3333', 'Chelsea@gmail.com', 1, 2)
	, ('Jennifer', 'Ray', '1-10-1982', '516-555-4444', 'Jennifer@gmail.com', 4, 3)
	, ('Austin', 'Casa', '2-02-1978', '516-555-5555', 'Austin@gmail.com', 7, 4);

INSERT INTO tblPWorkers (FirstName, LastName, StreetNum, StreetName, City, State, Zip, Phone, Email, DateOfHire, MonthsOfExperience)
	VALUES ('Charles', 'Rayes', '381', 'Kings St', 'Massapequa', 'NY', '11758', '516-551-1111', 'CharlesR@example.com', '5/23/2014', 34)
	, ('Vinny', 'Carlson', '582', 'Queens St', 'Massapequa', 'NY', '11758', '516-551-2222', 'VinnyC@example.com', '2/03/2015', 51)
	, ('Katherine', 'Landa', '391', 'Hollywood St', 'Farmingdale', 'NY', '11754', '631-555-3910', 'Katherine@example.com', '9/21/2017', 25)
	, ('Maggie', 'Lee', '201', 'Chestnut Dr', 'Levitown', 'NY', '11731', '516-093-3928', 'MaggieLe@gmail.com', '8/21/2013', 43)
	, ('Danny', 'Rich', '321', 'Hampton Blvd', 'Garden City', 'NY', '11040', '516-455-5050', 'DannyR@gmail.com', '9/20/2012', 53)
	, ('Driscoll', 'Jimenez', '101', 'Dolor. Rd', 'Fort Worth', 'NY', '43696', '516-970-7249', 'tempor@Maurisnondui.ca', '04/18/2019', 56)
	, ('Destiny', 'Aguirre', '295', 'Dapibus St', 'Athens', 'NY', '59274', '516-991-5348', 'quis.arcu@mienim.ca', '04/02/2019', 54)
	, ('Tarik', 'Le', '154', 'Pellentesque St', 'Lewiston', 'NY', '30733', '516-704-5473', 'Curabitur.egestas.nunc@yahoo.com', '09/15/2019', 34)
	, ('Winifred', 'Hooper', '195', 'Suspendisse Rd', 'Essex', 'NY', '73394', '516-978-7660', 'auctor.odio.a@magnis.net', '11/25/2018', 32)
	, ('Fallon', 'Rice', '207', 'Felis Rd', 'Billings', 'NY', '32042', '516-643-3631', 'arcu@dictumsapienAenean.org', '03/11/2020', 46)
	, ('Rylee', 'Landry', '219', 'Dignissim Ave', 'Jackson', 'NY', '39925', '516-727-6018', 'Nulla.facilisis@famesacturpis.net', '07/04/2019', 60)
	, ('Melodie', 'Brennan', '282', 'Egestas. St', 'Topeka', 'NY', '21139', '516-225-1680', 'eu.arcu@Maecenasiaculisaliquet.edu', '08/11/2018', 47)
	, ('Rooney', 'Craig', '163', 'Dui St', 'Orlando', 'NY', '72498', '516-233-8487', 'parturient.montes.nascetur@Integer.org', '08/27/2018', 48)
	, ('Kennan', 'Mckay', '125', 'Suspendisse Ave', 'West Jordan', 'NY', '42880', '516-970-8963', 'hendrerit.id.ante@luctus.ca', '01/31/2019', 44)
	, ('Harper', 'Holden', '231', '364-4943 Nam St', 'Bellevue', 'NY', '15027', '516-188-8792', 'ligula@posuere.ca', '03/11/2020', 51);

INSERT INTO tblPAppointment (FirstName, Phone, ServicePriceID, NumOfPeople, Appt_Date, WorkerID, Status)
	VALUES ('Alisa', '516-100-1962', 6, 1, '2019-05-06 23:29:15', 1, 'Scheduled')
	, ('Isabelle', '516-611-4765', 11, 1, '2019-04-16 08:03:07', 4, 'Cancelled')
	, ('Kelsie', '516-197-0955', 8, 1, '2019-05-07 03:49:42', 3, 'Scheduled');

INSERT INTO tblPAppointment (FirstName, Phone, ServicePriceID, NumOfPeople, Appt_Date, Status)
	VALUES ('Britanney', '516-891-0271', 19, 4, '2019-04-06 22:30:49', 'Arrived')
	, ('Octavia', '516-234-3769', 14, 3, '2019-04-10 12:43:11', 'Arrived')
	, ('Cullen', '516-156-7634', 7, 2, '2019-04-20 01:21:30', 'Arrived')
	, ('Baxter', '516-714-4028', 5, 5, '2019-05-08 09:43:38', 'Scheduled')
	, ('Jena', '516-571-3130', 7, 3, '2019-05-04 06:11:40', 'Scheduled')
	, ('Yetta', '516-583-7246', 13, 4, '2019-04-21 19:21:00', 'Scheduled')
	, ('Zenia', '516-517-8003', 10, 3, '2019-04-09 15:32:54', 'Arrived');

--Unpaid Customers
INSERT INTO tblPServiceLog (FirstName, Phone, TimeStarted, ServicePriceID, Room, WorkerID, PaidStatus)
	VALUES ('Isaac', '516-967-8448', '2019-09-03 11:45:55', 7, 'Room 2', 11, 'Unpaid')
	, ('Deacon', '516-564-1190', '2019-05-10 11:46:45', 4, 'Room 3', 14, 'Unpaid')
	, ('Mufutau', '516-912-0454', '2018-10-26 12:01:38', 6, 'Foot Area', 10, 'Unpaid')
	, ('Zephania', '516-854-6138', '2018-12-26 12:31:38', 10, 'Foot Area', 1, 'Unpaid')
	, ('Fulton', '516-745-0634', '2019-03-28 13:11:30', 9, 'Room 5', 2, 'Unpaid')
	, ('Nerea', '516-129-0958', '2018-12-02 13:22:25', 11, 'Room 3', 3, 'Unpaid')
	, ('Kai', '516-489-9002', '2019-01-23 14:51:45', 13, 'Room 2', 7, 'Unpaid')
	, ('Nicholas', '516-954-5073', '2019-01-25 15:28:38', 5, 'Room 1', 5, 'Unpaid')
	, ('Walter', '516-144-8506', '2018-05-26 15:35:46', 19, 'Foot Area', 6, 'Unpaid');


--Finished Customers
INSERT INTO tblPServiceComplete (FirstName, Phone, TimeStarted, TimeFinished, ServicePriceID, Room, WorkerID, PaymentType, PaidStatus)
	VALUES ('Ferdinand', '516-695-4408', '2019-04-18 16:37:57', '2019-04-18 15:35:54', 19, 'Room 3', 4, 'Credit', 'Paid')
	, ('Carly', '516-662-1428', '2019-04-18 20:53:36', '2019-04-18 21:50:09', 19, 'Room 2', 15, 'Credit', 'Paid')
	, ('Xavier', '516-241-0203', '2019-04-18 13:59:10', '2019-04-18 15:11:53', 19, 'Room 4', 13, 'Credit', 'Paid')
	, ('Raymond', '516-951-3911', '2019-04-18 10:45:39', '2019-04-18 09:52:41', 7, 'Room 4', 8, 'Credit', 'Paid')
	, ('Xenos', '516-308-6060', '2019-04-18 15:17:57', '2019-04-18 16:29:38', 3, 'Room 6', 13, 'Cash', 'Paid')
	, ('Xaviera', '516-430-0192', '2019-04-18 13:23:24', '2019-04-18 14:49:08', 17, 'Room 1', 1, 'Credit', 'Paid')
	, ('Ezra', '516-233-8944', '2019-04-18 14:20:00', '2019-04-18 15:41:35', 5, 'Room 4', 2, 'Cash', 'Paid')
	, ('Skyler', '516-228-7700', '2019-04-18 19:20:38', '2019-04-18 20:34:58', 1, 'Foot Area', 8, 'Cash', 'Paid')
	, ('Jackson', '516-105-3767', '2019-04-18 11:47:02', '2019-04-18 12:11:00', 10, 'Room 2', 13, 'Cash', 'Paid')
	, ('Ciaran', '516-343-3166', '2019-04-18 11:01:18', '2019-04-18 12:11:00', 14, 'Room 3', 7, 'Credit', 'Paid')
	, ('Clara', '516-444-4949', '2019-04-19 11:10:00', '2019-04-19 12:10:00', 13, 'Room 3', 7, 'Credit', 'Paid');

--Finished Customer Members
INSERT INTO tblPServiceComplete (FirstName, Phone, TimeStarted, TimeFinished, ServicePriceID, Room, WorkerID, PaymentType, MemberID, PaidStatus)
	VALUES ('John', '516-377-7606', '2019-04-18 20:53:36', '2019-04-18 21:50:09', 1, 'Room 3', 6, 'Member', 1, 'Paid')
	, ('Jimmy', '516-725-4394', '2019-04-18 20:53:36', '2019-04-18 21:50:09', 2, 'Room 1', 3, 'Member', 2, 'Paid')
	, ('Chelsea', '516-395-8655', '2019-04-18 20:53:36', '2019-04-18 21:50:09', 3, 'Room 5', 1, 'Member', 3, 'Paid');


--Create a view for price of completed service for reuse
CREATE VIEW vCompleteSPrice
AS
SELECT
	sc.ServiceCompID
   ,sc.AppointmentID
   ,sc.FirstName
   ,sc.Phone
   ,sc.TimeStarted
   ,sc.TimeFinished
   ,sc.Room
   ,sc.WorkerID
   ,sc.PaymentType
   ,sc.MemberID
   ,sc.PaidStatus
   ,sp.ServicePriceID
   ,sp.ServiceTimeID
   ,sp.Price
FROM tblPServiceComplete sc
JOIN tblPServicePrice sp
	ON sc.ServicePriceID = sp.ServicePriceID

--CASE 1:Owner requested that we calculate the total sales at the end of the day, or a week of sales separating customers paying with memberships
CREATE PROCEDURE spDayRevenue @DateStart DATE, @DateEnd DATE
AS
	SELECT
		(SELECT
				'$' + CAST(SUM(cs.Price) AS VARCHAR)
			FROM vCompleteSPrice cs
			WHERE cs.PaymentType != 'Member'
			AND cs.TimeFinished BETWEEN @DateStart AND @DateEnd)
		AS 'Cash & Credit Payment'
	   ,(SELECT
				'$' + CAST(SUM(cs.Price) AS VARCHAR)
			FROM vCompleteSPrice cs
			WHERE cs.PaymentType = 'Member'
			AND cs.TimeFinished BETWEEN @DateStart AND @DateEnd)
		AS 'Member Payment'
	   ,SUM(cs.Price) AS 'Grand Total'
	FROM vCompleteSPrice cs
	WHERE cs.TimeFinished BETWEEN @DateStart AND @DateEnd

	--See the revenue of 4-18
	EXEC spDayRevenue @DateStart = '2019-04-18'
					 ,@DateEnd = '2019-04-19'
	--See the revenue of two days - 4-18 & 4-19
	EXEC spDayRevenue @DateStart = '2019-04-18'
					 ,@DateEnd = '2019-04-20'



	--CASE 2: Owner needs to calculate how much will be paid to the workers for certain times.
	--Workers are paid based on type of service. Foot massage - 30%, every other 45%
Alter PROCEDURE spWorkerPay @DateStart DATE, @DateEnd DATE
AS
		SELECT DISTINCT p.WorkerID, p.FirstName +' '+ p.LastName AS 'Worker Name', '$' + CAST(ISNULL(foot.Total,0) + ISNULL(body.Total,0) AS VARCHAR(10)) AS 'Total Pay'
		FROM tblPWorkers p

		LEFT JOIN ( SELECT
				SUM(cs.Price) AS Total
			   ,cs.WorkerID
			FROM vCompleteSPrice cs
			JOIN tblPWorkers w
				ON cs.WorkerID = w.WorkerID
			WHERE cs.ServicePriceID BETWEEN 1 AND 3 AND cs.TimeFinished BETWEEN @DateStart AND @DateEnd
			GROUP BY cs.WorkerID) foot 
		ON foot.WorkerID = p.WorkerID 

		LEFT JOIN( SELECT
				SUM(cs.Price) AS Total
			   ,cs.WorkerID
			FROM vCompleteSPrice cs
			JOIN tblPWorkers w
				ON cs.WorkerID = w.WorkerID
			WHERE cs.ServicePriceID BETWEEN 4 AND 19 AND cs.TimeFinished BETWEEN @DateStart AND @DateEnd
			GROUP BY cs.WorkerID) body
		ON body.WorkerID = p.WorkerID

		WHERE (foot.Total IS NOT NULL OR body.Total IS NOT NULL)
		--GROUP BY ROLLUP(p.WorkerID, p.FirstName, p.LastName, foot.Total, body.total)

	--See the worker pay of 4-18
	EXEC spWorkerPay @DateStart = '2019-04-18'
					 ,@DateEnd = '2019-04-19'
	--See the worker pay of 4-19
	EXEC spWorkerPay @DateStart = '2019-04-19'
					 ,@DateEnd = '2019-04-20'


--CASE 3: When the table ServiceLog's 'PaidStatus' is set to 'Paid', move the record to tblPServiceCompleted

CREATE TRIGGER trgServiceStatus
ON tblPServiceLog
FOR UPDATE 
AS
BEGIN
	DECLARE @ServiceLogID INT;
	DECLARE @Payment VARCHAR(12);
	DECLARE @MemID INT;
	DECLARE @ServPrice INT;
	SELECT
		@ServiceLogID = i.ServiceLogID
	   ,@Payment = i.PaymentType
	   ,@MemID = i.MemberID
	   ,@ServPrice = i.ServicePriceID
	FROM INSERTED i;
	--ServiceLog has ServicePriceID, Member has PackageID, Memberships has ServiceTimeID, ServicePrice has ServicePriceID and ServiceTimeID
	DECLARE @ServTime INT
	SET @ServTime = (SELECT
			i.ServicePriceID
		FROM tblPServiceTime pt
		JOIN tblPMembershipPackage pp
			ON pt.ServiceTimeID = pp.ServiceTimeID
		JOIN tblPServicePrice pp1
			ON pt.ServiceTimeID = pp1.ServiceTimeID
		JOIN INSERTED i
			ON i.ServicePriceID = pp1.ServicePriceID
		JOIN tblPMembers p
			ON pp.PackageID = p.PackageID
		WHERE p.MemberID = i.MemberID)

	IF UPDATE(PaidStatus)
	BEGIN

		--If the records payment method is 'Member' Update tblPMembers remaining count by 1
		--Make sure the ServiceTimeID from tblMembershipPackages matches the ServiceTimeID from tblServiceLog
		IF @Payment = 'Member' AND @ServPrice = @ServTime
			BEGIN
				UPDATE tblPMembers
				SET Remaining = Remaining - 1
				WHERE MemberID = @MemID
				INSERT INTO tblPServiceComplete
					SELECT
						sl.AppointmentID
					   ,sl.FirstName
					   ,sl.Phone
					   ,sl.TimeStarted
					   ,sl.TimeFinished
					   ,sl.ServicePriceID
					   ,sl.Room
					   ,sl.WorkerID
					   ,sl.PaymentType
					   ,sl.MemberID
					   ,sl.PaidStatus
					FROM tblPServiceLog sl
					WHERE sl.ServiceLogID = @ServiceLogID
				DELETE FROM tblPServiceLog
				WHERE ServiceLogID = @ServiceLogID;
			END

		 ELSE IF @Payment = 'Credit' OR @Payment = 'Cash'
			BEGIN
				INSERT INTO tblPServiceComplete
					SELECT
						sl.AppointmentID
					   ,sl.FirstName
					   ,sl.Phone
					   ,sl.TimeStarted
					   ,sl.TimeFinished
					   ,sl.ServicePriceID
					   ,sl.Room
					   ,sl.WorkerID
					   ,sl.PaymentType
					   ,sl.MemberID
					   ,sl.PaidStatus
					FROM tblPServiceLog sl
					WHERE sl.ServiceLogID = @ServiceLogID
				DELETE FROM tblPServiceLog
				WHERE ServiceLogID = @ServiceLogID;
			END
		ELSE
			BEGIN
			UPDATE tblPServiceLog SET PaidStatus = 'Unpaid' WHERE ServiceLogID = @ServiceLogID
			PRINT('Member Service Type Mismatch or Payment type incorrect')
			END
	END
END

--Set the service to match the membership price
UPDATE tblPServiceLog SET ServicePriceID = 2 WHERE ServiceLogID = 6
UPDATE tblPServiceLog SET PaidStatus = 'Paid' WHERE ServiceLogID = 6
SELECT * FROM tblPServiceLog
SELECT * FROM tblPServiceComplete pc
SELECT * FROM tblPMembers p



--Case 4: In service log, if the service is foot massage, designate the ‘room’ to be in foot area. 
--Other services are to be put into rooms, business has 5 rooms
--If a room is full, 
CREATE TRIGGER trgSvcRoom
ON tblPServiceLog
 INSTEAD OF INSERT
AS
BEGIN
	DECLARE @ApptID INT
	DECLARE @Fname VARCHAR(25)
	DECLARE @Phone VARCHAR(12)
	DECLARE @ServPriceID INT
	DECLARE @WorkID INT
	DECLARE @Payment VARCHAR(15)
	DECLARE @MemID INT
	DECLARE @RoomSpace INT
	SELECT @ApptID = i.AppointmentID
		  ,@Fname = i.FirstName
		  ,@Phone = i.Phone
		  ,@ServPriceID = i.ServicePriceID
		  ,@WorkID = i.WorkerID
		  ,@Payment = i.PaymentType
		  ,@MemID = i.MemberID
		  FROM INSERTED i
	--See the amount of rooms available
	SELECT @RoomSpace = COUNT(sl.Room) FROM tblPServiceLog sl WHERE sl.Room LIKE 'Room%'


	IF(@ServPriceID BETWEEN 1 AND 3)
		BEGIN
				INSERT INTO tblPServiceLog (AppointmentID, FirstName, Phone, TimeStarted, ServicePriceID, Room, WorkerID, PaymentType, MemberID)
				VALUES (@ApptID, @Fname, @Phone, GETDATE(), @ServPriceID, 'Foot Area', @WorkID, @Payment, @MemID);
				PRINT ('There are currently ('+CAST(5-@RoomSpace AS VARCHAR(5))+') rooms available')
				IF (@ApptID IS NOT NULL)
					     UPDATE tblPAppointment SET STATUS = 'Arrived' WHERE AppointmentID = @ApptID
		END
	IF(@ServPriceID BETWEEN 4 AND 19)
		BEGIN
		IF NOT EXISTS(SELECT * FROM tblPServiceLog WHERE Room = 'Room 1')
			BEGIN
				INSERT INTO tblPServiceLog (AppointmentID, FirstName, Phone, TimeStarted, ServicePriceID, Room, WorkerID, PaymentType, MemberID)
				VALUES (@ApptID, @Fname, @Phone, GETDATE(), @ServPriceID, 'Room 1', @WorkID, @Payment, @MemID);
				PRINT ('There are currently ('+CAST(5-@RoomSpace AS VARCHAR(5))+') rooms available')
				IF (@ApptID IS NOT NULL)
					     UPDATE tblPAppointment SET STATUS = 'Arrived' WHERE AppointmentID = @ApptID
			END
		ELSE IF NOT EXISTS(SELECT * FROM tblPServiceLog WHERE Room = 'Room 2')
			BEGIN
				INSERT INTO tblPServiceLog (AppointmentID, FirstName, Phone, TimeStarted, ServicePriceID, Room, WorkerID, PaymentType, MemberID)
				VALUES (@ApptID, @Fname, @Phone, GETDATE(), @ServPriceID, 'Room 2', @WorkID, @Payment, @MemID);
				PRINT ('There are currently ('+CAST(5-@RoomSpace AS VARCHAR(5))+') rooms available')
				IF (@ApptID IS NOT NULL)
					     UPDATE tblPAppointment SET STATUS = 'Arrived' WHERE AppointmentID = @ApptID
			END
		ELSE IF NOT EXISTS(SELECT * FROM tblPServiceLog WHERE Room = 'Room 3')
			BEGIN
				INSERT INTO tblPServiceLog (AppointmentID, FirstName, Phone, TimeStarted, ServicePriceID, Room, WorkerID, PaymentType, MemberID)
				VALUES (@ApptID, @Fname, @Phone, GETDATE(), @ServPriceID, 'Room 3', @WorkID, @Payment, @MemID);
				PRINT ('There are currently ('+CAST(5-@RoomSpace AS VARCHAR(5))+') rooms available')
				IF (@ApptID IS NOT NULL)
					UPDATE tblPAppointment SET STATUS = 'Arrived' WHERE AppointmentID = @ApptID
			END
		ELSE IF NOT EXISTS(SELECT * FROM tblPServiceLog WHERE Room = 'Room 4')
			BEGIN
				INSERT INTO tblPServiceLog (AppointmentID, FirstName, Phone, TimeStarted, ServicePriceID, Room, WorkerID, PaymentType, MemberID)
				VALUES (@ApptID, @Fname, @Phone, GETDATE(), @ServPriceID, 'Room 4', @WorkID, @Payment, @MemID);
				PRINT ('There are currently ('+CAST(5-@RoomSpace AS VARCHAR(5))+') rooms available')
				IF (@ApptID IS NOT NULL)
					     UPDATE tblPAppointment SET STATUS = 'Arrived' WHERE AppointmentID = @ApptID
			END
		ELSE IF NOT EXISTS(SELECT * FROM tblPServiceLog WHERE Room = 'Room 5')
			BEGIN
				INSERT INTO tblPServiceLog (AppointmentID, FirstName, Phone, TimeStarted, ServicePriceID, Room, WorkerID, PaymentType, MemberID)
				VALUES (@ApptID, @Fname, @Phone, GETDATE(), @ServPriceID, 'Room 5', @WorkID, @Payment, @MemID);
				PRINT ('There are currently ('+CAST(5-@RoomSpace AS VARCHAR(5))+') rooms available')
				IF (@ApptID IS NOT NULL)
					     UPDATE tblPAppointment SET STATUS = 'Arrived' WHERE AppointmentID = @ApptID
			END
		ELSE
			PRINT('Rooms are full')
	END
END

-- Case 5: Scheduled appointments that updates the status to ‘arrived’ automatically gets created in service log

INSERT INTO tblPServiceLog (AppointmentID, FirstName, Phone, ServicePriceID, TimeStarted, WorkerID, PaidStatus)
VALUES (10, 'Zenia', '516-517-8003', 1, GETDATE(), 3, 'Unpaid')

SELECT * FROM tblPAppointment p
SELECT * FROM tblPServiceLog pl


--Case 6: Find how many customers were completed on a certain date

ALTER FUNCTION custComplete (@Date DATETIME)
RETURNS INT
BEGIN
	RETURN (SELECT COUNT(*) FROM tblPServiceComplete pc WHERE pc.TimeStarted >= @Date AND pc.TimeStarted < @Date+1)
END

SELECT dbo.custComplete('2019-04-19') AS 'Customers Completed'
