-- Bài 1: Tạo CSDL[20 điểm]:
CREATE DATABASE quanlydiemthi;

USE quanlydiemthi;

CREATE TABLE student(
studentId VARCHAR(4) PRIMARY KEY NOT NULL,
studentName VARCHAR(100) NOT NULL,
birthday DATE NOT NULL,
gender BIT(1) NOT NULL,
address TEXT NOT NULL,
phoneNumber VARCHAR(45) UNIQUE
);

CREATE TABLE subject(
subjectId VARCHAR(4) PRIMARY KEY NOT NULL,
subjectName VARCHAR(100) NOT NULL,
priority INT(11) NOT NULL
);

CREATE TABLE mark(
studentId VARCHAR(100) NOT NULL,
foreign key (studentId) references student(studentId),
subjectId VARCHAR(4) NOT NULL,
foreign key (subjectId) references subject(subjectId),
point DOUBLE NOT NULL,
primary key(subjectId,studentId)
);
-- Bài 2: Thêm , sửa , xoá dữ liệu [35 điểm]:
insert into student values('S001','nguyễn thế anh','1999-1-11',1,'hà nội',984678082);
insert into student values('S002','đặng bảo trâm','1998-12-22',0,'lào cai',904982654);
insert into student values('S003','trần hà phương','2000-5-5',0,'nghệ an',947645363);
insert into student values('S004','đỗ tiến mạnh','1999-3-26',1,'hà nội',983665353);
insert into student values('S005','phạm duy nhất','1998-10-4',1,'tuyên quang',987242678);
insert into student values('S006','mai văn thái','2002-6-22',1,'nam định',982654268);
insert into student values('S007','giang gia hân','1996-11-10',0,'phú thọ',982364753);
insert into student values('S008','nguyễn ngọc bảo my','1999-1-22',0,'hà nam',927867453);
insert into student values('S009','nguyễn tiến đạt','1998-8-7',1,'tuyên quang',989274673);
insert into student values('S010','nguyễn thiều quang','2000-9-18',1,'hà nội',984378291);

insert into subject values('MH01', 'Toán', 2);
insert into subject values('MH02', 'Vật Lí', 2);
insert into subject values('MH03', 'Hóa Học', 1);
insert into subject values('MH04', 'Ngữ Văn', 1);
insert into subject values('MH05', 'Tiếng Anh', 2);

insert into mark values('S001','MH01',8.5);
insert into mark values('S001','MH02',7);
insert into mark values('S001','MH03',9);
insert into mark values('S001','MH04',9);
insert into mark values('S001','MH05',5);

insert into mark values('S002','MH01',9);
insert into mark values('S002','MH02',8);
insert into mark values('S002','MH03',6.5);
insert into mark values('S002','MH04',8);
insert into mark values('S002','MH05',6);

insert into mark values('S003','MH01',7.5);
insert into mark values('S003','MH02',6.5);
insert into mark values('S003','MH03',8);
insert into mark values('S003','MH04',7);
insert into mark values('S003','MH05',7);

insert into mark values('S004','MH01',6);
insert into mark values('S004','MH02',7);
insert into mark values('S004','MH03',5);
insert into mark values('S004','MH04',6.5);
insert into mark values('S004','MH05',8);

insert into mark values('S005','MH01',5.5);
insert into mark values('S005','MH02',8);
insert into mark values('S005','MH03',7.5);
insert into mark values('S005','MH04',8.5);
insert into mark values('S005','MH05',9);

insert into mark values('S006','MH01',8);
insert into mark values('S006','MH02',10);
insert into mark values('S006','MH03',9);
insert into mark values('S006','MH04',7.5);
insert into mark values('S006','MH05',6.5);

insert into mark values('S007','MH01',9.5);
insert into mark values('S007','MH02',9);
insert into mark values('S007','MH03',6);
insert into mark values('S007','MH04',9);
insert into mark values('S007','MH05',4);

insert into mark values('S008','MH01',10);
insert into mark values('S008','MH02',8.5);
insert into mark values('S008','MH03',8.5);
insert into mark values('S008','MH04',6);
insert into mark values('S008','MH05',9.5);

