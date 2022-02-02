-- �л��̸��� �ּ��� ǥ��.
-- ��, ��� ����� "�л� �̸�", "�ּ���", �̸����� �������� 
SELECT STUDENT_NAME "�л� �̸�", STUDENT_ADDRESS "�ּ���"
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

-- �������� �л� �̸��� �ֹι�ȣ ���� ���� ������ ���
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

-- 3. �ּ����� ������ OR ��⵵�� �л��� �� 1900��� �й��� ���� �л� �̸�, �й�, �ּ�, �̸����� �������� 
-- ��, ��� ����� "�л��̸�", "�й�", "������ �ּ�"
SELECT STUDENT_NAME "�л� �̸�",  STUDENT_NO "�й�", STUDENT_ADDRESS "������ �ּ�"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '������%' OR STUDENT_ADDRESS LIKE '��⵵%')
      AND STUDENT_NO NOT LIKE 'A%'
ORDER BY STUDENT_NAME;

-- 4. ���� ���а� ���� �� ���� ���̰� ���� ��� ������ ���� �̸�, �ֹι�ȣ ���
-- [����Ŭ ����]
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR P, TB_DEPARTMENT D
WHERE P.DEPARTMENT_NO = D.DEPARTMENT_NO
      AND DEPARTMENT_NAME = '���а�'
ORDER BY PROFESSOR_SSN;

-- [ANSI ǥ�� ����]
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR 
     JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���а�'
ORDER BY PROFESSOR_SSN;

-- 5.2004�� 2�б⿡ 'C311800' ���� ������ �л��� ���� ��ȸ
-- ���� ���� �л� ������ , ������ ������ �й��� ���� �л����� ���
-- [����Ŭ ����]
SELECT STUDENT_NO, POINT
FROM TB_STUDENT, TB_GRADE
ORDER BY POINT





