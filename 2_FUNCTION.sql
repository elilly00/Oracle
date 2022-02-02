-- �Լ� : �÷��� ���� �о ����� ��� ����
-- ������ �Լ� : �÷��� ��ϵ� n���� ���� �о� n���� ��� ����
-- �׷� �Լ� : �÷��� ��ϵ� n���� ���� �о� 1���� ��� ����
-- ������ �Լ� �׷��Լ��� �Բ� ����� �� �ִ�/����? => ���� : ��� ���� ������ �ٸ��� ����

-- ������ �Լ�
-- 1. ���� ���� �Լ�
-- LENGTH : ���� �� ��ȯ / LENGTHB : ������ ����Ʈ ũ�� ��ȯ
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ') -- B�� BYTE�� �ǹ� (�� ���� �� 3byte�� �ν�)
FROM DUAL;  -- DUAL : ���� ���̺�

SELECT LENGTH(EMAIL), LENGTHB(EMAIL) -- Ư�����ڴ� 1byte�� �ν�
FROM EMPLOYEE;

-- INSTR : �ش� ���ڿ��� ��ġ(�ڹٿ��� 0���� ������, ����Ŭ�� 1���� ��)
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;    -- �ش� ���� ���ڿ��� ��ġ�� ���ٸ� 0 ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- �˻��� �����ϴ� ��ġ (1��° ���ں��� �˻� �����ؼ� �ش� ���� ������ ���ڿ� ��ġ ��ȯ)
SELECT INSTR('AABAACAABBAA', 'B', 7) FROM DUAL; -- 7��° ���ں��� �˻� ����
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;  -- ���������� �˻� ������ �ش� ���� ������ ���ڿ� ��ġ ��ȯ(��ġ�� ���� 1��° ���ں��� ��)
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;  -- 1��° ���ں��� �˻��� �ι�°�� ������ ���� ��ġ ��ȯ

-- EMPLOYEE���̺��� �̸����� @ ��ġ ��ȯ
SELECT INSTR(EMAIL, '@') FROM EMPLOYEE;

-- LPAD / RPAD
-- ������ ���ڸ�ŭ�� ������ �������� ���� ������ ������ ���ڷ� ����/�����ʿ� ä������
SELECT LPAD(EMAIL, 20) FROM EMPLOYEE;    -- ���̸� 20���� ���� �� ��ȯ
SELECT LPAD(EMAIL, 20, '#') FROM EMPLOYEE;  -- ���̸� 20���� ���� �� ���� ������ #�� ä������
SELECT RPAD(EMAIL, 20, '#') FROM EMPLOYEE; 

-- LTRIM : ���ڿ��� ���� ���� ����, ���ʺ��� �ݺ����� ���� ����  
-- RTRIM : ���ڿ��� ������ ���� ����, �����ʺ��� �ݺ����� ���� ����
-- TRIM : ���ڿ��� ���� ���� ����
SELECT LTRIM('   KH') A FROM DUAL;    -- ���� ���� ���� 
SELECT LTRIM('KH   ') A FROM DUAL;  -- ������ ���� ���� X
SELECT LTRIM('   KH', ' ') A FROM DUAL;  -- ������ �� ����� (������ ���� ������ �����Ͽ��� ������ ���ʿ� �ִ� ������ ���� ��)
SELECT LTRIM('0012345', '0') FROM DUAL;
SELECT LTRIM('123123KH', '123') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;   -- KH�� 1,2,3�� �ƴ϶� ���߰� �Ǿ� KH123�� ��� ��
SELECT LTRIM('ACBBAKH', 'ABC') FROM DUAL;   -- 'ABC'-> ���� ���� ���ڴ� A�Ǵ� B�Ǵ� C�̶�� �ǹ� �׷��� KH�� ��� ��
SELECT PHONE, LTRIM(PHONE, '010') FROM EMPLOYEE;

SELECT RTRIM('KH   ') A FROM DUAL;
SELECT RTRIM('123123KH', '123') FROM DUAL;
SELECT EMAIL, RTRIM(EMAIL, '@kh.or.kr') FROM EMPLOYEE;

SELECT TRIM('   KH   ') A FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM('123' FROM '123123KH12') FROM EMPLOYEE; -- ���� ���ڴ� �� �� ����
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- ���ʿ�������
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;  -- �����ʿ�������
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;    -- ���ʿ�������

-- SUBSTR = String.subString()
-- ���ڿ� �Ϻ� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;  -- 7��°���� ������ ��ȯ => THEMOENY
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;  -- 5��°���� 2�� ��ȯ => ME
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL;   -- NULL ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;   -- �Ųٷ� �����ؼ� ó������ ���� �� => THE

