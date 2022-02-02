-- 1. 70��� ��(1970 ~ 1979)�� �����̸鼭 ������ ����� �̸��� �ֹι�ȣ, �μ� ��, ���� ��ȸ
-- [ORACLE ����]

-- [ANSI ǥ�� ����]
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING (JOB_CODE)
WHERE (SUBSTR(EMP_NO, 1, 2) BETWEEN '70' AND '79')
      AND SUBSTR(EMP_NO, 8, 1) = 2
      AND EMP_NAME LIKE '��%';