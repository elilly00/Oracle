-- 엄청 많이 쓰임
-- 카페에서 글쓰면 생기는 글번호는 유일하게 행을 구분할 수 있음 -> 작성자가 적으면 중복될 수 있기 때문에 컴퓨터가 알아서 만들어 줘야함
-- 글번호는 시퀀스를 통해 만듦

-- SEQUENCE : 자동 번호 발생기
CREATE SEQUENCE SEQ_EMPID
START WITH 300 -- 시작 숫자
INCREMENT BY 5 -- 증가 숫자
MAXVALUE 310 -- 최대 값
NOCYCLE -- 사이클을 돌지 않음
NOCACHE; -- 메모리 상에서 관리 안함

SELECT * FROM USER_SEQUENCES;

-- 시퀀스명.CURRVAL : 현재 생성된 시퀀스 값 (NEXTVAL에 의해 마지막으로 리턴된 값은 CURRVAL에 저장됨)
--                   혼자서는 존재할 수 없고 NEXTVAL를 먼저 실행 한 후 CURRVAL를 실행 할 수 있음
-- 시퀀스명.NEXTVAL : 시퀀스를 증가시킴 또는 최초로 시퀀스를 실행시킴
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- ORA-08002: 시퀀스 SEQ_EMPID.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다.
-- NEXTVAL에 의해 마지막으로 리턴된 값은 CURRVAL에 저장되기 때문에
-- NEXTVAL를 먼저 실행하지 않고 CURRAVL를 실행해 오류가 발생됨

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 305 (5씩 증가하기 때문)
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 310 
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 310

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- ORA-08004: 시퀀스 SEQ_EMPID.NEXTVAL exceeds MAXVALUE은 사례로 될 수 없습니다
-- NOCYCLE이기 때문

CREATE SEQUENCE SEQ_EID
START WITH 300
NOCYCLE
NOCACHE;

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, '강건강', '111111-1111111', 'kang_kk@kh.or.kr', '01011112222',
        'D2', 'J3', 'S1', 5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
        
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 시퀀스 변경 : ALTER
-- START WITH는 변경 불가능 -> DROP 후 재생성
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
CYCLE
NOCACHE;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- CYCLE을 입력했기 때문에 400이 넘으면 기본값인 1로 돌아감