-- EMPLOYEE���̺��� �̸�, �̸���, @ ���ĸ� ������ ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) 
FROM EMPLOYEE;

-- �ֹε�Ϲ�ȣ�� �̿��Ͽ� ��/�� �Ǵ��Ͽ� �̸�, ���� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) ����
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ���ڸ� ��ȸ(��� ��, '��')
SELECT EMP_NAME, '��' ����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- EMPLOYEE���̺��� ���ڸ� ��ȸ(��� ��, '��')
SELECT EMP_NAME, '��' ����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

-- EMPLOYEE���̺��� �������� �ֹι�ȣ�� �̿��Ͽ� �����, ����, ����, ���� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 2) ����, SUBSTR(EMP_NO, 3, 2) ����, SUBSTR(EMP_NO, 5, 2) ����
FROM EMPLOYEE;

-- LOWER : ��� �ҹ��ڷ� ��ȯ / UPPER : ��� �빮�ڷ� ��ȯ / INITCAP : ù ���ڸ� �빮�ڷ� ��ȯ
SELECT LOWER('Welcome To My World') LOWER, UPPER('Welcome To My World') UPPER, INITCAP('Welcome To SELECTSELECTMy World') INITCAP FROM DUAL;
SELECT INITCAP('WELCOME TO MY WORLD') FROM DUAL;    

-- CONCAT : ���ڿ� ��ġ��
SELECT CONCAT('�����ٶ�', '���ٻ�') FROM DUAL;
SELECT '�����ٶ�' || '���ٻ�' FROM DUAL;   -- CONCAT ��� ���Ῥ���� ��� (���� ����� ����)

SELECT CONCAT(CONCAT(CONCAT(CONCAT(EMP_NO, ', '), EMP_NAME), ', '), DEPT_CODE)
FROM EMPLOYEE;

-- REPLACE : ��ü
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;
SELECT REPLACE('�ݽſ찭����� G���ǽǿ� �ֽ��ϴ�', '�����', '������') FROM DUAL; -- ���Ⱑ �ȵǾ� �־ �ٲ�

-- EMPLOYEE���̺��� �����, �ֹι�ȣ ��ȸ
-- �ֹι�ȣ�� ������ϸ� ���̰� �ϰ� '-'������ '*'�� ����
SELECT EMP_NAME, REPLACE(EMP_NO, SUBSTR(EMP_NO, 8), '********')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, INSTR(EMP_NO, '-')), LENGTH(EMP_NO), '*')
FROM EMPLOYEE;

--SELECT EMP_NAME, SUBSTR(EMP_NO, 1,)

-- 2. ���� ���� �Լ�
-- ABS : ���� �� ���ϴ� �Լ�
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-- MOD : �������� ������ �� ��ȯ (=��ⷯ)
SELECT MOD(10,3) FROM DUAL;
SELECT MOD(-10,3) FROM DUAL; -- �������� ���� ��ȣ�� ����
SELECT MOD(10,-3) FROM DUAL;

-- ROUND : �ݿø�
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.678) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL; -- �Ҽ��� 0��° �ڸ��������� �ݿø�
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;

-- FLOOR : ���� - ���������� �����ϴ� ��
SELECT FLOOR(123.456) FROM DUAL; -- ������ �ڸ��� ������ �� ����
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC : �Ҽ��� �ڸ��� ����, ������ ��
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;

-- CEIL : �ø�
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

-- 3. ��¥ ���� �Լ�
-- SYSDATE : ���� ��¥
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : ���� ���� ���̸� ���ڷ� ����
-- EMPLOYEE���̺��� ����� �̸�, �Ի���, �ٹ� ���� �� ��ȸ
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(HIRE_DATE, SYSDATE)  -- ������ ���� ����
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE)) -- ABS�� �̿��� ���밪�̳��������� ������ ������ �Ǽ��� ���� �ʵ��� ��
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, CEIL(ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))) || '������' ������  -- �ø��� �̿��� ������ ���
FROM EMPLOYEE;                  -- EX. �п� �����? 2������ (����� �Ѵ� ���� �Ѱ� ������ �ø��Ͽ� 2������ ����)

-- ADD_MONTHS : ��¥�� ���ڸ�ŭ ���� ���� ���Ͽ� ��¥ ����
SELECT ADD_MONTHS(SYSDATE, 2) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL;

