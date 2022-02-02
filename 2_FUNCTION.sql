-- 함수 : 컬럼의 값을 읽어서 계산한 결과 리턴
-- 단일행 함수 : 컬럼에 기록된 n개의 값을 읽어 n개의 결과 리턴
-- 그룹 함수 : 컬럼에 기록된 n개의 값을 읽어 1개의 결과 리턴
-- 단일행 함수 그룹함수는 함께 사용할 수 있다/없다? => 없다 : 결과 행의 개수가 다르기 때문

-- 단일행 함수
-- 1. 문자 관련 함수
-- LENGTH : 글자 수 반환 / LENGTHB : 글자의 바이트 크기 반환
SELECT LENGTH('오라클'), LENGTHB('오라클') -- B는 BYTE를 의미 (한 글자 당 3byte로 인식)
FROM DUAL;  -- DUAL : 가상 테이블

SELECT LENGTH(EMAIL), LENGTHB(EMAIL) -- 특수문자는 1byte로 인식
FROM EMPLOYEE;

-- INSTR : 해당 문자열의 위치(자바에선 0부터 세지만, 오라클은 1부터 셈)
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;    -- 해당 값이 문자열의 위치에 없다면 0 반환
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 검색을 시작하는 위치 (1번째 문자부터 검색 시작해서 해당 값이 나오는 문자열 위치 반환)
SELECT INSTR('AABAACAABBAA', 'B', 7) FROM DUAL; -- 7번째 문자부터 검색 시작
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;  -- 끝에서부터 검색 시작해 해당 값이 나오는 문자열 위치 반환(위치를 셀땐 1번째 문자부터 셈)
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;  -- 1번째 문자부터 검색해 두번째로 나오는 문자 위치 반환

-- EMPLOYEE테이블에서 이메일의 @ 위치 반환
SELECT INSTR(EMAIL, '@') FROM EMPLOYEE;

-- LPAD / RPAD
-- 제시한 숫자만큼의 공간을 만들어놓고 남는 공간은 임의의 문자로 왼쪽/오른쪽에 채워넣음
SELECT LPAD(EMAIL, 20) FROM EMPLOYEE;    -- 길이를 20으로 맞춘 후 반환
SELECT LPAD(EMAIL, 20, '#') FROM EMPLOYEE;  -- 길이를 20으로 맞춘 후 남는 공간은 #을 채워넣음
SELECT RPAD(EMAIL, 20, '#') FROM EMPLOYEE; 

-- LTRIM : 문자열의 왼쪽 공백 제거, 왼쪽부터 반복적인 문자 제거  
-- RTRIM : 문자열의 오른쪽 공백 제거, 오른쪽부터 반복전인 문자 제거
-- TRIM : 문자열의 양쪽 공백 제거
SELECT LTRIM('   KH') A FROM DUAL;    -- 왼쪽 공백 제거 
SELECT LTRIM('KH   ') A FROM DUAL;  -- 오른쪽 공백 제거 X
SELECT LTRIM('   KH', ' ') A FROM DUAL;  -- 지정한 값 지우기 (공백을 지울 값으로 지정하였기 때문에 왼쪽에 있는 공백이 제거 됨)
SELECT LTRIM('0012345', '0') FROM DUAL;
SELECT LTRIM('123123KH', '123') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;   -- KH는 1,2,3이 아니라서 멈추게 되어 KH123이 출력 됨
SELECT LTRIM('ACBBAKH', 'ABC') FROM DUAL;   -- 'ABC'-> 내가 지울 문자는 A또는 B또는 C이라는 의미 그래서 KH가 출력 됨
SELECT PHONE, LTRIM(PHONE, '010') FROM EMPLOYEE;

SELECT RTRIM('KH   ') A FROM DUAL;
SELECT RTRIM('123123KH', '123') FROM DUAL;
SELECT EMAIL, RTRIM(EMAIL, '@kh.or.kr') FROM EMPLOYEE;

SELECT TRIM('   KH   ') A FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM('123' FROM '123123KH12') FROM EMPLOYEE; -- 여러 글자는 쓸 수 없음
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- 왼쪽에서부터
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;  -- 오른쪽에서부터
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;    -- 양쪽에서부터

-- SUBSTR = String.subString()
-- 문자열 일부 반환
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;  -- 7번째부터 끝까지 반환 => THEMOENY
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;  -- 5번째부터 2개 반환 => ME
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL;   -- NULL 반환
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;   -- 거꾸로 시작해서 처음부터 수를 셈 => THE

