CREATE TABLE 회원 (
   회원번호 int primary key,
   회원명 varchar(50)  
);

CREATE TABLE 약관항목 (
   약관항목코드 int primary key,
   약관명 varchar(50)  -- 수정: 약관명으로 변경
);

CREATE TABLE 동의항목 (
   회원번호 int ,
   약관항목코드 int, 
   동의여부 char(1),
   동의일시 date,
   foreign key (회원번호) references 회원(회원번호),
   foreign key (약관항목코드) references 약관항목(약관항목코드)
);

CREATE TABLE 부서 (
    부서코드 VARCHAR(50) PRIMARY KEY,
    부서명 VARCHAR(50),
    상위부서코드 VARCHAR(50),
    FOREIGN KEY (상위부서코드) REFERENCES 부서(부서코드)
);

INSERT INTO 매출 (부서코드, 매출액) VALUES
('111', '1000');
INSERT INTO 매출 (부서코드, 매출액) VALUES
('112', '2000');
INSERT INTO 매출 (부서코드, 매출액) VALUES
('121', '1500');
INSERT INTO 매출 (부서코드, 매출액) VALUES
('122', '1000');
INSERT INTO 매출 (부서코드, 매출액) VALUES
('131', '1500');
INSERT INTO 매출 (부서코드, 매출액) VALUES
('132', '2000');
INSERT INTO 매출 (부서코드, 매출액) VALUES
('211', '2000');
INSERT INTO 매출 (부서코드, 매출액) VALUES
('212', '1500');
INSERT INTO 매출 (부서코드, 매출액) VALUES
('221', '1000');
INSERT INTO 매출 (부서코드, 매출액) VALUES
('222', '2000');


SELECT C.컨텐츠ID, C.컨텐츠명
FROM 고객 A INNER JOIN 추천컨텐츠 B ON (A.고객ID = B.고객ID) 
INNER JOIN 컨텐츠 C ON (B.컨텐츠ID = C.컨텐츠ID) 
WHERE A.고객 ="1" 
AND B.추천대상일자 = TO_CHAR(SYSDATE, 'YYYY.MM.DD')
AND NOT EXISTS(SELECT X.컨텐츠ID                
FROM 비선호컨텐츠 X                
WHERE X.고객ID = B.고객ID);

SELECT C.컨텐츠ID, C.컨텐츠명
FROM 고객 A INNER JOIN 추천컨텐츠 B ON (A.고객ID = 1 
AND A.고객ID = B.고객ID) 
INNER JOIN 컨텐츠 C ON (B.컨텐츠ID = C.컨텐츠ID) 
RIGHT OUTER JOIN 비선호컨텐츠 D ON (B.고객ID = D.고객ID AND B.컨텐츠ID = D.컨텐츠ID)
WHERE B.추천대상일자 = TO_CHAR(SYSDATE, 'YYYY.MM.DD')
AND B.컨텐츠ID IS NOT NULL;

SELECT C.컨텐츠ID, C.컨텐츠명
FROM 고객 A 
INNER JOIN 추천컨텐츠 B ON (A.고객ID = B.고객ID) 
INNER JOIN 컨텐츠 C ON (B.컨텐츠ID = C.컨텐츠ID) 
LEFT OUTER JOIN 비선호컨텐츠 D ON (B.고객ID = D.고객ID  AND B.컨텐츠ID = D.컨텐츠ID)
WHERE A.고객ID = 2 
AND B.추천대상일자 = TO_CHAR(SYSDATE, 'YYYY.MM.DD')
AND D.컨텐츠ID IS NULL;

SELECT C.컨텐츠ID, C.컨텐츠명
FROM 고객 A 
INNER JOIN 추천컨텐츠 B ON (A.고객ID = 2  
AND A.고객ID = B.고객ID) 
INNER JOIN 컨텐츠 C ON (B.컨텐츠ID = C.컨텐츠ID)
WHERE B.추천대상일자 = TO_CHAR(SYSDATE, 'YYYY.MM.DD')
AND NOT EXISTS (SELECT X.컨텐츠ID                
FROM 비선호컨텐츠 X                    
WHERE X.고객ID = B.고객ID                    
AND X.컨텐츠ID = B.컨텐츠ID);


SELECT A.고객번호, A.고객명, B.단말기ID, B.단말기명, C.OSID, C.OS명
FROM 고객 A 
LEFT OUTER JOIN 단말기 B ON (A.고객번호 IN (11000, 12000) AND A.단말기ID = B.단말기ID) 
LEFT OUTER JOIN OS CB ON (B.OSID = C.OSID)
ORDER BY A.고객번호;