-- NEXT_DAY : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥ ����
-- 1= �� / 2=�� / 3=ȭ / 4=�� / 5=�� / 6=�� / 7=��
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '������ �����ݾ�, ��ġ?') FROM DUAL;   -- �� �տ� '��'�� ���⶧���� ������ ��¥�� ���
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�츮�� ���� �ڼ��� �����ּ���') FROM DUAL;  -- �� ���� '��'�̱� ������ ������ ��
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;  -- ���α׷� �� �ѱ۷� �Ǿ��ֱ� ������ ����� �ν� X
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;  -- �� ����� �ٲٱ�(�ѱ��� �ν�X)
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL; 
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY : �ش� ���� ������ ��¥�� ���Ͽ� ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE���̺��� ��� ��, �Ի���-����, ����-�Ի��� ��ȸ
--       ��, ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ϰ� ��� ����ó��(����)
SELECT EMP_NAME, FLOOR(HIRE_DATE-SYSDATE) �ٹ��ϼ�1, FLOOR(SYSDATE-HIRE_DATE) �ٹ��ϼ�2
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;

-- EMPLOYEE���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE (SYSDATE-HIRE_DATE)/365 >= 20;
--WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;

-- EMPLOYEE���̺��� ��� ��, �Ի���, �Ի��� ���� �ٹ� �ϼ� ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

-- EXTRACT : ��, ��, �� ������ �����Ͽ� ����
-- EMPLOYEE���̺��� ����� �̸�, �Ի�⵵, �Ի� ��, �Ի���
SELECT EMP_NAME �̸�, EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵, 
        EXTRACT(MONTH FROM HIRE_DATE) "�Ի� ��", EXTRACT(DAY FROM HIRE_DATE) "�Ի� ��"
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ����� �̸�, �Ի���, �ٹ� ��� ��ȸ
--          ��, �ٹ������ ����⵵ - �Ի�⵵�� ��ȸ
SELECT EMP_NAME, HIRE_DATE, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "�ٹ� ���"
FROM EMPLOYEE;

-- 4. ����ȯ �Լ�
-- TO_CHAR : ��¥/������ �����͸� ������ �����ͷ� ����
-- 9 : ����(���� ������ ǥ�� X) / 0 : ����(���� ������ 0���� ó��) / FM : ���ڿ� ���� ���� / L : ���� ��ȭ ���� 
SELECT TO_CHAR(1234), 1234 AAAA FROM DUAL;   -- ���ڴ� ���� ����/ ���ڴ� ������ ����
SELECT TO_CHAR(1234, '99999') A FROM DUAL;  -- 
SELECT TO_CHAR(1234, '00000') A FROM DUAL;
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;  -- ��� ����
SELECT TO_CHAR(1234, 'FML99999') FROM DUAL; -- 
SELECT TO_CHAR(1234, '$99999') FROM DUAL;
SELECT TO_CHAR(1234, 'FM$99999') FROM DUAL;
SELECT TO_CHAR(1234, '99,999') A FROM DUAL;
SELECT TO_CHAR(1234, 'FM99,999') A FROM DUAL;
SELECT TO_CHAR(1234, '999') A FROM DUAL;
SELECT TO_CHAR(12, '999,999PR') FROM DUAL;

-- EMPLOYEE���̺��� �����, �޿� ǥ��
-- �޿� '\9,000,000'�������� ǥ��
SELECT EMP_NAME, TO_CHAR(SALARY, 'FML9,999,999') �޿�
FROM EMPLOYEE;

SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- ���� �ð� ���
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;   -- ���� ���Ķ� AM���� �ص� PM���� ���
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL;  -- 24�ð����� ���
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;    
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-FMDD DAY') FROM DUAL;  -- FM�� ���̸� 01-> 1�� ��� ��
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" DAY') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

SELECT TO_CHAR(HIRE_DATE, 'MM'), TO_CHAR(HIRE_DATE, 'MONTH'), TO_CHAR(HIRE_DATE, 'MON'), TO_CHAR(HIRE_DATE, 'RM')
FROM EMPLOYEE;

SELECT TO_CHAR(SYSDATE, 'DDD') "1�� ����", 
        TO_CHAR(SYSDATE, 'DD') "�� ����", 
        TO_CHAR(SYSDATE, 'D') "�� ����"
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'Q') �б�,
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- EMPLOYEE���̺��� �̸�, �Ի��� ��ȸ
--          �Ի��� : 0000�� 00�� 00�� (0)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" (DY)') �Ի���
FROM EMPLOYEE;

-- TO_DATE : ����/������ �����͸� ��¥�� �����ͷ� ����
SELECT TO_DATE('20200202', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20200202, 'YYYYMMDD') FROM DUAL;

SELECT TO_CHAR(TO_DATE('190505', 'YYYY"��" MM"��" DD"��"'), 'YYYY"��" MM"��" DD"��"') FROM DUAL;

