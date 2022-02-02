-- �ǹ����� ���̺��� �並 �� ���� ������ ��(Ȥ���� �ȿ� �ִ� �����͸� �����ϰ� �Ǿ� �����Ͱ� ���󰡰ų� ����Ǵ� ���� �����ϱ� ���� �並 �ǳ��� ����)

-- VIEW(��) : SELECT ����� ȭ�鿡 ������ ������ ���� ���̺� (��ü)
-- �������� �����͸� ���� ���� ������ ���̺�� �����ϰ� ��� ����

-- (��ü : ���̺�, USER, VIEW)

-- VIEW������
-- CREATE [OR REPLACE] VIEW ���̸� AS ��������

-- ���, �̸�, �μ���, �ٹ������� ��ȸ ����� V_EMPLOYEE �信 �����ϱ�
CREATE OR REPLACE VIEW V_EMPLOYEE
AS 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)  -- OUTER JOIN(�ܺ�����)
     LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
     LEFT JOIN NATIONAL USING (NATIONAL_CODE);
-- ORA-01031: ������ ������մϴ� 
-- 01031. 00000 -  "insufficient privileges"
-- ���� �������� VIEW�� �����ϱ� ���� ������ ���� ������ ���� ����
-- --> ������ �ο��ϱ� ���� SYSTEM����(�����ڰ���)�� ����

-- 1) SYSTEM ���� ����
-- 2) KH������ �� ���� ���� �ο�
GRANT CREATE VIEW TO KH;
-- 3) KH�������� ���ư� VIEW ����

SELECT * FROM V_EMPLOYEE;

UPDATE EMPLOYEE
SET EMP_NAME = '���߾�'
WHERE EMP_ID = 205;

SELECT * FROM EMPLOYEE WHERE EMP_ID = 205;
SELECT * FROM V_EMPLOYEE WHERE EMP_ID = 205;
-- �� ���̺�� �䰡 ���� �Ǿ� �ֱ� ������ ����� ����

ROLLBACK;

-- ���, �̸�, ����, ����(��/��), �ٹ������ V_EMP_JOB �� ����
-- �������� SELECT���� �Լ��� ���� ��� �ݵ�� ��Ī ����
-- ORA-00998: �� ���� ���� ����� �Բ� �����ؾ� �մϴ�
-- 00998. 00000 -  "must name this expression with a column alias"
CREATE OR REPLACE VIEW V_EMP_JOB (���, "��� ��", "���� ��", ����, �ٹ����)
AS
SELECT EMP_ID , EMP_NAME , JOB_NAME , 
       DECODE(SUBSTR(EMP_NO, 8, 1) , 1, '��', '��') ,  
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
FROM EMPLOYEE
     JOIN JOB USING (JOB_CODE);

SELECT * FROM  V_EMP_JOB;

CREATE OR REPLACE VIEW V_JOB
AS
SELECT JOB_CODE, JOB_NAME
FROM JOB;

SELECT * FROM V_JOB;
SELECT * FROM JOB;

INSERT INTO V_JOB VALUES('J8', '����');
UPDATE V_JOB SET JOB_NAME = '�˹�' WHERE JOB_CODE = 'J8';
DELETE V_JOB WHERE JOB_CODE = 'J8';

SELECT * FROM USER_VIEWS;
-- ����� ���� �� Ȯ�� ������ ��ųʸ�
-- ���� ���̺��� ���� �����Ͱ� �� ���� �ƴ϶� �� ���̺�� ����Ǿ� ���� ������ ���常 ������ ���������� �� ���̺���� ���� ��Ŵ

-- DML��ɾ�� ������ �Ұ����� ���
-- 1. �� ���ǿ� ���Ե��� ���� �÷� ����
CREATE OR REPLACE VIEW V_JOB2
AS
SELECT JOB_CODE FROM JOB;

SELECT * FROM V_JOB2;

INSERT INTO V_JOB2 VALUES ('J8', '����');  
-- SQL ����: ORA-00913: ���� ���� �ʹ� �����ϴ�
-- V_JOB2�� ������ �÷��� ������ 1�������� 2���� �÷��� �ְ��� �ϱ� ������ ���� �߻�
UPDATE V_JOB2 SET JOB_NAME = '����' WHERE JOB_CODE = 'J7';   
-- SQL ����: ORA-00904: "JOB_NAME": �������� �ĺ���
-- JOB_NAME�� �ִ� ���¿��� ���� ����
DELETE FROM V_JOB2 WHERE JOB_NAME = '���';   
-- SQL ����: ORA-00904: "JOB_NAME": �������� �ĺ���

-- 2. �信 ���Ե��� ���� �÷� �� NOT NULL���������� ������ ���
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME FROM JOB;

INSERT INTO V_JOB3 VALUES ('����');   -- ORA-01400: NULL�� ("KH"."JOB"."JOB_CODE") �ȿ� ������ �� �����ϴ�
                                      -- JOB_CODE�� NOT NULL ���������� �ɷ��ֱ� ����
UPDATE V_JOB3 SET JOB_CODE = NULL WHERE JOB_NAME = '���';  -- SQL ����: ORA-00904: "JOB_CODE": �������� �ĺ���

-- 3. ���ǥ�������� ���ǵ� ���
CREATE OR REPLACE VIEW EMP_SAL
AS
SELECT EMP_ID, EMP_NAME, SALARY, (SALARY + (SALARY*NVL(BONUS, 0)))*12 ����
FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL VALUES (600, '���ǰ�', 3000000, 36000000);  
-- SQL ����: ORA-01733: ���� ���� ����� �� �����ϴ�
-- ������ SALARY�� BONUS�� �̿��ؼ� ����� �ؾ��ϴµ� ���� ���� �־��� ������ �ν� �� �� ���� ���� �߻�
UPDATE EMP_SAL SET ���� = 80 WHERE EMP_ID = 200;  
-- SQL ����: ORA-01733: ���� ���� ����� �� �����ϴ�

-- �Լ��� ����� �÷��� INSERT, UPDATE�� �� �� ���� 

-- 4.�׷��Լ�/GROUP BY ���Ե� ���
-- V_GROUPDEPT�信 �μ��ڵ�, �μ� �� �޿� �հ�, �μ� �� �޿� ��� ����
CREATE OR REPLACE VIEW V_GROUPDEPT
AS 
SELECT DEPT_CODE, SUM(SALARY) �հ�, AVG(SALARY) ���
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT VALUES ('D10', 600, 400);  
-- SQL ����: ORA-01733: ���� ���� ����� �� �����ϴ�
-- SALARY�� �հ�, ������� ���� ���� �ƴ� 600,400 �̶�� ������ ���� �־��� ������ ���� �߻�
UPDATE V_GROUPDEPT SET DEPT_CODE = 'D10' WHERE DEPT_CODE = 'D3';  
-- SQL ����: ORA-01732: �信 ���� ������ ������ �������մϴ�
-- SUM�� AVG�� ����� �ٲ�� ����
DELETE FROM V_GROUPDEPT WHERE DEPT_CODE = 'D1';  
-- SQL ����: ORA-01732: �信 ���� ������ ������ �������մϴ�

-- 5. DISTINCT(�ߺ�����)�� ������ ���
CREATE OR REPLACE VIEW V_DT_EMP
AS
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT * FROM V_DT_EMP;

INSERT INTO V_DT_EMP VALUES ('J9');  
-- SQL ����: ORA-01732: �信 ���� ������ ������ �������մϴ�
UPDATE V_DT_EMP SET JOB_CODE = 'J9' WHERE JOB_CODE = 'J7';
-- SQL ����: ORA-01732: �信 ���� ������ ������ �������մϴ�
DELETE FROM V_DT_EMP WHERE JOB_CODE = 'J1';
--SQL ����: ORA-01732: �信 ���� ������ ������ �������մϴ�

-- 6. JOIN�� �̿��� ���� ���̺��� ������ ���
-- V_JOINEMP �信 ���, �̸�, �μ� �� ����
CREATE OR REPLACE VIEW V_JOINEMP
AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM V_JOINEMP;

INSERT INTO V_JOINEMP VALUES(700, '���ǰ�', '�ѹ���');  
-- SQL ����: ORA-01776: ���� �信 ���Ͽ� �ϳ� �̻��� �⺻ ���̺��� ������ �� �����ϴ�.

-- VIEW �ɼ�
-- CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���̸� [(ASLIA[, ALIAS]...)]
-- AS subquery
-- [WITH CHECK OPTION]
-- [WITH READ ONLY];

-- OR REPLACE : ������ ������ �� �̸��� �����ϴ� ��� �����, �������� ������ ���� ����
-- FORCE/NOFORCE
--      FORCE : ���������� ���� ���̺��� �������� �ʾƵ� �� ����
--      NOFORCE : ���������� ���� ���̺��� �����ؾ߸� �� ����(�⺻ ��)
-- WITH CHECK OPTION : �ɼ��� ������ �÷� ���� �Ұ���
-- WITH READ ONLY : ��ȸ�� �����ϰ� ����

--[CREATE]
CREATE OR REPLACE VIEW V_EMP1
AS
SELECT EMP_NO, EMP_NAME
FROM EMPLOYEE;

SELECT * FROM V_EMP1;

CREATE OR REPLACE VIEW V_EMP1
AS
SELECT EMP_NO, EMP_NAME, SALARY
FROM EMPLOYEE;

CREATE VIEW V_EMP1
AS
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;
-- ORA-00955: ������ ��ü�� �̸��� ����ϰ� �ֽ��ϴ�.
-- OR REPLACE�� ������� �ʾұ� ������ ����� �Ұ���

-- ��� ���� ���̺��� ������ ����ϴ� ���� �ƴ� ���̺��� ���� ��Ų ��� ���� ���鼭 ����ϴ� ���̱� ������ 
-- ���̺�� �޸� ������ ����Ǵ� ��찡 ���� OR REPLACE�� �����ϸ� ������� 

-- [FORCE / NOFORCE]
CREATE OR REPLACE /*NOFORCE*/VIEW V_EMP2   -- �⺻������ NOFORCE ����
AS
SELECT TCODE, TNAME, TCONTENT
FROM TT;

CREATE OR REPLACE FORCE VIEW V_EMP2 
AS
SELECT TCODE, TNAME, TCONTENT
FROM TT;
-- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.
-- ���� ���̺��� ��������� �ʾ����� ���� ���� �����ؾ� �� �� ���

-- [WITH CHECK OPTION]
CREATE OR REPLACE VIEW V_EMP3
AS
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'
WITH CHECK OPTION;

SELECT * FROM V_EMP3;

UPDATE V_EMP3
SET DEPT_CODE = 'D1'
WHERE EMP_ID = 200;
-- ORA-01402: ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�
-- WITH CHECK OPTION�� ���ǿ� DEPT_CODE�� �� �ֱ� ������ DEPT_CODE�� ���� �� �� ����

UPDATE V_EMP3
SET EMP_NAME = '������'
WHERE EMP_ID = 200;

ROLLBACK;

INSERT INTO V_EMP3
VALUES(999,'���ǰ�', '111111-1111111', 'kang_kk@kh.or.kr', '01011112222', 'D1', 'J3', 'S3',
        3000000, 0.2, 200, SYSDATE, NULL, 'N');
-- ORA-01402: ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�
-- WITH CHECK OPTION�� ���ǿ� ����ִ� EMP_CODE�� 'D9'�� �־��� ����

INSERT INTO V_EMP3
VALUES(999,'���ǰ�', '111111-1111111', 'kang_kk@kh.or.kr', '01011112222', 'D9', 'J3', 'S3',
        3000000, 0.2, 200, SYSDATE, NULL, 'N');

ROLLBACK;

-- [WITH READ ONLY]
CREATE OR REPLACE VIEW V_DEPT
AS
SELECT * FROM DEPARTMENT
WITH READ ONLY;

INSERT INTO V_DEPT
VALUES('D10', '�ؿܿ�����', 'L1');
-- SQL ����: ORA-42399: �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.

UPDATE V_DEPT
SET LOCATION_ID = 'L2'
WHERE DEPT_ID = 'D1';
-- SQL ����: ORA-42399: �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.

DELETE FROM V_DEPT;
-- SQL ����: ORA-42399: �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.
-- WITH READ ONLY�� ��ȸ�� ����

COMMIT;



