-- EMPLOYEE테이블의 이름, 이메일, @ 이후를 제외한 아이디 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) 
FROM EMPLOYEE;

-- 주민등록번호를 이용하여 남/여 판단하여 이름, 성별 조회
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) 성별
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 남자만 조회(사원 명, '남')
SELECT EMP_NAME, '남' 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- EMPLOYEE테이블에서 여자만 조회(사원 명, '여')
SELECT EMP_NAME, '여' 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- EMPLOYEE테이블에서 직원들의 주민번호를 이용하여 사원명, 생년, 생월, 생일 조회
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 2) 생년, SUBSTR(EMP_NO, 3, 2) 생월, SUBSTR(EMP_NO, 5, 2) 생일
FROM EMPLOYEE;

-- LOWER : 모두 소문자로 변환 / UPPER : 모두 대문자로 변환 / INITCAP : 첫 글자만 대문자로 변환
SELECT LOWER('Welcome To My World') LOWER, UPPER('Welcome To My World') UPPER, INITCAP('Welcome To SELECTSELECTMy World') INITCAP FROM DUAL;
SELECT INITCAP('WELCOME TO MY WORLD') FROM DUAL;    

-- CONCAT : 문자열 합치기
SELECT CONCAT('가나다라', '마바사') FROM DUAL;
SELECT '가나다라' || '마바사' FROM DUAL;   -- CONCAT 대신 연결연산자 사용 (같은 결과가 나옴)

SELECT CONCAT(CONCAT(CONCAT(CONCAT(EMP_NO, ', '), EMP_NAME), ', '), DEPT_CODE)
FROM EMPLOYEE;

-- REPLACE : 대체
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;
SELECT REPLACE('반신우강사님은 G강의실에 있습니다', '강사님', '선생님') FROM DUAL; -- 띄어쓰기가 안되어 있어도 바뀜

-- EMPLOYEE테이블에서 사원명, 주민번호 조회
-- 주민번호는 생년월일만 보이게 하고 '-'다은은 '*'로 변경
SELECT EMP_NAME, REPLACE(EMP_NO, SUBSTR(EMP_NO, 8), '********')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, INSTR(EMP_NO, '-')), LENGTH(EMP_NO), '*')
FROM EMPLOYEE;

--SELECT EMP_NAME, SUBSTR(EMP_NO, 1,)

-- 2. 숫자 관련 함수
-- ABS : 절대 값 구하는 함수
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-- MOD : 나누기의 나머지 값 반환 (=모듈러)
SELECT MOD(10,3) FROM DUAL;
SELECT MOD(-10,3) FROM DUAL; -- 나눠지는 수의 부호를 따라감
SELECT MOD(10,-3) FROM DUAL;

-- ROUND : 반올림
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.678) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL; -- 소소점 0번째 자리에서부터 반올림
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;

-- FLOOR : 내림 - 수학적으로 내림하는 것
SELECT FLOOR(123.456) FROM DUAL; -- 내림은 자리를 지정할 수 없음
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC : 소수점 자리를 절삭, 버리는 것
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;

-- CEIL : 올림
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

-- 3. 날짜 관련 함수
-- SYSDATE : 현재 날짜
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : 개월 수의 차이를 숫자로 리턴
-- EMPLOYEE테이블에서 사원의 이름, 입사일, 근무 개월 수 조회
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(HIRE_DATE, SYSDATE)  -- 음수로 값이 나옴
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE)) -- ABS를 이용해 절대값이나오도록해 음수가 나오는 실수를 하지 않도록 함
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, CEIL(ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))) || '개월차' 개월차  -- 올림을 이용해 개월차 출력
FROM EMPLOYEE;                  -- EX. 학원 몇개월차? 2개월차 (사실은 한달 조금 넘게 했지만 올림하여 2개월로 말함)

-- ADD_MONTHS : 날짜에 숫자만큼 개월 수를 더하여 날짜 리턴
SELECT ADD_MONTHS(SYSDATE, 2) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL;