SELECT TO_CHAR(TO_DATE('20200202 153814', 'YYYYMMDD HH24MISS'), 'YYYY-MM-DD HH:MI:SS') FROM DUAL;   -- ���ڸ� ��¥�� �ٲٰ� �ٽ� ���ڸ� ���� ���ϴ� �������� �ٲ㼭 ���

-- TO_DATE���� �� �ڸ� ������ YY�� �����Ű�� ������ ���� ����(21����, 2000���)�� ����
--                          RR�� �����Ű�� �� �ڸ� �������� 50�̻��� ���� ���� ����(20����, 1900���),
--                                                       50�̸��� ���� ���� ����(21����, 2000���) ����
-- ���ڸ� ��¥�� �ٲ� �� R�� ����ϴ°��� �� ����
SELECT TO_CHAR(TO_DATE('990311', 'YYMMDD'), 'YYYYMMDD')  "99YY",
       TO_CHAR(TO_DATE('070108', 'YYMMDD'), 'YYYYMMDD') "07YY",
       TO_CHAR(TO_DATE('990311', 'RRMMDD'), 'YYYYMMDD') "99RR",
       TO_CHAR(TO_DATE('070108', 'RRMMDD'), 'YYYYMMDD') "07RR"
FROM DUAL;

-- TO_NUMBER : ������ �����͸� ������ �����ͷ� ����
SELECT TO_NUMBER('12345') FROM DUAL;
SELECT 111+222 FROM DUAL;
SELECT '111'+'222' FROM DUAL;   -- ���������� ���ڰ� ������ �˾Ƽ� ���ڷ� �ٲ��ֱ⶧���� ������ ��
SELECT '1,111' + '2,222' FROM DUAL;  -- 
SELECT TO_NUMBER('1,111', '999,999') + TO_NUMBER('2,222', '9,999')
FROM DUAL;

-- 5. NULLó�� �Լ�
--- NVL
SELECT EMP_NAME, BONUS, NVL(BONUS, 0),DEPT_CODE, NVL(DEPT_CODE, '�μ�X')
FROM EMPLOYEE;

-- NVL2 : �ִ°� ���°� ���� �����ϰ� ���� ��
SELECT EMP_NAME, BONUS, NVL2(BONUS,0.7, 0.5)    -- ���ʽ��� ���� �̾��� 0.7�� ������ 0.5�� �ٲ�
FROM EMPLOYEE;

-- NULLIF : �ΰ��� ���ؼ� ���ٰ� �Ҷ��� ����, �ٸ��ٴ� ���ǿ� ���� ������ �� �� ����
SELECT NULLIF(123,123), NULLIF(123,132) FROM DUAL;  -- ù��° ���� ������ NULL, �ι�° ���� �ٸ��� 132�� �ٲ�

-- 6. ���� �Լ�
-- DECODE : DECODE(����/�÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2, ....)
-- ���ϰ����ϴ� ��/�÷��� ���ǽİ� ������ ���ð� ��ȯ
SELECT EMP_ID, EMP_NAME, EMP_NO,
--       SUBSTR(EMP_NO, 8,1) ����  -- ������� ��/���� ������ �ϰ� ������ DECODE �̿�
       DECODE(SUBSTR(EMP_NO, 8,1), 1, '��', 2, '��') ����   -- SUBSTR~�� 1�̸� ����, 2�̸� ����
--       DECODE(SUBSTR(EMP_NO, 8,1), 1, '��', '��') ����      -- 1�̸� ����, 1�� �ƴϸ� ����(��, 1������ ���ڰ� ���� �� ���ڷ� ����)
FROM EMPLOYEE;

-- �����ڵ尡 j7�̸� ������ �޿��� 10% �λ�
-- �����ڵ尡 j6�̸� ������ �޿��� 15% �λ�
-- �����ڵ尡 j5�̸� ������ �޿��� 20% �λ�
-- �� �� ������ �޿��� 5% �λ�
-- ���� ��, ���� �ڵ�, �޿�, �λ� �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY, DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2, SALARY*1.05) �λ�޿� 
FROM EMPLOYEE;

