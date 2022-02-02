-- 1. �������� ���̺�(TB_CLASS_TYPE) �Է�
INSERT INTO TB_CLASS_TYPE VALUES('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('02', '��������'); 
INSERT INTO TB_CLASS_TYPE VALUES('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('04', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES('05', '������');

-- 2. �л��� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺� �����
CREATE TABLE TB_�л��Ϲ�����
AS SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, STUDENT_ADDRESS �ּ�
    FROM TB_STUDENT;

SELECT * FROM TB_�л��Ϲ�����;

-- 3. �����а� �л� ������ ���Ե� �а����� ���̺� ����
CREATE TABLE TB_������а�
AS SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 6)), 'YYYY/DD/MM') ����⵵, PROFESSOR_NAME �����̸�
FROM TB_STUDENT S
     JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
     JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '������а�';

SELECT * FROM TB_������а�;

-- 4. �� �а��� ���� 10%���� (�ݿø� ����� �Ҽ��� �ڸ��� ������ �ʵ���)
UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY*1.1);

SELECT * FROM TB_DEPARTMENT;
-- 5. �й� A413041�� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21"�� ����
UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21'
WHERE STUDENT_NO = 'A413042';

SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';

-- 6. �л����� ���̺��� �ֹι�ȣ ���ڸ� ���� X (EX. 830530-2124663 -> 830530)
UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

SELECT STUDENT_SSN
FROM TB_STUDENT;

-- 7. ���а� ����� �л� 2005�� 1�б� '�Ǻλ�����' ���� 3.5�� ����
UPDATE TB_GRADE
SET POINT = 3.5
WHERE STUDENT_NO = (SELECT STUDENT_NO
                    FROM TB_STUDENT
                         JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                    WHERE STUDENT_NAME = '�����'
                          AND DEPARTMENT_NAME = '���а�')
      AND TERM_NO LIKE '200501'
      AND CLASS_NO = (SELECT CLASS_NO 
                      FROM TB_CLASS
                      WHERE CLASS_NAME = '�Ǻλ�����');            


-- 8. ���� ���̺�(TB_GRADE)���� ���л����� �����׺� ����
DELETE FROM TB_GRADE 
WHERE STUDENT_NO IN (SELECT STUDENT_NO
                     FROM TB_STUDENT
                     WHERE ABSENCE_YN = 'Y');

COMMIT;

