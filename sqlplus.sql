CREATE TABLE ȸ�� (
   ȸ����ȣ int primary key,
   ȸ���� varchar(50)  
);

CREATE TABLE ����׸� (
   ����׸��ڵ� int primary key,
   ����� varchar(50)  -- ����: ��������� ����
);

CREATE TABLE �����׸� (
   ȸ����ȣ int ,
   ����׸��ڵ� int, 
   ���ǿ��� char(1),
   �����Ͻ� date,
   foreign key (ȸ����ȣ) references ȸ��(ȸ����ȣ),
   foreign key (����׸��ڵ�) references ����׸�(����׸��ڵ�)
);

CREATE TABLE �μ� (
    �μ��ڵ� VARCHAR(50) PRIMARY KEY,
    �μ��� VARCHAR(50),
    �����μ��ڵ� VARCHAR(50),
    FOREIGN KEY (�����μ��ڵ�) REFERENCES �μ�(�μ��ڵ�)
);

INSERT INTO ���� (�μ��ڵ�, �����) VALUES
('111', '1000');
INSERT INTO ���� (�μ��ڵ�, �����) VALUES
('112', '2000');
INSERT INTO ���� (�μ��ڵ�, �����) VALUES
('121', '1500');
INSERT INTO ���� (�μ��ڵ�, �����) VALUES
('122', '1000');
INSERT INTO ���� (�μ��ڵ�, �����) VALUES
('131', '1500');
INSERT INTO ���� (�μ��ڵ�, �����) VALUES
('132', '2000');
INSERT INTO ���� (�μ��ڵ�, �����) VALUES
('211', '2000');
INSERT INTO ���� (�μ��ڵ�, �����) VALUES
('212', '1500');
INSERT INTO ���� (�μ��ڵ�, �����) VALUES
('221', '1000');
INSERT INTO ���� (�μ��ڵ�, �����) VALUES
('222', '2000');


SELECT C.������ID, C.��������
FROM �� A INNER JOIN ��õ������ B ON (A.��ID = B.��ID) 
INNER JOIN ������ C ON (B.������ID = C.������ID) 
WHERE A.�� ="1" 
AND B.��õ������� = TO_CHAR(SYSDATE, 'YYYY.MM.DD')
AND NOT EXISTS(SELECT X.������ID                
FROM ��ȣ������ X                
WHERE X.��ID = B.��ID);

SELECT C.������ID, C.��������
FROM �� A INNER JOIN ��õ������ B ON (A.��ID = 1 
AND A.��ID = B.��ID) 
INNER JOIN ������ C ON (B.������ID = C.������ID) 
RIGHT OUTER JOIN ��ȣ������ D ON (B.��ID = D.��ID AND B.������ID = D.������ID)
WHERE B.��õ������� = TO_CHAR(SYSDATE, 'YYYY.MM.DD')
AND B.������ID IS NOT NULL;

SELECT C.������ID, C.��������
FROM �� A 
INNER JOIN ��õ������ B ON (A.��ID = B.��ID) 
INNER JOIN ������ C ON (B.������ID = C.������ID) 
LEFT OUTER JOIN ��ȣ������ D ON (B.��ID = D.��ID  AND B.������ID = D.������ID)
WHERE A.��ID = 2 
AND B.��õ������� = TO_CHAR(SYSDATE, 'YYYY.MM.DD')
AND D.������ID IS NULL;

SELECT C.������ID, C.��������
FROM �� A 
INNER JOIN ��õ������ B ON (A.��ID = 2  
AND A.��ID = B.��ID) 
INNER JOIN ������ C ON (B.������ID = C.������ID)
WHERE B.��õ������� = TO_CHAR(SYSDATE, 'YYYY.MM.DD')
AND NOT EXISTS (SELECT X.������ID                
FROM ��ȣ������ X                    
WHERE X.��ID = B.��ID                    
AND X.������ID = B.������ID);


SELECT A.����ȣ, A.����, B.�ܸ���ID, B.�ܸ����, C.OSID, C.OS��
FROM �� A 
LEFT OUTER JOIN �ܸ��� B ON (A.����ȣ IN (11000, 12000) AND A.�ܸ���ID = B.�ܸ���ID) 
LEFT OUTER JOIN OS CB ON (B.OSID = C.OSID)
ORDER BY A.����ȣ;

SELECT A.����ȣ, A.����, B.�ܸ���ID, B.�ܸ����, C.OSID, C.OS��
FROM �� A LEFT OUTER JOIN �ܸ��� B
ON (A.����ȣ IN (11000, 12000) AND A.�ܸ���ID = B.�ܸ���ID) LEFT OUTER JOIN OS C
ON (B.OSID = C.OSID)
ORDER BY A.����ȣ;

SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM DEPT D LEFT OUTER JOIN EMP E ON D.DEPTNO = E.DEPTNO;


SELECT ENAME AAA, JOB AAB
FROM EMP
WHERE EMPNO = 7369
UNION ALL
SELECT ENAME BBA, JOB BBB
FROM EMP
WHERE EMPNO = 7566
ORDER BY 1, 2;

SELECT COL1, COL2, COUNT(*) AS CNT
FROM (SELECT COL1, COL2      
FROM TBL1      
UNION ALL      
SELECT COL1, COL2      
FROM TBL2      
UNION      
SELECT COL1, COL2     
FROM TBL1)
GROUP BY COL1, COL2;


SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�, B.�����, LVL
FROM (SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL      
FROM �μ�      
START WITH �μ��ڵ� = '120'      
CONNECT BY PRIOR �����μ��ڵ� = �μ��ڵ�      
UNION      
SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL      
FROM �μ�      
START WITH �μ��ڵ� = '120'      
CONNECT BY �����μ��ڵ� = PRIOR �μ��ڵ�) A 
LEFT OUTER JOIN ���� B ON (A.�μ��ڵ� = B.�μ��ڵ�)
ORDER BY A.�μ��ڵ�;


SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�, B.�����, LVL
FROM (SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL      
FROM �μ�      
START WITH �μ��ڵ� = '100'      
CONNECT BY �����μ��ڵ� = PRIOR �μ��ڵ�) A 
LEFT OUTER JOIN ���� B ON (A.�μ��ڵ� = B.�μ��ڵ�)
ORDER BY A.�μ��ڵ�;

SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�,  B.�����
FROM (SELECT �μ��ڵ�, �μ��������μ��ڵ�, LEVEL AS LVL 
FROM �μ�      
START WITH �μ��ڵ� = '121'      
CONNECT BY PRIOR �����μ��ڵ� = �μ��ڵ�)A 
LEFT OUTER JOIN ���� B ON (A.�μ��ڵ� = B.�μ��ڵ�)
ORDER BY A.�μ��ڵ�;

SELECT COUNT(DISTINCT A || B)
FROM EMP1 WHERE D = (SELECT D FROM DEPT1 WHERE E = 'i');

CREATE TABLE �μ�1 (
    �μ��ڵ� VARCHAR(50) PRIMARY KEY,
    �μ��� VARCHAR(50),
    �����μ��ڵ� VARCHAR(50),
    ����� VARCHAR(50),
    FOREIGN KEY (�����μ��ڵ�) REFERENCES �μ�1(�μ��ڵ�)
);

CREATE TABLE �μ��ӽ� (
    �μ��ڵ� VARCHAR(50),
    �������� DATE,
    ����� VARCHAR(50),
    PRIMARY KEY (�μ��ڵ�, ��������),
    FOREIGN KEY (�μ��ڵ�) REFERENCES �μ�1(�μ��ڵ�)
);

INSERT INTO �μ�1 (�μ��ڵ�, �μ���, �����μ��ڵ�, �����) VALUES
('A001', '��ǥ�̻�', NULL, '���ǥ');
INSERT INTO �μ�1 (�μ��ڵ�, �μ���, �����μ��ڵ�, �����) VALUES
('A002', '��������', 'A001', 'ȫ�浿');
INSERT INTO �μ�1 (�μ��ڵ�, �μ���, �����μ��ڵ�, �����) VALUES
('A003', '�濵����', 'A001', '�̼���');
INSERT INTO �μ�1 (�μ��ڵ�, �μ���, �����μ��ڵ�, �����) VALUES
('A004', '������', 'A001', '������');
INSERT INTO �μ�1 (�μ��ڵ�, �μ���, �����μ��ڵ�, �����) VALUES
('A005', '�ؿܿ���', 'A002', '��û��');
INSERT INTO �μ�1 (�μ��ڵ�, �μ���, �����μ��ڵ�, �����) VALUES
('A006', '��������', 'A002', '������');
INSERT INTO �μ�1 (�μ��ڵ�, �μ���, �����μ��ڵ�, �����) VALUES
('A007', '�ѹ���', 'A003', '���θ�');
INSERT INTO �μ�1 (�μ��ڵ�, �μ���, �����μ��ڵ�, �����) VALUES
('A008', '�λ���', 'A003', '�̹���');
INSERT INTO �μ�1 (�μ��ڵ�, �μ���, �����μ��ڵ�, �����) VALUES
('A009', '�ؿܸ�����', 'A004', '�̺���');
INSERT INTO �μ�1 (�μ��ڵ�, �μ���, �����μ��ڵ�, �����) VALUES
('A010', '����������', 'A004', '���¿�');

-- �μ��ӽ� ���̺� ������ ����
INSERT INTO �μ��ӽ� (�μ��ڵ�, ��������, �����) VALUES
('A007', '2024-02-22', '�̴���');
INSERT INTO �μ��ӽ� (�μ��ڵ�, ��������, �����) VALUES
('A007', '2024-02-23', 'ȫ���');
INSERT INTO �μ��ӽ� (�μ��ڵ�, ��������, �����) VALUES
('A008', '2024-02-24', '���缮');

UPDATE �μ�1 A SET ����� = (SELECT B.�����
    FROM �μ��ӽ� B
    WHERE B.�μ��ڵ� = A.�μ��ڵ�
    AND B.�������� = (SELECT MAX(C.��������)
                     FROM �μ��ӽ� C 
                     WHERE C.�μ��ڵ� = B.�μ��ڵ�))
WHERE �μ��ڵ� IN (SELECT �μ��ڵ� FROM �μ��ӽ�);
ROLLBACK;

SELECT C.�μ��ڵ�    
    FROM (
        SELECT �μ��ڵ�, MAX(��������) AS ��������          
        FROM �μ��ӽ�          
        GROUP BY �μ��ڵ�
    ) B, �μ��ӽ� C    
    WHERE B.�μ��ڵ� = C.�μ��ڵ�    
    AND B.�������� = C.�������� ;   

    
SELECT �μ��ڵ�, MAX(��������) AS ��������          
    FROM �μ��ӽ�          
    GROUP BY �μ��ڵ�;
    
    UPDATE �μ�1 A SET ����� = (
    SELECT C.�μ��ڵ�    
    FROM (
        SELECT �μ��ڵ�, MAX(��������) AS ��������          
        FROM �μ��ӽ�          
        GROUP BY �μ��ڵ�
    ) B, �μ��ӽ� C    
    WHERE B.�μ��ڵ� = C.�μ��ڵ�    
    AND B.�������� = C.��������    
    AND A.�μ��ڵ� = C.�μ��ڵ�
)
WHERE EXISTS (
    SELECT 1 FROM �μ��ӽ� C WHERE A.�μ��ڵ� = C.�μ��ڵ�
);


CREATE TABLE TBL3 (
    C1 VARCHAR(50),
    C2 INT

);

INSERT INTO TBL3 (C1, C2) VALUES
('A', 100);
INSERT INTO TBL3 (C1, C2) VALUES
('B', 200);
INSERT INTO TBL3 (C1, C2) VALUES
('B', 100);
INSERT INTO TBL3 (C1, C2) VALUES
('B', NULL);
INSERT INTO TBL3 (C1, C2) VALUES
(NULL, 200);

SELECT *
FROM TBL3;

CREATE VIEW V_TBL AS
SELECT *
FROM TBL3
WHERE C1 = 'B' OR C1 IS NULL;


CREATE TABLE ��(
    ���ڵ� varchar(50) primary key,
    �𵨸� varchar(50),
    a�����ڵ�1 varchar(50),
    b�����ڵ�2 varchar(50),
    c�����ڵ�3 varchar(50),
    d�����ڵ�4 varchar(50),
    e�����ڵ�5 varchar(50),
    f�����ڵ�6 varchar(50),
    �𵨸� varchar(50),
    ���� varchar(50),
    ���� varchar(50)
   
);

