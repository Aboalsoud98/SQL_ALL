--------------------------- Comments  -----------------------------
-- Single Line Comment
/*
 Multi Line Comment
 .....
 .....
*/
===================================================================
===================================================================
--------------------------- Data Types ----------------------------
------------------- 1.Numeric Data Types
bit         -- Boolean Value 0[false]  : 1[true] 
tinyint		-- 1 Byte => -128:127		| 0:255 [Unsigned(Positive)]
smallint	-- 2 Byte => -32768:32767	| 0:65555 [Unsigned] 
int			-- 4 Byte 
bigint		-- 8 Byte

------------------- 2.Fractions Data Types
smallmoney	4B.0000            -- 4 Numbers After Point
money		8B.0000            -- 4 Numbers After Point 
real		  .0000000         -- 7 Numbers After Point
float		  .000000000000000 -- 15 Numbers After Point
dec			-- Datatype and Make Valiadtion at The Same Time => Recommended
dec(5, 2) 124.22	18.1	12.2212 XXX 2.1234

------------------- 3.String Data Types 
char(10)		[Fixed Length Character]	Ahmed 10	Ali 10	
varchar(10)		[Variable Length Character]	Ahmed 5		Ali 3
nchar(10)		[like char(), But With UniCode] على ???
nvarchar(10)	[like varchar(), But With UniCode] على
nvarchar(max)	[Up to 2GB]
varchar(max)

------------------- 4.DateTime Data Types
Date			MM/dd/yyyy
Time			hh:mm:ss.123 --Defualt=> Time(3)
Time(5)			hh:mm:ss.12345
smalldatetime	MM/dd/yyyy hh:mm:00
datetime		MM/dd/yyyy hh:mm:ss.123
datetime2(4)	MM/dd/yyyy hh:mm:ss.1234
datetimeoffset	11/23/2020 10:30 +2:00 Timezone

------------------- 5. Binary Data Types
binary 01110011 11110000
image

------------------- 6. Other Data Types
Xml
sql_variant -- Like Var In Javascript

==================================================================
--------------------------- Variables ----------------------------
-- 1. Global Variables
select @@Version
select @@ServerName

-- 2. Local Variables
declare @age int = 3
set @age = 55
print @age



-------------------------------------------------------------------
-- 1) DDL => Data Definition Language
-- 1. Create

Create Database CompanyCycle39

Use CompanyCycle39

create table Employee
(
SSN int primary key identity(1, 1),
FName varchar(15) not null,
LName varchar(15),
Address varchar(20) default 'Cairo',
Salary Money,
Gender char(1),
BDate Date,
DNo int,
SuperSSN int references Employee(SSN)
)
create table Department
(
Number int primary key identity(10, 10),
Name varchar(15) not null,
StarteDate Date,
MGRSSN int references Employee(SSN)
)
create table DeptLocations
(
Number int references Department(Number),
Name varchar(15),
primary key(Number, Name)
)

create table Project
(
PNum int primary key identity, 
PName varchar(20) not null,
Location varchar(20),
DNo int references Department(Number)
)

create table Dependent
(
Name varchar(20) not null,
Gender char(1),
BDate Date,
Relationship varchar(20),
ESSN int references Employee(SSN),
primary key(ESSN, Name)
)

create table Works_On
(
ESSN int references Employee(SSN),
PNo int references Project(PNum),
Hours tinyint ,
primary key(ESSN, PNo)
)

-- 2. ALter [Update]

Alter Table Employees
Add Test int

Alter Table Employees
Alter Column Test bigint

Alter Table Employees
Drop Column Test



alter table Employee
add foreign key (DNo) references Department(Number)
 

-- 3. Drop [Remove]
drop table Employee
=========================================================================
-- 2) DML => Data Manpulation Language

-- 1. Insert

--------- 1.1 Simple Insert (Add Just Only One Row)

Insert Into Employees
Values('Ahmed', 'Nasr', '02-22-1963', 'Alex', 'M', 8000, Null, Null)

Insert Into Employees(Salary, FName, BDate, Gender)
Values(4000, 'Mohamed', '03-22-1999', 'M')

-- 1. Identity Constraint
-- 2. Default Value
-- 3. Allow Null


