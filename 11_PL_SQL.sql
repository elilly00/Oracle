-- PL/SQL
-- 선언부       DECLARE         변수, 상수 선언
-- 실행부       BEGIN           로직 기술
-- 예외처리부    EXCEPTION       예외 발생 시 해결 문장 기술

/*
    // 변수 선언 없이 바로 실행  -> DECLARE 필요 X
    System.outprinln(10);
    
    // 변수 선언 후 실행 -> DECLARE 필요 
    int a = 10;
    System.out.prinln(a);
*/

SET SERVEROUTPUT ON;
-- 출력을 화면에 보여주도록 하는 설정

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/   
-- END 다음엔 /가 꼭 있어야 함 (문장이 끝났다는 것을 구분 하는 역할)
/*
    int empId;
    String empName;
    
    final int PI = 3.14;
    
    empId = 800;
    empName = "남나눔";
    
    System.out.println("empId : " + empId);
    System.out.println("empName : " + empName);
*/

DECLARE  -- 선언부 시작
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
    PI CONSTANT NUMBER := 3.14;     -- := 대입연산자
BEGIN
    EMP_ID := 800;
    EMP_NAME := '남나눔';
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    -- || : 연결연산자
END;
/

DECLARE
--  EMP_ID NUMBER;
    EMP_ID EMPLOYEE.EMP_ID%TYPE;    -- EMPLOYEE에 있는 EMP_ID의 타입을 따라가겠다(레퍼런스 변수)
--  EMP_NAME VARCHAR2(30);
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;    -- EMPLOYEE에 있는 EMP_NAME의 타입을 따라가겠다(레퍼런스 변수)
    -- 변수 명으로 사용할 이름을 따로 지정 한 것
BEGIN
    SELECT EMP_ID, EMP_NAME     -- EMPLOYEE테이블에 있는 컬럼 명 (위의 EMP_ID, EMP_NAME과 다름)
    INTO EMP_ID, EMP_NAME   --SELECT에서 가지고 온 EMP_ID, EMP_NAME을 EMP_ID, EMP_NAME에 넣음
    FROM EMPLOYEE
--  WHERE EMP_ID = 200; 
--  WHERE EMP_ID = '&EMP_ID';   
    WHERE EMP_ID = '&사번';
    -- & : 대체 변수 입력 (값 입력) -> 영어든 한글이든 아무 문자 가능
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

-- 레퍼런스 변수로 EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY를 선언하고
-- EMPLOYEE테이블에서 사번, 이름, 직급코드, 부서코드, 급여를 조회 후 선언한 레퍼런스 변수에 담아 출력
-- 단, 입력 받은 이름과 일치하는 조건의 직원 조회
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY   -- SELECT과 INTO의 순서를 맞춰서 적어야함(이름이 같아도 순서가 다르면 그 순서대로 값이 들어가게 됨)
    FROM EMPLOYEE
    WHERE EMP_NAME = '&이름';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
END;
/

DECLARE 
    E EMPLOYEE%ROWTYPE;
    -- %ROWTYPE : 행에 대한 데이터형, 크기, 속성 참조(다 가지고 옴)
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
--    DBMS_OUTPUT.PUT_LINE('E : ' || E);  -- ORA-06550: 줄 10, 열26:PLS-00306: '||' 호출 시 인수의 갯수나 유형이 잘못되었습니다
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
END;
/

-- IF ~ THEN ~END IF (단일 IF문)
-- EMP_ID를 입력받아 사번, 이름,  급여, 보너스를 출력
-- 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다' 출력
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS  EMPLOYEE.BONUS%TYPE;
BEGIN
--  SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0) -- NULL인 값은 0으로 출력
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID  = '&사번';  
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
--  DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS);
    
--  IF(BONUS = 0)
    IF(BONUS IS NULL)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다');
    END IF;
    DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS * 100 || '%');
END;
/

-- IF~THEN~ELSE~END IF(IF ~ ELSE문)
-- EMP_ID를 입력받아 해당 사원의 사번, 이름, 부서명, 소속 출력
-- TEAM변수를 만들어 소속이 KO면 국내팀, 아니면 해외팀으로 저장
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&사번';
    
    IF(NATIONAL_CODE = 'KO')
        THEN TEAM := '국내팀';
    ELSE 
        TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
END;
/

-- 사용자에게 사번을 받아와 그 사원의 전체 정보를 VEMP에 저장
-- VEMP를 이용하여 연봉 계산(보너스가 있을 경우 보너스 포함하여 계산)
-- 연봉 결과 값은 YSALARY에 저장
-- 급여 이름 연본(\1,000,000) 형식 출력