CREATE TABLE SCOTT.BONUS1 (
    ENAME VARCHAR2(10 BYTE),
    JOB VARCHAR2(9 BYTE),
    SAL NUMBER,
    COMM NUMBER
) 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
TABLESPACE USERS;

select * 
from EMP2;

insert into bonus1 (ENAME,JOB,SAL,COMM)
select a, b,c,d
from emp1;


  CREATE TABLE "SCOTT"."EMP2" 
   (	"A" NUMBER(*,0), 
	"B" CHAR(1 BYTE), 
	"C" NUMBER(*,0), 
	"D" CHAR(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  
  
insert into EMP2 (A,B,C,D)
select a, b,c,d
from emp1;


create table a 
( a varchar(10) not null,
b varchar (10)
);
alter table a add constraint pk_a primary key (a);

alter table  a MODIFY (b date);
INSERT INTO a(A,B) VALUES('A',SYSDATE);
SELECT*
FROM A;


CREATE TABLE T(C INTEGER PRIMARY KEY, D INTEGER); 
CREATE TABLE S(B INTEGER PRIMARY KEY, C INTEGER REFERENCES T(C) ON DELETE CASCADE); 
CREATE TABLE R(A INTEGER PRIMARY KEY, B INTEGER REFERENCES S(B) ON DELETE SET NULL);

INSERT INTO T VALUES(1,1);
INSERT INTO T VALUES(2,1);

INSERT INTO S VALUES(1,1);
INSERT INTO S VALUES(2,1);

INSERT INTO R VALUES(1,1);
INSERT INTO R VALUES(2,2);

DELETE FROM T; 
SELECT *
FROM S;
ROLLBACK;

CREATE TABLE ����(    
���񽺹�ȣ VARCHAR2(10) PRIMARY KEY,    
���񽺸� VARCHAR2(100) NULL,    
�������� DATE NOT NULL);?

INSERT INTO ���� VALUES(1,1,SYSDATE);
SELECT *
FROM ����
WHERE ���񽺹�ȣ = '1';
INSERT INTO ���� VALUES ('999', '', '2015-11-11');
INSERT INTO ���� VALUES ('990',NULL , '2015-11-11');
SELECT *
FROM ����;

SELECT * FROM ���� WHERE ���񽺸� IS NULL;



CREATE TABLE SVC_JOIN(    
��ID VARCHAR2(10) NOT NULL,    
����ID VARCHAR2(5) NOT NULL,  
�������� VARCHAR2(8) NOT NULL,
���Խð�  VARCHAR2(4) NOT NULL,
���񽺽����Ͻ� DATE NULL,
���������Ͻ� DATE NULL ,
PRIMARY KEY (��ID, ����ID,��������,���Խð� )
);?

INSERT INTO SVC_JOIN (��ID, ����ID, ��������, ���Խð�, ���񽺽����Ͻ�, ���������Ͻ�)
VALUES ('C001', 'S001', '20141201', '0800', TO_DATE('201412010800', 'YYYYMMDDHH24MI'), TO_DATE('201501010000', 'YYYYMMDDHH24MI'));

INSERT INTO SVC_JOIN (��ID, ����ID, ��������, ���Խð�, ���񽺽����Ͻ�, ���������Ͻ�)
VALUES ('C002', 'S002', '20141201', '0930', TO_DATE('201412010930', 'YYYYMMDDHH24MI'), TO_DATE('201501010000', 'YYYYMMDDHH24MI'));

INSERT INTO SVC_JOIN (��ID, ����ID, ��������, ���Խð�, ���񽺽����Ͻ�, ���������Ͻ�)
VALUES ('C003', 'S001', '20141201', '1030', TO_DATE('201412011030', 'YYYYMMDDHH24MI'), TO_DATE('201501010000', 'YYYYMMDDHH24MI'));

INSERT INTO SVC_JOIN (��ID, ����ID, ��������, ���Խð�, ���񽺽����Ͻ�, ���������Ͻ�)
VALUES ('C004', 'S003', '20141201', '1200', TO_DATE('201412011200', 'YYYYMMDDHH24MI'), TO_DATE('201501010000', 'YYYYMMDDHH24MI'));

INSERT INTO SVC_JOIN (��ID, ����ID, ��������, ���Խð�, ���񽺽����Ͻ�, ���������Ͻ�)
VALUES ('C005', 'S002', '20141201', '1500', TO_DATE('201412011500', 'YYYYMMDDHH24MI'), TO_DATE('201501010000', 'YYYYMMDDHH24MI'));

SELECT *
FROM SVC_JOIN;


SELECT ����ID, COUNT(*) AS CNT 
FROM SVC_JOIN 
WHERE ���������Ͻ� >= TO_DATE('20150101000000', 'YYYYMMDDHH24MISS')
AND ���������Ͻ� <= TO_DATE('20150131235959', 'YYYYMMDDHH24MISS')
AND CONCAT(��������, ���Խð�) = '2014120100'
GROUP BY ����ID;

-- SQL �⺻ ���� 42
CREATE TABLE Sample_Table (
    sample_date TIMESTAMP
);

-- ������ ������ ����
INSERT INTO Sample_Table (sample_date)
VALUES 
(TO_TIMESTAMP('2015-01-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));

SELECT TO_CHAR(TO_DATE('2015.01.10 10', 'YYYY.MM.DD HH24')+ 1/24/(60/10), 'YYYY.MM.DD HH24:MI:SS') FROM Sample_Table;

--�⺻ 43

CREATE TABLE DEPT2 (
    DEPTNO INT,
    LOC VARCHAR(50)
);

-- ������ ������ ����
INSERT INTO DEPT2 (DEPTNO, LOC) VALUES (10, 'NEW YORK');
INSERT INTO DEPT2 (DEPTNO, LOC) VALUES (20, 'CHICAGO');
INSERT INTO DEPT2 (DEPTNO, LOC) VALUES (30, 'LOS ANGELES');
INSERT INTO DEPT2 (DEPTNO, LOC) VALUES (40, 'DALLAS');


SELECT LOC,  CASE WHEN LOC = 'NEW YORK' THEN 'EAST'   ELSE 'ETC'    END as AREA
FROM DEPT2; 


SELECT LOC,  CASE  LOC WHEN 'NEW YORK' THEN 'EAST'    ELSE 'ETC'    END as AREA
FROM DEPT2; 


--�⺻ 44 

-- PLAYER ���̺� ����
CREATE TABLE PLAYER (
    PLAYER_ID INT PRIMARY KEY,
    TEAM_ID INT,
    POSITION VARCHAR(2)
);
ALTER TABLE PLAYER DROP COLUMN PLAYER_ID;
-- ������ ������ ����
INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, POSITION) VALUES (1, 1, 'FW');
INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, POSITION) VALUES (2, 1, 'FW');
INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, POSITION) VALUES (3, 1, 'MF');
INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, POSITION) VALUES (4, 1, 'DF');
INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, POSITION) VALUES (5, 2, 'FW');
INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, POSITION) VALUES (6, 2, 'FW');
INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, POSITION) VALUES (7, 2, 'MF');
INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, POSITION) VALUES (8, 2, 'GK');

