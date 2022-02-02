-- JOIN : �ϳ� �̻��� ���̺��� �����͸� ��ȸ�ϱ� ���� ��� (����� �ϳ��� RESULT SET�� ����)
-- ���, ��� ��, �μ��ڵ�, �μ� �� ��ȸ
SELECT EMPM_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE;
-- EMP_ID, EMP_NAME, EMP_CODE : EMPLOYEE
-- DEPT_TITLE : DEPARTMENT

SELECT EMP_ID, EMPT_NAME, DEPT_CODE
FROM EMPLOYEE;
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ���� ���� (INNER JOIN) : ������ �⺻
-- ����Ǵ� �÷��� ���� ��ġ�ϴ� ��鸸 ���� ��

-- [����Ŭ ����]
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT       -- ��� ������� ��� DEPT_TITLE�� ���ư��鼭 ����� (WHERE���� ���� ������ ���)
WHERE DEPT_CODE = DEPT_ID;      -- DEPT_CDOE�� NULL�� ����� ��µ��� ���� (DEPT_ID�� NULL�� �������� �ʱ� ����)
-- [ANSI ǥ�� ����]
-- ON : ���� �÷� ���� �ٸ� ��
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
 FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ���, ��� ��, �����ڵ�, ���� �� ��ȸ
-- [����Ŭ ����]
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
--WHERE JOB_CODE = JOB_CODE;  -- (���� ���ǰ� �ָ��մϴ�.��� ���� ��) �÷����� ���� ��� ���̺� �ִ� �÷����� ���� �� �� ����
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE; -- (���� ���ǰ� �ָ��մϴ�.��� ���� ��) SELECT���� JOB_CODE ����. SELECT������ ��� ���̺��� JOB_CODE���� ���

SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- ���̺� ��Ī ����ؼ� ���̺� ��� ����
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- [ANSI ǥ�� ����]
-- ON : ���� �÷� ���� �ٸ� ��
--      �÷� ���� ���ٸ� ��� ���̺� ���� �÷����� �� �� �ֵ��� ���̺� ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE
    JOIN JOB ON (JOB.JOB_CODE = EMPLOYEE.JOB_CODE);

-- USING : ���� �÷� ���� ���� ��
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE); 

-- �μ� ��� �ش� �μ��� ���� �� ��ȸ
-- [����Ŭ ����]
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

-- [ANSI ǥ�� ����]
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT 
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- �ܺ�����(OUTER JOIN)

-- LEFT [OUTER] JOIN : ���� ����� ���̺��� �÷� ���� �������� JOIN
-- [ANSI ǥ�� ����]
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    LEFT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);    -- OUTER���� ����

-- [����Ŭ ����]
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);   
-- ������ �����ִ� �÷��� (+)�� ���̸� �ܺ������� ��

-- RIGHT [OUTER] JOIN : ������ ����� ���̺��� �÷� ���� �������� JOIN
-- [ANSI ǥ�� ����]
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    RIGHT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- [����Ŭ ����]
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- PULL [OUTER] JOIN : �� ���̺��� ��� ������ �Ǵ� JOIN
-- [ANSI ǥ�� ����]
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    FULL /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- [����Ŭ ����]
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);   -- ORA-01468: outer-join�� ���̺��� 1���� ������ �� �ֽ��ϴ�
-- FULL OTER JOIN�� ����Ŭ�� ǥ�� X

-- ���� ���� : ���� ����
-- ���, ��� ��, �μ��ڵ� �μ� ��, ���� ��
-- [����Ŭ ����]
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
      AND LOCAL_CODE = LOCATION_ID;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE,  LOCATION, DEPARTMENT
WHERE LOCAL_CODE = LOCATION_ID
      AND DEPT_CODE = DEPT_ID;
      
-- [ANSI ǥ�� ����]
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID );

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
     JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID )  
     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- [ERROR] : ORA-00904: "LOCATION_ID": �������� �ĺ��� 
-- EMPLOYEE���̺�� LOCATION���̺��� ���� �������� ���� ����   
    
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
     JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID ) 
     JOIN EMPLOYEE ON (DEPT_CODE = DEPT_ID);

-- ������ �븮�̸鼭 �ƽþ� ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸�, ���� ��, �μ� ��, �ٹ�������, �޿�
-- [����Ŭ ����]
SELECT EMP_ID, EMP_NAME, J.JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM DEPARTMENT, EMPLOYEE E, JOB J, LOCATION
WHERE DEPT_ID = DEPT_CODE  -- DEPARTMENT�� EMPLOYEE ����
      AND E.JOB_CODE = J.JOB_CODE   
      AND LOCATION_ID = LOCAL_CODE  -- DEPARTMENT�� LOCATEION ����
      AND JOB_NAME  = '�븮'
      AND LOCAL_NAME LIKE 'ASIA%';
      
-- [ANSI ǥ�� ����]
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM DEPARTMENT
     JOIN EMPLOYEE ON (DEPT_ID = DEPT_CODE)
     JOIN JOB USING (JOB_CODE) 
     JOIN  LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE JOB_NAME = '�븮'
      AND LOCAL_NAME LIKE 'ASIA%';
      

      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      