insert into mark values('S009','MH01',7.5);
insert into mark values('S009','MH02',7);
insert into mark values('S009','MH03',9);
insert into mark values('S009','MH04',5);
insert into mark values('S009','MH05',10);

insert into mark values('S010','MH01',6.5);
insert into mark values('S010','MH02',8);
insert into mark values('S010','MH03',5.5);
insert into mark values('S010','MH04',4);
insert into mark values('S010','MH05',7);

UPDATE student SET studentName = 'Đỗ Đức Mạnh' WHERE studentId = 'S004';
UPDATE subject SET subjectName = 'Ngoại Ngữ' WHERE subjectId = 'MH05';
UPDATE mark SET point = 8.5 WHERE studentId = 'S009' AND subjectId = 'MH01';
UPDATE mark SET point = 7 WHERE studentId = 'S009' AND subjectId = 'MH02';
UPDATE mark SET point = 5.5 WHERE studentId = 'S009' AND subjectId = 'MH03';
UPDATE mark SET point = 6 WHERE studentId = 'S009' AND subjectId = 'MH04';
UPDATE mark SET point = 9 WHERE studentId = 'S009' AND subjectId = 'MH05';

DELETE FROM mark WHERE studentId = 'S010';
DELETE FROM student WHERE studentId = 'S010';

-- Bài 3: Truy vấn dữ liệu [25 điểm]:
SELECT * FROM student;

SELECT * FROM subject WHERE priority = 1;

SELECT studentId,studentName,YEAR(CURDATE()) - YEAR(birthday) AS 'Age',CASE gender WHEN 1 THEN 'Nam' ELSE 'Nữ' END AS 'Gender', address 
FROM student;

SELECT studentName, subjectName, point
FROM student
JOIN mark
ON student.studentId = mark.studentId
JOIN subject
ON mark.subjectId = subject.subjectId
WHERE subject.subjectName = 'Toán'
ORDER BY point desc;

SELECT CASE gender when 1 THEN 'Nam' ElSE 'Nữ' END AS Gender, COUNT(*) AS so_luong
FROM student
group by gender;

SELECT s.studentId, s.studentName, SUM(m.point) AS total_score, AVG(m.point) AS avg_score
FROM student s
JOIN mark m 
ON s.studentId = m.studentId
GROUP BY s.studentId, s.studentName;

-- Bài 4: Tạo View, Index, Procedure [20 điểm]:

CREATE VIEW STUDENT_VIEW
AS
SELECT studentId, studentName, CASE gender when 1 THEN 'Nam' ElSE 'Nữ' END AS Gender , address FROM student;
SELECT * FROM STUDENT_VIEW;

CREATE VIEW AVERAGE_MARK_VIEW
AS
SELECT s.studentId, s.studentName, AVG(m.point) as 'AVG'
FROM student s
LEFT JOIN mark m
ON s.studentId = m.studentId
GROUP BY s.studentId, s.studentName;
SELECT * FROM AVERAGE_MARK_VIEW;

CREATE UNIQUE INDEX idx_phoneNumber ON student(phoneNumber);

DELIMITER //
CREATE PROCEDURE PROC_INSERTSTUDENT(
IN stId VARCHAR(4),
stName VARCHAR(100),
bday DATE,
gd BIT(1),
arss TEXT,
pNumber VARCHAR(45))
BEGIN
insert into student values(stId,stName,bday,gd,arss,pNumber);
END;
//
-- CALL PROC_INSERTSTUDENT('S010','nguyễn thế em','1999-11-11',1,'hà nội',984678073);

DELIMITER //
CREATE PROCEDURE PROC_UPDATESUBJECT(
    IN sjId VARCHAR(4),
    sjName VARCHAR(100)
)
BEGIN
    UPDATE subject 
    SET subjectName = sjName
    WHERE subject.subjectId = sjId;
END;
//

-- CALL PROC_UPDATESUBJECT('MH04', 'Sua xong');
DELIMITER //
CREATE PROCEDURE PROC_DELETEMARK(
    IN stId VARCHAR(4)
)
BEGIN
    DELETE FROM mark WHERE studentId = stId;
END;
//
-- CALL PROC_DELETEMARK('S001');