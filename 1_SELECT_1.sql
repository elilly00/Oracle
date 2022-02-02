-- EMPLYEE���̺��� ���, �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ��� ���� ��ȸ
SELECT * FROM EMPLOYEE;

-- JOB ���̺��� ��� ���� ��ȸ
SELECT * FROM JOB;

-- JOB ���̺��� ���� �̸� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- DEPARTMENT���̺��� ��� ���� ��ȸ
SELECT * FROM DEPARTMENT;

-- EMPLOYEE���̺��� ���� ��, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE���̺��� �����, ��� �̸�, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-- �÷� �� ����
-- EMPLOYEE���̺��� ���� ��, ����(����*12) ��ȸ
SELECT EMP_NAME, SALARY*12 ����
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ���� ��, ����, ���ʽ��� �߰��� ���� ��ȸ
SELECT EMP_NAME, SALARY*12 ����, (SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE;

-- EMPLOYEE���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ� ����), �Ǽ��ɾ�(�Ѽ��ɾ�-(����*����3%)) ��ȸ
SELECT EMP_NAME, SALARY*12 ����, (SALARY+(SALARY*BONUS))*12 �Ѽ��ɾ�, 
      (SALARY+(SALARY*BONUS))*12-((SALARY*12)*0.03) �Ǽ��ɾ�
FROM EMPLOYEE;

-- EMPLOYEE���̺��� �̸�, �����, �ٹ��ϼ�(���ó�¥(SYSDATE)-�����) ��ȸ
SELECT EMP_NAME, HIRE_DATE �����, SYSDATE-HIRE_DATE �ٹ��ϼ�
FROM EMPLOYEE;

-- ���ͷ�
-- EMPLOYEE���̺��� ���� ��ȣ, ��� ��, �޿�, ����(��) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' ����
FROM EMPLOYEE;

-- DISTINCT : �÷��� ���Ե� �ߺ��� ���� �� ���� ǥ��
-- EMPLOYEE���̺��� ������ ���� �ڵ� ��ȸ
SELECT JOB_CODE FROM EMPLOYEE;
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE���̺��� �μ��ڵ�� �����ڵ� ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE���̺��� �μ��ڵ尡 D9�� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE���̺��� �޿��� 400000 �̻��� ������ �̸�, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 400000;

-- EMPLOYEE���̺��� �μ��ڵ尡 D9�� �ƴ� ����� ���, �̸�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';

-- EMPLOYEE���̺��� ��� ���ΰ� N�� ������ ��ȸ�ϰ� �ٹ� ���θ� ���������� ǥ���Ͽ�
-- ���, �̸�, �����, �ٹ� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '������' "�ٹ� ����"
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- EMPLOYEE���̺��� ������ 3000000 �̻��� ����� �̸�, ����, ����� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- EMPLOYEE���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- EMPLOYEE���̺��� �Ǽ��ɾ�(�Ѽ��ɾ�-(����*����3%))�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, �����
SELECT EMP_NAME, SALARY, (SALARY+(SALARY*BONUS))*12 �Ǽ��ɾ�, HIRE_DATE
FROM EMPLOYEE
WHERE (SALARY+(SALARY*BONUS))*12 >= 50000000;

-- EMPLOYEE���̺��� �μ��ڵ尡 D6�̰� �޿��� 3�鸸���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY >= 3000000;

-- EMMPLOYEE���̺��� �μ��ڵ尡 D6�̰ų� �޿��� 3�鸸���� ���� �޴� ������ �̸�, �ΙC�ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- EMPLOYEE���̺��� �޿��� 350�� �̻� 600�� ���ϸ� �޴� ������ ��� �̸�, �޿�, �μ���, �����ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- EMPLOYEE���̺� ������ 4000000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

-- EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� �� ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND HIRE_DATE <= '02/01/01';

-- EMPLOYEE���̺��� �޿��� 350�� �̻� 600�� ���ϸ� �޴� ������ ��� �̸�, �޿�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 350�� �̸� �Ǵ� 600�� �ʰ��ϴ� ������ ���, �̸�, �޿�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- EMPLOYEE���̺��� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ���� ��ȸ
SELECT * 
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- EMPLOYEE���̺��� ���� ������ ����� ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- EMPLOYEE���̺��� �̸��� '��'�� ���Ե� ������ �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- EMPOYEE���̺��� ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ����� ���, �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '____9%';

-- EMPLOYEE���̺��� �达 ���� �ƴ� ����� ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '��%';

-- EMPLOYEE���̺��� �̸��� �� _�� �� ���ڰ� 3�ڸ��� �̸��� �ּҸ� ���� ����� ���, �̸�, �̸��� �ּ� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___^_%' ESCAPE '^';

-- EMPLOYEE���̺��� �̸� ���� '��'���� ������ ��� �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- EMPLOYEE���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- EMPLOYEE���̺��� �����ּ� _���� 4�����̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰� ������� 90/01/01~00/12/01�̰�, �޿��� 270�� �̻��� ��� ��ü ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____!_%' ESCAPE '!'
      AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') 
      AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
      AND SALARY >= 2700000;
      
-- IS NULL/IS NOT NULL : �÷����� NULL�� ������ / �� ������ �Ǻ�
-- EMPLOYEE���̺��� ���ʽ��� ���� �ʴ� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- EMPLOYEE���̺��� ���ʽ��� �޴� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- EMPLOYEE���̺��� �����ڵ� ���� �μ� ��ġ�� ���� ���� ������ �̸�, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- EMPLOYEE���̺��� �μ� ��ġ�� ���� �ʾ����� ���ʽ��� ���޹��� ������ �̸�, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- IN : ��Ͽ� ��ġ�ϴ� ���� ������ TRUE ��ȯ (OR ��� ���)
-- D6 �μ��� D9�μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE IN ('D6', 'D9');

-- �����ڵ尡 J1, J2, J3, J4�� ������� �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J1', 'J2', 'J3', 'J4');

-- EMPLOYEE���̺��� ���, �̸�, �޿��� �����Ͽ� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- OREDER BY : ������ �� �ۼ��ϴ� ����
-- SELECT������ ���� �������� �ۼ��Ǹ� ��������� ���� ������
-- NULL FIRST / NULL LAST : �÷���/��Ī/�÷����� ���� ���
-- ASC : �������� (��������)
-- DESC : �������� (������ ���)

SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�, BONUS ���ʽ�
FROM EMPLOYEE
ORDER BY SALARY NULLS FIRST;