SELECT *
FROM PLAYER;

-- �ַ� ����
SELECT TEAM_ID,    
NVL(SUM(CASE POSITION WHEN = 'FW' THEN 1 END), 0) FW,    
NVL(SUM(CASE POSITION WHEN = 'MF' THEN 1 END), 0) MF,    
NVL(SUM(CASE POSITION WHEN = 'DF' THEN 1 END), 0) DF,    
NVL(SUM(CASE POSITION WHEN = 'GK' THEN 1 END), 0) GK,        
COUNT(*) SUM        
FROM PLAYER        
GROUP BY TEAM_ID;

-- �ߵǴ� ����
SELECT 
    TEAM_ID,
    NVL(SUM(CASE WHEN POSITION = 'FW' THEN 1 END), 0) FW,
    NVL(SUM(CASE WHEN POSITION = 'MF' THEN 1 END), 0) MF,
    NVL(SUM(CASE WHEN POSITION = 'DF' THEN 1 END), 0) DF,
    NVL(SUM(CASE WHEN POSITION = 'GK' THEN 1 END), 0) GK,
    COUNT(*) AS SUM
FROM 
    PLAYER
GROUP BY 
    TEAM_ID;
    
-- ����� ��� 444    
SELECT TEAM_ID,
    NVL(SUM(CASE WHEN POSITION= 'FW' THEN 1 ELSE 1 END), 0) FW,
    NVL(SUM(CASE WHEN POSITION = 'MF' THEN 1 ELSE 1 END), 0) MF,
    NVL(SUM(CASE WHEN POSITION = 'DF' THEN 1 ELSE 1 END), 0) DF,
    NVL(SUM(CASE WHEN POSITION = 'GK' THEN 1 ELSE 1 END), 0) GK,
        COUNT(*) SUM
        FROM PLAYER
        GROUP BY TEAM_ID;
        
        
        
--���� SQL �⺻ 45 

CREATE TABLE TAB2 (
    COL1 VARCHAR2(1),
    COL2 VARCHAR2(10)
);

INSERT INTO TAB2 (COL1, COL2) VALUES ('a', NULL);
INSERT INTO TAB2 (COL1, COL2) VALUES ('b', '');
INSERT INTO TAB2 (COL1, COL2) VALUES ('c', '3');
INSERT INTO TAB2 (COL1, COL2) VALUES ('d', '4');
INSERT INTO TAB2 (COL1, COL2) VALUES ('e', '5');

SELECT COL2 FROM TAB2 WHERE COL1 = 'b';
-- SQL SERVER������ �ȴ�.
SELECT ISNULL(COL2, 'X') FROM TAB2 WHERE COL1 = 'a';
SELECT NVL(COL2, 'X') FROM TAB2 WHERE COL1 = 'a';



SELECT COUNT(COL1) FROM TAB2 WHERE COL2 = NULL;
SELECT COUNT(COL2) FROM TAB2 WHERE COL1 IN ('b', 'c');



-- SQL �⺻ 48
CREATE TABLE TAB3 (
    C1 INT,
    C2 INT,
    C3 INT
);

TRUNCATE TABLE  TAB3;


INSERT INTO TAB3 (C1, C2, C3) VALUES (1,2,3);
INSERT INTO TAB3 (C1, C2, C3) VALUES (NULL,4,3);
INSERT INTO TAB3 (C1, C2, C3) VALUES (NULL,NULL,5);

SELECT*
FROM TAB3;
-- G
SELECT COALESCE(C1, C2, C3)FROM TAB3;
SELECT COUNT(C3+C2+C1) FROM TAB3;

SELECT COUNT(*)
FROM TAB3
WHERE C1 IS NOT NULL OR C2 IS NOT NULL OR C3 IS NOT NULL;

SELECT COUNT(*)
FROM TAB3
WHERE C1 IS NULL;

SELECT COUNT(*) AS total_count
FROM TAB3;
--SUM() �Լ� ���ο��� COUNT() �Լ��� ����Ͽ� ��ø�� �׷� �Լ��� �߻��߱� ���� ����
SELECT
SUM(
    COUNT(CASE WHEN C1 IS NOT NULL THEN 1 END) +
    COUNT(CASE WHEN C2 IS NOT NULL THEN 1 END) +
    COUNT(CASE WHEN C3 IS NOT NULL THEN 1 END) ) AS �Ѱ�
FROM TAB3;


SELECT
    SUM(
        CASE WHEN C1 IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN C2 IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN C3 IS NOT NULL THEN 1 ELSE 0 END
    ) AS �Ѱ�
FROM TAB3;

-- SQL Ȱ�� ����2 
SELECT C.������ID, C.��������
FROM �� A
INNER JOIN ��õ������ B ON (A.��ID = B.��ID)
INNER JOIN ������ C ON (B.������ID = C.������ID)
LEFT OUTER JOIN ��ȣ������ D ON (B.��ID = D.��ID AND B.������ID = D.������ID)
WHERE A.��ID = 1
AND B.��õ������� = TO_CHAR(SYSDATE, 'YYYY.MM.DD')
AND D.������ID IS NULL;

