--1. BASIC SELECT
-- 1)
SELECT DEPARTMENT_NAME "학과 명", CATEGORY 계열
FROM TB_DEPARTMENT;

-- 2)
SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || '명 입니다.' "학과별 정원"
FROM TB_DEPARTMENT;

-- 3)
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_SSN, 8, 1) = 2
      AND ABSENCE_YN = 'Y'
      AND DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                           FROM TB_DEPARTMENT
                           WHERE DEPARTMENT_NAME = '국어국문학과');

SELECT STUDENT_NAME
FROM TB_STUDENT
    LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
      AND SUBSTR(STUDENT_SSN, 8, 1) = 2
      AND ABSENCE_YN = 'Y';

-- 4)
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY 1 DESC;

-- 5)
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- 6)
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7)
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8)
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9)
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY 1;

-- 10)
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) = 2002
      AND STUDENT_ADDRESS LIKE '%전주%'
      AND ABSENCE_YN = 'N';
      

-- 2. ADDITIONAL SELECT - 함수
-- 1) 
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, 
       TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 입학년도;

-- 2)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3)
SELECT PROFESSOR_NAME 교수이름, EXTRACT(YEAR FROM SYSDATE) - (19 || SUBSTR(PROFESSOR_SSN, 1, 2)) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = 1
ORDER BY 나이;

-- 4)
SELECT SUBSTR(PROFESSOR_NAME, 2) 이름
FROM TB_PROFESSOR;

-- 5)
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6))) > 19;

-- 6)
SELECT TO_CHAR(TO_DATE('20201225'), 'DAY')
FROM DUAL;

-- 7)
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'),'YYYY'), TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'),'YYYY'),
       TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'YYYY'), TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'YYYY')
FROM DUAL;

-- 8)
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE ENTRANCE_DATE < '2000/01/01';

-- 9)
SELECT ROUND(AVG(POINT), 1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10)
SELECT DEPARTMENT_NO, COUNT(*)
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 11)
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12)
SELECT SUBSTR(TERM_NO, 1, 4) 년도, ROUND(AVG(POINT), 1) "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

-- 13
SELECT DEPARTMENT_NO 학과코드명, COUNT(DECODE(ABSENCE_YN, 'Y', 1)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 14)
SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY 1;

-- 15)
SELECT SUBSTR(TERM_NO, 1, 4) 년도, SUBSTR(TERM_NO, 5, 2) 학기, ROUND(AVG(POINT), 1) 평균
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY 1; 