SELECT A.고객번호, A.고객명, B.단말기ID, B.단말기명, C.OSID, C.OS명
FROM 고객 A LEFT OUTER JOIN 단말기 B
ON (A.고객번호 IN (11000, 12000) AND A.단말기ID = B.단말기ID) LEFT OUTER JOIN OS C
ON (B.OSID = C.OSID)
ORDER BY A.고객번호;

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


SELECT A.부서코드, A.부서명, A.상위부서코드, B.매출액, LVL
FROM (SELECT 부서코드, 부서명, 상위부서코드, LEVEL AS LVL      
FROM 부서      
START WITH 부서코드 = '120'      
CONNECT BY PRIOR 상위부서코드 = 부서코드      
UNION      
SELECT 부서코드, 부서명, 상위부서코드, LEVEL AS LVL      
FROM 부서      
START WITH 부서코드 = '120'      
CONNECT BY 상위부서코드 = PRIOR 부서코드) A 
LEFT OUTER JOIN 매출 B ON (A.부서코드 = B.부서코드)
ORDER BY A.부서코드;


SELECT A.부서코드, A.부서명, A.상위부서코드, B.매출액, LVL
FROM (SELECT 부서코드, 부서명, 상위부서코드, LEVEL AS LVL      
FROM 부서      
START WITH 부서코드 = '100'      
CONNECT BY 상위부서코드 = PRIOR 부서코드) A 
LEFT OUTER JOIN 매출 B ON (A.부서코드 = B.부서코드)
ORDER BY A.부서코드;

SELECT A.부서코드, A.부서명, A.상위부서코드,  B.매출액
FROM (SELECT 부서코드, 부서명，상위부서코드, LEVEL AS LVL 
FROM 부서      
START WITH 부서코드 = '121'      
CONNECT BY PRIOR 상위부서코드 = 부서코드)A 
LEFT OUTER JOIN 매출 B ON (A.부서코드 = B.부서코드)
ORDER BY A.부서코드;

SELECT COUNT(DISTINCT A || B)
FROM EMP1 WHERE D = (SELECT D FROM DEPT1 WHERE E = 'i');

CREATE TABLE 부서1 (
    부서코드 VARCHAR(50) PRIMARY KEY,
    부서명 VARCHAR(50),
    상위부서코드 VARCHAR(50),
    담당자 VARCHAR(50),
    FOREIGN KEY (상위부서코드) REFERENCES 부서1(부서코드)
);

CREATE TABLE 부서임시 (
    부서코드 VARCHAR(50),
    변경일자 DATE,
    담당자 VARCHAR(50),
    PRIMARY KEY (부서코드, 변경일자),
    FOREIGN KEY (부서코드) REFERENCES 부서1(부서코드)
);

INSERT INTO 부서1 (부서코드, 부서명, 상위부서코드, 담당자) VALUES
('A001', '대표이사', NULL, '김대표');
INSERT INTO 부서1 (부서코드, 부서명, 상위부서코드, 담당자) VALUES
('A002', '영업본부', 'A001', '홍길동');
INSERT INTO 부서1 (부서코드, 부서명, 상위부서코드, 담당자) VALUES
('A003', '경영지원', 'A001', '이순신');
INSERT INTO 부서1 (부서코드, 부서명, 상위부서코드, 담당자) VALUES
('A004', '마케팅', 'A001', '강감찬');
INSERT INTO 부서1 (부서코드, 부서명, 상위부서코드, 담당자) VALUES
('A005', '해외영업', 'A002', '이청용');
INSERT INTO 부서1 (부서코드, 부서명, 상위부서코드, 담당자) VALUES
('A006', '국내영업', 'A002', '박지성');
INSERT INTO 부서1 (부서코드, 부서명, 상위부서코드, 담당자) VALUES
('A007', '총무팀', 'A003', '차두리');
INSERT INTO 부서1 (부서코드, 부서명, 상위부서코드, 담당자) VALUES
('A008', '인사팀', 'A003', '이민정');
INSERT INTO 부서1 (부서코드, 부서명, 상위부서코드, 담당자) VALUES
('A009', '해외마케팅', 'A004', '이병헌');
INSERT INTO 부서1 (부서코드, 부서명, 상위부서코드, 담당자) VALUES
('A010', '국내마케팅', 'A004', '차승원');

-- 부서임시 테이블에 데이터 삽입
INSERT INTO 부서임시 (부서코드, 변경일자, 담당자) VALUES
('A007', '2024-02-22', '이달자');
INSERT INTO 부서임시 (부서코드, 변경일자, 담당자) VALUES
('A007', '2024-02-23', '홍경민');
INSERT INTO 부서임시 (부서코드, 변경일자, 담당자) VALUES
('A008', '2024-02-24', '유재석');