--SELECT EMP_NAME, JOB_CODE, SALARY, SALARY *(1 + DECODE(JOB_CODE, 'J7', SALARY*0.1, 'J6', SALARY*0.15, 'J5', SALARY*0.2, SALARY*0.05) �λ�޿� 
--FROM EMPLOYEE;


-- CASE WHEN
-- CASE WHEN ���ǽ� THEN �����
--      WHEN ���ǽ� THEN �����
--      [ELSE �����]
-- END
-- ���ϰ��� �ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ����� ��ȯ
-- ������ ���� �� ����

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE WHEN SUBSTR(EMP_NO, 8, 1) =1 THEN '����' 
        WHEN SUBSTR(EMP_NO, 8, 1) = 2  THEN '����' 
        END ����
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE WHEN SUBSTR(EMP_NO, 8, 1) =1 THEN '����' 
        ELSE '����' 
        END ����
FROM EMPLOYEE;

-- �����ڵ尡 j7�̸� ������ �޿��� 10% �λ�
-- �����ڵ尡 j6�̸� ������ �޿��� 15% �λ�
-- �����ڵ尡 j5�̸� ������ �޿��� 20% �λ�
-- �� �� ������ �޿��� 5% �λ�
-- ���� ��, ���� �ڵ�, �޿�, �λ� �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY, 
       CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
       WHEN JOB_CODE = 'J6' THEN SALARY*1.15
       WHEN jOB_CODE = 'J5' THEN SALARY*1.2
       ELSE SALARY*1.05
       END "�λ� �޿�"
FROM EMPLOYEE;

SELECT EMP_NAME, JOB_CODE, SALARY, 
       CASE JOB_CODE WHEN 'J7' THEN SALARY*1.1
                     WHEN 'J6' THEN SALARY*1.15
                     WHEN 'J5' THEN SALARY*1.2
                     ELSE SALARY*1.05
       END "�λ� �޿�"
FROM EMPLOYEE;

-- ���, ��� ��, �޿�, ��� ��ȸ
-- ��� ���� : �޿��� 500������ ũ�� 1���, 350������ ũ�� 2���, 200������ ũ�� 3���, �������� 4������� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY,
        CASE WHEN SALARY > 5000000 THEN '1���'
             WHEN SALARY > 3500000 THEN '2���'
             WHEN SALARY > 2000000 THEN '3���'
             ELSE '4���'
        END ���
FROM EMPLOYEE;

-- ���, �����, �޿�
-- �޿��� 500���� �̻��̸� '���'
-- �޿��� 300~500�����̸� '�߱�'
-- �� ���ϴ� '�ʱ�'���� ���ó���ϰ� ��Ī�� '����'���� �Ѵ�.
SELECT EMP_ID, EMP_NAME,
        CASE WHEN SALARY >= 5000000 THEN '���'
             WHEN SALARY >= 3000000 THEN '�߱�'
             ELSE '�ʱ�'
        END ����
FROM EMPLOYEE;

-- �׷� �Լ� : 1���� ���
-- SUM : �հ�

-- EMPLOYEE���̺��� �� ����� �޿� ����
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ���� ����� �޿� ���� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 1;

-- EMPLOYEE���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���Ե� ���� �հ� ��ȸ
SELECT SUM((SALARY + (SALARY * NVL(BONUS, 0)))*12)
FROM  EMPLOYEE
WHERE DEPT_CODE =  'D5';

-- AVG : ���

-- EMPLOYEE���̺��� �� ����� �޿� ���
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE���̺��� �� ����� ���ʽ� ����� �Ҽ��� ��°�ڸ����� �ݿø� ��ȸ
SELECT ROUND(AVG(BONUS), 2)  -- NULL�� ���� ���� ��꿡 ���Կ� �ȵ� -> ��Ȯ�� ����� �ƴ�
FROM EMPLOYEE;  -- 0.22 

SELECT ROUND(AVG(NVL(BONUS, 0)), 2)     -- NULL���� 0���� �ٲٰ� ���Խ�Ų ���
FROM EMPLOYEE;  -- 0.08

SELECT AVG(BONUS), AVG(DISTINCT BONUS), AVG(NVL(BONUS, 0))
FROM EMPLOYEE;

-- MIN : ���� ���� �� / MAX : ���� ū �� -> ����, ����, ��¥ ���� ����

-- EMPLOYEE���̺��� ���� ���� �޿�, ���ĺ� ������ ���� ���� �̸���, ���� ���� �Ի��� ��ȸ
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ���� ���� �޿�, ���ĺ� ������ ���� ���� �̸���, ���� �ֱ� �Ի��� ��ȸ
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- COUNT : ���� ����
-- COUNT(�÷���) : NULL�� ���ܵ� �ش� �÷��� ���� ���� ����
-- COUNT(DISTINCT �ķ���) : �ߺ����ŵ� �� ���� ����
-- COUNT(*) : NULL�� ������ ��ü �� ���� ����

-- ��ü ��� ��, �μ��ڵ尡 �ִ� ��� ��, ������� �����ִ� �μ� ��
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;