--------- 1.2 Row Constructor Insert (Add More Than One Row)


Insert Into Employees
Values
('Mona', 'Nasr', '02-22-1963', 'Cairo', 'F', 8000, 1, Null),
('Amr', 'Ibrahim', '02-22-1963', 'Tanta', 'M', 8000, 1, Null),
('Aya', 'Ali', '02-22-1963', 'Giza', 'F', 8000, 1, Null),
('Mohamed', 'Amr', '02-22-1963', 'Mansoura', 'M', 8000, 1, Null)



-- 2. Update

Update Employees
	Set EmpAddress = 'Dokki'
	where Id = 1

Update Employees
	Set FName = 'Hamda', LName = 'Hambozo'
	where Id = 2

Update Employees
	Set Salary += Salary * .1
	where Salary <= 5000 and EmpAddress = 'Cairo'


-- 3. Delete

Delete From Employees



Delete From Employees
	Where Id = 9

=========================================================================
=========================================================================
=========================================================================


use Route

-- 3) DQL => Data Query Language

select *
from Student

select St_Fname +' '+ St_Lname FullName
from Student

select St_Fname +' '+ St_Lname  [Full Name]
from Student

select [Full Name] = St_Fname +' '+ St_Lname  
from Student


select * 
from Student
where St_Age > 23

select * 
from Student
where St_Age between 21 and 25

select *
from Student
where St_Address in ('Alex', 'Mansoura', 'Cairo')


select *
from Student
where St_Address not in ('Alex', 'Mansoura', 'Cairo')

Select * 
from Student
where St_super is not Null

--------------------------
-- like With Some Patterns
/*
_ => one Char
% => Zero or More Chars 

*/ 
select *
from Student
where St_Fname like '_A%' -- Na Fady Kamel Hassan Nada Nadia 

/*

'a%h' ah aghjklh
'%a_' ak hjkak
'[ahm]%' amr hassan mohamed a
'[^ahm]%'
'[a-h]%'
'[^a-h]%'
'[346]%'
'%[%]'       ghjkl%
'%[_]%' Ahmed_Ali _
'[_]%[_]' _Ahmed_

*/
select *
from Employee
where FName like '[_]A%'


-- Distinct
select distinct FName
from Employee

-- Order By
select St_Id, St_Fname, St_Age
from Student
order by St_Fname, St_Age desc

select St_Id, St_Fname, St_Age
from Student
order by 1, 2 desc

select *
from Student
order by 1
===========================================================
--------------------------- Joins -------------------------

-- 1. Cross join (Cartisian Product)
select S.St_Fname, D.Dept_Name
from Student S, Department D -- ANSI (Cartisian Product)

select S.St_Fname,  D.Dept_Name
from Student S Cross Join Department D -- Microsoft (Cross Join)



-- 2. Inner Join (Equi Join)

-- Equi Join Syntax (ANSI)
select S.St_Fname,  D.Dept_Name
from Student S, Department D
where D.Dept_Id = S.Dept_Id 

select S.St_Fname , D.*
from Student S, Department D
where D.Dept_Id = S.Dept_Id

-- Inner Join Syntax (Microsoft)
select S.St_Fname, D.Dept_Name
from Student S inner join Department D
	on D.Dept_Id= S.Dept_Id


-- 3. Outer Join
-- 3.1 Left Outer Join
select S.St_Fname, D.Dept_Name
from Student S left outer join Department D
	on D.Dept_Id= S.Dept_Id

-- 3.2 Right Outer Join
select S.St_Fname, D.Dept_Name
from Student S right outer join Department D
	on D.Dept_Id= S.Dept_Id

-- 3.3 Full Outer Join
select S.St_Fname, D.Dept_Name
from Student S full outer join Department D
	on D.Dept_Id = S.Dept_Id





	
-- 4. Self Join
select S.St_Fname, Super.*
from Student S , Student Super
where Super.St_Id = S.St_Super

select S.St_Fname, Super.*
from Student S inner join Student Super
on Super.St_Id = S.St_Super

-- Multi Table Join
-- Equi Join Syntax
select S.St_Fname, Crs_Name, Grade
from Student S, Stud_Course SC, Course C
where S.St_Id = SC.St_Id and C.Crs_Id = SC.Crs_Id

