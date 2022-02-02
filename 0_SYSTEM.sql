-- 한 줄 주석
/*
여러 줄
주석
*/

-- 관리자 계정 : 데이터베이스의 생성과 관리를 담당하는 슈퍼 유저 계정
--              오브젝트 생성, 변경, 삭제 등의 작업 가능
--              데이터베이스에 대한 모든 권한 및 책임을 가짐
-- 사용자 계정 : 데이터베이스에 대한 질의(Query), 갱신, 보고서 작성 등 작업을 수행할 수 있는 계정
--             일반 계정은 보안을 위해 업무에 필요한 최소한의 권한만 가지는 것을 원칙으로 함

-- 11g 버전 생성 방식
-- CREATE USER KH IDENTIFIED BY KH;  -- 계정 생성 쿼리
-- 생성    계정       비밀번호 지정
--           계정이름          비밀번호
-- 앞으로 계정이름과 비밀번호는 동일하게 KH로 할거임

-- 12c버전부턴 생성하는 방식이 달라짐 (계정이름 앞에 c##을 붙임 -> 대문자 C 사용 가능)
-- CREATE USER c##KH IDENTIFIED BY KH; (무조건 세미콜론 붙여줘야함)

-- C##을 붙이는 일이 번거롭기 때문에 이전 버전처럼 안 붙이고도 계정 생성할 수 있는 세션 설정하기
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER KH IDENTIFIED BY KH;  
-- ERROR : ORA-01045: user EMP lacks CREATE SESSION privilege; logon denied
-- 원인 : 권한을 부여하지 않았기 때문에 아무것도 할 수 없는 껍데기만 만들어져 놓은 상태
-- 해결 방법 : 권한을 부여하는 쿼리를 작성함
GRANT CONNECT, RESOURCE TO KH; -- 권한 부여하는 쿼리  -- GRANT : 권한을 부여하는 쿼리

-- 쿼리 = DB에서 사용하는 명령문

-- Data Dictionary(DD), 데이터 사전
-- 데이터베이스의 데이터를 제외한 DB 전반에 대한 모든 정보 제공
-- System(관리자)이 DD에 대한 내용을 변경할 수 있는 권한을 가지고 있고
-- 사용자 계정은 단순 조회만 가능(읽기 전용 형태로 제공됨)

-- 테이블 : 행(row)과 열(colunm)로 구성되는 가장 기본적인 데이터베이스 객체
--         데이터베이스 내에서 모든 데이터는 테이블을 통해 저장 됨        
-- 인덱스 : 검색 연산을 최적화하기 위해 데이터베이스 상에 행들의 정보를 구성하는 데이터 구조
--         인덱스를 이용하면 전체 데이터를 검색하지 않고 데이터베이스에서 원하는 정보를 빠르게 검색 가
-- (원하는 정보를 빠르게 가져오는 객체(인덱스 없이 충분히 빠르게 가져오기 때문에 굳이 수업에선 다루지 않음 -> 하지만 면접에서 물어볼 수 있기 때문에 따로 공부하기))

-- KH에서 '테이블스페이스 'SYSTEM'에 대한 권한이 없습니다.'가 뜸
-- 테이블스페이스의 저장 공간이 얼마만큼의 영역을 할당 할것인지에 대해 정해주지 않았기 때문에 뜸
-- 얼마큼의 공간을 만들어서 얼만큼의 테이블을 저장할 것인지에 대해 설정하지 않았음
-- 테이블스페이스 : 테이블이 저장되는 공간

-- 용량 설정
alter user KH default tablespace system quota unlimited on system;
-- KH 안에 있는 System라고하는 tablesapce의 범위(용량)를 제한하지 않고 만들겠다.
-- java에선 대소문자를 확실하게 구분해야 하지만 
-- DB에선 대소문자를 가리지지않는다. 단, 비밀번호, 리터럴 값은 대소문자를 가림

CREATE USER SCOTT IDENTIFIED BY SCOTT;
GRANT RESOURCE, CONNECT TO SCOTT;

alter user SCOTT default tablespace system quota unlimited on system;

CREATE USER CHOON IDENTIFIED BY CHOON;
GRANT RESOURCE, CONNECT TO CHOON;

ALTER USER CHOON DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;