-- 서브쿼리 : 하나의 sql문 안에 또다른 sql문이 포함되는 것
-- 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
-- 1) 노옹철 사원의 부서코드
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';     -- D9
-- 2) 부서코드가 D9인 직원 명단 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';
---- 1) + 2)
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');

-- 전 직원의 평균 급여보다 많은 급여를 받고있는 직원의 사번, 이름, 직급코드, 급여
-- 1) 전 직원의 평균 급여
SELECT AVG(SALARY)
FROM EMPLOYEE;  -- 3047662.60869565217391304347826086956522
-- 2) 평균 급여보다 많이 받는 직원
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3047662.60869565217391304347826086956522;
-- 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- 서브쿼리 유형
-- 단일행 서브쿼리 : 서브쿼리의 결과 값이 1개일 때
-- 다중행 서브쿼리 : 서브쿼리의 결과 값이 여러 개일 때
-- 다중열 서브쿼리 : 서브쿼리의 결과 항목이 여러 개 일 때
-- 다중행 다중열 서브쿼리 : 서브쿼리의 결과 항목 및 개수가 여러 개일 때

-- 단일행 서브쿼리 : 일반적으로 단일행 서브쿼리 앞에는 일반 연산자가 들어감
--  <, >, <=, >=, =, !=/<>/^=
-- 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서콛, 직급코드, 급여 조회
-- 1) 노옹철 사원의 급여
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';
-- 2)3700000보다 많이 받는 직원 정보
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3700000;
-- 1) + 2)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철'); 

-- 가장 적은 급여를 받는 직원의 사번, 이름, 직급코드, 부서코드, 급여, 입사일
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- 전 직원의 급여 평균보다 적은 급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회(직급 순으로 정렬)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY JOB_CODE;

-- 부서 별 급여 합계 중 가장 큰 부서의 부서명, 급여 합계 조회
-- 1) 부서 병 급여 합계
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;
-- 2) 급여 합계가 가장 큰 부서의 급여 합계
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 1) + 2)
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);

-- 다중행 서브쿼리 : 일반 비교연산자 사용X
-- IN/NOT IN : 여러 개의 결과 값 중 한 개라도 일치하는 값이 있다면/없다면
-- > ANY, < ANY : 여러 개의 결과 값 중 한 개라도 큰/작은 경우
--                가장 작은 값보다 크냐 / 가장 큰 값보다 작냐
-- > ALL, < ALL : 모든 값보다 큰/작은 경우
--                가장 큰 값보다 크냐 / 가장 작은 값보다 작냐
-- EXISTS / NOT EXISTS : 값이 존재/존재하지 않는지
-- IN과 EXISTS의 차이 : IN 같은 경우 값을 찾아 반환
--                     EXISTS는 TRUE/FALSE만 반환

-- 부서 별로 최고 급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회
-- 1) 부서 별 최고 급여
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                 FROM EMPLOYEE
                 GROUP BY DEPT_CODE);

-- 관리자와 일반 직원에 해당하는 사원 정보 추출 : 사번, 이름, 부서명, 직급, 구분(관리자/직원)
-- 1) 관리자에 해당하는 사원 번호 조회
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;
-- 2) 직원의 사번, 이름, 부서명, 직급 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE);
-- 3) 관리자에 해당하는 직원에 대한 정보 추출 (1 + 2)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL);

-- 4) 일반 직원에 해당하는 직원 정보 추출
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '직원' 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE
                     WHERE MANAGER_ID IS NOT NULL);
-- 3) + 4) 관리자,직원 정보 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '직원' 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE
                     WHERE MANAGER_ID IS NOT NULL);

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
       CASE WHEN EMP_ID IN (SELECT DISTINCT MANAGER_ID
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '관리자'
            ELSE '직원'
       END 구분
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE);

-- 대리 직급의 직원 중 과장 직급의 최소 급여보다 많이 받는 직원의 사번, 이름, 직급, 급여 조회
-- 1) 대리 직급 ㅣㅈㄱ원 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';

-- 2) 과장 직급 직원 급여
SELECT SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리'
      AND SALARY > ANY(SELECT SALARY
                        FROM EMPLOYEE
                             JOIN JOB USING (JOB_CODE)
                        WHERE JOB_NAME = '과장');

-- 다른 방법
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리'
      AND SALARY > (SELECT MIN(SALARY)
                    FROM EMPLOYEE
                         JOIN JOB USING (JOB_CODE)
                    WHERE JOB_NAME = '과장');

-- 차장 직급 급여의 가장 큰 값보다 많이 받는 과장 직급의 사번, 이름, 직급, 급여 조회
-- 1) 과장 직급의 사번, 이름,직급, 급여
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- 2) 차장 직급 급여
SELECT SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '차장';

-- 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장' 
      AND SALARY > ALL(SELECT SALARY
                        FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '차장');

