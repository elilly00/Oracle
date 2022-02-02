-- DDL : 데이터 정의언어
-- 객체 생성(CREAT)/수정(ALTER)/삭제(DROP)

-- 테이블 생성
-- CREATE TABLE 테이블명 (컬럼명 자료형(크기), ... );
CREATE TABLE MEMBER(MEMBER_ID VARCHAR2(10),
                    MEMBER_PWD VARCHAR2(20),
                    MEMBER_NAME VARCHAR2(30));

COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAMES IS '회원 이름';

SELECT * FROM USER_TABLES;
-- USER_TABLES : 사용자가 작성한 테이블을 확인하는 뷰

SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-- USER_TAB_CLOUMNSP : 컬럼과 관련된 정보

DESC MEMBER;
-- DESC : 테이블 구조

-- 제약 조건(CONSTRAINTS)
-- 테이블 작성 시 각 컬럼에 대해 값 기록에 대한 제약조건 설정 가능
-- 데이터 무결성 보장을 목정으로함
-- 데이터 무결성 : 데이터의 정확성, 일관성, 유효성 보장
-- 제약조건은 테이블을 처음 생성할 때 지정해줘도 되고 만들고 나서 지정해도 됨

DESC USER_CONSTRAINTS;
-- USER_CONSTRAINTS : 사용자가 작성한 제약조건을 확인하는 뷰
SELECT * FROM USER_CONSTRAINTS;

SELECT * FROM USER_CONS_COLUMNS;
-- USER_CONS_COLUMNS : 제약조건이 걸려있는 컬럼을 확인하는 뷰

-- NOT NULL : 컬럼에 반드시 값을 기록하게 하는 제약조건
CREATE TABLE USER_NOCONST(USER_NO NUMBER,
                          USER_ID VARCHAR2(20),
                          USER_PWD VARCHAR2(30),
                          USER_NAME VARCHAR2(30),
                          GENDER VARCHAR2(10),
                          PHONE VARCHAR2(30),
                          EMAIL VARCHAR2(50));

INSERT INTO USER_NOCONST
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_NOCONST
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL);

CREATE TABLE USER_NOTNULL(USER_NO NUMBER NOT NULL,  -- 컬럼레벨에서 NOT NULL 제약조건 넣어줌 (테이블레벨에선 사용 X)
                          USER_ID VARCHAR2(20) NOT NULL,
                          USER_PWD VARCHAR2(30) NOT NULL,
                          USER_NAME VARCHAR2(30) NOT NULL,
                          GENDER VARCHAR2(10),
                          PHONE VARCHAR2(30),
                          EMAIL VARCHAR2(50));

INSERT INTO USER_NOTNULL
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_NOTNULL
VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL); 
-- ORA-01400: NULL을 ("KH"."USER_NOTNULL"."USER_ID") 안에 삽입할 수 없습니다 -> NOT NULL제약조건을 넣었기 때문

INSERT INTO USER_NOTNULL
VALUES (3, 'user03', 'pass03', '도대담', NULL, NULL, NULL);

COMMIT; -- COMMIT을 사용해 데이터베이스를 확정시켰기 때문에 창을 닫을 때 팝업이 뜨지 않게 됨

-- UNIQUE : 컬럼 값이 중복을 제한하는 제약 조건
SELECT * FROM USER_NOCONST;

INSERT INTO USER_NOCONST
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');

CREATE TABLE USER_UNIQUE(USER_NO NUMBER /*UNIQUE*/, -- 제약조건에 대한 설정만 다를 뿐 UNIQUE(USER_NO)와 같음
                          USER_ID VARCHAR2(20) UNIQUE,  -- 컬럼레벨(컬럼 옆에 적는 것)에서의 UNIQUE제약조건 설정
                          USER_PWD VARCHAR2(30),
                          USER_NAME VARCHAR2(30),
                          GENDER VARCHAR2(10),
                          PHONE VARCHAR2(30),
                          EMAIL VARCHAR2(50),
                          UNIQUE(USER_NO));     -- 테이블레벨(테이블 옆에 적는 것)에서의 UNIQUE제약조건 설정
                          -- 각각 컬럼에 유니크가 들어간 

