-- �Լ� : �÷��� ���� �о ����� ����� �����ϴ� ��
-- ������ �Լ� : �÷��� n���� ���� �о n���� ����� ���� ��
-- �׷� �Լ� : �÷�


-- 1. ���� ���� �Լ�
-- LENGTH : ���� �� ��ȯ
-- LENGTHB : ������ ����Ʈ ũ�� ��ȯ
SELECT LENGTH('����Ŭ') FROM DUAL;
SELECT LENGTHB('����Ŭ') FROM DUAL;

SELECT LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : �ش� ���ڿ��� ��ġ ��ȯ
SELECT INSTR('DKFJWOIDSADF', 'W') FROM DUAL;
SELECT INSTR(EMAIL, '@') FROM EMPLOYEE;

-- LPAD / RPAD
-- ������ ���ڸ�ŭ ������ ����� ���� ������ ������ ���ڿ� ����/�����ʿ� ä������
SELECT LPA) FROM DUAL;














