-- Inner Join Syntax
select S.St_Fname, Crs_Name, Grade
from Student s inner join Stud_Course SC
on S.St_Id = SC.St_Id 
inner join Course C
on C.Crs_Id = SC.Crs_Id
----------------------------------
-- Join + DML
-- Update 

-- Updates Grades Of Student Who 're Living in Cairo
update SC
	set grade += 10
from Student S inner join Stud_Course SC
on  S.St_Id = SC.St_Id and St_Address = 'cairo'

-- Self Study
-- Delete
-- Insert
----------------------------------------------------------
----------------------------------------------------------
=======================================================
--------------------- Built-in Functions --------------
=======================================================

------------------- 1. Aggregate Functions ---------------
--  Return Just Only One Value (Scalar Functions) 
--  That Value is Not Existed In Database
--	Count, Sum, Avg, Max, Min  

select count(*)
from student

select count(St_Id)
from student

--The Count of Students That have Ages (Not Null)
select count(st_age) 
from student

select count(*) , count(st_id), count(st_lname), count(st_age)
from Student

select sum(salary)
from instructor


select avg(st_age)
from Student

select sum(st_age)/COUNT(*)
from Student
select sum(st_age)/COUNT(st_age)
from Student


select Max(Salary) as MaxSalary, Min(Salary) as MinSalary
from Instructor


-- Minimum Salary For Each Department
select Dept_Id, Min(Salary) as MininmumSalary
from Instructor
Group By Dept_Id


-- You Can't Group By With * or PK 
-- We Grouping With Repeated Value Column


Select Dept_Id, St_Address, Count(St_Id) as NumberOfStudents
From Student
Group By Dept_Id, St_Address  -- Will Group Here With Which Column?
-- If You Select Columns With Aggregate Functions, 
-- You Must Group By With The Same Columns 



-- Get Number Of Student For Each Department [that has more than 3 students]
select S.Dept_Id, D.Dept_Name, Count(St_Id) as NumberOfStudents
from Student S, Department D
where D.Dept_Id = S.Dept_Id
group by S.Dept_Id , D.Dept_Name
having Count(St_Id) > 3


-- Get Number Of Student For Each Department [Need Join?]
select Dept_id, Count(St_Id) as NumberOfStudents
from Student
group by Dept_Id
where dept_id is not null

select S.Dept_id, Count(S.St_Id) as NumberOfStudents
from Student S, Department D
where D.Dept_Id = S.Dept_Id
group by S.Dept_Id

-- Get Sum Salary of Instructors For Each  [Which has more than 3 Instructors]
select Dept_Id, Sum(Salary) as SumOfSalary
from Instructor
group by Dept_Id
having Count(Ins_Id) > 3


-- You Can't Use Agg Functions Inside Where Clause (Not Valid)
-- Because Aggreagate Generate Groups That 'Having' Works With it
-- Where Works With Rows => in order to Make Filteration
select Sum(Salary)
from Instructor
where count(Ins_Id) < 100 -- Not Valid

-- You Can Use Having Without Group By Only In Case Of Selecting Just Agg Functions
select Sum(Salary)
from Instructor
having count(Ins_Id) < 100 -- Valid

-- Group By With Self Join
select Super.St_FName, Count(Stud.St_Id)
from Student Stud, Student Super
where Super.St_Id = Stud.St_Super
group by Super.St_FName


------------------------------------------------------------
---------------------- 2. Null Functions -------------------
------- 1. IsNull
select st_Fname
from Student

select st_Fname
from Student
where St_Fname is not null

select isnull(st_Fname, '')
from Student

select isnull(st_Fname, 'Student Has No FName')
from Student

select isnull(st_Fname, St_Lname) as NewName
from Student

------- 2. Coalesce
select coalesce(st_Fname, St_Lname, St_Address, 'No Data')
from Student


---------------------------------------------------------
---------------------- 3. Casting Functions -------------

select St_Fname +' '+ St_Age
from student

------- 1. Convert [Convert From Any DateType To DateType]
select St_Fname +' '+ Convert(varchar(2), St_Age)
from student

select 'Student Name= ' + St_Fname + ' & Age= '+ Convert(varchar(2), St_Age)
from student

select IsNull(St_Fname,'')+' '+ Convert(varchar(2), IsNull(St_Age, 0))
from student

-- Concat => Convert All Values To String Even If Null Values (Empty String)
select Concat(St_Fname, ' ', St_Age)
from student


------- 2. Cast [Convert From Any DateType To DateType]
select cast(getdate() as varchar(50))

-- Convert Take Third Parameter If You Casting From Date To String
-- For Specifying The Date Format You Need
select convert(varchar(50),getdate(),101)
select convert(varchar(50),getdate(),102)
select convert(varchar(50),getdate(),110)
select convert(varchar(50),getdate(),111)

------- 3. Format [Convert From Date To String]

select format(getdate(),'dd-MM-yyyy')
select format(getdate(),'dddd MMMM yyyy')
select format(getdate(),'ddd MMM yy')
select format(getdate(),'dddd')
select format(getdate(),'MMMM')
select format(getdate(),'hh:mm:ss')
select format(getdate(),'hh tt')
select format(getdate(),'HH')
select format(getdate(),'dd MM yyyy hh:mm:ss')
select format(getdate(),'dd MM yyyy hh:mm:ss tt')
select format(getdate(),'dd')

---------------------------------------------------------
------------------- 4. DateTime Functions ---------------

select getdate()
select day(getdate())
select Month(GETDATE())
select eomonth(getdate())
select eomonth('1/1/2000')
select format(eomonth(getdate()),'dd')
select format(eomonth(getdate()),'dddd')

---------------------------------------------------------
------------------- 5. String Functions -----------------

select lower(st_fname),upper(st_lname)
from Student

select substring(st_fname,1,3)
from Student

select len(st_fname),st_fname
from Student

---------------------------------------------------------
--------------------- 6. Math Functions -----------------

select power(2,2)


-- log sin cos tan

---------------------------------------------------------
--------------------- 7. System Functions ---------------

select db_name()

select suser_nam e()

select @@ServerName


==============================================================
---------------------- Sub Query -----------------------------
-- Output Of Sub Query[Inner] As Input To Another Query[Outer]
-- SubQuery Is Very Slow (Not Recommended Except Some Cases)

/* 
select *
from student
where st_age > avg(st_age) => Not Valid
*/

select *
from student
where st_age > (select avg(st_age) from student) --23 just value

/*
select *, count(st_id)
from student => Not Valid
*/
select *,(select count(st_id) from student) --14
from student

-- SubQuery Vs Join

-- Get Departments Names That Have Students

select distinct D.Dept_Name
from Department D inner join Student S
on D.Dept_Id = S.Dept_Id

select dept_name
from Department
where Dept_Id in (	select distinct(Dept_Id)
					from Student
					where Dept_Id is not null
				)

-- SubQuery With DML
--------- SubQuery With Delete

--Delete Students Grades Who Are Living in Cairo
delete from Stud_Course
where St_Id in (
				Select St_Id from Student 
				where St_Address = 'Cairo'
				)
delete SC
from Student S inner join Stud_Course SC
on S.St_Id = SC.St_Id 
where S.St_Address = 'Cairo'



==========================================================
------------------------- Top ----------------------------

-- First 5 Students From Table
select top(5)*
from  student

select top(5)st_fname
from  student

-- Last 5 Students From Table
select top(5)*
from  student
order by st_id desc

-- Get The Maximum 2 Salaries From Instractors Table
select Max(Salary)
from Instructor

select Max(Salary)
from Instructor
where Salary <> (Select Max(Salary) from Instructor)

select top(2)salary
from Instructor
order by Salary desc


-- Top With Ties, Must Make Order by
select top(5) st_age
from student 
order by st_age desc

select top(5) with ties st_age
from student
order by st_age  desc


-- Randomly Select
select newid()   -- Return GUID Value (Global Universal ID)

select St_Fname, newid()
from Student

select top(3)*
from student
order by newid()
============================================================
------------------------------------------------------------
------------------- Ranking Function -----------------------



-- 1. Row_Number()
-- 2. Dense_Rank()
-- 3. Rank()

select Ins_Name, Salary,
	Row_Number() over (Order by Salary desc) as RNumber,
	Dense_Rank() over (Order by Salary desc) as DRank,
	Rank()       over (Order by Salary desc) as R
from Instructor


-- 1. Get The 2 Older Students at Students Table

-- Using Ranking 
select *
from (select St_Fname, St_Age, Dept_Id,
		Row_number() over(order by St_Age desc) as RN
	from Student) as newtable
where RN <= 2

-- Using Top(Recommended)
Select top(2) St_Fname, St_Age, Dept_Id
from Student
Order By St_Age Desc

-- 2. Get The 5th Younger Student 

-- Using Ranking (Recommended)
select * from 
(select St_Fname, St_Age, Dept_Id,
		row_number() over(order by St_age desc) as RN
from Student) as newtable
where RN = 5

-- Using Top
select top(1)* from
(select top(5)*
from Student
order by St_Age desc) as newTable
order by St_Age

-- 2. Get The Younger Student At Each Department

-- Using Ranking Only
select * from 
(select Dept_Id, St_Fname, St_Age, 
		row_number() over(partition by Dept_id order by St_age desc) as RN
from Student) as newtable
where RN = 1



-- 4.NTile

-- We Have 15 Instructors, and We Need to Get The 5th Instructors Who Take the lowest salary
select *
from
(
select Ins_Name, Salary, Ntile(3) over(order by Salary) as G
from Instructor
) as newTable
where G = 3


=========================================================
---------------------------------------------------------
-- Execution Order
Select CONCAT(St_FName, ' ', St_Lname) as FullName
from Student
Where FullName = 'Ahmed Hassan' -- Not Valid


Select CONCAT(St_FName, ' ', St_Lname) as FullName
from Student
Where CONCAT(St_FName, ' ', St_Lname) = 'Ahmed Hassan'

Select *
from  (Select CONCAT(St_FName, ' ', St_Lname) as FullName
	   from Student) as Newtable
Where FullName = 'Ahmed Hassan'

Select CONCAT(St_FName, ' ', St_Lname) as FullName
from Student
Order By FullName


--execution order
----from
----join
----on
----where 
----group by
----having
----select
----order by
----top

=========================================================
---------------------------------------------------------
---------------------------- Schema ---------------------

-- Schema Solved 3 Problems:
-- 1.You Can't Create Object With The Same Name
--	[Table, View, Index, Trigger, Stored Procedure, Rule]
-- 2. There Is No Logical Meaning (Logical Name)
-- 3. Permissions
select *
from Student

-- DBO [Default Schema] => Database Owner
select *
from ServerName.DBName.SchemaName.objectName

select *
from  [DESKTOP-VF50P25].iti.dbo.student

select *
from Company_SD.dbo.Project

Create Schema HR

Create Schema Sales


Alter Schema HR 
Transfer student


select * from Student  -- not valid

select * from Hr.Student -- valid

Alter Schema HR
Transfer Department

Select *
from HR.Department


ALter Schema Dbo
Transfer HR.Department


======================================================
------------------------------------------------------
-- Union Family (union | union all | intersect | except)
-- Have 2 Conditions:
-- 1- The Same Datatype
-- 2- The Same Number Of Selected Columns

Select St_Id, St_FName from Student
-- except --intersect --union all --union
Select Ins_Id, Ins_Name from Instructor

-- Example (Select The Student Names At All Route Branches)

===============================================================
---------------------------------------------------------------
-- DDL [Create, Alter, Drop, Select Into]    
-- Create Physical Table


Select * into NewEmployees
From MyCompany.Dbo.Employee


-- Create Just The Structure Without Data
Select * into NewProjects
From MyCompany.Dbo.Project
Where 1 = 2



-- Take Just The Data Without Table Structure, 
-- but 2 tables must have same structure (Insert Based On Select)
Insert Into NewProjects
Select * from MyCompany.Dbo.Project


=========================================================
---------------------------------------------------------
---------------- User Defined Function ------------------

-- Any SQL Server Function must return value
-- Specify Type Of User Defined Function That U Want Based On The Type Of Return
-- User Defined Function Consist Of
--- 1. Signature (Name, Parameters, ReturnType)
--- 2. Body
-- Body Of Function Must be Select Statement Or Insert Based On Select
-- May Take Parameters Or Not

