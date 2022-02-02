-- �������� : �ϳ��� sql�� �ȿ� �Ǵٸ� sql���� ���ԵǴ� ��
-- �μ��ڵ尡 ���ö ����� ���� �Ҽ��� ���� ��� ��ȸ
-- 1) ���ö ����� �μ��ڵ�
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';     -- D9
-- 2) �μ��ڵ尡 D9�� ���� ��� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';
---- 1) + 2)
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');

-- �� ������ ��� �޿����� ���� �޿��� �ް��ִ� ������ ���, �̸�, �����ڵ�, �޿�
-- 1) �� ������ ��� �޿�
SELECT AVG(SALARY)
FROM EMPLOYEE;  -- 3047662.60869565217391304347826086956522
-- 2) ��� �޿����� ���� �޴� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3047662.60869565217391304347826086956522;
-- 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- �������� ����
-- ������ �������� : ���������� ��� ���� 1���� ��
-- ������ �������� : ���������� ��� ���� ���� ���� ��
-- ���߿� �������� : ���������� ��� �׸��� ���� �� �� ��
-- ������ ���߿� �������� : ���������� ��� �׸� �� ������ ���� ���� ��

-- ������ �������� : �Ϲ������� ������ �������� �տ��� �Ϲ� �����ڰ� ��
--  <, >, <=, >=, =, !=/<>/^=
-- ���ö ����� �޿����� ���� �޴� ������ ���, �̸�, �μ���, �����ڵ�, �޿� ��ȸ
-- 1) ���ö ����� �޿�
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';
-- 2)3700000���� ���� �޴� ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3700000;
-- 1) + 2)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö'); 

-- ���� ���� �޿��� �޴� ������ ���, �̸�, �����ڵ�, �μ��ڵ�, �޿�, �Ի���
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- �� ������ �޿� ��պ��� ���� �޿��� �޴� ������ �̸�, �����ڵ�, �μ��ڵ�, �޿� ��ȸ(���� ������ ����)
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY JOB_CODE;

-- �μ� �� �޿� �հ� �� ���� ū �μ��� �μ���, �޿� �հ� ��ȸ
-- 1) �μ� �� �޿� �հ�
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;
-- 2) �޿� �հ谡 ���� ū �μ��� �޿� �հ�
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

-- ������ �������� : �Ϲ� �񱳿����� ���X
-- IN/NOT IN : ���� ���� ��� �� �� �� ���� ��ġ�ϴ� ���� �ִٸ�/���ٸ�
-- > ANY, < ANY : ���� ���� ��� �� �� �� ���� ū/���� ���
--                ���� ���� ������ ũ�� / ���� ū ������ �۳�
-- > ALL, < ALL : ��� ������ ū/���� ���
--                ���� ū ������ ũ�� / ���� ���� ������ �۳�
-- EXISTS / NOT EXISTS : ���� ����/�������� �ʴ���
-- IN�� EXISTS�� ���� : IN ���� ��� ���� ã�� ��ȯ
--                     EXISTS�� TRUE/FALSE�� ��ȯ

-- �μ� ���� �ְ� �޿��� �޴� ������ �̸�, �����ڵ�, �μ��ڵ�, �޿� ��ȸ
-- 1) �μ� �� �ְ� �޿�
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                 FROM EMPLOYEE
                 GROUP BY DEPT_CODE);

-- �����ڿ� �Ϲ� ������ �ش��ϴ� ��� ���� ���� : ���, �̸�, �μ���, ����, ����(������/����)
-- 1) �����ڿ� �ش��ϴ� ��� ��ȣ ��ȸ
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;
-- 2) ������ ���, �̸�, �μ���, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE);
-- 3) �����ڿ� �ش��ϴ� ������ ���� ���� ���� (1 + 2)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������' ����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL);

-- 4) �Ϲ� ������ �ش��ϴ� ���� ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '����' ����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE
                     WHERE MANAGER_ID IS NOT NULL);
-- 3) + 4) ������,���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '������' ����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '����' ����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE
                     WHERE MANAGER_ID IS NOT NULL);

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
       CASE WHEN EMP_ID IN (SELECT DISTINCT MANAGER_ID
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '������'
            ELSE '����'
       END ����
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE);

-- �븮 ������ ���� �� ���� ������ �ּ� �޿����� ���� �޴� ������ ���, �̸�, ����, �޿� ��ȸ
-- 1) �븮 ���� �Ӥ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';

-- 2) ���� ���� ���� �޿�
SELECT SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
      AND SALARY > ANY(SELECT SALARY
                        FROM EMPLOYEE
                             JOIN JOB USING (JOB_CODE)
                        WHERE JOB_NAME = '����');

-- �ٸ� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
      AND SALARY > (SELECT MIN(SALARY)
                    FROM EMPLOYEE
                         JOIN JOB USING (JOB_CODE)
                    WHERE JOB_NAME = '����');