--SQL Ȱ�� ���� 3
CREATE TABLE ��ǰ(
��ǰ�ڵ� INT PRIMARY KEY,
��ǰ�� VARCHAR(20),
��ǰ�����ڵ� INT,
���� VARCHAR(20));

CREATE TABLE ������� (
���ι�ȣ INT PRIMARY KEY,
���ʰ������� DATE);

CREATE TABLE ������ǰ (
���ι�ȣ INT ,
��ǰ�ڵ� INT,
PRIMARY KEY(���ι�ȣ,��ǰ�ڵ�),
FOREIGN KEY (���ι�ȣ) REFERENCES �������(���ι�ȣ),
FOREIGN KEY (��ǰ�ڵ�) REFERENCES ��ǰ(��ǰ�ڵ�));

-- ��ǰ ���̺� ������ �߰�
INSERT INTO ��ǰ (��ǰ�ڵ�, ��ǰ��, ��ǰ�����ڵ�, ����) VALUES
(1, '���', 101, '��');
INSERT INTO ��ǰ (��ǰ�ڵ�, ��ǰ��, ��ǰ�����ڵ�, ����) VALUES
(2, '�ٳ���', 102, '��');
INSERT INTO ��ǰ (��ǰ�ڵ�, ��ǰ��, ��ǰ�����ڵ�, ����) VALUES
(3, '����', 103, '��');

-- ������� ���̺� ������ �߰�
INSERT INTO ������� (���ι�ȣ, ���ʰ�������) VALUES
(101, TO_DATE('2024-02-24', 'YYYY-MM-DD'));
INSERT INTO ������� (���ι�ȣ, ���ʰ�������) VALUES
(102, TO_DATE('2024-02-25', 'YYYY-MM-DD'));
INSERT INTO ������� (���ι�ȣ, ���ʰ�������) VALUES
(103, TO_DATE('2024-02-26', 'YYYY-MM-DD'));

-- ������ǰ ���̺� ������ �߰�
INSERT INTO ������ǰ (���ι�ȣ, ��ǰ�ڵ�) VALUES
(101, 1);
INSERT INTO ������ǰ (���ι�ȣ, ��ǰ�ڵ�) VALUES
(102, 2);
INSERT INTO ������ǰ (���ι�ȣ, ��ǰ�ڵ�) VALUES
(103, 3);
INSERT INTO ������ǰ (���ι�ȣ, ��ǰ�ڵ�) VALUES
(101, 2);
INSERT INTO ������ǰ (���ι�ȣ, ��ǰ�ڵ�) VALUES
(102, 3);


--SQL Ȱ�� 4�� 68��
--���̺���� �����ϱ� ���ؼ��� ALTER TABLE ���� ����մϴ�. �Ʒ��� ���̺���� �����ϴ� SQL ���� �����Դϴ�.

--sql
--Copy code
ALTER TABLE �������̺��
RENAME TO ���������̺��;
���� ���, "��" ���̺��� �̸��� "�ű԰�"���� �����Ϸ��� ������ ���� �ۼ��� �� �ֽ��ϴ�.

--sql
--Copy code
ALTER TABLE ��
RENAME TO �ű԰�;

CREATE TABLE ��_68 (
    ����ȣ INT PRIMARY KEY,
    �̸� VARCHAR(50),
    ��� VARCHAR(20)
);

CREATE TABLE ��������_68 (
    ���Ź�ȣ INT PRIMARY KEY,
    ���űݾ� DECIMAL(10, 2),
    ����ȣ INT,
    FOREIGN KEY (����ȣ) REFERENCES ��_68(����ȣ)
);

-- �� ���̺� ������ ����
INSERT INTO ��_68 (����ȣ, �̸�, ���) VALUES
(1, '��1', '�Ϲ�');
INSERT INTO ��_68 (����ȣ, �̸�, ���) VALUES
(2, '��2', '���');
INSERT INTO ��_68 (����ȣ, �̸�, ���) VALUES
(3, '��3', '�Ϲ�');
INSERT INTO ��_68 (����ȣ, �̸�, ���) VALUES
(4, '��4', '���');
INSERT INTO ��_68 (����ȣ, �̸�, ���) VALUES
(5, '��5', '�Ϲ�');

-- �������� ���̺� ������ ����
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(1, 10000, 1);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(2, 20000, 1);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(3, 15000, 2);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(4, 30000, 3);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(5, 25000, 4);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(6, 18000, 1);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(7, 22000, 2);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(8, 21000, 1);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(9, 28000, 2);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(10, 35000, 3);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(11, 23000, 5);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(12, 27000, 4);
INSERT INTO ��������_68 (���Ź�ȣ, ���űݾ�, ����ȣ) VALUES
(13, 32000, 3);
SELECT * FROM ��������_68;
SELECT A.�̸�, A.���, COUNT(*)
FROM ��_68 A
INNER JOIN ��������_68 B ON (A.����ȣ = B.����ȣ)
GROUP BY A.�̸�, A.���
HAVING COUNT(*) >=3;

-- 69�� Ȱ�� 6��


-- �ð��뺰��뷮 ���̺� ����
CREATE TABLE �ð��뺰��뷮_69 (
    ��뷮 INT,
    ���ð��� INT,
    ��ID INT,
    PRIMARY KEY (��ID,���ð���),
    FOREIGN KEY (��ID) REFERENCES ��_69 (��ID)
);

-- �ð��뱸�� ���̺� ����
CREATE TABLE �ð��뱸��_69  (
    ���۽ð��� INT,
    ����ð��� INT,
    PRIMARY KEY (���۽ð���,����ð���),
    �ܰ� DECIMAL(10, 2)
);

-- �� ���̺� ����
CREATE TABLE ��_69  (
    ��ID INT PRIMARY KEY,
    ���� VARCHAR(50),
    ������� DATE 
);

INSERT INTO ��_69  (��ID, ����, �������) VALUES
(1, '��1', '1990-01-01');
INSERT INTO ��_69  (��ID, ����, �������) VALUES
(2, '��2', '1985-05-15');
INSERT INTO ��_69  (��ID, ����, �������) VALUES
(3, '��3', '1992-11-30');