UPDATE 부서1 A SET 담당자 = (SELECT B.담당자
    FROM 부서임시 B
    WHERE B.부서코드 = A.부서코드
    AND B.변경일자 = (SELECT MAX(C.변경일자)
                     FROM 부서임시 C 
                     WHERE C.부서코드 = B.부서코드))
WHERE 부서코드 IN (SELECT 부서코드 FROM 부서임시);
ROLLBACK;

SELECT C.부서코드    
    FROM (
        SELECT 부서코드, MAX(변경일자) AS 변경일자          
        FROM 부서임시          
        GROUP BY 부서코드
    ) B, 부서임시 C    
    WHERE B.부서코드 = C.부서코드    
    AND B.변경일자 = C.변경일자 ;   

    
SELECT 부서코드, MAX(변경일자) AS 변경일자          
    FROM 부서임시          
    GROUP BY 부서코드;
    
    UPDATE 부서1 A SET 담당자 = (
    SELECT C.부서코드    
    FROM (
        SELECT 부서코드, MAX(변경일자) AS 변경일자          
        FROM 부서임시          
        GROUP BY 부서코드
    ) B, 부서임시 C    
    WHERE B.부서코드 = C.부서코드    
    AND B.변경일자 = C.변경일자    
    AND A.부서코드 = C.부서코드
)
WHERE EXISTS (
    SELECT 1 FROM 부서임시 C WHERE A.부서코드 = C.부서코드
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


CREATE TABLE 모델(
    모델코드 varchar(50) primary key,
    모델명 varchar(50),
    a유형코드1 varchar(50),
    b유형코드2 varchar(50),
    c유형코드3 varchar(50),
    d유형코드4 varchar(50),
    e유형코드5 varchar(50),
    f유형코드6 varchar(50),
    모델명 varchar(50),
    가로 varchar(50),
    세로 varchar(50)
   
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

CREATE TABLE 서비스(    
서비스번호 VARCHAR2(10) PRIMARY KEY,    
서비스명 VARCHAR2(100) NULL,    
개시일자 DATE NOT NULL);?

INSERT INTO 서비스 VALUES(1,1,SYSDATE);
SELECT *
FROM 서비스
WHERE 서비스번호 = '1';
INSERT INTO 서비스 VALUES ('999', '', '2015-11-11');
INSERT INTO 서비스 VALUES ('990',NULL , '2015-11-11');
SELECT *
FROM 서비스;

SELECT * FROM 서비스 WHERE 서비스명 IS NULL;



CREATE TABLE SVC_JOIN(    
고객ID VARCHAR2(10) NOT NULL,    
서비스ID VARCHAR2(5) NOT NULL,  
가입일자 VARCHAR2(8) NOT NULL,
가입시간  VARCHAR2(4) NOT NULL,
서비스시작일시 DATE NULL,
서비스종료일시 DATE NULL ,
PRIMARY KEY (고객ID, 서비스ID,가입일자,가입시간 )
);?

INSERT INTO SVC_JOIN (고객ID, 서비스ID, 가입일자, 가입시간, 서비스시작일시, 서비스종료일시)
VALUES ('C001', 'S001', '20141201', '0800', TO_DATE('201412010800', 'YYYYMMDDHH24MI'), TO_DATE('201501010000', 'YYYYMMDDHH24MI'));

INSERT INTO SVC_JOIN (고객ID, 서비스ID, 가입일자, 가입시간, 서비스시작일시, 서비스종료일시)
VALUES ('C002', 'S002', '20141201', '0930', TO_DATE('201412010930', 'YYYYMMDDHH24MI'), TO_DATE('201501010000', 'YYYYMMDDHH24MI'));

INSERT INTO SVC_JOIN (고객ID, 서비스ID, 가입일자, 가입시간, 서비스시작일시, 서비스종료일시)
VALUES ('C003', 'S001', '20141201', '1030', TO_DATE('201412011030', 'YYYYMMDDHH24MI'), TO_DATE('201501010000', 'YYYYMMDDHH24MI'));

INSERT INTO SVC_JOIN (고객ID, 서비스ID, 가입일자, 가입시간, 서비스시작일시, 서비스종료일시)
VALUES ('C004', 'S003', '20141201', '1200', TO_DATE('201412011200', 'YYYYMMDDHH24MI'), TO_DATE('201501010000', 'YYYYMMDDHH24MI'));

INSERT INTO SVC_JOIN (고객ID, 서비스ID, 가입일자, 가입시간, 서비스시작일시, 서비스종료일시)
VALUES ('C005', 'S002', '20141201', '1500', TO_DATE('201412011500', 'YYYYMMDDHH24MI'), TO_DATE('201501010000', 'YYYYMMDDHH24MI'));

SELECT *
FROM SVC_JOIN;


SELECT 서비스ID, COUNT(*) AS CNT 
FROM SVC_JOIN 
WHERE 서비스종료일시 >= TO_DATE('20150101000000', 'YYYYMMDDHH24MISS')
AND 서비스종료일시 <= TO_DATE('20150131235959', 'YYYYMMDDHH24MISS')
AND CONCAT(가입일자, 가입시간) = '2014120100'
GROUP BY 서비스ID;

-- SQL 기본 문제 42
CREATE TABLE Sample_Table (
    sample_date TIMESTAMP
);

-- 가상의 데이터 삽입
INSERT INTO Sample_Table (sample_date)
VALUES 
(TO_TIMESTAMP('2015-01-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));

SELECT TO_CHAR(TO_DATE('2015.01.10 10', 'YYYY.MM.DD HH24')+ 1/24/(60/10), 'YYYY.MM.DD HH24:MI:SS') FROM Sample_Table;

--기본 43

CREATE TABLE DEPT2 (
    DEPTNO INT,
    LOC VARCHAR(50)
);

-- 가상의 데이터 삽입
INSERT INTO DEPT2 (DEPTNO, LOC) VALUES (10, 'NEW YORK');
INSERT INTO DEPT2 (DEPTNO, LOC) VALUES (20, 'CHICAGO');
INSERT INTO DEPT2 (DEPTNO, LOC) VALUES (30, 'LOS ANGELES');
INSERT INTO DEPT2 (DEPTNO, LOC) VALUES (40, 'DALLAS');


SELECT LOC,  CASE WHEN LOC = 'NEW YORK' THEN 'EAST'   ELSE 'ETC'    END as AREA
FROM DEPT2; 


SELECT LOC,  CASE  LOC WHEN 'NEW YORK' THEN 'EAST'    ELSE 'ETC'    END as AREA
FROM DEPT2; 


--기본 44 

-- PLAYER 테이블 생성
CREATE TABLE PLAYER (
    PLAYER_ID INT PRIMARY KEY,
    TEAM_ID INT,
    POSITION VARCHAR(2)
);
ALTER TABLE PLAYER DROP COLUMN PLAYER_ID;
-- 가상의 데이터 삽입
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

-- 애러 구문
SELECT TEAM_ID,    
NVL(SUM(CASE POSITION WHEN = 'FW' THEN 1 END), 0) FW,    
NVL(SUM(CASE POSITION WHEN = 'MF' THEN 1 END), 0) MF,    
NVL(SUM(CASE POSITION WHEN = 'DF' THEN 1 END), 0) DF,    
NVL(SUM(CASE POSITION WHEN = 'GK' THEN 1 END), 0) GK,        
COUNT(*) SUM        
FROM PLAYER        
GROUP BY TEAM_ID;

-- 잘되는 구문
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
    
-- 결과값 모두 444    
SELECT TEAM_ID,
    NVL(SUM(CASE WHEN POSITION= 'FW' THEN 1 ELSE 1 END), 0) FW,
    NVL(SUM(CASE WHEN POSITION = 'MF' THEN 1 ELSE 1 END), 0) MF,
    NVL(SUM(CASE WHEN POSITION = 'DF' THEN 1 ELSE 1 END), 0) DF,
    NVL(SUM(CASE WHEN POSITION = 'GK' THEN 1 ELSE 1 END), 0) GK,
        COUNT(*) SUM
        FROM PLAYER
        GROUP BY TEAM_ID;
        
        
        
--문제 SQL 기본 45 

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
-- SQL SERVER에서만 된다.
SELECT ISNULL(COL2, 'X') FROM TAB2 WHERE COL1 = 'a';
SELECT NVL(COL2, 'X') FROM TAB2 WHERE COL1 = 'a';



SELECT COUNT(COL1) FROM TAB2 WHERE COL2 = NULL;
SELECT COUNT(COL2) FROM TAB2 WHERE COL1 IN ('b', 'c');



-- SQL 기본 48
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
--SUM() 함수 내부에서 COUNT() 함수를 사용하여 중첩된 그룹 함수가 발생했기 때문 에러
SELECT
SUM(
    COUNT(CASE WHEN C1 IS NOT NULL THEN 1 END) +
    COUNT(CASE WHEN C2 IS NOT NULL THEN 1 END) +
    COUNT(CASE WHEN C3 IS NOT NULL THEN 1 END) ) AS 총계
FROM TAB3;


SELECT
    SUM(
        CASE WHEN C1 IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN C2 IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN C3 IS NOT NULL THEN 1 ELSE 0 END
    ) AS 총계
FROM TAB3;

-- SQL 활용 문제2 
SELECT C.컨텐츠ID, C.컨텐츠명
FROM 고객 A
INNER JOIN 추천컨텐츠 B ON (A.고객ID = B.고객ID)
INNER JOIN 컨텐츠 C ON (B.컨텐츠ID = C.컨텐츠ID)
LEFT OUTER JOIN 비선호컨텐츠 D ON (B.고객ID = D.고객ID AND B.컨텐츠ID = D.컨텐츠ID)
WHERE A.고객ID = 1
AND B.추천대상일자 = TO_CHAR(SYSDATE, 'YYYY.MM.DD')
AND D.컨텐츠ID IS NULL;

--SQL 활용 문제 3
CREATE TABLE 제품(
제품코드 INT PRIMARY KEY,
제품명 VARCHAR(20),
제품유형코드 INT,
단위 VARCHAR(20));

CREATE TABLE 생산라인 (
라인번호 INT PRIMARY KEY,
최초가동일자 DATE);

CREATE TABLE 생산제품 (
라인번호 INT ,
제품코드 INT,
PRIMARY KEY(라인번호,제품코드),
FOREIGN KEY (라인번호) REFERENCES 생산라인(라인번호),
FOREIGN KEY (제품코드) REFERENCES 제품(제품코드));

-- 제품 테이블에 데이터 추가
INSERT INTO 제품 (제품코드, 제품명, 제품유형코드, 단위) VALUES
(1, '사과', 101, '개');
INSERT INTO 제품 (제품코드, 제품명, 제품유형코드, 단위) VALUES
(2, '바나나', 102, '개');
INSERT INTO 제품 (제품코드, 제품명, 제품유형코드, 단위) VALUES
(3, '딸기', 103, '팩');

-- 생산라인 테이블에 데이터 추가
INSERT INTO 생산라인 (라인번호, 최초가동일자) VALUES
(101, TO_DATE('2024-02-24', 'YYYY-MM-DD'));
INSERT INTO 생산라인 (라인번호, 최초가동일자) VALUES
(102, TO_DATE('2024-02-25', 'YYYY-MM-DD'));
INSERT INTO 생산라인 (라인번호, 최초가동일자) VALUES
(103, TO_DATE('2024-02-26', 'YYYY-MM-DD'));

-- 생산제품 테이블에 데이터 추가
INSERT INTO 생산제품 (라인번호, 제품코드) VALUES
(101, 1);
INSERT INTO 생산제품 (라인번호, 제품코드) VALUES
(102, 2);
INSERT INTO 생산제품 (라인번호, 제품코드) VALUES
(103, 3);
INSERT INTO 생산제품 (라인번호, 제품코드) VALUES
(101, 2);
INSERT INTO 생산제품 (라인번호, 제품코드) VALUES
(102, 3);


--SQL 활용 4번 68번
--테이블명을 수정하기 위해서는 ALTER TABLE 문을 사용합니다. 아래는 테이블명을 변경하는 SQL 문의 예시입니다.

--sql
--Copy code
ALTER TABLE 현재테이블명
RENAME TO 변경할테이블명;
예를 들어, "고객" 테이블의 이름을 "신규고객"으로 변경하려면 다음과 같이 작성할 수 있습니다.

--sql
--Copy code
ALTER TABLE 고객
RENAME TO 신규고객;

CREATE TABLE 고객_68 (
    고객번호 INT PRIMARY KEY,
    이름 VARCHAR(50),
    등급 VARCHAR(20)
);

CREATE TABLE 구매정보_68 (
    구매번호 INT PRIMARY KEY,
    구매금액 DECIMAL(10, 2),
    고객번호 INT,
    FOREIGN KEY (고객번호) REFERENCES 고객_68(고객번호)
);

-- 고객 테이블에 데이터 삽입
INSERT INTO 고객_68 (고객번호, 이름, 등급) VALUES
(1, '고객1', '일반');
INSERT INTO 고객_68 (고객번호, 이름, 등급) VALUES
(2, '고객2', '우수');
INSERT INTO 고객_68 (고객번호, 이름, 등급) VALUES
(3, '고객3', '일반');
INSERT INTO 고객_68 (고객번호, 이름, 등급) VALUES
(4, '고객4', '우수');
INSERT INTO 고객_68 (고객번호, 이름, 등급) VALUES
(5, '고객5', '일반');

-- 구매정보 테이블에 데이터 삽입
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(1, 10000, 1);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(2, 20000, 1);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(3, 15000, 2);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(4, 30000, 3);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(5, 25000, 4);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(6, 18000, 1);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(7, 22000, 2);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(8, 21000, 1);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(9, 28000, 2);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(10, 35000, 3);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(11, 23000, 5);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(12, 27000, 4);
INSERT INTO 구매정보_68 (구매번호, 구매금액, 고객번호) VALUES
(13, 32000, 3);
SELECT * FROM 구매정보_68;
SELECT A.이름, A.등급, COUNT(*)
FROM 고객_68 A
INNER JOIN 구매정보_68 B ON (A.고객번호 = B.고객번호)
GROUP BY A.이름, A.등급
HAVING COUNT(*) >=3;

-- 69번 활용 6번


-- 시간대별사용량 테이블 생성
CREATE TABLE 시간대별사용량_69 (
    사용량 INT,
    사용시간대 INT,
    고객ID INT,
    PRIMARY KEY (고객ID,사용시간대),
    FOREIGN KEY (고객ID) REFERENCES 고객_69 (고객ID)
);

-- 시간대구간 테이블 생성
CREATE TABLE 시간대구간_69  (
    시작시간대 INT,
    종료시간대 INT,
    PRIMARY KEY (시작시간대,종료시간대),
    단가 DECIMAL(10, 2)
);

-- 고객 테이블 생성
CREATE TABLE 고객_69  (
    고객ID INT PRIMARY KEY,
    고객명 VARCHAR(50),
    생년월일 DATE 
);

INSERT INTO 고객_69  (고객ID, 고객명, 생년월일) VALUES
(1, '고객1', '1990-01-01');
INSERT INTO 고객_69  (고객ID, 고객명, 생년월일) VALUES
(2, '고객2', '1985-05-15');
INSERT INTO 고객_69  (고객ID, 고객명, 생년월일) VALUES
(3, '고객3', '1992-11-30');

-- 시간대구간 테이블에 데이터 삽입
INSERT INTO 시간대구간_69  (시작시간대, 종료시간대, 단가) VALUES
(0, 6, 10.0);
INSERT INTO 시간대구간_69  (시작시간대, 종료시간대, 단가) VALUES
(7, 12, 12.0);
INSERT INTO 시간대구간_69  (시작시간대, 종료시간대, 단가) VALUES
(13, 18, 15.0);
INSERT INTO 시간대구간_69  (시작시간대, 종료시간대, 단가) VALUES
(19, 23, 11.0);

-- 시간대별사용량 테이블에 데이터 삽입
INSERT INTO 시간대별사용량_69  (사용량, 사용시간대, 고객ID) VALUES
(5, 8, 1);
INSERT INTO 시간대별사용량_69  (사용량, 사용시간대, 고객ID) VALUES
(10, 15, 1);
INSERT INTO 시간대별사용량_69  (사용량, 사용시간대, 고객ID) VALUES
(8, 21, 2);
INSERT INTO 시간대별사용량_69  (사용량, 사용시간대, 고객ID) VALUES
(6, 10, 2);
INSERT INTO 시간대별사용량_69  (사용량, 사용시간대, 고객ID) VALUES
(12, 17, 3);

SELECT *
FROM 시간대별사용량_69,시간대구간_69,고객_69

SELECT A.고객ID, A.고객명, B.사용량 * C.단가 AS 사용금액
FROM 고객_69 A
INNER JOIN 시간대별사용량_69 B ON(A.고객ID = B.고객ID)
INNER JOIN 시간대구간_69 C ON (B.사용시간대 BETWEEN C.시작시간대 AND C.종료시간대)

SELECT A.고객ID, A.고객명, SUM(B.사용량 * C.단가) AS 사용금액
FROM 고객_69 A
INNER JOIN 시간대별사용량_69 B ON(A.고객ID = B.고객ID)
INNER JOIN 시간대구간_69 C ON (B.사용시간대 BETWEEN C.시작시간대 AND C.종료시간대)
GROUP BY A.고객ID, A.고객명
ORDER BY A.고객ID, A.고객명


-- 70번 활용 6번

-- 구장 테이블 생성
CREATE TABLE STADIUM_70 (
    STADIUM_ID INT PRIMARY KEY,
    STADIUM_NAME VARCHAR(100),
    LOCATION VARCHAR(100)
);

-- 팀 테이블 생성
CREATE TABLE TEAM_70 (
    TEAM_ID INT PRIMARY KEY,
    REGION_NAME VARCHAR(100),
    TEAM_NAME VARCHAR(100),
    STADIUM_ID INT,
    FOREIGN KEY (STADIUM_ID) REFERENCES STADIUM_70(STADIUM_ID)
);


-- 팀 테이블 가상 데이터 삽입
INSERT INTO TEAM_70 (TEAM_ID, REGION_NAME, TEAM_NAME, STADIUM_ID) VALUES
(1, 'Region A', 'Team X', 101);
INSERT INTO TEAM_70 (TEAM_ID, REGION_NAME, TEAM_NAME, STADIUM_ID) VALUES
(2, 'Region B', 'Team Y', 102);
INSERT INTO TEAM_70 (TEAM_ID, REGION_NAME, TEAM_NAME, STADIUM_ID) VALUES
(3, 'Region C', 'Team Z', 103);

-- 구장 테이블 가상 데이터 삽입
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

--에러 구문 
SELECT T.REGION_NAME, T.TEAM_NAME, T.STADIUM_ID, S.STADIUM_NAME   
FROM TEAM_70 T 
INNER JOIN STADIUM_70 S    
USING (STADIUM_ID);



-- 72번 활용 문제 8번
ALTER TABLE 고객1 RENAME TO 고객_72;
ALTER TABLE 단가 RENAME TO 단말기_72;
ALTER TABLE OS RENAME TO 0S_72;

SELECT *
FROM 고객_72, 단말기_72;

SELECT A.고객번호, A.고객명, B.단말기ID, B.단말기명, C.OSID, C.OS명
FROM 고객_72 A  LEFT OUTER JOIN 단말기_72 B 
ON (A.고객번호 IN (11000, 12000) AND A.단말기ID = B.단말기ID ) LEFT OUTER JOIN OS C   
ON (B.OSID = C.OSID)
ORDER BY A.고객번호;

-- 73번 활용 문제 9번

SELECT A.ID, B.ID
FROM TBL1 A 
FULL OUTER JOIN TBL2 B ON A.ID = B.ID;?


-- TBL1 테이블 생성
CREATE TABLE TBL1_73 (
    ID INT PRIMARY KEY
);

-- TBL2 테이블 생성
CREATE TABLE TBL2_73 (
    ID INT PRIMARY KEY
);

-- TBL1에 데이터 삽입
INSERT INTO TBL1_73 (ID) VALUES (1);
INSERT INTO TBL1_73 (ID) VALUES (2);
INSERT INTO TBL1_73 (ID) VALUES (3);
INSERT INTO TBL1_73 (ID) VALUES (4);
-- TBL2에 데이터 삽입
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



-- 74번 활용 문제 10번


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


-- 75번 활용 문제 11번

-- 76번 활용 문제 12번

CREATE TABLE tab1_76
(	"c1" CHAR(1 BYTE) ,
   "c2" NUMBER(*,0) 
 )
 
CREATE TABLE tab2_76
(	"c1" CHAR(1 BYTE) ,
   "c2" NUMBER(*,0) 
 )
 
-- 77번 활용 문제 13번

alter table 게시판 rename to 게시판_77;
alter table 게시글 rename to 게시글_77;
select *
from 게시글_77, 게시판_77;
--에러문
alter table 게시글_77 column 사용여부 rename to 삭제여부;

ALTER TABLE 게시글_77 RENAME COLUMN 사용여부 TO 삭제여부;


SELECT A.게시판ID, A.게시판명, COUNT(B.게시글ID) AS CNT
FROM 게시판_77 A, 게시글_77 B
WHERE A.게시판ID = B.게시판ID(+) AND B.삭제여부(+) = 'N' AND A.사용여부 = 'Y'
GROUP BY A.게시판ID, A.게시판명
ORDER BY A.게시판ID;


SELECT A.게시판ID, A.게시판명, COUNT(B.게시글ID) AS CNT
FROM 게시판_77 A LEFT OUTER JOIN 게시글_77 B ON (A.게시판ID = B.게시판ID AND B.삭제여부 = 'N')
WHERE A.사용여부 = 'Y'
GROUP BY A.게시판ID, A.게시판명
ORDER BY A.게시판ID;


SELECT A.게시판ID, A.게시판명, COUNT(B.게시글ID) AS CNT
FROM 게시판_77 A 
LEFT OUTER JOIN 게시글_77 B ON (A.게시판ID = B.게시판ID AND A.사용여부 = 'Y')
WHERE B.삭제여부 = 'N'
GROUP BY A.게시판ID, A.게시판명
ORDER BY A.게시판ID;

SELECT A.게시판ID, A.게시판명, COUNT(B.게시글ID) AS CNT
FROM 게시판_77 A 
LEFT OUTER JOIN 게시글_77 B ON (A.게시판ID = B.게시판ID)
WHERE A.사용여부 = 'Y' AND B.삭제여부 = 'N'
GROUP BY A.게시판ID, A.게시판명
ORDER BY A.게시판ID;

SELECT A.게시판ID, A.게시판명, COUNT(B.게시글ID) AS CNT
FROM 게시판_77 A 
RIGHT OUTER JOIN 게시글_77 B ON (A.게시판ID = B.게시판ID 
AND A.사용여부 = 'Y' AND B.삭제여부 = 'N')
GROUP BY A.게시판ID, A.게시판명
ORDER BY A.게시판ID;


-- 78번 활용 문제 14번

-- 79번 활용 문제 15번

-- TAB1 테이블 생성
CREATE TABLE TAB1_79 (
    A INT,
    B VARCHAR(1)
);

-- TAB2 테이블 생성
CREATE TABLE TAB2_79 (
    A INT,
    B VARCHAR(1)
);

-- 데이터 삽입
INSERT INTO TAB1_79 (A, B) VALUES (1, 'x');
INSERT INTO TAB1_79 (A, B) VALUES (2, 'y');
INSERT INTO TAB1_79 (A, B) VALUES (3, 'z');

INSERT INTO TAB2_79 (A, B) VALUES (1, 'x');
INSERT INTO TAB2_79 (A, B) VALUES (4, 'w');
INSERT INTO TAB2_79 (A, B) VALUES (3, 'z');



-- 80번 활용 문제 16번


-- 서비스 테이블 생성
CREATE TABLE 서비스_80 (
    서비스ID INT PRIMARY KEY,
    서비스명 VARCHAR(50),
    서비스URL VARCHAR(100)
);
CREATE TABLE 회원_80 (
    회원ID INT PRIMARY KEY ,
    회원명 VARCHAR(20)

)
-- 서비스이용 테이블 생성
CREATE TABLE 서비스이용_80 (
    회원ID INT ,
    서비스ID INT,
    이용일시 DATE,
    PRIMARY KEY(회원ID,서비스ID),
    FOREIGN KEY (회원ID) REFERENCES 회원_80(회원ID),
    FOREIGN KEY (서비스ID) REFERENCES 서비스_80(서비스ID)

);

-- 데이터 삽입
-- 서비스 테이블 데이터 삽입
INSERT INTO 서비스_80 (서비스ID, 서비스명, 서비스URL) VALUES (100, '서비스1', 'http://example.com/service1');
INSERT INTO 서비스_80 (서비스ID, 서비스명, 서비스URL) VALUES (200, '서비스2', 'http://example.com/service2');
INSERT INTO 서비스_80 (서비스ID, 서비스명, 서비스URL) VALUES (300, '서비스3', 'http://example.com/service3');


INSERT INTO 회원_80 (회원ID, 회원명) VALUES (1, '서1');
INSERT INTO 회원_80 (회원ID, 회원명) VALUES (2, '서2');
INSERT INTO 회원_80 (회원ID, 회원명) VALUES (3, '서3');

-- 서비스이용 테이블 데이터 삽입
INSERT INTO 서비스이용_80 (회원ID, 서비스ID, 이용일시) VALUES (1, 100, '2020.01.01');
INSERT INTO 서비스이용_80 (회원ID, 서비스ID, 이용일시) VALUES (2, 200, '2020.01.02');
INSERT INTO 서비스이용_80 (회원ID, 서비스ID, 이용일시) VALUES (3, 300, '2020.01.02');

SELECT A.서비스ID, B.서비스명, B.서비스URL
FROM 
(SELECT
서비스ID      
FROM 서비스_80      
INTERSECT      
SELECT 서비스ID      
FROM 서비스이용_80) A, 서비스_80 B
WHERE A.서비스ID = B.서비스ID;

--1
SELECT B.서비스ID, A.서비스명, A.서비스URL
FROM 서비스_80 A, 서비스이용_80 B
WHERE A.서비스ID = B.서비스ID;

--2
SELECT X.서비스ID, X.서비스명, X.서비스URL
FROM 서비스_80 X
WHERE NOT EXISTS (
SELECT 1                 
FROM (SELECT 서비스ID                        
FROM 서비스_80                        
MINUS                        
SELECT 서비스ID                        
FROM 서비스이용_80) Y                  
WHERE X.서비스ID = Y.서비스ID);

--3
SELECT B.서비스ID, A.서비스명, A.서비스URL
FROM 서비스_80 A 
LEFT OUTER JOIN 서비스이용_80 B ON (A.서비스ID = B.서비스ID)
WHERE B.서비스ID IS NULL
GROUP BY B.서비스ID, A.서비스명, A.서비스URL;

--4
SELECT A.서비스ID, A.서비스명, A.서비스URL
FROM 서비스_80 A
WHERE 서비스ID IN (
SELECT 서비스ID                 
FROM 서비스이용_80                  
MINUS                 
SELECT 서비스ID                  
FROM 서비스_80);


-- 81번 활용 문제 17번


-- 82번 활용 문제 18번

-- ORDER BY 1, 2 절은 첫 번째 컬럼(ENAME 또는 BBA)과 두 번째 컬럼(JOB 또는 BBB)의 값들을 오름차순으로 정렬합니다. 
-- 그래서 "Jones"가 "Smith"보다 알파벳순으로 먼저 나오기 때문에 7566번 사원의 정보가 먼저 출력됩니다.


-- 83번 활용 문제 19번

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


-- 84번 활용 문제 20번

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


-- 85번 활용 문제 21번


-- 86번 활용 문제 22번

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