-- NEXT_DAY : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜 리턴
-- 1= 일 / 2=월 / 3=화 / 4=수 / 5=목 / 6=금 / 7=토
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월남쌈 맛있잖아, 그치?') FROM DUAL;   -- 맨 앞에 '월'이 들어가기때문에 월요일 날짜가 출력
SELECT SYSDATE, NEXT_DAY(SYSDATE, '우리와 같은 박수를 보내주세요') FROM DUAL;  -- 맨 앞이 '우'이기 때문에 에러가 남
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;  -- 프로그램 언어가 한글로 되어있기 때문에 영어는 인식 X
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;  -- 언어를 영어로 바꾸기(한글은 인식X)
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL; 
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY : 해당 월의 마지막 날짜를 구하여 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE테이블에서 사원 명, 입사일-오늘, 오늘-입사일 조회
--       단, 별칭은 근무일수1, 근무일수2로 하고 모든 정수처리(내림)
SELECT EMP_NAME, FLOOR(HIRE_DATE-SYSDATE) 근무일수1, FLOOR(SYSDATE-HIRE_DATE) 근무일수2
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;

-- EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회
SELECT *
FROM EMPLOYEE
--WHERE (SYSDATE-HIRE_DATE)/365 >= 20;
--WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;

-- EMPLOYEE테이블에서 사원 명, 입사일, 입사한 달의 근무 일수 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

-- EXTRACT : 년, 월, 일 정보를 추출하여 리턴
-- EMPLOYEE테이블에서 사원의 이름, 입사년도, 입사 월, 입사일
SELECT EMP_NAME 이름, EXTRACT(YEAR FROM HIRE_DATE) 입사년도, 
        EXTRACT(MONTH FROM HIRE_DATE) "입사 월", EXTRACT(DAY FROM HIRE_DATE) "입사 일"
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 사원의 이름, 입사일, 근무 년수 조회
--          단, 근무년수는 현재년도 - 입사년도로 조회
SELECT EMP_NAME, HIRE_DATE, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무 년수"
FROM EMPLOYEE;

-- 4. 형변환 함수
-- TO_CHAR : 날짜/숫자형 데이터를 문자형 데이터로 변경
-- 9 : 숫자(값이 없으면 표시 X) / 0 : 숫자(값이 없으면 0으로 처리) / FM : 문자열 공백 제거 / L : 지역 통화 단위 
SELECT TO_CHAR(1234), 1234 AAAA FROM DUAL;   -- 문자는 왼쪽 정렬/ 숫자는 오른쪽 정렬
SELECT TO_CHAR(1234, '99999') A FROM DUAL;  -- 
SELECT TO_CHAR(1234, '00000') A FROM DUAL;
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;  -- 가운데 정렬
SELECT TO_CHAR(1234, 'FML99999') FROM DUAL; -- 
SELECT TO_CHAR(1234, '$99999') FROM DUAL;
SELECT TO_CHAR(1234, 'FM$99999') FROM DUAL;
SELECT TO_CHAR(1234, '99,999') A FROM DUAL;
SELECT TO_CHAR(1234, 'FM99,999') A FROM DUAL;
SELECT TO_CHAR(1234, '999') A FROM DUAL;
SELECT TO_CHAR(12, '999,999PR') FROM DUAL;

-- EMPLOYEE테이블에서 사원명, 급여 표시
-- 급여 '\9,000,000'형식으로 표시
SELECT EMP_NAME, TO_CHAR(SALARY, 'FML9,999,999') 급여
FROM EMPLOYEE;

SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- 지금 시간 출력
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;   -- 지금 오후라서 AM으로 해도 PM으로 출력
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL;  -- 24시간으로 출력
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;    
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-FMDD DAY') FROM DUAL;  -- FM을 붙이면 01-> 1로 출력 됨
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" DAY') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

SELECT TO_CHAR(HIRE_DATE, 'MM'), TO_CHAR(HIRE_DATE, 'MONTH'), TO_CHAR(HIRE_DATE, 'MON'), TO_CHAR(HIRE_DATE, 'RM')
FROM EMPLOYEE;

SELECT TO_CHAR(SYSDATE, 'DDD') "1년 기준", 
        TO_CHAR(SYSDATE, 'DD') "달 기준", 
        TO_CHAR(SYSDATE, 'D') "주 기준"
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'Q') 분기,
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- EMPLOYEE테이블에서 이름, 입사일 조회
--          입사일 : 0000년 00월 00일 (0)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" (DY)') 입사일
FROM EMPLOYEE;

-- TO_DATE : 문자/숫자형 데이터를 날짜형 데이터로 변경
SELECT TO_DATE('20200202', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20200202, 'YYYYMMDD') FROM DUAL;

SELECT TO_CHAR(TO_DATE('190505', 'YYYY"년" MM"월" DD"일"'), 'YYYY"년" MM"월" DD"일"') FROM DUAL;