-- �ð��뱸�� ���̺� ������ ����
INSERT INTO �ð��뱸��_69  (���۽ð���, ����ð���, �ܰ�) VALUES
(0, 6, 10.0);
INSERT INTO �ð��뱸��_69  (���۽ð���, ����ð���, �ܰ�) VALUES
(7, 12, 12.0);
INSERT INTO �ð��뱸��_69  (���۽ð���, ����ð���, �ܰ�) VALUES
(13, 18, 15.0);
INSERT INTO �ð��뱸��_69  (���۽ð���, ����ð���, �ܰ�) VALUES
(19, 23, 11.0);

-- �ð��뺰��뷮 ���̺� ������ ����
INSERT INTO �ð��뺰��뷮_69  (��뷮, ���ð���, ��ID) VALUES
(5, 8, 1);
INSERT INTO �ð��뺰��뷮_69  (��뷮, ���ð���, ��ID) VALUES
(10, 15, 1);
INSERT INTO �ð��뺰��뷮_69  (��뷮, ���ð���, ��ID) VALUES
(8, 21, 2);
INSERT INTO �ð��뺰��뷮_69  (��뷮, ���ð���, ��ID) VALUES
(6, 10, 2);
INSERT INTO �ð��뺰��뷮_69  (��뷮, ���ð���, ��ID) VALUES
(12, 17, 3);

SELECT *
FROM �ð��뺰��뷮_69,�ð��뱸��_69,��_69

SELECT A.��ID, A.����, B.��뷮 * C.�ܰ� AS ���ݾ�
FROM ��_69 A
INNER JOIN �ð��뺰��뷮_69 B ON(A.��ID = B.��ID)
INNER JOIN �ð��뱸��_69 C ON (B.���ð��� BETWEEN C.���۽ð��� AND C.����ð���)

SELECT A.��ID, A.����, SUM(B.��뷮 * C.�ܰ�) AS ���ݾ�
FROM ��_69 A
INNER JOIN �ð��뺰��뷮_69 B ON(A.��ID = B.��ID)
INNER JOIN �ð��뱸��_69 C ON (B.���ð��� BETWEEN C.���۽ð��� AND C.����ð���)
GROUP BY A.��ID, A.����
ORDER BY A.��ID, A.����


-- 70�� Ȱ�� 6��

-- ���� ���̺� ����
CREATE TABLE STADIUM_70 (
    STADIUM_ID INT PRIMARY KEY,
    STADIUM_NAME VARCHAR(100),
    LOCATION VARCHAR(100)
);

-- �� ���̺� ����
CREATE TABLE TEAM_70 (
    TEAM_ID INT PRIMARY KEY,
    REGION_NAME VARCHAR(100),
    TEAM_NAME VARCHAR(100),
    STADIUM_ID INT,
    FOREIGN KEY (STADIUM_ID) REFERENCES STADIUM_70(STADIUM_ID)
);


-- �� ���̺� ���� ������ ����
INSERT INTO TEAM_70 (TEAM_ID, REGION_NAME, TEAM_NAME, STADIUM_ID) VALUES
(1, 'Region A', 'Team X', 101);
INSERT INTO TEAM_70 (TEAM_ID, REGION_NAME, TEAM_NAME, STADIUM_ID) VALUES
(2, 'Region B', 'Team Y', 102);
INSERT INTO TEAM_70 (TEAM_ID, REGION_NAME, TEAM_NAME, STADIUM_ID) VALUES
(3, 'Region C', 'Team Z', 103);

-- ���� ���̺� ���� ������ ����
INSERT INTO STADIUM_70 (STADIUM_ID, STADIUM_NAME, LOCATION) VALUES
(101, 'Stadium A', 'Location A');
INSERT INTO STADIUM_70 (STADIUM_ID, STADIUM_NAME, LOCATION) VALUES
(102, 'Stadium B', 'Location B');
INSERT INTO STADIUM_70 (STADIUM_ID, STADIUM_NAME, LOCATION) VALUES
(103, 'Stadium C', 'Location C');

SELECT *
FROM STADIUM_70, TEAM_70;

SELECT TEAM_70.REGION_NAME, TEAM_70.TEAM_NAME, TEAM_70.STADIUM_ID, STADIUM_70.STADIUM_NAME    
FROM TEAM_70 
INNER JOIN STADIUM_70 ON (TEAM_70.STADIUM_ID = STADIUM_70.STADIUM_ID);

SELECT T.REGION_NAME, T.TEAM_NAME, T.STADIUM_ID, S.STADIUM_NAME   
FROM TEAM_70 T, STADIUM_70 S    
WHERE T.STADIUM_ID = S.STADIUM_ID;

SELECT TEAM_70.REGION_NAME, TEAM_70.TEAM_NAME,TEAM_70.STADIUM_ID, STADIUM_70.STADIUM_NAME    
FROM TEAM_70, STADIUM_70   
WHERE TEAM_70.STADIUM_ID = STADIUM_70.STADIUM_ID;

--���� ���� 
SELECT T.REGION_NAME, T.TEAM_NAME, T.STADIUM_ID, S.STADIUM_NAME   
FROM TEAM_70 T 
INNER JOIN STADIUM_70 S    
USING (STADIUM_ID);



-- 72�� Ȱ�� ���� 8��
ALTER TABLE ��1 RENAME TO ��_72;
ALTER TABLE �ܰ� RENAME TO �ܸ���_72;
ALTER TABLE OS RENAME TO 0S_72;

SELECT *
FROM ��_72, �ܸ���_72;

SELECT A.����ȣ, A.����, B.�ܸ���ID, B.�ܸ����, C.OSID, C.OS��
FROM ��_72 A  LEFT OUTER JOIN �ܸ���_72 B 
ON (A.����ȣ IN (11000, 12000) AND A.�ܸ���ID = B.�ܸ���ID ) LEFT OUTER JOIN OS C   
ON (B.OSID = C.OSID)
ORDER BY A.����ȣ;

-- 73�� Ȱ�� ���� 9��

SELECT A.ID, B.ID
FROM TBL1 A 
FULL OUTER JOIN TBL2 B ON A.ID = B.ID;?


-- TBL1 ���̺� ����
CREATE TABLE TBL1_73 (
    ID INT PRIMARY KEY
);

-- TBL2 ���̺� ����
CREATE TABLE TBL2_73 (
    ID INT PRIMARY KEY
);

-- TBL1�� ������ ����
INSERT INTO TBL1_73 (ID) VALUES (1);
INSERT INTO TBL1_73 (ID) VALUES (2);
INSERT INTO TBL1_73 (ID) VALUES (3);
INSERT INTO TBL1_73 (ID) VALUES (4);
-- TBL2�� ������ ����
INSERT INTO TBL2_73 (ID) VALUES (2);
INSERT INTO TBL2_73 (ID) VALUES (3);
INSERT INTO TBL2_73 (ID) VALUES (4);
INSERT INTO TBL2_73 (ID) VALUES (5);

SELECT A.ID, B.ID
FROM TBL1_73 A FULL OUTER JOIN TBL2_73 B 
ON A.ID = B.ID;

SELECT A.ID, B.ID
FROM TBL1_73 A  LEFT OUTER JOIN TBL2_73 B 
ON A.ID = B.ID 
UNION 
SELECT A.ID, B.ID
FROM TBL1_73 A RIGHT OUTER JOIN TBL2_73 B 
ON A.ID = B.ID;

SELECT A.ID, B.ID
FROM TBL1_73 A, TBL2_73 B
WHERE A.ID = B.ID
UNION ALL
SELECT A.ID, NULL
FROM TBL1_73 A
WHERE NOT EXISTS (SELECT 1 FROM TBL2_73 B WHERE A.ID = B.ID)
UNION ALL
SELECT NULL, B.ID
FROM TBL2_73 B
WHERE NOT EXISTS (SELECT 1 FROM TBL1_73 A WHERE B.ID = A.ID);



-- 74�� Ȱ�� ���� 10��


  CREATE TABLE EMP_74
   (	"A" NUMBER(*,0), 
	"B" CHAR(1 BYTE), 
	"C" CHAR(1 BYTE)

   )

  CREATE TABLE DEPT_74
   (	"C" CHAR(1 BYTE),
	"D"  NUMBER(*,0), 
	"E"  NUMBER(*,0)

   )
   
INSERT INTO EMP_74(A,B,C) VALUES (1,'b','w');
INSERT INTO EMP_74(A,B,C) VALUES (3,'d','w');
INSERT INTO EMP_74(A,B,C) VALUES (1,'y','y');

INSERT INTO DEPT_74(C,D,E) VALUES ('w',1,10);
INSERT INTO DEPT_74(C,D,E) VALUES ('z',4,11);
INSERT INTO DEPT_74(C,D,E) VALUES ('v',2,22);

SELECT *
FROM EMP_74 LEFT OUTER JOIN DEPT_74 ON EMP_74.C = DEPT_74.C;

SELECT *
FROM EMP_74 right OUTER JOIN DEPT_74 ON EMP_74.C = DEPT_74.C;

SELECT *
FROM EMP_74 full OUTER JOIN DEPT_74 ON EMP_74.C = DEPT_74.C;


-- 75�� Ȱ�� ���� 11��

-- 76�� Ȱ�� ���� 12��

CREATE TABLE tab1_76
(	"c1" CHAR(1 BYTE) ,
   "c2" NUMBER(*,0) 
 )
 
CREATE TABLE tab2_76
(	"c1" CHAR(1 BYTE) ,
   "c2" NUMBER(*,0) 
 )
 
-- 77�� Ȱ�� ���� 13��

alter table �Խ��� rename to �Խ���_77;
alter table �Խñ� rename to �Խñ�_77;
select *
from �Խñ�_77, �Խ���_77;
--������
alter table �Խñ�_77 column ��뿩�� rename to ��������;

ALTER TABLE �Խñ�_77 RENAME COLUMN ��뿩�� TO ��������;


SELECT A.�Խ���ID, A.�Խ��Ǹ�, COUNT(B.�Խñ�ID) AS CNT
FROM �Խ���_77 A, �Խñ�_77 B
WHERE A.�Խ���ID = B.�Խ���ID(+) AND B.��������(+) = 'N' AND A.��뿩�� = 'Y'
GROUP BY A.�Խ���ID, A.�Խ��Ǹ�
ORDER BY A.�Խ���ID;


SELECT A.�Խ���ID, A.�Խ��Ǹ�, COUNT(B.�Խñ�ID) AS CNT
FROM �Խ���_77 A LEFT OUTER JOIN �Խñ�_77 B ON (A.�Խ���ID = B.�Խ���ID AND B.�������� = 'N')
WHERE A.��뿩�� = 'Y'
GROUP BY A.�Խ���ID, A.�Խ��Ǹ�
ORDER BY A.�Խ���ID;


SELECT A.�Խ���ID, A.�Խ��Ǹ�, COUNT(B.�Խñ�ID) AS CNT
FROM �Խ���_77 A 
LEFT OUTER JOIN �Խñ�_77 B ON (A.�Խ���ID = B.�Խ���ID AND A.��뿩�� = 'Y')
WHERE B.�������� = 'N'
GROUP BY A.�Խ���ID, A.�Խ��Ǹ�
ORDER BY A.�Խ���ID;

SELECT A.�Խ���ID, A.�Խ��Ǹ�, COUNT(B.�Խñ�ID) AS CNT
FROM �Խ���_77 A 
LEFT OUTER JOIN �Խñ�_77 B ON (A.�Խ���ID = B.�Խ���ID)
WHERE A.��뿩�� = 'Y' AND B.�������� = 'N'
GROUP BY A.�Խ���ID, A.�Խ��Ǹ�
ORDER BY A.�Խ���ID;

SELECT A.�Խ���ID, A.�Խ��Ǹ�, COUNT(B.�Խñ�ID) AS CNT
FROM �Խ���_77 A 
RIGHT OUTER JOIN �Խñ�_77 B ON (A.�Խ���ID = B.�Խ���ID 
AND A.��뿩�� = 'Y' AND B.�������� = 'N')
GROUP BY A.�Խ���ID, A.�Խ��Ǹ�
ORDER BY A.�Խ���ID;


-- 78�� Ȱ�� ���� 14��

-- 79�� Ȱ�� ���� 15��

-- TAB1 ���̺� ����
CREATE TABLE TAB1_79 (
    A INT,
    B VARCHAR(1)
);

-- TAB2 ���̺� ����
CREATE TABLE TAB2_79 (
    A INT,
    B VARCHAR(1)
);