-- ���� ���� �޿��� ���� ū ������ ���� �޴� ���� ������ ���, �̸�, ����, �޿� ��ȸ
-- 1) ���� ������ ���, �̸�,����, �޿�
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- 2) ���� ���� �޿�
SELECT SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����' 
      AND SALARY > ALL(SELECT SALARY
                        FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '����');

-- �ٸ� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����' 
      AND SALARY > (SELECT MAX(SALARY)
                    FROM EMPLOYEE
                         JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '����');

-- ���߿� ��������
-- ����� �������� ���� �μ�, ���� ���޿� �ش��ϴ� ����� �̸�, �����ڵ�, �μ��ڵ�, �Ի��� ��ȸ
-- 1) ����� �������� �μ�, ���� ��ȸ
SELECT JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2
    AND ENT_YN = 'Y';

-- 2) ��� ������ ���� �μ�, ���� ����
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

-- ���߿� �������� ����
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y')
      AND EMP_NAME != (SELECT EMP_NAME
                        FROM EMPLOYEE
                        WHERE SUBSTR(EMP_NO,  8, 1) = 2 AND ENT_YN = 'Y');

-- ������ ���߿� ��������
-- �ڱ� ������ ��� �޿��� �ް� �ִ� ������ ���, �̸�, �����ڵ�, �޿� ��ȸ
-- ��, �޿��� �޿� ����� �ʸ��������� ��� TRUNC(�÷���, -5)
-- 1) ���޺� ��� �޿�
SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) �ڱ� ������ ��� �޿��� �ް� �ִ� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);

-- �ζ��κ� : FROM���� �� ��������
-- �� ���� �� �޿��� ���� ���� 5���� ����, �̸�, �޿� ��ȸ
-- ROWNUM : �� ��ȣ �ǹ�, FROM�� ������ �� �ٿ��� 
-- ���� ���� : 1. FROM 2. SELECT 3. ORDER BY (!���� �߿�!)
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE   -- FROM���� ORDER BY���� ���� ���� �Ǳ⶧���� EMPLOYEE������ �� ��ȣ�� �״�� ������ ROWNUM�� ���׹������� ��
ORDER BY SALARY DESC;  -- ������, ������, ������, ���ȥ. ���ö

-- ���� ���� : 1. FROM 2. WHERE 3. SELECT 4. ORDER BY
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE 
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- FROM�� �ȿ� ���������� ������ ���� ���������� ����� �� ���������� ���� ROWNUM�� �ٰ�, �������� ���� ROWNUM 5���� �̾ƿ´�.
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME       
      FROM EMPLOYEE
      ORDER BY SALARY DESC)  -- ������ �÷��� �������� �ʾ� ORA-00904: "SALARY": �������� �ĺ��ڷ� ������ �߻���
WHERE ROWNUM <= 5;
--ORDER BY SALARY DESC;  -- FROM���� ������������ �̹� ������������ ������ �߱� ������ ��� ��

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT * /*EMP_NAME, SALARY*/  -- SELECT������ ��ȸ�� �����͸� �̾ƿ��� ������ ������������ * ��� ���� 
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;
-- TOP-N�м� : ������ ���ϴ� �� 

-- �޿� ��� 3�� �ȿ� ��� �μ��� �μ��ڵ�� �μ� ��, ��� �޿� ��ȸ

SELECT DEPT_CODE, DEPT_TITLE, /*AVG(SALARY)*/ ��ձ޿� -- FROM�� ������������ AVG(SALARY)�� ��ձ޿��� ��Ī�� �����߱⶧���� ��ձ޿��� 
 FROM(SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) ��ձ޿�
      FROM EMPLOYEE
           JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
      GROUP BY DEPT_CODE, DEPT_TITLE
      ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;  -- ORA-00904: "SALARY": �������� �ĺ���

-- WITH : ���������� �̸��� �ٿ���
-- ���� ���������� ������ ����� �� �� �ߺ� �ۼ��� ����
-- ���� �ӵ��� ������
WITH TOPN_SAL AS (SELECT *
                   FROM EMPLOYEE
                   ORDER BY SALARY DESC)
SELECT ROWNUM, EMP_NAME, SALARY
FROM TOPN_SAL;

WITH AVG_SAL AS (SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) ��ձ޿�
                 FROM EMPLOYEE
                     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                  GROUP BY DEPT_CODE, DEPT_TITLE
                ORDER BY AVG(SALARY) DESC)
SELECT DEPT_CODE, DEPT_TITLE, /*AVG(SALARY)*/ ��ձ޿�  
FROM AVG_SAL
WHERE ROWNUM <= 3;

-- RANK() OVER / DENSE_RANK() OVER
-- RANK() OVER : ������ ���� ������ ����� ������ �ο� ����ŭ �ǳʶٰ� ���� ���
SELECT RANK() OVER(ORDER BY SALARY DESC) ����, EMP_NAME, SALARY
FROM EMPLOYEE;

-- DENSE_RANK() OVER : �ߺ��Ǵ� ���� ������ ����� ���� ����� ���
-- DENSE_RANK() OVER : ������ ���� ������ ����� ������ ������ ���
SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) ����, EMP_NAME, SALARY
FROM EMPLOYEE;