=================================================================
-- 1. Scalar Fun (Return One Value)


Create Function GetStudentNameByStudentId(@StId int)
returns varchar(20) -- Function Signature
begin
	declare @StudentName varchar(20)
	Select @StudentName = St_FName
	from Student
	where St_Id = @StId
	return @StudentName
end
     
Select	Dbo.GetStudentNameByStudentId(8)


-----------------------------------------------------

Create Function GetDepartmentManagerNameByDepartmentName(@DeptName varchar(20))
Returns varchar(20) -- Function Signature
begin
	declare @MangerName varchar(20)
	Select @MangerName = E.FName
	From Employee E, Departments D
	where E.SSN = D.MGRSSN and D.DName =  @DeptName
	return @MangerName
end

Select	Dbo.GetDepartmentManagerNameByDepartmentName('DP2')




=================================================================
-- 2. Inline Table Function (Return Table)

Create Function GetDepartmenInstructorsByDepartmentId(@DeptId int)
Returns Table  -- Function Signature
as
	Return
	(
		Select Ins_Id, Ins_Name, Dept_Id
		from Instructor
		Where Dept_Id = @DeptId
	)

	Select * from dbo.GetDepartmenInstructorsByDepartmentId(20)

=================================================================
-- 3. Multistatment Table Fuction
--    => Return Table With Logic [Declare, If, While] Inside Its Body

Alter Function GetStudentDataBasedPassedFormat(@Format varchar(20))
Returns @t table
		(
			StdId int,
			StdName varchar(20)
		)
With Encryption
as
	Begin
		if @format = 'first'
			Insert Into @t
			Select St_Id, St_FName
			from Student
		else if @format = 'last'
			Insert Into @t
			Select St_Id, St_LName
			from Student
		else if @format = 'full'
			Insert Into @t
			Select St_Id, Concat(St_FName, ' ', St_LName)
			from Student
		
		return 
	End

select * from dbo.GetStudentDataBasedPassedFormat('fullname')
select * from dbo.GetStudentDataBasedPassedFormat	('FIRST')

-------------------------------------------------------------
---------------------- Views --------------------------------

-- 1. Standard View (Contains Just Only One Select Statement)


Create View AlexStudentsView
as
	Select St_Id, St_FName, St_Address
	from StudentsView
	Where St_Address = 'Alex'

Select * from AlexStudentsView

Create View CairoStudentsView
as
	Select St_Id, St_FName, St_Address
	from Student
	Where St_Address = 'Cairo'

Select * from CairoStudentsView



---------------------------------------------------------------
-- 2. Partitioned View (Contains More Than One Select Statement)

Create View CairoAlexStudentsView
as
	Select * from CairoStudentsView
	Union
	Select * from AlexStudentsView

Select * from CairoAlexStudentsView

-- Hierarchy Of Database?
/*
 Server Level	=> Databases
 Database Level	=> Schemas
 Schema Level	=> Database Objects (Table, View, SP, and etc)
 Table Level	=> Columns, Constraints
*/

Alter Schema Dbo
Transfer HR.CairoAlexStudentsView


Create View StudentDepartmentDataView(StdId, StdName, DeptId, DeptName)
With Encryption
as
	Select St_Id, St_FName, D.Dept_Id, D.Dept_Name
	from Student S inner join Department D
	on D.Dept_Id = S.Dept_Id

Select * from StudentDepartmentDataView

SP_HelpText 'GetStudentDataBasedPassedFormat'



Create View StudentGradesView (StdName, CrsName, StdGrade)
With Encryption
as
	Select S.St_FName, C.Crs_Name, SC.Grade
	from Student S, Stud_Course SC, Course C
	where S.St_Id = SC.St_Id and C.Crs_Id = SC.Crs_Id

Select * from StudentGradesView



---------------------------------------------------------
-- View + DML
-- View =>  One Table

Create View CairoStudentsView
as
	Select St_Id, St_FName, St_Address
	from StudentsView
	Where St_Address = 'Cairo'

Insert Into CairoStudentsView
Values(323234, 'Pola', 'Cairo')


-- View  =>  Multi Table

