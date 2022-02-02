-- 실무에선 테이블보다 뷰를 더 많이 만나게 됨(혹여라도 안에 있는 데이터를 조작하게 되어 데이터가 날라가거나 변경되는 것을 방지하기 위해 뷰를 건네줄 거임)

-- VIEW(뷰) : SELECT 결과를 화면에 저장한 논리적인 가상 테이블 (객체)
-- 실질적인 데이터를 갖고 있지 않지만 테이블과 동일하게 사용 가능

-- (객체 : 테이블, USER, VIEW)

-- VIEW생성문
-- CREATE [OR REPLACE] VIEW 뷰이름 AS 서브쿼리

-- 사번, 이름, 부서명, 근무지역의 조회 결과를 V_EMPLOYEE 뷰에 저장하기
CREATE OR REPLACE VIEW V_EMPLOYEE
AS 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)  -- OUTER JOIN(외부조인)
     LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
     LEFT JOIN NATIONAL USING (NATIONAL_CODE);
-- ORA-01031: 권한이 불충분합니다 
-- 01031. 00000 -  "insufficient privileges"
-- 현재 계정에서 VIEW를 생성하기 위한 권한이 없기 때문에 나는 오류
-- --> 권한을 부여하기 위해 SYSTEM계정(관리자계정)에 접속

-- 1) SYSTEM 계정 접속
-- 2) KH계정에 뷰 생성 권한 부여
GRANT CREATE VIEW TO KH;
-- 3) KH계정으로 돌아가 VIEW 생성

SELECT * FROM V_EMPLOYEE;

UPDATE EMPLOYEE
SET EMP_NAME = '정중앙'
WHERE EMP_ID = 205;

SELECT * FROM EMPLOYEE WHERE EMP_ID = 205;
SELECT * FROM V_EMPLOYEE WHERE EMP_ID = 205;
-- 본 테이블과 뷰가 연결 되어 있기 때문에 결과가 같음

ROLLBACK;

-- 사번, 이름, 직급, 성별(남/여), 근무년수를 V_EMP_JOB 뷰 저장
-- 서브쿼리 SELECT절에 함수가 사용된 경우 반드시 별칭 지정
-- ORA-00998: 이 식은 열의 별명과 함께 지정해야 합니다
-- 00998. 00000 -  "must name this expression with a column alias"
CREATE OR REPLACE VIEW V_EMP_JOB (사번, "사원 명", "직급 명", 성별, 근무년수)
AS
SELECT EMP_ID , EMP_NAME , JOB_NAME , 
       DECODE(SUBSTR(EMP_NO, 8, 1) , 1, '남', '여') ,  
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
FROM EMPLOYEE
     JOIN JOB USING (JOB_CODE);

SELECT * FROM  V_EMP_JOB;

CREATE OR REPLACE VIEW V_JOB
AS
SELECT JOB_CODE, JOB_NAME
FROM JOB;

SELECT * FROM V_JOB;
SELECT * FROM JOB;

INSERT INTO V_JOB VALUES('J8', '인턴');
UPDATE V_JOB SET JOB_NAME = '알바' WHERE JOB_CODE = 'J8';
DELETE V_JOB WHERE JOB_CODE = 'J8';

SELECT * FROM USER_VIEWS;
-- 사용자 정의 뷰 확인 테이터 딕셔너리
-- 가상 테이블에선 실제 데이터가 들어간 것이 아니라 본 테이블과 연결되어 내가 실행할 문장만 가져와 실질적으로 본 테이블들을 실행 시킴

-- DML명령어로 조작이 불가능한 경우
-- 1. 뷰 정의에 포함되지 않은 컬럼 조작
CREATE OR REPLACE VIEW V_JOB2
AS
SELECT JOB_CODE FROM JOB;

SELECT * FROM V_JOB2;

