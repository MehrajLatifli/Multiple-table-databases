-- Multiple table databases


--Cannot drop database because it is currently in use
USE [master]
ALTER DATABASE Academy SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP database Academy;




create database Academy
use Academy




-- Curators

create table Curators
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Curator's name]  nvarchar(max) NOT NULL,
[Curator's surname]  nvarchar(max) NOT NULL,

Check([Curator's name] <>' '),
Check([Curator's surname] <>' ')
)

Insert into Academy.dbo.Curators(Academy.dbo.Curators.[Curator's name], Academy.dbo.Curators.[Curator's surname]) 
values
(N'Fikrət',N'Bayramlı'),
(N'Həsən',N'Hesenli'),
(N'Cavid',N'Oğuzlu'),
(N'Qıbçaq',N'Türksoy'),
(N'Orxan',N'Qüdrətli'),
(N'Bağır',N'Bağırzadə'),
(N'Səbinə',N'Fikrətli'),
(N'Zərifə',N'Osmanlı')

select *from Academy.dbo.Curators




-- Faculties

create table Faculties
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Faculty name]  nvarchar(100) NOT NULL,
Financing money default(0) NOT NULL,

Check([Faculty name] <>' '),
UNIQUE ([Faculty name]),
Check(Financing>0)
)

Insert into Academy.dbo.Faculties(Academy.dbo.Faculties.[Faculty name], Academy.dbo.Faculties.Financing) 
values
(N'Computer Science', 2505000),
(N'Physics and Chemistry', 2505000),
(N'Statistics and Econometrica', 2505000),
(N'Sociology and Philosophy', 2505000)

select *from Academy.dbo.Faculties




-- Departments

create table Departments
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Department name]  nvarchar(100) NOT NULL,
Financing money default(0) NOT NULL,
FK_FacultyId int foreign key references Faculties(Id),

Check([Department name] <>' '),
UNIQUE ([Department name]),
Check(Financing>0)
)

Insert into Academy.dbo.Departments(Academy.dbo.Departments.[Department name], Academy.dbo.Departments.Financing, Academy.dbo.Departments.FK_FacultyId) 
values
(N'Computer Science', 250500, 1),
(N'Cybernetics', 250500, 1),
(N'Physics', 250500, 2),
(N'Chemistry', 250500, 2),
(N'Statistics', 250500, 3),
(N'Econometrica', 250500, 3),
(N'Sociology', 250500, 4),
(N'Philosophy', 250500, 4)

select *from Academy.dbo.Departments

select D.[Department name], D.Financing, F.[Faculty name] from Academy.dbo.Faculties as F, Academy.dbo.Departments as D where F.Id = D.FK_FacultyId




-- Groups

create table Groups
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Group name] nvarchar(10) NOT NULL,
[Year] int  NOT NULL,
FK_DepartmentId int FOREIGN KEY REFERENCES Departments(Id),

Check([Group name] <>' '),
UNIQUE ([Group name]),
Check([Year] >=1 AND [Year] <=5)
)

Insert into Academy.dbo.Groups(Academy.dbo.Groups.[Group name], Academy.dbo.Groups.[Year], Academy.dbo.Groups.FK_DepartmentId) 
values
(N'P107', 2, 1),
(N'B103', 3, 1),
(N'C226', 2, 2),
(N'D252', 5, 2),
(N'A213', 2, 3),
(N'Q289', 3, 3),
(N'V214', 4, 4),
(N'J283', 5, 4),
(N'P137', 2, 5),
(N'B167', 3, 5),
(N'C197', 2, 6),
(N'D147', 5, 6),
(N'A168', 2, 7),
(N'Q193', 3, 7),
(N'V147', 4, 8),
(N'J145', 5, 8)

select *from Academy.dbo.Groups

select G.[Group name], D.[Department name], G.[Year] from Academy.dbo.Groups as G, Academy.dbo.Departments as D where G.FK_DepartmentId = D.Id




