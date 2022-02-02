-- DDL : ������ ���Ǿ��
-- ��ü ����(CREAT)/����(ALTER)/����(DROP)

-- ���̺� ����
-- CREATE TABLE ���̺�� (�÷��� �ڷ���(ũ��), ... );
CREATE TABLE MEMBER(MEMBER_ID VARCHAR2(10),
                    MEMBER_PWD VARCHAR2(20),
                    MEMBER_NAME VARCHAR2(30));

COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�� ���̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAMES IS 'ȸ�� �̸�';

SELECT * FROM USER_TABLES;
-- USER_TABLES : ����ڰ� �ۼ��� ���̺��� Ȯ���ϴ� ��

SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-- USER_TAB_CLOUMNSP : �÷��� ���õ� ����

DESC MEMBER;
-- DESC : ���̺� ����

-- ���� ����(CONSTRAINTS)
-- ���̺� �ۼ� �� �� �÷��� ���� �� ��Ͽ� ���� �������� ���� ����
-- ������ ���Ἲ ������ ����������
-- ������ ���Ἲ : �������� ��Ȯ��, �ϰ���, ��ȿ�� ����
-- ���������� ���̺��� ó�� ������ �� �������൵ �ǰ� ����� ���� �����ص� ��

DESC USER_CONSTRAINTS;
-- USER_CONSTRAINTS : ����ڰ� �ۼ��� ���������� Ȯ���ϴ� ��
SELECT * FROM USER_CONSTRAINTS;

SELECT * FROM USER_CONS_COLUMNS;
-- USER_CONS_COLUMNS : ���������� �ɷ��ִ� �÷��� Ȯ���ϴ� ��

-- NOT NULL : �÷��� �ݵ�� ���� ����ϰ� �ϴ� ��������
CREATE TABLE USER_NOCONST(USER_NO NUMBER,
                          USER_ID VARCHAR2(20),
                          USER_PWD VARCHAR2(30),
                          USER_NAME VARCHAR2(30),
                          GENDER VARCHAR2(10),
                          PHONE VARCHAR2(30),
                          EMAIL VARCHAR2(50));

INSERT INTO USER_NOCONST
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_NOCONST
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL);

CREATE TABLE USER_NOTNULL(USER_NO NUMBER NOT NULL,  -- �÷��������� NOT NULL �������� �־��� (���̺������� ��� X)
                          USER_ID VARCHAR2(20) NOT NULL,
                          USER_PWD VARCHAR2(30) NOT NULL,
                          USER_NAME VARCHAR2(30) NOT NULL,
                          GENDER VARCHAR2(10),
                          PHONE VARCHAR2(30),
                          EMAIL VARCHAR2(50));

INSERT INTO USER_NOTNULL
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL); 
-- ORA-01400: NULL�� ("KH"."USER_NOTNULL"."USER_ID") �ȿ� ������ �� �����ϴ� -> NOT NULL���������� �־��� ����

INSERT INTO USER_NOTNULL
VALUES (3, 'user03', 'pass03', '�����', NULL, NULL, NULL);

COMMIT; -- COMMIT�� ����� �����ͺ��̽��� Ȯ�����ױ� ������ â�� ���� �� �˾��� ���� �ʰ� ��

-- UNIQUE : �÷� ���� �ߺ��� �����ϴ� ���� ����
SELECT * FROM USER_NOCONST;

INSERT INTO USER_NOCONST
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

CREATE TABLE USER_UNIQUE(USER_NO NUMBER /*UNIQUE*/, -- �������ǿ� ���� ������ �ٸ� �� UNIQUE(USER_NO)�� ����
                          USER_ID VARCHAR2(20) UNIQUE,  -- �÷�����(�÷� ���� ���� ��)������ UNIQUE�������� ����
                          USER_PWD VARCHAR2(30),
                          USER_NAME VARCHAR2(30),
                          GENDER VARCHAR2(10),
                          PHONE VARCHAR2(30),
                          EMAIL VARCHAR2(50),
                          UNIQUE(USER_NO));     -- ���̺���(���̺� ���� ���� ��)������ UNIQUE�������� ����
                          -- ���� �÷��� ����ũ�� �� 

INSERT INTO USER_UNIQUE
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');
-- ORA-00001: ���Ἲ ���� ����(KH.SYS_C007610)�� ����˴ϴ�  -> ���� �ߺ� �Ǳ� ������ ���� �� ���� �� �� ����

INSERT INTO USER_UNIQUE
VALUES(2, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr');

INSERT INTO USER_UNIQUE
VALUES(3, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr');
-- ORA-00001: ���Ἲ ���� ����(KH.SYS_C007610)�� ����˴ϴ�

INSERT INTO USER_UNIQUE
VALUES(2, 'user03', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr');
-- ORA-00001: ���Ἲ ���� ����(KH.SYS_C007611)�� ����˴ϴ�

CREATE TABLE USER_UNIQUE2(USER_NO NUMBER ,
                          USER_ID VARCHAR2(20),
                          USER_PWD VARCHAR2(30),
                          USER_NAME VARCHAR2(30),
                          GENDER VARCHAR2(10),
                          PHONE VARCHAR2(30),
                          EMAIL VARCHAR2(50),
                          UNIQUE(USER_NO, USER_ID));  -- �ϳ��� �������� ��

-- ���� �÷��� ����� ��� �� �÷��� ��� �ߺ� ���� �� ���� �߻�

INSERT INTO USER_UNIQUE2
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_UNIQUE2
VALUES(1, 'user02', 'pass02', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');
-- USER_NO�� �ߺ� -> ������ ���� ���̱� ������ ��ü�� ���ƾ� ���ٰ� ��
-- �׷��� USER_NO�� �ߺ� �Ǵ��� ���̵� �ٸ��� ������ ���� ���� ��

INSERT INTO USER_UNIQUE2
VALUES(2, 'user01', 'pass02', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');
-- user01�� �ߺ� -> USER_NO�� �ٸ��� ������ ���� ���� ��

INSERT INTO USER_UNIQUE2
VALUES(2, 'user02', 'pass02', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');
-- USER_O2�� user02�� ���� �ߺ� -> �������� ���� ���� ���� ������ ���� ���� ��
--- ���� ���� �� �ٽ� �����Ϸ��� �ϸ� ���Ἲ ���� ���ǿ� ����ȴٰ� �� (�̹� ���� ���� �����ϱ� ������)

-- �������� �̸��� ���� ��ġ�� ã�� ���� -> ���� ���� �̸��� ���� ��� ����
-- �������� �̸� ����
CREATE TABLE CONS_NAME(     -- ? �������� �̸��� CN_NN_TD1�� ���������� ����, �� �������ǿ� NOT NULL�� ��
    TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_CN_TD1 NOT NULL, -- NN : � ���� ��������, CN : ���̺� �̸�, TD1 : �÷� �� (�̷��� ������ �̸��� �����ϴ� ������ ���?�Ϲ����� ��? �� -> ������ ������ ����)
    TEST_DATA2 VARCHAR2(20) CONSTRAINT UQ_CN_TD2 UNIQUE,
    TEST_DATA3 VARCHAR2(20),
    CONSTRAINT UK_CN_TD3 UNIQUE(TEST_DATA3)  -- UNIQUE�� UQ/UK�� ǥ�� ��
);

INSERT INTO CONS_NAME VALUES('TEST1', 'TEST2', 'TEST3');

-- PRIMARY KEY : NOT NULL + UNIQUE
-- �������� ���� �ߺ����� �ʴ� ������ �����ؾ� �� : ���� ������ �� �ִ� �ĺ��� ����
-- �� ���̺� �� �� ���� ���� ���� (NOT NULL&UNIQUE�� ���� �� ���� ����)

CREATE TABLE USER_PRIMARYKEY(
    USER_NO NUMBER CONSTRAINT PK_UP_UNO PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');
-- ORA-00001: ���Ἲ ���� ����(KH.PK_UP_UNO)�� ����˴ϴ�
-- UNIQUE ���� ������ ���� ���� ���� ���� �޼����� ���� ����

INSERT INTO USER_PRIMARYKEY
VALUES(NULL, 'user02', 'pass02', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');
-- ORA-01400: NULL�� ("KH"."USER_PRIMARYKEY"."USER_NO") �ȿ� ������ �� �����ϴ� 
-- NOT NULL ���� ������ ���� ���� ��
-- => PRIMARYKEY�� UNIQUE�� NOT NULL�� ������ ���̱� ����

CREATE TABLE USER_PRIMARYKEY2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    CONSTRAINT PK_UP2_UNO_UID PRIMARY KEY(USER_NO, USER_ID)
);

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(2, 'user01', 'pass02', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

-- ��� �� ������ ��
-- => ���������� USER_ID�� USER_NO�� �ϳ��� ������ ������ ���� ������ ���ƾ߸� ���Ἲ ���� ���ǿ� ���� ��

-- FOREIGN KEY : ������ ���̺��� �����ϴ� ���� ��� ������ ��������
-- FOREIGN KEY ������������ ���̺�� ���̺� ���� ���� ����(�ٸ� ����)
CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE VALUES(30, 'Ư��ȸ��');

CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER CONSTRAINT FK_UF_GC REFERENCES USER_GRADE(GRADE_CODE)   -- USER_GRADE�� GRADE_CODE NUMBER PRIMARY KEY�� ���� �� (�̸��� �޶� �� -> )
);                                                                            -- �����Ѵٴ� �ǹ��� REFERENCES�� �̿��� ������ ���̺��(������ Ŀ��)�� ����ϸ� ��

INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '�����', '��', '010-3333-4444', 'doh123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '�����', '��', '010-4444-5555', 'ryu123@kh.or.kr', NULL);

INSERT INTO USER_FOREIGNKEY
VALUES(5, 'user05', 'pass05', '���̹�', '��', '010-5555-6666', 'moon123@kh.or.kr', 50);
-- 50�� USER_GRADE���׺� GRADE_CODE�÷����� �����ϴ� ���� �ƴϹǷ� �ܷ�Ű ���� ���ǿ� ���� ��

COMMIT;

DELETE FROM  USER_GRADE
WHERE GRADE_CODE = 10;
-- ORA-02292: ���Ἲ ��������(KH.FK_UF_GC)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
-- 10�� �����ϰ� �ִ� �����Ͱ� �����ϱ� ������ ���� �Ұ���

DELETE FROM  USER_GRADE
WHERE GRADE_CODE = 20; 

SELECT * FROM USER_GRADE;

ROLLBACK;

-- ���� �ɼ� : �θ� ���̺� �ִ� �����͸� ���� �� �ڽ� ���̺��� �����ʹ� ��� ó������������ �����ϴ� ��
CREATE TABLE USER_GRADE2(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE2 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE2 VALUES(30, 'Ư��ȸ��');

CREATE TABLE USER_FOREIGNKEY2(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_UF2_GC FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
    -- ON DELETE SET NULL : �θ� Ű ���� �� �ڽ� Ű�� NULL�� �����ϴ� �ɼ�
);

INSERT INTO USER_FOREIGNKEY2
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES(2, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES(3, 'user03', 'pass03', '�����', '��', '010-3333-4444', 'doh123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY2
VALUES(4, 'user04', 'pass04', '�����', '��', '010-4444-5555', 'ryu123@kh.or.kr', NULL);

COMMIT;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FOREIGNKEY3;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3 VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE3 VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE3 VALUES(30, 'Ư��ȸ��');

CREATE TABLE USER_FOREIGNKEY3(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_UF3_GC FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
    -- ON DELETE CASCADE : �θ� Ű ���� �� �ڽ� Ű�� �Բ� ����
);

INSERT INTO USER_FOREIGNKEY3
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES(2, 'user02', 'pass02', '������', '��', '010-2222-3333', 'nam123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES(3, 'user03', 'pass03', '�����', '��', '010-3333-4444', 'doh123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY3
VALUES(4, 'user04', 'pass04', '�����', '��', '010-4444-5555', 'ryu123@kh.or.kr', NULL);

COMMIT;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FOREIGNKEY3;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

-- CHECK : �÷��� ��ϵǴ� ���� ������ �����ϴ� ��������
CREATE TABLE USER_CHECK(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10) CHECK(GENDER IN('��', '��')),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_CHECK
VALUES(1, 'user01', 'pass01', '���ǰ�', '��', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_CHECK
VALUES(1, 'user01', 'pass01', '���ǰ�', '����', '010-1111-2222', 'kang123@kh.or.kr');
-- ORA-02290: üũ ��������(KH.SYS_C007636)�� ����Ǿ����ϴ�

CREATE TABLE USER_CHECK2(
    TEST_NUMBER NUMBER,
    CONSTRAINT CK_UC2_TNUM CHECK (TEST_NUMBER > 0)
);
INSERT INTO USER_CHECK2 VALUES(10);
INSERT INTO USER_CHECK2 VALUES(-10);
--ORA-02290: üũ ��������(KH.CK_UC2_TNUM)�� ����Ǿ����ϴ� -> ������ ����� ����

CREATE TABLE USER_CHECK3(
    C_NAME VARCHAR2(15 CHAR),  -- ���� ��
    C_PRICE NUMBER,
    C_LEVEL CHAR(1),
    C_DATE DATE,
    CONSTRAINT PK_UC3_NAME PRIMARY KEY(C_NAME),
    CONSTRAINT CH_UC3_PRICE CHECK(C_PRICE >= 1 AND C_PRICE <= 99999)
    CONSTRAINT CH_UC3_LEVEL CHECK(C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
    CONSTRAINT CK_UC3_DATE CHECK(C_DATE >= TO_DATE('2021/09/15', 'YYYY/MM/DD'))
);

-- [�ǽ� ����]
-- ȸ�����Կ� ���̺� ����(USER_TEST)
-- �÷��� : USER_NO(ȸ����ȣ)           : NUMBER         - �⺻Ű(PK_UT_USERNO),
--         USER_ID (���̵�)            : VARCHAR2(20)   - �ߺ�����(UQ_UT_USERID),
--         USER_PWD(ȸ����й�ȣ)       : VARCHAR2(20)   - NULL�� ������(NN_UT_USERPWD),
--         PNO(�ֹε�Ϲ�ȣ)            : VARCHAR2(20)   - �ߺ�����(NN_UT_PNO) 
--         GENDER(����)                : VARCHAR2(3)
--         PHONE(��ȭ��ȣ)
--         ADDRESS(�ּ�)               : VARCHAR2(100),
--         STATUS(Ż�𿩺�)             : VARCHAR2(3)   - NOT NULL(NN_UT_STATUS), 'Y' Ȥ�� 'N'���� �Է�(CK_UT_STATUS)
CREATE TABLE USER_TEST(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) CONSTRAINT NN_UT_USERPWD NOT NULL,
    PNO VARCHAR2(20) CONSTRAINT NN_UT_PNO NOT NULL,
    GENDER VARCHAR2(3),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(100),
    STATUS VARCHAR2(3) CONSTRAINT NN_UN_STATUS NOT NULL,
    CONSTRAINT PK_UT_USERNO PRIMARY KEY(USER_NO),
    CONSTRAINT UQ_UT_USERID UNIQUE(USER_ID),
    CONSTRAINT UQ_UT_PNO UNIQUE, 
    CONSTRAINT CK_UT_GENDER CHECK(GENDER IN ('��', '��')),
    CONSTRAINT CK_UT_STATUS CHECK(STATUS IN ('Y', 'N'))
);

-- SUBQUERY�� �̿��� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
    FROM EMPLOYEE
         JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
         JOIN JOB USING(JOB_CODE);

SELECT * FROM EMPLOYEE_COPY2;
-- �÷� ��, ������ Ÿ��, ������, �������� NOT NULL�� ���� ����

CREATE TABLE USER_GRADE4(
    GRADE_CODE NUMBER,
    GRADE_NAME VARCHAR2(30)
);
-- �������� �߰��ϱ�
ALTER TABLE USER_GRADE4 ADD CONSTRAINT PK_UG4_GC PRIMARY KEY(GRADE_CODE);

CREATE TABLE USER_FOREIGNKEY4(
    USER_NO NUMBER, -- PRIMARY KEY
    USER_ID VARCHAR2(20),  -- UNIQUE
    USER_PWD VARCHAR2(30),   -- NOT NULL
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),   -- CHECK
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER   -- FOREIGN KEY
);

ALTER TABLE USER_FOREIGNKEY4 ADD PRIMARY KEY(USER_NO);
ALTER TABLE USER_FOREIGNKEY4 ADD UNIQUE(USER_ID);
ALTER TABLE USER_FOREIGNKEY4 ADD CHECK(GENDER IN ('��', '��'));
ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4 /*(GREADE_CODE)*/;
-- �θ����̺� ������ �÷��� ������ ���, �θ����̺��� �⺻Ű�� ����Ʈ�� ����
ALTER TABLE USER_FOREIGNKEY4 MODIFY USER_PWD NOT NULL;

-- [�̴� �ǽ�]
-- DEPARTMENT���̺��� LOCATION_ID�� �ܷ�Ű �������� �߰�
-- ���� ���̺��� LOCATION, ���� �÷��� LOCATION�� �⺻Ű
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE); 
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;