INSERT INTO V_JOB2 VALUES ('J8', '인턴');  
-- SQL 오류: ORA-00913: 값의 수가 너무 많습니다
-- V_JOB2에 설정한 컬럼의 개수는 1개이지만 2개의 컬럼을 넣고자 하기 때문에 오류 발생
UPDATE V_JOB2 SET JOB_NAME = '인턴' WHERE JOB_CODE = 'J7';   
-- SQL 오류: ORA-00904: "JOB_NAME": 부적합한 식별자
-- JOB_NAME이 있는 상태에선 변경 가능
DELETE FROM V_JOB2 WHERE JOB_NAME = '사원';   
-- SQL 오류: ORA-00904: "JOB_NAME": 부적합한 식별자

-- 2. 뷰에 포함되지 않은 컬럼 중 NOT NULL제약조건이 지정된 경우
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME FROM JOB;

INSERT INTO V_JOB3 VALUES ('인턴');   -- ORA-01400: NULL을 ("KH"."JOB"."JOB_CODE") 안에 삽입할 수 없습니다
                                      -- JOB_CODE에 NOT NULL 제약조건이 걸려있기 때문
UPDATE V_JOB3 SET JOB_CODE = NULL WHERE JOB_NAME = '사원';  -- SQL 오류: ORA-00904: "JOB_CODE": 부적합한 식별자

-- 3. 산술표현식으로 정의된 경우
CREATE OR REPLACE VIEW EMP_SAL
AS
SELECT EMP_ID, EMP_NAME, SALARY, (SALARY + (SALARY*NVL(BONUS, 0)))*12 연봉
FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL VALUES (600, '강건강', 3000000, 36000000);  
-- SQL 오류: ORA-01733: 가상 열은 사용할 수 없습니다
-- 계산식은 SALARY와 BONUS를 이용해서 계산을 해야하는데 숫자 값을 넣었기 때문에 인식 할 수 없어 오류 발생
UPDATE EMP_SAL SET 연봉 = 80 WHERE EMP_ID = 200;  
-- SQL 오류: ORA-01733: 가상 열은 사용할 수 없습니다

-- 함수를 사용한 컬럼은 INSERT, UPDATE를 할 수 없음 

-- 4.그룹함수/GROUP BY 포함된 경우
-- V_GROUPDEPT뷰에 부서코드, 부서 별 급여 합계, 부서 별 급여 평균 저장
CREATE OR REPLACE VIEW V_GROUPDEPT
AS 
SELECT DEPT_CODE, SUM(SALARY) 합계, AVG(SALARY) 평균
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT VALUES ('D10', 600, 400);  
-- SQL 오류: ORA-01733: 가상 열은 사용할 수 없습니다
-- SALARY의 합계, 평균으로 계산된 값이 아닌 600,400 이라는 고정된 값을 넣었기 때문에 오류 발생
UPDATE V_GROUPDEPT SET DEPT_CODE = 'D10' WHERE DEPT_CODE = 'D3';  
-- SQL 오류: ORA-01732: 뷰에 대한 데이터 조작이 부적합합니다
-- SUM과 AVG의 계산이 바뀌기 때문
DELETE FROM V_GROUPDEPT WHERE DEPT_CODE = 'D1';  
-- SQL 오류: ORA-01732: 뷰에 대한 데이터 조작이 부적합합니다

-- 5. DISTINCT(중복제거)를 포함한 경우
CREATE OR REPLACE VIEW V_DT_EMP
AS
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT * FROM V_DT_EMP;

INSERT INTO V_DT_EMP VALUES ('J9');  
-- SQL 오류: ORA-01732: 뷰에 대한 데이터 조작이 부적합합니다
UPDATE V_DT_EMP SET JOB_CODE = 'J9' WHERE JOB_CODE = 'J7';
-- SQL 오류: ORA-01732: 뷰에 대한 데이터 조작이 부적합합니다
DELETE FROM V_DT_EMP WHERE JOB_CODE = 'J1';
--SQL 오류: ORA-01732: 뷰에 대한 데이터 조작이 부적합합니다

-- 6. JOIN을 이용해 여러 테이블을 연결한 경우
-- V_JOINEMP 뷰에 사번, 이름, 부서 명 저장
CREATE OR REPLACE VIEW V_JOINEMP
AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM V_JOINEMP;