INSERT INTO USER_UNIQUE
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');
-- ORA-00001: 무결성 제약 조건(KH.SYS_C007610)에 위배됩니다  -> 값이 중복 되기 때문에 여러 번 삽입 할 수 없음

INSERT INTO USER_UNIQUE
VALUES(2, 'user02', 'pass02', '남나눔', '남', '010-2222-3333', 'nam123@kh.or.kr');

INSERT INTO USER_UNIQUE
VALUES(3, 'user02', 'pass02', '남나눔', '남', '010-2222-3333', 'nam123@kh.or.kr');
-- ORA-00001: 무결성 제약 조건(KH.SYS_C007610)에 위배됩니다

INSERT INTO USER_UNIQUE
VALUES(2, 'user03', 'pass02', '남나눔', '남', '010-2222-3333', 'nam123@kh.or.kr');
-- ORA-00001: 무결성 제약 조건(KH.SYS_C007611)에 위배됩니다

CREATE TABLE USER_UNIQUE2(USER_NO NUMBER ,
                          USER_ID VARCHAR2(20),
                          USER_PWD VARCHAR2(30),
                          USER_NAME VARCHAR2(30),
                          GENDER VARCHAR2(10),
                          PHONE VARCHAR2(30),
                          EMAIL VARCHAR2(50),
                          UNIQUE(USER_NO, USER_ID));  -- 하나의 묶음으로 들어감

-- 여러 컬럼을 묶어둔 경우 두 컬럼이 모두 중복 됐을 때 오류 발생

