/*
실행순서. (!중요!)
5. SELECT 컬럼명 AS 별칭, 계산식, 함수식            -- 
1. FROM 참조할 테이블 명                           -- 테이블을 먼저 세팅(like 뽑기판) 
2. WHERE 컬럼명|함수식 비교연산자 비교값              -- 필요한것을 걸러줌
3. GROUP BY 그룹으로 묶을 컬럼명                    -- 
4. HAVING 그룹함수식 비교연산자 비교값
6. OREDER BY 컬럼명|별칭|컬럼순번 정령 방식 [NULLS FIRSTR|LAST] 
    -- 별칭은 1234보다 늦게 만들었기 때문에 1234에선 사용 못함
*/

-- GROUP BY
SELECT DEPT_CODE, SUM(SALARY)   
FROM EMPLOYEE;                   
-- ORA-00937: 단일 그룹의 그룹 함수가 아닙니다 (행의 개수가 다르기 때문 / 행이 맞지 않기 때문)
-- GROUP BY를 사용해야 함 
 
SELECT DEPT_CODE, SUM(SALARY)   
FROM EMPLOYEE 
GROUP BY DEPT_CODE;

SELECT SUM(SALARY)   -- 출력은 되지만 뭐가 뭐의 합계인지 모름
FROM EMPLOYEE 
GROUP BY DEPT_CODE;     

-- EMPLOYEE테이블에서 부서 코드별 그룹을 지정하여 부서 코드, 그룹별 급여 합계, 그룹별 급여 평균(정수처리), 인원 수 조회
-- 부서코드 순으로 정렬
SELECT DEPT_CODE, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE테이블에서 부서코드와 보너스 받는 사원 수 조회하고 부서코드 순으로 정렬
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE테이블에서 직급코드, 보너스를 받는 사원의 수를 조회하여 직급코드 순으로 오름차순 정렬
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL     -- NULL인 것은 제외시켜 출력
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE테이블에서 성별과 성별 별 급여(정수처리), 급여 합계, 인원 수 조회하고 인원수로 내림차순 정렬
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여') 성별, FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1)  -- 성별로 그룹을 만듬
--GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여')
ORDER BY 인원수 DESC;

-- EMPLOYEE테이블에서 부서 코드 별로 같은 직급인 사원의 급여 합계 조회
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

-- HAVING

-- 부서 코드와 급여 300만 이상인 직원의 그룹별 평균 급여 조회 (WHERE절 이용)
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

-- 부서 코드와 급여 평균 300만 이상인 그룹 조회 (HAVING절 이용)
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- 부서 별 그룹의 급여 합계 중 9백만을 초과하는 부서코드와 급여 합계
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000;

-- 집계함수 ROLLUP / CUBE
-- 그룹 별 산출한 결과 값의 집계를 계산하는 함수
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)  -- 총 합계
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)    
ORDER BY JOB_CODE;

-- ROLLUP : 그룹 별로 중간 집계처리를 하는 함수
-- 인자로 전달받은 그룹 중에서 가장 먼저 지정된 그룹으로 집계 진행
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE) -- DEPT_CODE가 먼저 지정되었기 때문에 DEPT_CODE에 대해 집계가 진행 됨
ORDER BY DEPT_CODE;

-- CUBE : 그룹 별로 중간 집계처리를 하는 함수
-- 인자로 전달받은 모든 그룹에 대한 집계와 총 합계
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- 집합연산자
-- UNION : 합집합 (=OR)
-- INTERSECT : 교집합 (=AND)
-- UNION ALL : 합집합 + 교집합 (OR+AND)
-- MINUS : 차집합

-- UNION 
-- 사번이 200번인 사원과 201번인 사원 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200;
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201;

SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200 OR EMP_ID = 201;

SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200 
UNION
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201; 

-- DEPT_CODE가 D5이거나 급여가 300만원을 초과하는 직원의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- INTERSECT 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

-- UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 교집합의 결과 값인 심봉선과 대북혼이 중복되어 출력 됨

-- MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;     -- D5이면서 3백만원 이하로 버는 사람이 출력 됨 (=NOT)

-- GROUPING SETS : 행의 개수가 달라도  
-- UNION ALL 한 결과와 동일 함
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY GROUPING SETS((DEPT_CODE, JOB_CODE, MANAGER_ID),
                        (DEPT_CODE, MANAGER_ID),
                        (JOB_CODE, MANAGER_ID));
-- ↑  밑의 모든 합이 출력
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;       -- 19행

SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, MANAGER_ID;       -- 15행

SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;       -- 19행