INSERT INTO V_JOINEMP VALUES(700, '강건강', '총무부');  
-- SQL 오류: ORA-01776: 조인 뷰에 의하여 하나 이상의 기본 테이블을 수정할 수 없습니다.

-- VIEW 옵션
-- CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름 [(ASLIA[, ALIAS]...)]
-- AS subquery
-- [WITH CHECK OPTION]
-- [WITH READ ONLY];

-- OR REPLACE : 기존에 동일한 뷰 이름이 존재하는 경우 덮어쓰고, 존재하지 않으면 새로 생성
-- FORCE/NOFORCE
--      FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
--      NOFORCE : 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성(기본 값)
-- WITH CHECK OPTION : 옵션을 설정한 컬럼 수정 불가능
-- WITH READ ONLY : 조회만 가능하게 만듦

--[CREATE]
CREATE OR REPLACE VIEW V_EMP1
AS
SELECT EMP_NO, EMP_NAME
FROM EMPLOYEE;

SELECT * FROM V_EMP1;

CREATE OR REPLACE VIEW V_EMP1
AS
SELECT EMP_NO, EMP_NAME, SALARY
FROM EMPLOYEE;

CREATE VIEW V_EMP1
AS
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;
-- ORA-00955: 기존의 객체가 이름을 사용하고 있습니다.
-- OR REPLACE를 사용하지 않았기 때문에 덮어쓰기 불가능

-- 뷰는 실제 테이블을 가지고 사용하는 것이 아닌 테이블을 실행 시킨 결과 값을 보면서 사용하는 것이기 때문에 
-- 테이블과 달리 내용이 변경되는 경우가 많아 OR REPLACE를 웬만하면 사용하자 

-- [FORCE / NOFORCE]
CREATE OR REPLACE /*NOFORCE*/VIEW V_EMP2   -- 기본적으로 NOFORCE 적용
AS
SELECT TCODE, TNAME, TCONTENT
FROM TT;

CREATE OR REPLACE FORCE VIEW V_EMP2 
AS
SELECT TCODE, TNAME, TCONTENT
FROM TT;
-- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.
-- 아직 테이블이 만들어지지 않았지만 글을 먼저 생성해야 할 때 사용

-- [WITH CHECK OPTION]
CREATE OR REPLACE VIEW V_EMP3
AS
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'
WITH CHECK OPTION;

SELECT * FROM V_EMP3;

UPDATE V_EMP3
SET DEPT_CODE = 'D1'
WHERE EMP_ID = 200;
-- ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다
-- WITH CHECK OPTION의 조건에 DEPT_CODE가 들어가 있기 때문에 DEPT_CODE는 수정 할 수 없음

UPDATE V_EMP3
SET EMP_NAME = '성동일'
WHERE EMP_ID = 200;

ROLLBACK;

INSERT INTO V_EMP3
VALUES(999,'강건강', '111111-1111111', 'kang_kk@kh.or.kr', '01011112222', 'D1', 'J3', 'S3',
        3000000, 0.2, 200, SYSDATE, NULL, 'N');
-- ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다
-- WITH CHECK OPTION의 조건에 들어있는 EMP_CODE에 'D9'만 넣었기 때문

INSERT INTO V_EMP3
VALUES(999,'강건강', '111111-1111111', 'kang_kk@kh.or.kr', '01011112222', 'D9', 'J3', 'S3',
        3000000, 0.2, 200, SYSDATE, NULL, 'N');

ROLLBACK;

-- [WITH READ ONLY]
CREATE OR REPLACE VIEW V_DEPT
AS
SELECT * FROM DEPARTMENT
WITH READ ONLY;

INSERT INTO V_DEPT
VALUES('D10', '해외영업부', 'L1');
-- SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.

UPDATE V_DEPT
SET LOCATION_ID = 'L2'
WHERE DEPT_ID = 'D1';
-- SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.

DELETE FROM V_DEPT;
-- SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
-- WITH READ ONLY는 조회만 가능

COMMIT;



















