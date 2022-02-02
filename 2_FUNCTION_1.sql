-- 함수 : 컬럼의 값을 읽어서 계산한 결과를 리턴하는 것
-- 단일행 함수 : 컬럼에 n개의 값을 읽어서 n개의 결과를 리턴 함
-- 그룹 함수 : 컬럼


-- 1. 문자 관련 함수
-- LENGTH : 글자 수 반환
-- LENGTHB : 글자의 바이트 크기 반환
SELECT LENGTH('오라클') FROM DUAL;
SELECT LENGTHB('오라클') FROM DUAL;

SELECT LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : 해당 문자열의 위치 반환
SELECT INSTR('DKFJWOIDSADF', 'W') FROM DUAL;
SELECT INSTR(EMAIL, '@') FROM EMPLOYEE;

-- LPAD / RPAD
-- 제시한 숫자만큼 공간을 만들어 놓고 공간은 임의의 문자에 왼쪽/오른쪽에 채워넣음
SELECT LPA) FROM DUAL;














































