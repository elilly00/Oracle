-- PL/SQL
-- �����       DECLARE         ����, ��� ����
-- �����       BEGIN           ���� ���
-- ����ó����    EXCEPTION       ���� �߻� �� �ذ� ���� ���

/*
    // ���� ���� ���� �ٷ� ����  -> DECLARE �ʿ� X
    System.outprinln(10);
    
    // ���� ���� �� ���� -> DECLARE �ʿ� 
    int a = 10;
    System.out.prinln(a);
*/

SET SERVEROUTPUT ON;
-- ����� ȭ�鿡 �����ֵ��� �ϴ� ����

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/   
-- END ������ /�� �� �־�� �� (������ �����ٴ� ���� ���� �ϴ� ����)
/*
    int empId;
    String empName;
    
    final int PI = 3.14;
    
    empId = 800;
    empName = "������";
    
    System.out.println("empId : " + empId);
    System.out.println("empName : " + empName);
*/

DECLARE  -- ����� ����
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
    PI CONSTANT NUMBER := 3.14;     -- := ���Կ�����
BEGIN
    EMP_ID := 800;
    EMP_NAME := '������';
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    -- || : ���Ῥ����
END;
/

DECLARE
--  EMP_ID NUMBER;
    EMP_ID EMPLOYEE.EMP_ID%TYPE;    -- EMPLOYEE�� �ִ� EMP_ID�� Ÿ���� ���󰡰ڴ�(���۷��� ����)
--  EMP_NAME VARCHAR2(30);
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;    -- EMPLOYEE�� �ִ� EMP_NAME�� Ÿ���� ���󰡰ڴ�(���۷��� ����)
    -- ���� ������ ����� �̸��� ���� ���� �� ��
BEGIN
    SELECT EMP_ID, EMP_NAME     -- EMPLOYEE���̺� �ִ� �÷� �� (���� EMP_ID, EMP_NAME�� �ٸ�)
    INTO EMP_ID, EMP_NAME   --SELECT���� ������ �� EMP_ID, EMP_NAME�� EMP_ID, EMP_NAME�� ����
    FROM EMPLOYEE
--  WHERE EMP_ID = 200; 
--  WHERE EMP_ID = '&EMP_ID';   
    WHERE EMP_ID = '&���';
    -- & : ��ü ���� �Է� (�� �Է�) -> ����� �ѱ��̵� �ƹ� ���� ����
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

-- ���۷��� ������ EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY�� �����ϰ�
-- EMPLOYEE���̺��� ���, �̸�, �����ڵ�, �μ��ڵ�, �޿��� ��ȸ �� ������ ���۷��� ������ ��� ���
-- ��, �Է� ���� �̸��� ��ġ�ϴ� ������ ���� ��ȸ
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY   -- SELECT�� INTO�� ������ ���缭 �������(�̸��� ���Ƶ� ������ �ٸ��� �� ������� ���� ���� ��)
    FROM EMPLOYEE
    WHERE EMP_NAME = '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
END;
/

DECLARE 
    E EMPLOYEE%ROWTYPE;
    -- %ROWTYPE : �࿡ ���� ��������, ũ��, �Ӽ� ����(�� ������ ��)
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
--    DBMS_OUTPUT.PUT_LINE('E : ' || E);  -- ORA-06550: �� 10, ��26:PLS-00306: '||' ȣ�� �� �μ��� ������ ������ �߸��Ǿ����ϴ�
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
END;
/

-- IF ~ THEN ~END IF (���� IF��)
-- EMP_ID�� �Է¹޾� ���, �̸�,  �޿�, ���ʽ��� ���
-- ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�' ���
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS  EMPLOYEE.BONUS%TYPE;
BEGIN
--  SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0) -- NULL�� ���� 0���� ���
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    INTO EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID  = '&���';  
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
--  DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS);
    
--  IF(BONUS = 0)
    IF(BONUS IS NULL)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�');
    END IF;
    DBMS_OUTPUT.PUT_LINE('BONUS : ' || BONUS * 100 || '%');
END;
/

-- IF~THEN~ELSE~END IF(IF ~ ELSE��)
-- EMP_ID�� �Է¹޾� �ش� ����� ���, �̸�, �μ���, �Ҽ� ���
-- TEAM������ ����� �Ҽ��� KO�� ������, �ƴϸ� �ؿ������� ����
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NATIONAL_CODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&���';
    
    IF(NATIONAL_CODE = 'KO')
        THEN TEAM := '������';
    ELSE 
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/

-- ����ڿ��� ����� �޾ƿ� �� ����� ��ü ������ VEMP�� ����
-- VEMP�� �̿��Ͽ� ���� ���(���ʽ��� ���� ��� ���ʽ� �����Ͽ� ���)
-- ���� ��� ���� YSALARY�� ����
-- �޿� �̸� ����(\1,000,000) ���� ���