-- ������ ����
INSERT INTO TAB1_79 (A, B) VALUES (1, 'x');
INSERT INTO TAB1_79 (A, B) VALUES (2, 'y');
INSERT INTO TAB1_79 (A, B) VALUES (3, 'z');

INSERT INTO TAB2_79 (A, B) VALUES (1, 'x');
INSERT INTO TAB2_79 (A, B) VALUES (4, 'w');
INSERT INTO TAB2_79 (A, B) VALUES (3, 'z');



-- 80�� Ȱ�� ���� 16��


-- ���� ���̺� ����
CREATE TABLE ����_80 (
    ����ID INT PRIMARY KEY,
    ���񽺸� VARCHAR(50),
    ����URL VARCHAR(100)
);
CREATE TABLE ȸ��_80 (
    ȸ��ID INT PRIMARY KEY ,
    ȸ���� VARCHAR(20)

)
-- �����̿� ���̺� ����
CREATE TABLE �����̿�_80 (
    ȸ��ID INT ,
    ����ID INT,
    �̿��Ͻ� DATE,
    PRIMARY KEY(ȸ��ID,����ID),
    FOREIGN KEY (ȸ��ID) REFERENCES ȸ��_80(ȸ��ID),
    FOREIGN KEY (����ID) REFERENCES ����_80(����ID)

);

-- ������ ����
-- ���� ���̺� ������ ����
INSERT INTO ����_80 (����ID, ���񽺸�, ����URL) VALUES (100, '����1', 'http://example.com/service1');
INSERT INTO ����_80 (����ID, ���񽺸�, ����URL) VALUES (200, '����2', 'http://example.com/service2');
INSERT INTO ����_80 (����ID, ���񽺸�, ����URL) VALUES (300, '����3', 'http://example.com/service3');


INSERT INTO ȸ��_80 (ȸ��ID, ȸ����) VALUES (1, '��1');
INSERT INTO ȸ��_80 (ȸ��ID, ȸ����) VALUES (2, '��2');
INSERT INTO ȸ��_80 (ȸ��ID, ȸ����) VALUES (3, '��3');

-- �����̿� ���̺� ������ ����
INSERT INTO �����̿�_80 (ȸ��ID, ����ID, �̿��Ͻ�) VALUES (1, 100, '2020.01.01');
INSERT INTO �����̿�_80 (ȸ��ID, ����ID, �̿��Ͻ�) VALUES (2, 200, '2020.01.02');
INSERT INTO �����̿�_80 (ȸ��ID, ����ID, �̿��Ͻ�) VALUES (3, 300, '2020.01.02');

SELECT A.����ID, B.���񽺸�, B.����URL
FROM 
(SELECT
����ID      
FROM ����_80      
INTERSECT      
SELECT ����ID      
FROM �����̿�_80) A, ����_80 B
WHERE A.����ID = B.����ID;

--1
SELECT B.����ID, A.���񽺸�, A.����URL
FROM ����_80 A, �����̿�_80 B
WHERE A.����ID = B.����ID;

--2
SELECT X.����ID, X.���񽺸�, X.����URL
FROM ����_80 X
WHERE NOT EXISTS (
SELECT 1                 
FROM (SELECT ����ID                        
FROM ����_80                        
MINUS                        
SELECT ����ID                        
FROM �����̿�_80) Y                  
WHERE X.����ID = Y.����ID);

--3
SELECT B.����ID, A.���񽺸�, A.����URL
FROM ����_80 A 
LEFT OUTER JOIN �����̿�_80 B ON (A.����ID = B.����ID)
WHERE B.����ID IS NULL
GROUP BY B.����ID, A.���񽺸�, A.����URL;

--4
SELECT A.����ID, A.���񽺸�, A.����URL
FROM ����_80 A
WHERE ����ID IN (
SELECT ����ID                 
FROM �����̿�_80                  
MINUS                 
SELECT ����ID                  
FROM ����_80);


-- 81�� Ȱ�� ���� 17��


-- 82�� Ȱ�� ���� 18��

-- ORDER BY 1, 2 ���� ù ��° �÷�(ENAME �Ǵ� BBA)�� �� ��° �÷�(JOB �Ǵ� BBB)�� ������ ������������ �����մϴ�. 
-- �׷��� "Jones"�� "Smith"���� ���ĺ������� ���� ������ ������ 7566�� ����� ������ ���� ��µ˴ϴ�.


-- 83�� Ȱ�� ���� 19��

ALTER TABLE TBL1 RENAME TO TABL1_83;
ALTER TABLE TBL2 RENAME TO TABL2_83;

SELECT COL1, COL2, COUNT(*) AS CNT
FROM (
SELECT COL1, COL2  FROM TABL1_83  
UNION ALL  
SELECT COL1, COL2   FROM TABL2_83   
UNION   
SELECT COL1, COL2  FROM TABL1_83)
GROUP BY COL1, COL2;


-- 84�� Ȱ�� ���� 20��

CREATE TABLE T1_84 (
A VARCHAR(10),
B VARCHAR(10),
C VARCHAR(10)

)

CREATE TABLE T2_84 (
A VARCHAR(10),
B VARCHAR(10),
C VARCHAR(10)
)

INSERT INTO T1_84 VALUES('A3','B2','C3');
INSERT INTO T1_84 VALUES('A1','B1','C1');
INSERT INTO T1_84 VALUES('A2','B3','C2');

INSERT INTO T2_84 VALUES('A1','B1','C1');
INSERT INTO T2_84 VALUES('A3','B2','C3');

SELECT A, B, C 
FROM T1_84
UNION ALL
SELECT A, B, C 
FROM T2_84;

SELECT A, B, C 
FROM T1_84
UNION 
SELECT A, B, C 
FROM T2_84;


-- 85�� Ȱ�� ���� 21��


-- 86�� Ȱ�� ���� 22��

select*
from emp;

select *
from(select empno, job,comm, deptno from emp)
pivot(count(empno) for deptno in (10,20,30));


CREATE TABLE new_table AS
SELECT *
FROM (
    SELECT *
    FROM (
        SELECT job, comm, deptno 
        FROM emp
    ) AS source_table
    PIVOT (
        COUNT(empno) 
        FOR deptno IN (10 AS "DEPT_10", 20 AS "DEPT_20", 30 AS "DEPT_30")
    ) AS pivot_table
);
