-- SELECT : 데이터 조회(검색)
-- SELECT를 통해 데이터를 조회하면 결과물로 Result Set으로 반환


-- EMPLYEE테이블의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY  
FROM EMPLOYEE;

-- EMPLOYEE테이블의 모든 정보 조회
SELECT EMP_ID, EMP_NAME, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
FROM EMPLOYEE;
-- 또는 SELECT * FROME EMPLOYEE; 
-- * : 아스트로

-- JOB 테이블의 모든 정보 조회
SELECT * FROM JOB;
-- JOB 테이블의 직급 이름 조회
SELECT JOB_NAME
FROM JOB;
-- DEPARTMENT테이블의 모든 정보 조회
SELECT * FROM DEPARTMENT;
-- EMPLOYEE테이블의 직원 명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;
-- EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 컬럼 값 연산
-- EMPLOYEE테이블에서 직원 명, 연봉(월급*12) 조회
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE데이블에서 직원 명, 연봉, 보너스를 추가한 연봉 조회
SELECT EMP_NAME, SALARY*12, (SALARY*(1+BONUS))*12  
FROM EMPLOYEE;
--SELECT EMP_NAME, SALARY*12, (SALARY+(SALARY*BONUS))*12  
--FROM EMPLOYEE;

-- EMPLOYEE테이블에서 이름 연봉, 총수령액(보너스 포함), 실수령액(총수령액-(연봉*세금3%)) 조회
SELECT EMP_NAME, SALARY*12, 
       (SALARY*(1+BONUS))*12, 
       (SALARY*(1+BONUS))*12 -(SALARY*12*0.03)
FROM EMPLOYEE;
-- EMPLOYEE테이블에서 이름, 고용일, 근무일수(오늘날짜(SYSDATE)-고용일) 조회
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;

-- 컴럼 별칭
-- 컬럼명 AS 별칭         컬럼명 "별칭"         컬럼명 AS "별칭"         컬럼명 별칭
-- 별칭을 ""으로 써야하는 경우 : 별칭에 특수문자가 들어간 경우(무조건), 특수문자를 쓰지 않아도 사용 가능
SELECT EMP_NAME AS 사원명, SALARY*12 연봉, (SALARY*(1+BONUS))*12 AS 보너스포함연봉  
FROM EMPLOYEE;

SELECT EMP_NAME "사원 명", SALARY*12 연봉, 
       (SALARY*(1+BONUS))*12 AS "총수령액(보너스 포함)", 
       (SALARY*(1+BONUS))*12 -(SALARY*12*0.03) AS 실수령액
FROM EMPLOYEE;

-- 리터럴
-- ''은 문자를 묶어줌(여러 문자가 들어가도 상관없음)
-- EMPLOYEE테이블에서 직원 번호, 사원 명, 급여, 단위(원) 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' 단위
FROM EMPLOYEE;

-- DISTINCT : 컬럼에 포함된 중복된 값을 한 번씩만 표시하고자 할 때

-- EMPLOYEE테이블에서 직원의 직급 코드 조회
SELECT JOB_CODE FROM EMPLOYEE;
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE테이블에서 부서코드와 직급코드 조회
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
--SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
--FROM EMPLOYEE;
-- DISTINCT는 SELECT절에 딱 한 번만 쓸 수 있음
SELECT DISTINCT DEPT_CODE, JOB_CODE    -- 앞에 쓰면 한 번에 묶여서 적용 됨
FROM EMPLOYEE;

-- WHERE절 : 조회할 조건을 명시하는 부분
-- 비교 연산자
-- = 같냐, > 크냐, < 작냐, >= 크거나 같냐, <= 작거나 같냐
-- !=, ^=, <> 같지 않냐

-- EMPLOYEE테이블에서 부서코드가 D9인 직원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE테이블에서 급여가 400000 이상인 직원의 이름, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE테이블에서 부서코드가 D9가 아닌 사원의 사번, 이름, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D9';
-- WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE테이블에서 퇴사 여부가 N인 직원을 조회하고 근무 여부를 재직중으로 표시하여
-- 사번, 이름, 고용일, 근무 여부 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, ENT_DATE, '재직중' "근무 여부"
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- EMPLOYEE데이블에서 월급이 3000000 이상인 사원의 이름, 월급, 고용일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000; 

-- EMPLOYEE테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- EMPLOYEE테이블에서 실수령액(총수령액-(연봉*세금3%))이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
SELECT EMP_NAME, SALARY, (SALARY*(1+BONUS))*12 -(SALARY*12*0.03) "실수령액", HIRE_DATE
FROM EMPLOYEE
WHERE (SALARY*(1+BONUS))*12 -(SALARY*12*0.03) >= 50000000;

-- 논리 연산자 : AND / OR    
-- AND : ~고, 동시에 (= &&)
-- OR : 또는, 이거나 (= ||)
-- 둘 중 AND가 우선순위

-- EMPLOYEE테이블에서 부서코드가 D6이고 급여를 3백만보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 3000000;

-- EMMPLOYEE테이블에서 부서코드가 D6이거나 급여를 3백만보다 많이 받는 직원의 이름, 부섴코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY > 3000000;

-- EMPLOYEE테이블에서 급여를 350만 이상 600만 이하를 받는 직원의 사번 이름, 급여, 부서콛, 직급코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- EMPLOYEE테이블에 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

-- EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중 고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE ='D9' OR DEPT_CODE = 'D5') AND HIRE_DATE <= '02/01/01';
-- AND가 우선이기 때문에 소괄호를 붙여 DEPT_CODE를 먼저 비교한 후 고용일이 비교함