SELECT TO_CHAR(TO_DATE('20200202 153814', 'YYYYMMDD HH24MISS'), 'YYYY-MM-DD HH:MI:SS') FROM DUAL;   -- 문자를 날짜라 바꾸고 다시 문자를 내가 원하는 형식으로 바꿔서 출력

-- TO_DATE에서 두 자리 연도에 YY를 적용시키면 무조건 현재 세기(21세기, 2000년대)가 적용
--                          RR을 적용시키면 두 자리 연도수가 50이상일 때는 이전 세기(20세기, 1900년대),
--                                                       50미만일 때는 현재 세기(21세기, 2000년대) 적용
-- 문자를 날짜로 바꿀 땐 R을 사용하는것이 더 좋다
SELECT TO_CHAR(TO_DATE('990311', 'YYMMDD'), 'YYYYMMDD')  "99YY",
       TO_CHAR(TO_DATE('070108', 'YYMMDD'), 'YYYYMMDD') "07YY",
       TO_CHAR(TO_DATE('990311', 'RRMMDD'), 'YYYYMMDD') "99RR",
       TO_CHAR(TO_DATE('070108', 'RRMMDD'), 'YYYYMMDD') "07RR"
FROM DUAL;

-- TO_NUMBER : 문자형 데이터를 숫자형 데이터로 변경
SELECT TO_NUMBER('12345') FROM DUAL;
SELECT 111+222 FROM DUAL;
SELECT '111'+'222' FROM DUAL;   -- 숫자형식의 문자가 있으면 알아서 숫자로 바꿔주기때문에 덧셉이 됨
SELECT '1,111' + '2,222' FROM DUAL;  -- 
SELECT TO_NUMBER('1,111', '999,999') + TO_NUMBER('2,222', '9,999')
FROM DUAL;

-- 5. NULL처리 함수
--- NVL
SELECT EMP_NAME, BONUS, NVL(BONUS, 0),DEPT_CODE, NVL(DEPT_CODE, '부서X')
FROM EMPLOYEE;

-- NVL2 : 있는거 없는거 같이 연산하고 싶을 때
SELECT EMP_NAME, BONUS, NVL2(BONUS,0.7, 0.5)    -- 보너스에 값이 이쓰면 0.7로 없으면 0.5로 바꿈
FROM EMPLOYEE;

-- NULLIF : 두개를 비교해서 같다고 할때의 조간, 다르다는 조건에 대한 조건을 쓸 수 있음
SELECT NULLIF(123,123), NULLIF(123,132) FROM DUAL;  -- 첫번째 값이 같으면 NULL, 두번째 값이 다르면 132로 바꿈

-- 6. 선택 함수
-- DECODE : DECODE(계산식/컬럼명, 조건값1, 선택값1, 조건값2, 선택값2, ....)
-- 비교하고자하는 값/컬럼이 조건식과 같으면 선택값 반환
SELECT EMP_ID, EMP_NAME, EMP_NO,
--       SUBSTR(EMP_NO, 8,1) 성별  -- 결과값이 남/여로 나오게 하고 싶으면 DECODE 이용
       DECODE(SUBSTR(EMP_NO, 8,1), 1, '남', 2, '여') 성별   -- SUBSTR~가 1이면 남자, 2이면 여자
--       DECODE(SUBSTR(EMP_NO, 8,1), 1, '남', '여') 성별      -- 1이면 남자, 1이 아니면 여자(즉, 1제외한 숫자가 들어가면 다 여자로 나옴)
FROM EMPLOYEE;

-- 직급코드가 j7이면 직원의 급여를 10% 인상
-- 직급코드가 j6이면 직원의 급여를 15% 인상
-- 직급코드가 j5이면 직원의 급여를 20% 인상
-- 그 외 직급은 급여를 5% 인상
-- 직원 명, 직급 코드, 급여, 인상 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY, DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2, SALARY*1.05) 인상급여 
FROM EMPLOYEE;

