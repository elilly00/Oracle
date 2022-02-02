/*
�������. (!�߿�!)
5. SELECT �÷��� AS ��Ī, ����, �Լ���            -- 
1. FROM ������ ���̺� ��                           -- ���̺��� ���� ����(like �̱���) 
2. WHERE �÷���|�Լ��� �񱳿����� �񱳰�              -- �ʿ��Ѱ��� �ɷ���
3. GROUP BY �׷����� ���� �÷���                    -- 
4. HAVING �׷��Լ��� �񱳿����� �񱳰�
6. OREDER BY �÷���|��Ī|�÷����� ���� ��� [NULLS FIRSTR|LAST] 
    -- ��Ī�� 1234���� �ʰ� ������� ������ 1234���� ��� ����
*/

-- GROUP BY
SELECT DEPT_CODE, SUM(SALARY)   
FROM EMPLOYEE;                   
-- ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ� (���� ������ �ٸ��� ���� / ���� ���� �ʱ� ����)
-- GROUP BY�� ����ؾ� �� 
 
SELECT DEPT_CODE, SUM(SALARY)   
FROM EMPLOYEE 
GROUP BY DEPT_CODE;

SELECT SUM(SALARY)   -- ����� ������ ���� ���� �հ����� ��
FROM EMPLOYEE 
GROUP BY DEPT_CODE;     

-- EMPLOYEE���̺��� �μ� �ڵ庰 �׷��� �����Ͽ� �μ� �ڵ�, �׷캰 �޿� �հ�, �׷캰 �޿� ���(����ó��), �ο� �� ��ȸ
-- �μ��ڵ� ������ ����
SELECT DEPT_CODE, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE���̺��� �μ��ڵ�� ���ʽ� �޴� ��� �� ��ȸ�ϰ� �μ��ڵ� ������ ����
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE���̺��� �����ڵ�, ���ʽ��� �޴� ����� ���� ��ȸ�Ͽ� �����ڵ� ������ �������� ����
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL     -- NULL�� ���� ���ܽ��� ���
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE���̺��� ������ ���� �� �޿�(����ó��), �޿� �հ�, �ο� �� ��ȸ�ϰ� �ο����� �������� ����
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��') ����, FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1)  -- ������ �׷��� ����
--GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��')
ORDER BY �ο��� DESC;

-- EMPLOYEE���̺��� �μ� �ڵ� ���� ���� ������ ����� �޿� �հ� ��ȸ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

-- HAVING

-- �μ� �ڵ�� �޿� 300�� �̻��� ������ �׷캰 ��� �޿� ��ȸ (WHERE�� �̿�)
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

-- �μ� �ڵ�� �޿� ��� 300�� �̻��� �׷� ��ȸ (HAVING�� �̿�)
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- �μ� �� �׷��� �޿� �հ� �� 9�鸸�� �ʰ��ϴ� �μ��ڵ�� �޿� �հ�
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000;

-- �����Լ� ROLLUP / CUBE
-- �׷� �� ������ ��� ���� ���踦 ����ϴ� �Լ�
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)  -- �� �հ�
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)    
ORDER BY JOB_CODE;

-- ROLLUP : �׷� ���� �߰� ����ó���� �ϴ� �Լ�
-- ���ڷ� ���޹��� �׷� �߿��� ���� ���� ������ �׷����� ���� ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE) -- DEPT_CODE�� ���� �����Ǿ��� ������ DEPT_CODE�� ���� ���谡 ���� ��
ORDER BY DEPT_CODE;

-- CUBE : �׷� ���� �߰� ����ó���� �ϴ� �Լ�
-- ���ڷ� ���޹��� ��� �׷쿡 ���� ����� �� �հ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- ���տ�����
-- UNION : ������ (=OR)
-- INTERSECT : ������ (=AND)
-- UNION ALL : ������ + ������ (OR+AND)
-- MINUS : ������

-- UNION 
-- ����� 200���� ����� 201���� ��� ��ȸ
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

-- DEPT_CODE�� D5�̰ų� �޿��� 300������ �ʰ��ϴ� ������ ���, �̸�, �μ��ڵ�, �޿� ��ȸ
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
WHERE SALARY > 3000000; -- �������� ��� ���� �ɺ����� ���ȥ�� �ߺ��Ǿ� ��� ��

-- MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;     -- D5�̸鼭 3�鸸�� ���Ϸ� ���� ����� ��� �� (=NOT)

-- GROUPING SETS : ���� ������ �޶�  
-- UNION ALL �� ����� ���� ��
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY GROUPING SETS((DEPT_CODE, JOB_CODE, MANAGER_ID),
                        (DEPT_CODE, MANAGER_ID),
                        (JOB_CODE, MANAGER_ID));
-- ��  ���� ��� ���� ���
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;       -- 19��

SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, MANAGER_ID;       -- 15��

SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;       -- 19��


