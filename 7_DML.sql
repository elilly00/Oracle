-- DML : ������ ���� ���
-- ���̺� �� ����(INSERT) / ���� (UPDATE) / ���� (DELETE)

-- INSERT : ���̺� ������ �߰� (�� ���� ����)
-- INSERT INTO ���̺� ��(�÷���1, �÷���2,...) VALUES(��1, ��2,....)
--INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE,
--                     SAL_LEVEL, SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN)
--VALUES(500, '�ۼ���', '990111-1223344', 'song_ss@kh.or.kr', '01023456789', 'D1', 'J7', 'S3',
--       3000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE,
                     SAL_LEVEL, SALARY, BONUS,  HIRE_DATE, MANAGER_ID, ENT_DATE, ENT_YN)
VALUES(500, '�ۼ���', '990111-1223344', 'song_ss@kh.or.kr', '01023456789', 'D1', 'J7', 'S3',
       3000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL)
VALUES(500, '�ۼ���', '990111-1223344', 'J7', 'S3');
-- ���� INSERT
-- ���� : ���� ������ �÷� ������� ���� ���� ���� �� ���� (�� ���̺��� �÷� ������ ������� �ʾƵ� ��)
--     : ���� ���ϴ� �÷��� �̾Ƽ� ���� ���� �� ����
-- ���� : ���� �� �ʹ� ����

ROLLBACK;

INSERT INTO EMPLOYEE
VALUES(500, '�ۼ���', '990111-1223344', 'song_ss@kh.or.kr', '01023456789', 'D1', 'J7', 'S3',
       3000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
-- INSERT INTO EMPLOYEE
-- VALUES
-- ��� �÷��� �� �߰��Ѵٸ� �÷��� ���� ����
-- ���� :
-- ����:

COMMIT;

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

INSERT INTO EMP_01(
    SELECT EMP_ID,  EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
         LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
);   -- ���� �� ���� ����

-- INSERT ALL : ���� ���� ���̺� �� ���� ����
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0;  -- ���� 1�� 0�� �ƴϱ� ������ ���������� false, �׷��� ������ �� �����Ͱ� ����
-- WHERE���� 1=0�� ��� ��� �࿡�� FALSE�� ���� �ƹ� �൵ ������ ������Ű�� ���ϹǷ� ���� ���Ե��� �ʰ� ���̺� �÷��� ����
-- EX) �ڹ� if�� : if(true) {//������ ������ }
--                if(false) {//������ �ȵ���, ���� �ǹ̰� ����}

SELECT * FROM EMP_DEPT_D1;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_MANAGER;

-- EMP_DEPT_D1���̺� EMPLOYEE���̺� �ִ� �μ��ڵ尡 D1�� ������ ��ȸ�� ���, �̸�, �ҼӺμ�, �Ի��� ����
-- EMP_MANAGER���̺� EMPLOYEE���̺� �ִ� �μ��ڵ尡 D1�� ������ ��ȸ�� ���, �̸�, ������ ��� ����

-- ���� �ֱ�
INSERT INTO EMP_DEPT_D1(
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1'
);

SELECT * FROM EMP_DEPT_D1;

INSERT INTO EMP_MANAGER(
    SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1'
);

SELECT * FROM EMP_MANAGER;

ROLLBACK;

-- �ѹ��� �ֱ�
INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';  -- ���������� �������� ����
    
SELECT * FROM EMP_DEPT_D1;
SELECT * FROM EMP_MANAGER;

-- EMPLOYEE���̺��� ������ �����Ͽ� ���, �̸�,�Ի���, �޿��� ����� �� �ִ� EMP_OLD, EMP_NEW���̺� ����
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- EMPLOYEE���̺��� �Ի��� �������� 2000�� 1�� 1�� ������ �Ի��� ����� EMP_OLD��
-- 2000�� 1�� 1�� ���Ŀ� �Ի��� ����� EMP_NEW�� ���, �̸�, �Ի���, �޿� ����
INSERT INTO EMP_OLD(
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE HIRE_DATE < '2000/01/01'
);

INSERT INTO EMP_NEW(
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE HIRE_DATE >= '2000/01/01'
);
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
 
ROLLBACK;

INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

-- UPDATE : ���̺� ��ϵ� �� ����(�� ���� ��ȭX)
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_COPY���̺��� DEPT_ID�� D9�� ���� DEPT_TITLE�� ������ȹ������ ����
UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��'   -- WHERE���� �������� ������ ��� ���� ������ȹ������ ���� ��
WHERE DEPT_ID = 'D9';   -- �������� �������� ���� �� ��� �࿡ ���� UPDATE ����

ROLLBACK;

CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('����', '�����');

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
              FROM EMP_SALARY
              WHERE EMP_NAME = '�����'),
    BONUS = (SELECT BONUS
             FROM EMP_SALARY
             WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('����', '�����', '���ö', '������', '������', '�ϵ���');

UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                       FROM EMP_SALARY
                       WHERE EMP_NAME = '�����')
WHERE EMP_NAME IN ('���ö', '������', '������', '�ϵ���');

-- EMP_SALARY���̺��� �ƽþ������� �ٹ��ϴ� ������ ���ʽ��� 0.3���� ����
UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                 FROM EMP_SALARY
                      JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                      JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                 WHERE LOCAL_NAME LIKE 'ASIA%');

SELECT EMP_ID, EMP_NAME, SALARY, BONUS, LOCAL_NAME
FROM EMP_SALARY
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

COMMIT;

-- UPDATE�� �������ǿ� ������� �ʰ� �����ؾ� ��
UPDATE DEPARTMENT
SET LOCATION_ID = '77'  
WHERE LOCATION_ID = 'L2';
-- ���Ἲ ��������(KH.SYS_C007508)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
-- �θ� 77�̶� ���� ����

UPDATE EMPLOYEE
SET DEPT_CODE = '66'
WHERE DEPT_CODE = 'D6';

ROLLBACK;

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);

UPDATE EMPLOYEE
SET EMP_NAME = NULL;   
-- ORA-01407: NULL�� ("KH"."EMPLOYEE"."EMP_NAME")�� ������Ʈ�� �� �����ϴ�
-- NOT NULL ���������� �ֱ� ����

-- DELETE : ���̺� �ִ� �� ����(�� ���� �پ��)
COMMIT;

SELECT * FROM EMPLOYEE;

DELETE FROM EMPLOYEE 
WHERE EMP_NAME = '�ۼ���';

DELETE FROM EMPLOYEE;

ROLLBACK;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- ORA-02292: ���Ἲ ��������(KH.SYS_C007667)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
-- FOREIGN KEY�������Ƕ����� �����ǰ� �ִ� ���� ���� �Ұ���

ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT SYS_C007667 CASCADE;  -- �������� ��Ȱ��ȭ

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D1';

ROLLBACK;

ALTER TABLE EMPLOYEE
ENABLE CONSTRAINT SYS_C007667;  -- �������� Ȱ��ȭ

COMMIT;

-- TRUNCATE : ���̺��� ��ü �� ����
-- DELETE���� ����ӵ��� ����, ROLLBACK�� ���� ���� �Ұ���
SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY;













