--SELECT EMP_NAME, JOB_CODE, SALARY, SALARY *(1 + DECODE(JOB_CODE, 'J7', SALARY*0.1, 'J6', SALARY*0.15, 'J5', SALARY*0.2, SALARY*0.05) 인상급여 
--FROM EMPLOYEE;


-- CASE WHEN
-- CASE WHEN 조건식 THEN 결과값
--      WHEN 조건식 THEN 결과값
--      [ELSE 결과값]
-- END
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과값 반환
-- 조건은 범위 값 가능

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE WHEN SUBSTR(EMP_NO, 8, 1) =1 THEN '남자' 
        WHEN SUBSTR(EMP_NO, 8, 1) = 2  THEN '여자' 
        END 성별
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE WHEN SUBSTR(EMP_NO, 8, 1) =1 THEN '남자' 
        ELSE '여자' 
        END 성별
FROM EMPLOYEE;

-- 직급코드가 j7이면 직원의 급여를 10% 인상
-- 직급코드가 j6이면 직원의 급여를 15% 인상
-- 직급코드가 j5이면 직원의 급여를 20% 인상
-- 그 외 직급은 급여를 5% 인상
-- 직원 명, 직급 코드, 급여, 인상 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY, 
       CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
       WHEN JOB_CODE = 'J6' THEN SALARY*1.15
       WHEN jOB_CODE = 'J5' THEN SALARY*1.2
       ELSE SALARY*1.05
       END "인상 급여"
FROM EMPLOYEE;

SELECT EMP_NAME, JOB_CODE, SALARY, 
       CASE JOB_CODE WHEN 'J7' THEN SALARY*1.1
                     WHEN 'J6' THEN SALARY*1.15
                     WHEN 'J5' THEN SALARY*1.2
                     ELSE SALARY*1.05
       END "인상 급여"
FROM EMPLOYEE;

-- 사번, 사원 명, 급여, 등급 조회
-- 등급 조건 : 급여가 500만보다 크면 1등급, 350만보다 크면 2등급, 200만보다 크면 3등급, 나머지는 4등급으로 등급 조회
SELECT EMP_ID, EMP_NAME, SALARY,
        CASE WHEN SALARY > 5000000 THEN '1등급'
             WHEN SALARY > 3500000 THEN '2등급'
             WHEN SALARY > 2000000 THEN '3등급'
             ELSE '4등급'
        END 등급
FROM EMPLOYEE;

-- 사번, 사원명, 급여
-- 급여가 500만원 이상이면 '고급'
-- 급여가 300~500만원이면 '중급'
-- 그 이하는 '초급'으로 출력처리하고 별칭은 '구분'으로 한다.
SELECT EMP_ID, EMP_NAME,
        CASE WHEN SALARY >= 5000000 THEN '고급'
             WHEN SALARY >= 3000000 THEN '중급'
             ELSE '초급'
        END 구분
FROM EMPLOYEE;

-- 그룹 함수 : 1개의 결과
-- SUM : 합계

-- EMPLOYEE테이블에서 전 사원의 급여 총합
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 남자 사원의 급여 총합 조회
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- EMPLOYEE테이블에서 부서코드가 D5인 직원의 보너스 포함된 연봉 합계 조회
SELECT SUM((SALARY + (SALARY * NVL(BONUS, 0)))*12)
FROM  EMPLOYEE
WHERE DEPT_CODE =  'D5';

-- AVG : 평균

-- EMPLOYEE테이블에서 전 사원의 급여 평균
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 전 사원의 보너스 평균을 소수점 셋째자리에서 반올림 조회
SELECT ROUND(AVG(BONUS), 2)  -- NULL을 가진 것은 계산에 포함에 안됨 -> 정확한 평균이 아님
FROM EMPLOYEE;  -- 0.22 

SELECT ROUND(AVG(NVL(BONUS, 0)), 2)     -- NULL값을 0으로 바꾸고 포함시킨 평균
FROM EMPLOYEE;  -- 0.08

SELECT AVG(BONUS), AVG(DISTINCT BONUS), AVG(NVL(BONUS, 0))
FROM EMPLOYEE;

-- MIN : 가장 작은 값 / MAX : 가장 큰 값 -> 숫자, 문자, 날짜 적용 가능

-- EMPLOYEE테이블에서 가장 적은 급여, 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일 조회
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 가장 많은 급여, 알파벳 순서가 가장 늦은 이메일, 가장 최근 입사일 조회
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- COUNT : 개수 세기
-- COUNT(컬럼명) : NULL이 제외된 해당 컬럼에 대한 개수 리턴
-- COUNT(DISTINCT 컴럼명) : 중복제거된 행 개수 리턴
-- COUNT(*) : NULL을 포함한 전체 행 개수 리턴

-- 전체 사원 수, 부서코드가 있는 사원 수, 사원들이 속해있는 부서 수
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;