Alter View StudentDepartmentDataView(StdId, StdName, FK_DeptId, DeptId, DeptName)
With Encryption
as
	Select St_Id, St_FName, S.Dept_Id, D.Dept_Id, D.Dept_Name
	from Student S inner join Department D
	on D.Dept_Id = S.Dept_Id

Select * from StudentDepartmentDataView
--- DELETE XXXXX
Delete From StudentDepartmentDataView
	Where StdId = 1

-- Insert Update
Insert Into StudentDepartmentDataView(StdId, StdName, FK_DeptId)
Values(9709, 'Ay 7aga', 1000)

Insert Into StudentDepartmentDataView(DeptId, DeptName)
Values(1000, 'Test')



Alter View CairoStudentsView
With Encryption
as
	Select St_Id, St_FName, St_Address
	from StudentsView
	Where St_Address = 'Cairo' -- Make Check Constraint
	With Check Option

Insert Into CairoStudentsView
Values(97397, 'Ronaldo', 'Cairo')


--====================================================================
--------------------- Relationship Rules -----------------------------
--- 1. Delete Rule

--- Before Delete Department No (40) With Its Instructors and Students
Delete From Department
	Where Dept_Id = 40

-- Firstly, For Instructors
	-- 1. Transfer Instructors Of Department No (40) to another Department
Update Instructor	
	Set Dept_Id = 10
	Where Dept_Id = 40

	-- 2. Transfer Instructors Of Department No (40) To No Department (Null)
Update Instructor	
	Set Dept_Id = Null
	Where Dept_Id = 40

	-- 3. Transfer Instructors Of Department No (40) To No Department (Null)
Delete From Instructor
	Where Dept_Id = 40

-- Secondly, For Students also The Same Idea

-- 2. Update Rule [The Same Idea Of Delete Rule]

===================================================================
------------------------ Delete Vs Truncate -----------------------
Delete From Student

Truncate Table Student

===================================================================
-------------------------------------------------------------------
------------------------ Stored Procedure -------------------------
-- Benefits Of SP:
-- 1. Performance
-- 2. Security (Hide Meta Data)
-- 3. Network Wise 
-- 4. Hide Business Rules
-- 5. Handle Errors (SP Contain DML)
-- 6. Accept Input And Out Parameteres => Make It More Flexbile 


Create Procedure SP_GetStudentById @StdId int
as
	Select *
	from Student
	Where St_Id =  @StdId

	SP_GetStudentById 1

	declare @X  int = 1 
	exec HR.SP_GetStudentById @X



alter schema hr 
transfer SP_GetStudentById



Delete From Topic
	Where Top_Id = 1

Alter Proc SP_DeleteTopicById @TopicId int
With Encryption
as
	Begin Try
		Delete From Topic
			Where Top_Id = @TopicId
	End Try 
	Begin Catch
		Select 'Error'
	End Catch

DeleteStudent 6


Sp_HelpText 'SP_DeleteTopicById'


Alter Procedure SP_SumData @X int = 2, @Y varchar(10) = '8'
as
	Select @X + @Y

SP_SumData 3,7			-- Passing Parameters by Position
SP_SumData @y=7,@x=3    -- Passing Parameters by name
SP_SumData 6			-- Default Values
SP_SumData				-- Default Values




Create Proc SP_GetStudentByAddress @StdAddress varchar(20)
With Encryption
As
	Select St_Id, St_FName, St_Address
	From Student
	Where St_Address = @StdAddress

	SP_GetStudentByAddress 'Alex'


Create Table StudentsWithAddresss
(
StdId int Primary Key,
StdName varchar(20),
StdAddress varchar(20)
)

-- Insert Based On Execute
Insert Into StudentsWithAddresss
exec SP_GetStudentByAddress 'Alex'


---------------------------------------
-- Return Of SP

Create Proc SP_GetStudentNameAndAgeByIdV02 @Data int output, @Name varchar(20) output
With Encryption
As
	Select @Name = St_FName, @Data = St_Age -- [Output]
	from Student
	Where St_Id = @Data -- 10 [Input]

	declare @StudentName varchar(20), @Data int = 10
	exec SP_GetStudentNameAndAgeByIdV02 @Data output, @StudentName output
	Select @StudentName, @Data