-- BETWEEN AND : 하한값 이상 상한값 이하
-- 컬럼명 BETWEEN 하한값 AND 상한값
-- EMPLOYEE테이블에서 급여를 350만 이상 600만 이하를 받는 직원의 사번 이름, 급여, 부서코드, 직급코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 350만 미만 또는 600만 초과하는 직원의 사번, 이름, 급여, 부서코드, 직급코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY < 3500000 OR SALARY > 6000000;

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
-- WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- EMPLOYEE테이블에서 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- LIKE : 특정 패턴을 만족시키는지 조회
-- 검색하려는 값을 정확히 모를 경우 사용
-- WHERE 컬럼명 LIKE 검색내용
-- % / _  => 와일드 카드
-- % : 0글자 이상
-- _ : 1글자
-- '글자%' : 글자로 시작하는 값 EX. 글자, 글자뭐지 ...
-- '%글자%' : 글자가 포함된 값(위치는 상관없이 글자가 들어가기만 하면 됨) EX. 글자, 글자뭦, 내글자 ...
-- '%글자' : 글자로 끝나는 값 EX. 네글자, 글자 ...
-- '글%자' : 글로 시작해서 자로 끝나는 값 EX. 글의남자, 글자 ...
-- '_' : 한 글자
-- '__' : 두 글자
-- '___' : 세 글자 
-- EMPLOYEE테이블에서 성이 전씨인 사원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';  
--'전___'라고 하면 무조건 이름이 세 글자인 사람만 나옴(외자나 세 글자 이상인 사람은 나오지 않음)

-- EMPLOYEE테이블에서 이름에 '하'가 포함된 직원의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- EMPOYEE테이블에서 전화번호 4번째 자리가 9로 시작하는 사원의 사번, 이름, 전화번호 조회
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- EMPLOYEE테이블에서 김씨 성이 아닌 사원의 사번, 이름, 고용일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE NOT EMP_NAME LIKE '김%';
WHERE EMP_NAME NOT LIKE '김%';

-- EMPLOYEE테이블에서 이메일 중 _의 앞 글자가 3자리인 이메일 주소를 가진 사원의 사번, 이름, 이메일 주소 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- 와일드카드 문자와 패턴의 특수 문자가 동일한 경우 어떤 것이 와일드카드이고 어떤것이 특수문자인지 구분X
-- 특부문자 자체를 데이터로 처리하기 위해 구분할 수 있는 장치 필요 = ESCAPE OPTION
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___!_%' ESCAPE '!';   -- 특수문자 뒤에 있는 데이터는 와일드카드가 아니다!
-- 특수문자는 아무꺼나 사용 가능

-- EMPLOYEE테이블에서 이름 끝이 '연'으로 끝나는 사원 이름 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';
-- EMPLOYEE테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
-- EMPLOYEE테이블에서 메일주소 _앞이 4글자이면서 DEPT_CODE가 D9 또는 D6이고 고용일이 90/01/01~00/12/01이고, 급여가 270만 이상인 사원 전체 조회
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____!_%' ESCAPE '!' 
    AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') 
    AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01' 
    AND SALARY >= 2700000;

-- IS NULL/IS NOT NULL : 컬럼값에 NULL값이 들어가있는지 아닌지 판별

-- EMMPLOYEE테이블에서 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- EMMPLOYEE테이블에서 보너스를 받는 사원의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS IS NOT NULL;
WHERE NOT BONUS IS NULL;

-- EMPLOYEE테이블에서 관리자도 없고 부서 배치도 받지 않은 직원의 이름, 관리자, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- EMPLOYEE테이블에서 부서 배치를 받지 않았지만 보너스를 지급받은 직원의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- IN : 목록에 일치하는 값이 있으면 TRUE 반환

-- D6 부서와 D9부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D9';
WHERE DEPT_CODE IN ('D6','D9'); 

-- 직급코드가 J1, J2, J3, J4인 사람들의 이름, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
--WHERE JOB_CODE = 'J1' OR JOB_CODE = 'J2' OR JOB_CODE = 'J3' OR JOB_CODE = 'J4';
WHERE JOB_CODE IN ('J1', 'J2', 'J3', 'J4');

-- 연결 연산자 ||
-- EMPLOYEE테이블에서 사번, 이름, 급여를 연결하여 조회
--SELECT EMP_ID, EMP_NAME, SALARY
--FROM EMPLOYEE;
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY || '원'
FROM EMPLOYEE;

-- OREDER BY : 정렬할 때 작성하는 구문
-- SELECT문에서 가장 마지막에 작성, 실행 순서도 가장 마지막
-- 컬럼명/별칭/컬럼순번 정렬방식 NULLS FIRST/NULLS LAST
-- 오름차순 : ASC(생략가능) / 내림차순 : DESC(무조건 명시)
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, BONUS
FROM EMPLOYEE
--ORDER BY EMP_ID;          -- 오름차순
--ORDER BY EMP_ID DESC;     -- 내림차순
--ORDER BY EMP_ID ASC;        -- 오름차순
--ORDER BY EMP_NAME ASC;
--ORDER BY EMP_NAME ;
--ORDER BY EMP_NAME DESC;
--ORDER BY 이름 DESC;           -- 별칭으로 내림차순 정렬
--ORDER BY 3 DESC;        -- 3은 SELECT에서의 순번을 의미
ORDER BY BONUS DESC NULLS LAST;     -- NULL값은 마지막으로 출력