-- 다른 방법
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장' 
      AND SALARY > (SELECT MAX(SALARY)
                    FROM EMPLOYEE
                         JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '차장');

-- 다중열 서브쿼리
-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급코드, 부서코드, 입사일 조회
-- 1) 퇴사한 여직원의 부서, 직급 조회
SELECT JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2
    AND ENT_YN = 'Y';

-- 2) 퇴사 직원과 같은 부서, 같은 직급
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y')
      AND JOB_CODE = (SELECT JOB_CODE
                     FROM EMPLOYEE
                     WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y')
     AND EMP_NAME != (SELECT EMP_NAME
                     FROM EMPLOYEE
                     WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y');

-- 다중열 서브쿼리 적용
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y')
      AND EMP_NAME != (SELECT EMP_NAME
                        FROM EMPLOYEE
                        WHERE SUBSTR(EMP_NO,  8, 1) = 2 AND ENT_YN = 'Y');

-- 다중행 다중열 서브쿼리
-- 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회
-- 단, 급여와 급여 평균은 십만원단위로 계산 TRUNC(컬럼명, -5)
-- 1) 직급별 편균 급여
SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) 자기 직급의 편균 급여를 받고 있는 직원
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);

-- 인라인뷰 : FROM절에 들어간 서브쿼리
-- 전 직원 중 급여가 높은 상위 5명의 순위, 이름, 급여 조회
-- ROWNUM : 행 번호 의미, FROM절 수행할 때 붙여짐 
-- 수행 순서 : 1. FROM 2. SELECT 3. ORDER BY (!순서 중요!)
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE   -- FROM절이 ORDER BY보다 먼저 수행 되기때문에 EMPLOYEE에서의 행 번호를 그대로 가져와 ROWNUM이 뒤죽박죽으로 됨
ORDER BY SALARY DESC;  -- 선동일, 송종시, 정중하, 대북혼. 노옹철

-- 수행 순서 : 1. FROM 2. WHERE 3. SELECT 4. ORDER BY
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE 
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- FROM절 안에 서브쿼리가 존재해 먼저 서브쿼리가 실행된 후 서브쿼리에 대한 ROWNUM이 붙고, 조건절에 의해 ROWNUM 5개를 뽑아온다.
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME       
      FROM EMPLOYEE
      ORDER BY SALARY DESC)  -- 정렬할 컬럼이 존재하지 않아 ORA-00904: "SALARY": 부적합한 식별자로 오류가 발생함
WHERE ROWNUM <= 5;
--ORDER BY SALARY DESC;  -- FROM절의 서브쿼리에서 이미 내림차순으로 정렬을 했기 때문에 없어도 됨

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT * /*EMP_NAME, SALARY*/  -- SELECT절에서 조회할 데이터를 뽑아오기 때문에 서브쿼리에서 * 사용 가능 
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;
-- TOP-N분서 : 순위를 정하는 것 

-- 급여 평균 3위 안에 드는 부서의 부서코드와 부서 명, 평균 급여 조회

SELECT DEPT_CODE, DEPT_TITLE, /*AVG(SALARY)*/ 평균급여 -- FROM절 서브쿼리에서 AVG(SALARY)를 평균급여로 별칭을 지정했기때문에 평균급여를 
 FROM(SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) 평균급여
      FROM EMPLOYEE
           JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      GROUP BY DEPT_CODE, DEPT_TITLE
      ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;  -- ORA-00904: "SALARY": 부적합한 식별자

-- WITH : 서브쿼리에 이름을 붙여줌
-- 같은 서브쿼리가 여러번 사용이 될 때 중복 작성을 줄임
-- 실행 속도도 빨라짐
WITH TOPN_SAL AS (SELECT *
                   FROM EMPLOYEE
                   ORDER BY SALARY DESC)
SELECT ROWNUM, EMP_NAME, SALARY
FROM TOPN_SAL;

WITH AVG_SAL AS (SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) 평균급여
                 FROM EMPLOYEE
                     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                  GROUP BY DEPT_CODE, DEPT_TITLE
                ORDER BY AVG(SALARY) DESC)
SELECT DEPT_CODE, DEPT_TITLE, /*AVG(SALARY)*/ 평균급여  
FROM AVG_SAL
WHERE ROWNUM <= 3;

-- RANK() OVER / DENSE_RANK() OVER
-- RANK() OVER : 동일한 순위 이후의 등수를 동일한 인원 수만큼 건너뛰고 순위 계산
SELECT RANK() OVER(ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY
FROM EMPLOYEE;

-- DENSE_RANK() OVER : 중복되는 순위 이후의 등수를 이후 등수로 계산
-- DENSE_RANK() OVER : 동일한 순위 이후의 등수를 이후의 순위로 계산
SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY
FROM EMPLOYEE;