-- Groups and Curators

create table [Groups and Curators]
(
Id int primary key IDENTITY (1,1) NOT NULL,
FK_CuratorId int FOREIGN KEY REFERENCES Curators(Id) not null,
FK_GroupId int FOREIGN KEY REFERENCES Groups(Id) not null,
)

Insert into Academy.dbo.[Groups and Curators](Academy.dbo.[Groups and Curators].FK_CuratorId, Academy.dbo.[Groups and Curators].FK_GroupId) 
values
(1,1),
(1,9),
(2,2),
(2,10),
(3,3),
(3,11),
(4,4),
(4,12),
(5,5),
(5,13),
(6,6),
(6,14),
(7,7),
(7,15),
(8,8),
(8,16)

select *from Academy.dbo.Curators
select *from Academy.dbo.Groups

select G.Id, G.[Group name], G.[Year], C.Id, C.[Curator's name], C.[Curator's surname], GC.FK_GroupId , GC.FK_CuratorId
from  Academy.dbo.Groups as G, Academy.dbo.Curators as C, [Groups and Curators] AS GC
where G.Id=GC.FK_GroupId AND C.Id=GC.FK_CuratorId




-- Subjects

create table Subjects
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Subject name] nvarchar(100) NOT NULL,

Check([Subject name] <>' '),
UNIQUE ([Subject name])
)

Insert into Academy.dbo.Subjects(Academy.dbo.Subjects.[Subject name])
values
(N'Basics of Programming'),
(N'Algorithm'),
(N'Higher mathematics'),
(N'Basics of cybernetics'),
(N'Basics of physics'),
(N'Higher physics'),
(N'Basics of chemistry'),
(N'Higher chemistry'),
(N'Basics of statistics'),
(N'Database  Theory'),
(N'Basics of econometrica'),
(N'Basics of economics'),
(N'Basics of sociology'),
(N'Religions and myths'),
(N'Basics of phiolosophy'),
(N'Metaphysics')

select *from Academy.dbo.Subjects




-- Teachers

