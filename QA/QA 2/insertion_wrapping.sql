-- Create test table if it doesn't exist
IF OBJECT_ID(N'dbo.Sometest', N'U') IS NULL 
BEGIN CREATE TABLE Sometest(
	id INT PRIMARY KEY, 
	SomeCol VARCHAR(200), 
	SomeDate DATETIME, 
	SomeCol2 VARCHAR(200), 
	SomeDate2 DATETIME,
	SomeCol3 VARCHAR(200), 
	SomeDate3 DATETIME, 
	SomeCol4 VARCHAR(200), 
	SomeDate4 DATETIME);
END;
GO


/* Test without Transaction */
TRUNCATE TABLE Sometest
DECLARE @start DATETIME = GETDATE()
SET NOCOUNT ON
DECLARE @id INT =0
WHILE @id < 50000
BEGIN
	INSERT Sometest
	SELECT @id ,'BlaBlaBlaBlaBlaBlaBlaBlaBlaBla111111',GETDATE(),
	'BlaBlaBlaBlaBlaBlaBlaBlaBlaBla2222',GETDATE(),
	'BlaBlaBlaBlaBlaBlaBlaBlaBlaBla3333',GETDATE(),
	'BlaBlaBlaBlaBlaBlaBlaBlaBlaBla4444',GETDATE()
SET @id+=1
END
-- Returns running time of this test
SELECT DATEDIFF(ms,@start,GETDATE())


/* Test with Transaction */
TRUNCATE TABLE Sometest
DECLARE @start2 DATETIME = GETDATE()
SET NOCOUNT ON
BEGIN TRAN
DECLARE @id2 INT =0
WHILE @id2 < 50000
BEGIN
	INSERT Sometest
	SELECT @id2 ,'BlaBlaBlaBlaBlaBlaBlaBlaBlaBla111111',GETDATE(),
	'BlaBlaBlaBlaBlaBlaBlaBlaBlaBla2222',GETDATE(),
	'BlaBlaBlaBlaBlaBlaBlaBlaBlaBla3333',GETDATE(),
	'BlaBlaBlaBlaBlaBlaBlaBlaBlaBla4444',GETDATE()
SET @id2+=1
END
COMMIT
-- Returns running time of this test
SELECT DATEDIFF(ms,@start2,GETDATE())