INSERT INTO USER_UNIQUE2
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_UNIQUE2
VALUES(1, 'user02', 'pass02', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');
-- USER_NO가 중복 -> 쌍으로 보는 것이기 때문에 전체가 같아야 같다고 봄
-- 그래서 USER_NO가 중복 되더라도 아이디가 다르기 때문에 값이 삽입 됨

INSERT INTO USER_UNIQUE2
VALUES(2, 'user01', 'pass02', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');
-- user01가 중복 -> USER_NO가 다르기 때문에 값이 삽입 됨

INSERT INTO USER_UNIQUE2
VALUES(2, 'user02', 'pass02', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');
-- USER_O2와 user02가 각각 중복 -> 묶음으로 같은 것이 없기 때문에 값이 삽입 됨
--- 같은 것을 또 다시 삽입하려고 하면 무결성 제약 조건에 위배된다고 뜸 (이미 같은 값이 존재하기 때문에)

-- 제약조건 이름만 보고선 위치를 찾기 힘듦 -> 제약 조건 이름을 직접 명시 가능
-- 제약조건 이름 설정
CREATE TABLE CONS_NAME(     -- ? 제약조건 이름이 CN_NN_TD1인 제약조건이 들어가고, 그 제약조건에 NOT NULL일 들어감
    TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_CN_TD1 NOT NULL, -- NN : 어떤 제약 조건인지, CN : 테이블 이름, TD1 : 컬럼 명 (이러한 순으로 이름을 설정하는 것으로 약속?암묵적인 룰? 임 -> 무조건 적이진 않음)
    TEST_DATA2 VARCHAR2(20) CONSTRAINT UQ_CN_TD2 UNIQUE,
    TEST_DATA3 VARCHAR2(20),
    CONSTRAINT UK_CN_TD3 UNIQUE(TEST_DATA3)  -- UNIQUE를 UQ/UK로 표기 함
);

INSERT INTO CONS_NAME VALUES('TEST1', 'TEST2', 'TEST3');

-- PRIMARY KEY : NOT NULL + UNIQUE
-- 데이터의 값이 중복되지 않는 값으로 존재해야 함 : 행을 구분할 수 있는 식별자 역할
-- 한 테이블 당 한 개만 설정 가능 (NOT NULL&UNIQUE는 여러 개 설정 가능)

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
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');
-- ORA-00001: 무결성 제약 조건(KH.PK_UP_UNO)에 위배됩니다
-- UNIQUE 제약 조건을 위배 했을 때의 오류 메세지가 같게 나옴

INSERT INTO USER_PRIMARYKEY
VALUES(NULL, 'user02', 'pass02', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');
-- ORA-01400: NULL을 ("KH"."USER_PRIMARYKEY"."USER_NO") 안에 삽입할 수 없습니다 
-- NOT NULL 제약 조건을 위배 했을 때
-- => PRIMARYKEY는 UNIQUE와 NOT NULL이 결합한 것이기 때문

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
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_PRIMARYKEY2
VALUES(2, 'user01', 'pass02', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');

-- 모두 잘 삽입이 됨
-- => 제약조건을 USER_ID와 USER_NO를 하나로 묶었기 때문에 값이 쌍으로 같아야만 무결성 제약 조건에 위배 됨

-- FOREIGN KEY : 참조된 테이블이 제공하는 값만 사용 가능한 제약조건
-- FOREIGN KEY 제약조건으로 테이블과 테이블 간에 관계 형성(다리 역할)
CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10, '일반회원');
INSERT INTO USER_GRADE VALUES(20, '우수회원');
INSERT INTO USER_GRADE VALUES(30, '특별회원');

CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER CONSTRAINT FK_UF_GC REFERENCES USER_GRADE(GRADE_CODE)   -- USER_GRADE의 GRADE_CODE NUMBER PRIMARY KEY와 연결 됨 (이름은 달라도 됨 -> )
);                                                                            -- 참조한다는 의미의 REFERENCES를 이용해 참조할 테이블명(참조할 커럼)을 명시하면 됨

INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '남나눔', '남', '010-2222-3333', 'nam123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '도대담', '남', '010-3333-4444', 'doh123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '류라라', '여', '010-4444-5555', 'ryu123@kh.or.kr', NULL);

INSERT INTO USER_FOREIGNKEY
VALUES(5, 'user05', 'pass05', '문미미', '여', '010-5555-6666', 'moon123@kh.or.kr', 50);
-- 50은 USER_GRADE테잉블 GRADE_CODE컬럼에서 제공하는 갑이 아니므로 외래키 제약 조건에 위배 됨

COMMIT;

DELETE FROM  USER_GRADE
WHERE GRADE_CODE = 10;
-- ORA-02292: 무결성 제약조건(KH.FK_UF_GC)이 위배되었습니다- 자식 레코드가 발견되었습니다
-- 10을 참조하고 있는 데이터가 존재하기 때문에 삭제 불가능

DELETE FROM  USER_GRADE
WHERE GRADE_CODE = 20; 

SELECT * FROM USER_GRADE;

ROLLBACK;

-- 삭제 옵션 : 부모 테이블에 있는 데이터를 삭제 시 자식 테이블의 데이터는 어떻게 처리할지에대해 설정하는 것
CREATE TABLE USER_GRADE2(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES(10, '일반회원');
INSERT INTO USER_GRADE2 VALUES(20, '우수회원');
INSERT INTO USER_GRADE2 VALUES(30, '특별회원');

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
    -- ON DELETE SET NULL : 부모 키 삭제 시 자식 키를 NULL로 변경하는 옵션
);

INSERT INTO USER_FOREIGNKEY2
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES(2, 'user02', 'pass02', '남나눔', '남', '010-2222-3333', 'nam123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY2
VALUES(3, 'user03', 'pass03', '도대담', '남', '010-3333-4444', 'doh123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY2
VALUES(4, 'user04', 'pass04', '류라라', '여', '010-4444-5555', 'ryu123@kh.or.kr', NULL);

COMMIT;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FOREIGNKEY3;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3 VALUES(10, '일반회원');
INSERT INTO USER_GRADE3 VALUES(20, '우수회원');
INSERT INTO USER_GRADE3 VALUES(30, '특별회원');

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
    -- ON DELETE CASCADE : 부모 키 삭제 시 자식 키도 함께 삭제
);

INSERT INTO USER_FOREIGNKEY3
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES(2, 'user02', 'pass02', '남나눔', '남', '010-2222-3333', 'nam123@kh.or.kr', 10);

INSERT INTO USER_FOREIGNKEY3
VALUES(3, 'user03', 'pass03', '도대담', '남', '010-3333-4444', 'doh123@kh.or.kr', 30);

INSERT INTO USER_FOREIGNKEY3
VALUES(4, 'user04', 'pass04', '류라라', '여', '010-4444-5555', 'ryu123@kh.or.kr', NULL);

COMMIT;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FOREIGNKEY3;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

-- CHECK : 컬럼에 기록되는 값에 조건을 설정하는 제약조건
CREATE TABLE USER_CHECK(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10) CHECK(GENDER IN('남', '여')),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_CHECK
VALUES(1, 'user01', 'pass01', '강건강', '남', '010-1111-2222', 'kang123@kh.or.kr');

INSERT INTO USER_CHECK
VALUES(1, 'user01', 'pass01', '강건강', '남자', '010-1111-2222', 'kang123@kh.or.kr');
-- ORA-02290: 체크 제약조건(KH.SYS_C007636)이 위배되었습니다

CREATE TABLE USER_CHECK2(
    TEST_NUMBER NUMBER,
    CONSTRAINT CK_UC2_TNUM CHECK (TEST_NUMBER > 0)
);
INSERT INTO USER_CHECK2 VALUES(10);
INSERT INTO USER_CHECK2 VALUES(-10);
--ORA-02290: 체크 제약조건(KH.CK_UC2_TNUM)이 위배되었습니다 -> 범위를 벗어났기 때문

CREATE TABLE USER_CHECK3(
    C_NAME VARCHAR2(15 CHAR),  -- 글자 수
    C_PRICE NUMBER,
    C_LEVEL CHAR(1),
    C_DATE DATE,
    CONSTRAINT PK_UC3_NAME PRIMARY KEY(C_NAME),
    CONSTRAINT CH_UC3_PRICE CHECK(C_PRICE >= 1 AND C_PRICE <= 99999)
    CONSTRAINT CH_UC3_LEVEL CHECK(C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
    CONSTRAINT CK_UC3_DATE CHECK(C_DATE >= TO_DATE('2021/09/15', 'YYYY/MM/DD'))
);

-- [실습 문제]
-- 회원가입용 테이블 생성(USER_TEST)
-- 컬럼명 : USER_NO(회원번호)           : NUMBER         - 기본키(PK_UT_USERNO),
--         USER_ID (아이디)            : VARCHAR2(20)   - 중복금지(UQ_UT_USERID),
--         USER_PWD(회원비밀번호)       : VARCHAR2(20)   - NULL값 허용안함(NN_UT_USERPWD),
--         PNO(주민등록번호)            : VARCHAR2(20)   - 중복금지(NN_UT_PNO) 
--         GENDER(성별)                : VARCHAR2(3)
--         PHONE(전화번호)
--         ADDRESS(주소)               : VARCHAR2(100),
--         STATUS(탈퇴여부)             : VARCHAR2(3)   - NOT NULL(NN_UT_STATUS), 'Y' 혹은 'N'으로 입력(CK_UT_STATUS)
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
    CONSTRAINT CK_UT_GENDER CHECK(GENDER IN ('남', '여')),
    CONSTRAINT CK_UT_STATUS CHECK(STATUS IN ('Y', 'N'))
);

-- SUBQUERY를 이용한 테이블 생성
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
    FROM EMPLOYEE
         JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
         JOIN JOB USING(JOB_CODE);

SELECT * FROM EMPLOYEE_COPY2;
-- 컬럼 명, 데이터 타입, 데이터, 제약조건 NOT NULL만 복사 가능

CREATE TABLE USER_GRADE4(
    GRADE_CODE NUMBER,
    GRADE_NAME VARCHAR2(30)
);
-- 제약조건 추가하기
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
ALTER TABLE USER_FOREIGNKEY4 ADD CHECK(GENDER IN ('남', '여'));
ALTER TABLE USER_FOREIGNKEY4 ADD FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE4 /*(GREADE_CODE)*/;
-- 부모테이블에 참조할 컬럼을 생략할 경우, 부모테이블의 기본키를 디폴트로 연결
ALTER TABLE USER_FOREIGNKEY4 MODIFY USER_PWD NOT NULL;

-- [미니 실습]
-- DEPARTMENT테이블의 LOCATION_ID에 외래키 제약조건 추가
-- 참조 테이블은 LOCATION, 참조 컬럼은 LOCATION의 기본키
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE); 
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;