create table Teachers
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Teacher's surname] nvarchar(max) NOT NULL,
[Teacher's name] nvarchar(max) NOT NULL,
Salary money NOT NULL,

Check([Teacher's name] <>' '),
Check([Teacher's surname] <>' '),
Check(Salary>0)
)

Insert into Academy.dbo.Teachers(Academy.dbo.Teachers.[Teacher's name], Academy.dbo.Teachers.[Teacher's surname], Academy.dbo.Teachers.Salary)
values
(N'Samantha', N'Adams', 1000),
(N'Ülkər', N'Məmmədli', 1000),
(N'Fazil', N'İsfəndiyarlı', 1000),
(N'Teymur', N'Şeybani', 1000),
(N'Aidə', N'Namazlı', 1000),
(N'John', N'White', 1000),
(N'Kate', N'Brown', 1000),
(N'Tamerlan', N'Zamanlı', 1000)

select *from Academy.dbo.Teachers




-- Lectures

create table Lectures
(
Id int primary key IDENTITY (1,1) NOT NULL,
Classroom nvarchar(max) NOT NULL,
FK_TeacherId int FOREIGN KEY REFERENCES Teachers(Id) not null,
FK_SubjectId int FOREIGN KEY REFERENCES Subjects(Id) not null,

Check(Classroom <>' ')
)


insert into Academy.dbo.Lectures(Academy.dbo.Lectures.Classroom, Academy.dbo.Lectures.FK_TeacherId, Academy.dbo.Lectures.FK_SubjectId)
values
(N'A101',1,1),
(N'A102',1,2),
(N'B103',2,3),
(N'B104',2,4),
(N'C105',3,5),
(N'C106',3,6),
(N'D107',4,7),
(N'D108',4,8),
(N'E109',5,9),
(N'E110',5,10),
(N'F111',6,11),
(N'F112',6,12),
(N'G113',7,13),
(N'G114',7,14),
(N'H115',8,15),
(N'H115',8,16)

select *from Academy.dbo.Teachers

select *from Academy.dbo.Subjects order by Academy.dbo.Subjects.Id ASC

select T.Id, T.[Teacher's name], T.[Teacher's surname], T.Salary, S.Id, S.[Subject name], L.FK_SubjectId , L.FK_TeacherId
from  Academy.dbo.Teachers as T, Academy.dbo.Subjects as S, Lectures AS L
where T.Id=L.FK_TeacherId AND S.Id=L.FK_SubjectId




-- Groups and Lectures

create table [Groups and Lectures]
(
Id int primary key IDENTITY (1,1) NOT NULL,
FK_GroupId int FOREIGN KEY REFERENCES Groups(Id) not null,
FK_LectureId int FOREIGN KEY REFERENCES Lectures(Id) not null,
)

insert into Academy.dbo.[Groups and Lectures](Academy.dbo.[Groups and Lectures].FK_GroupId, Academy.dbo.[Groups and Lectures].FK_LectureId)
values
(1,1),
(1,2),
(2,3),
(2,4),
(3,5),
(3,6),
(4,7),
(4,8),
(5,9),
(5,10),
(6,11),
(6,12),
(7,13),
(7,14),
(8,15),
(8,16)

select *from Academy.dbo.Groups order by Academy.dbo.Groups.Id asc

select *from Academy.dbo.Lectures 

select 
G.Id,
G.[Group name], 
G.[Year], 
G.FK_DepartmentId, 
L.Id, 
L.Classroom, 
L.FK_SubjectId, 
L.FK_TeacherId, 
GL.FK_GroupId, 
GL.FK_LectureId
from  
Academy.dbo.Groups as G, 
Academy.dbo.Lectures as L, 
Academy.dbo.[Groups and Lectures] AS GL
where G.Id=GL.FK_GroupId AND L.Id=GL.FK_LectureId





BEGIN




-- Print all possible pairs of lines of teachers and groups.

select T.[Teacher's name], G.[Group name], L.FK_TeacherId, GL.FK_GroupId
from Academy.dbo.Teachers as T, Academy.dbo.Groups as G, Academy.dbo.Lectures as L, Academy.dbo.[Groups and Lectures] AS GL
where T.Id = L.FK_TeacherId and G.Id=GL.FK_GroupId and L.Id = GL.FK_LectureId 
order by T.Id asc


-- Print names of faculties, where financing fund of departments exceeds financing fund of the faculty.

select F.[Faculty name]
from Academy.dbo.Faculties as F, Academy.dbo.Departments as D
where D.Financing > F.Financing


-- Print names of the group curators and groups names they are supervising.

select 
C.[Curator's name], 
C.[Curator's surname], 
G.[Group name]
from 
Academy.dbo.Curators as C, 
Academy.dbo.Groups as G, 
Academy.dbo.[Groups and Curators] as GC
where 
C.Id = GC.FK_CuratorId AND G.Id = GC.Id


-- Print names of the teachers who deliver lectures in the group "P107"

select distinct T.[Teacher's name], G.[Group name], L.FK_TeacherId, GL.FK_GroupId
from Academy.dbo.Teachers as T, Academy.dbo.Groups as G, Academy.dbo.Lectures as L, Academy.dbo.[Groups and Lectures] AS GL
where T.Id = L.FK_TeacherId and G.Id=GL.FK_GroupId and L.Id = GL.FK_LectureId and G.[Group name]='P107'


--x_ Print names of the teachers and names of the faculties where they are lecturing

select *from Academy.dbo.Faculties

select DISTINCT T.[Teacher's name], F.[Faculty name]
from 
Academy.dbo.Teachers as T, 
Academy.dbo.Faculties as F, 
Academy.dbo.Lectures as L, 
Academy.dbo.Departments as D, 
Academy.dbo.[Groups and Lectures] as GL, 
Academy.dbo.Groups as G,
Academy.dbo.Subjects as S
where 
G.Id=GL.FK_GroupId 
AND 
L.Id=GL.FK_LectureId
AND
T.Id=L.FK_TeacherId
AND
F.Id = D.FK_FacultyId
AND
D.FK_FacultyId=G.FK_DepartmentId




-- Print names of the departments and names of the groups that relate to them.

select distinct  D.[Department name], G.[Group name]
from 
Academy.dbo.Teachers as T, 
Academy.dbo.Faculties as F, 
Academy.dbo.Lectures as L, 
Academy.dbo.Departments as D, 
Academy.dbo.[Groups and Lectures] as GL, 
Academy.dbo.Groups as G,
Academy.dbo.Subjects as S
where 
D.Id = G.FK_DepartmentId


-- Print names of the subjects that the teacher "Samantha Adams" teaches.

select distinct  S.[Subject name]
from 
Academy.dbo.Teachers as T, 
Academy.dbo.Faculties as F, 
Academy.dbo.Lectures as L, 
Academy.dbo.Departments as D, 
Academy.dbo.[Groups and Lectures] as GL, 
Academy.dbo.Groups as G,
Academy.dbo.Subjects as S
where 
S.Id=L.FK_SubjectId
and
T.Id = L.FK_TeacherId 
and 
L.Id=GL.FK_LectureId
and
T.[Teacher's name]='Samantha'


--x_ Print  names  of  the  departments,  where  "Database  Theory" is taught.

select distinct  D.[Department name]
from 
Academy.dbo.Teachers as T, 
Academy.dbo.Faculties as F, 
Academy.dbo.Lectures as L, 
Academy.dbo.Departments as D, 
Academy.dbo.[Groups and Lectures] as GL, 
Academy.dbo.Groups as G,
Academy.dbo.Subjects as S
where 
D.Id= G.FK_DepartmentId
and
G.Id=GL.FK_GroupId
and
S.Id=L.FK_SubjectId
and
L.Id=GL.FK_LectureId
and
S.[Subject name]= N'Database  Theory'


-- Print names of the groups that belong to the "Computer Science" faculty.

select distinct G.[Group name], D.[Department name]
from 
Academy.dbo.Teachers as T, 
Academy.dbo.Faculties as F, 
Academy.dbo.Lectures as L, 
Academy.dbo.Departments as D, 
Academy.dbo.[Groups and Lectures] as GL, 
Academy.dbo.Groups as G,
Academy.dbo.Subjects as S
where 
F.Id=D.FK_FacultyId
and
D.Id=G.FK_DepartmentId
and
f.[Faculty name]='Computer Science'


-- Print names of the 5th year groups, as well as names of the faculties to which they relate

select distinct G.[Group name], F.[Faculty name]
from 
Academy.dbo.Teachers as T, 
Academy.dbo.Faculties as F, 
Academy.dbo.Lectures as L, 
Academy.dbo.Departments as D, 
Academy.dbo.[Groups and Lectures] as GL, 
Academy.dbo.Groups as G,
Academy.dbo.Subjects as S
where 
F.Id=D.FK_FacultyId
and
D.Id=G.FK_DepartmentId
and
G.[Year]=5


-- Print full names of the teachers and lectures they deliver (names of subjects and groups), and select only those lectures that are delivered in the classroom "B103". 

select distinct T.[Teacher's name],L.Classroom,S.[Subject name],G.[Group name]
from 
Academy.dbo.Teachers as T, 
Academy.dbo.Faculties as F, 
Academy.dbo.Lectures as L, 
Academy.dbo.Departments as D, 
Academy.dbo.[Groups and Lectures] as GL, 
Academy.dbo.Groups as G,
Academy.dbo.Subjects as S
where 
T.Id = L.FK_TeacherId
and
S.Id = L.FK_SubjectId
and
L.Id=GL.FK_LectureId
and
g.Id=GL.FK_GroupId
and
L.Classroom='B103'






END