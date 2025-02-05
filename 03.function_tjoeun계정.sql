/*
    <함수 FUNCTION>
    전달된 컬럼값을 읽어들여 함수를 실행한 결과를 반환
    
    - 단일행 함수: n개의 값을 읽어들여 n개의 결과값 반환(매 행마다 함수 실행)
    - 그룹 함수: n개의 값을 읽어들여 1개의 결과값 반환(그룹별로 함수 실행)
    
    >> SELECT절에 단일행 함수와 그룹함수를 함께 사용할 수 없음
    
    >> 함수식을 기술할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, HAVING절
*/

---------------------------단일행 함수------------------------------------
--======================================================================
--                          <문자 처리 함수>
--======================================================================
/*
    LENGTH / LENGTHB => NUMBER로 반환
    
    LENGTH(컬럼|'문자열'): 해당 문자열의 글자수를 반환
    LENGTHB(컬럼|'문자열'): 해당 문자열의 byte를 반환
        - 한글: XE버전일때 => 1글자당 3byte(ㄱ, ㅏ 등도 1글자에 해당)
                EE버전일때 => 1글자당 2byte
        - 그외: 1글자당 1byte
*/

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;
-------------------------------------------------------------------------
/*
    INSTR: 문자열로부터 특정 문자의 시작위치(INDEX)를 찾아서 반환(반환형: NUMBER)
        -ORACLE은 INDEX번호는 1번부터 시작, 찾는 문자가 없을때 0반환
        
    INSTR(컬럼|'문자열', '찾고자하는 문자',[찾을위치의 시작값, [순번]])
        -찾을 위치값
        1: 앞에서부터 찾기(기본값)
        -1: 뒤에서부터 찾기
*/

SELECT INSTR('JAVASCRIPTJAVAORACLE', 'A') FROM DUAL;
SELECT INSTR('JAVASCRIPTJAVAORACLE', 'A', 1) FROM DUAL;
SELECT INSTR('JAVASCRIPTJAVAORACLE', 'A', 3) FROM DUAL;
SELECT INSTR('JAVASCRIPTJAVAORACLE', 'A', -1) FROM DUAL;
SELECT INSTR('JAVASCRIPTJAVAORACLE', 'A', 1, 3) FROM DUAL;
SELECT INSTR('JAVASCRIPTJAVAORACLE', 'A', -1, 2) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_') "_위치", INSTR(EMAIL, '@') "@위치"
FROM EMPLOYEE;
-------------------------------------------------------------------------
/*
    SUBSTR: 문자열에서 특정 문자열을 추출하여 반환(반환형: CHARACTER)
    
    SUBSTR('문자열', POSITON, [LENGTH])
    -POSITION: 문자열을 추출할 시작위치 INDEX
    -LENGTH: 추출할 문자의 갯수(생략시 맨 마지막까지 추출)
*/

SELECT SUBSTR('ORACLEHTMLCSS', 7) FROM DUAL;
SELECT SUBSTR('ORACLEHTMLCSS', 7, 4) FROM DUAL;
SELECT SUBSTR('ORACLEHTMLCSS', 1, 6) FROM DUAL;
SELECT SUBSTR('ORACLEHTMLCSS', -3) FROM DUAL;

-- EMPLOYEE 테이블에서 주민번호에서 성별만 추출하여 사원명, 주민번호, 성별을 조회
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) AS 성별
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 주민번호에서 성별만 추출하여 여성 사원만 사원명, 주민번호, 성별을 조회
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) AS 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8, 1) = 2 OR SUBSTR(EMP_NO,8, 1) = 4;

-- EMPLOYEE 테이블에서 주민번호에서 성별만 추출하여 남성 사원만 사원명, 주민번호, 성별을 조회
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) AS 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8, 1) = 1 OR SUBSTR(EMP_NO,8, 1) = 3;

-- EMPLOYEE 테이블에서 EMAIL에서 아이디만 추출하여 사원명, 이메일, 아이디를 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS 아이디
FROM EMPLOYEE;
-------------------------------------------------------------------------
/*
    LPAD / RPAD: 문자열을 조회할때 통일감있게 자리수에 맞춰서 조회하고자 할때(반환형: CHARACTER)
    
    LPAD / RPAD('문자열', 최종적으로 반환할 문자의 길이, [덧붙이고자하는 문자])
    문자열에 덧붙이고자하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 n길이 만큼의 문자열 반환
*/
SELECT *
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 25)
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 25, '-')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 25, '-')
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 주민번호를 123456-1****** 형식 사번, 사원명, 주민번호(형식에 맞춰) 조회
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') AS 주민번호
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO, 1, 8)||'******' AS 주민번호
FROM EMPLOYEE;
-------------------------------------------------------------------------
/*
    LTRIM / RTRIM: 문자열에서 특정 문자를 제거한 나머지 반환(반환형: CHARACTER)
    TRIM: 문자열의 앞/뒤 양쪽에 있는 특정 문자를 제거한 나머지 반환
    
    [표현법]
    LTRIM / RTRIM('문자열', [제거하고자하는 문자])
    TRIM([LEADING|TRAILING|BOTH] 제거하고자하는 문자들 FROM '문자열')
        => 제거하고자하는 문자 1개만 가능
*/

SELECT LTRIM('     TJOEUN     ')|| '더조은' FROM DUAL; --제거할 문자를 안넣으면 공백 제거
SELECT RTRIM('     TJOEUN     ')|| '더조은' FROM DUAL;

SELECT LTRIM('JAVAJAVASCRIPTJSPJAVA', 'JAVA') FROM DUAL;
SELECT LTRIM('BAABCABFDSIA', 'ABC') FROM DUAL;
SELECT LTRIM('1284715DXAXC8482', '0123456789') FROM DUAL;

SELECT TRIM('     TJOEUN     ')||'더조은' FROM DUAL;

SELECT TRIM(LEADING 'A' FROM 'AAAIOIOIAAOAIIIAAA') FROM DUAL;
SELECT TRIM(TRAILING 'A' FROM 'AAKJKJKAJKKAJKJAA') FROM DUAL;
SELECT TRIM(BOTH 'A' FROM 'AADDFDFEECCACVVAVAA') FROM DUAL;
SELECT TRIM('A' FROM 'AAACCDDFGGACCSSAAA') FROM DUAL; -- BOTH 기본값 생략가능
-------------------------------------------------------------------------
/*
    LOWER / UPPER / INITCAP: 문자열을 모두 대문자로 혹은 소문자로, 첫글자만 대문자로 변환(반환형: CHARACTER)
    
    [표현법]
    LOWER / UPPER / INITCAP(문자열)
*/

SELECT LOWER('JAVA LETS go') FROM DUAL;
SELECT UPPER('java LETS go') FROM DUAL;
SELECT INITCAP('java LETS go') FROM DUAL;
-------------------------------------------------------------------------
/*
    CONCAT: 문자열 2개를 전달받아 하나로 합친 문자 반환
    
    [표현법]
    CONCAT('문자열', '문자열')
*/

SELECT CONCAT('JAVA', '자바') FROM DUAL;
SELECT 'JAVA'||'자바' FROM DUAL;

-- SELECT CONCAT('JAVA', '자바', '안니용') FROM DUAL; -- 문자열 2개만 가능
SELECT 'JAVA'||'자바'||'안니용' FROM DUAL;
-------------------------------------------------------------------------
/*
    REPLACE: 기존문자열을 새로운 문자열로 바꿈
    
    [표현법]
    REPLACE('문자열', '기존문자열', '바꿀문자열')
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'tjoeun.or.kr', 'naver.com') AS 네이버
FROM EMPLOYEE;
-------------------------------------------------------------------------
/*
    ABS: 숫자의 절대값을 구해주는 함수
    
    [표현법]
    ABS(NUMBER)
*/

SELECT ABS (25) FROM DUAL;
SELECT ABS (-25) FROM DUAL;
SELECT ABS(5 - 12) FROM DUAL;

-------------------------------------------------------------------------
/*
    MOD: 두 수를 나눈 나머지값을 반환해주는 함수
    
    [표현법]
    MOD(NUMBER, NUMBER)
*/

SELECT MOD(10, 3) FROM DUAL;
-------------------------------------------------------------------------
/*
    ROUND: 반올림한 결과를 반환해주는 함수
    
    [표현법]
    ROUND(NUMBER, [위치])
*/

SELECT ROUND(1234.567) FROM DUAL; -- 위치 생략시 0
SELECT ROUND(12.345) FROM DUAL;
SELECT ROUND(1234.56789, 2) FROM DUAL;
SELECT ROUND(12.34, 4) FROM DUAL;
SELECT ROUND(1234.5678, -2) FROM DUAL;
SELECT ROUND(1734.5678, -3) FROM DUAL;
-------------------------------------------------------------------------
/*
    CEIL: 무조건 올림
    
    [표현법]
    CEIL(NUMBER)
*/

SELECT CEIL(123.45) FROM DUAL;
SELECT CEIL(-123.45) FROM DUAL;
-------------------------------------------------------------------------
/*
    FLOOR: 무조건 내림
    
    [표현법]
    FLOOR(NUMBER)
*/

SELECT FLOOR(123.45) FROM DUAL;
SELECT FLOOR(-123.45) FROM DUAL;
-------------------------------------------------------------------------
/*
    TRUNC: 위치 지정 가능한 버림처리 함수
    
    [표현법]
    TRUNC(NUMBER, [위치])
*/
SELECT TRUNC(123.789) FROM DUAL;
SELECT TRUNC(123.789, 1) FROM DUAL;
SELECT TRUNC(123.789, -1) FROM DUAL;
SELECT TRUNC(123.789, -2) FROM DUAL;
--==========================================================================
--                              <날짜 처리 함수>
--==========================================================================
/*
    SYSDATE: 시스템 날짜 및 시간 반환
*/
SELECT SYSDATE FROM DUAL;
-----------------------------------------------------------------------
/*
    MONTHS_BETWEEN(DATE1, DATE2): 두 날짜 사이에
*/

-- EMPLOYEE에서 오늘날짜까지 근무 일수(소수점까지 나옴)
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE에서 오늘날짜까지 근무 일수(정수)
SELECT EMP_NAME, HIRE_DATE, CEIL(SYSDATE - HIRE_DATE) AS 근무일수
FROM EMPLOYEE;

-- EMPLOYEE에서 오늘날짜까지 근무 개월수(소수점까지 나옴)
SELECT EMP_NAME, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) AS 근무개월수
FROM EMPLOYEE;

-- EMPLOYEE에서 오늘날짜까지 근무 개월수(정수)
SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))||'개월차' AS 근무개월수
FROM EMPLOYEE;
-----------------------------------------------------------------------
/*
    ADD_MONTHS(DATE, NUMBER): 특정 날짜에 해당 숫자만큼의 개월수를 더해 그 날짜를 반환
*/
SELECT ADD_MONTHS(SYSDATE, 1) FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 입사일, 정직원이 된 날짜(입사일에서 6개월후) 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;
-----------------------------------------------------------------------
/*
    NEXT_DAY(DATE, 요일(문자|숫자)): 특정 날짜 이후에 가까운 해당 요일의 날짜를 반환해주는 함수
*/
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;

-- 1: 일요일
SELECT SYSDATE, NEXT_DAY(SYSDATE, 2) FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL; -- 오류 현재 언어가 KOREA이기 때문

-- 언어 변경
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
-----------------------------------------------------------------------
/*
    LAST_DAY(DATE): 해당 월의 마지막 날짜를 반환해주는 함수
*/

SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 입사일, 입사한 달의 마지막 날짜 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;
-----------------------------------------------------------------------
/*
    EXTRACT: 특정날짜로부터 년|월|일 값을 추출하여 반환해주는 함수(반환형: NUMBER)
    
    EXTRACT(YEAR FROM DATE): 년도만 추출
    EXTRACT(MONTH FROM DATE): 월만 추출
    EXTRACT(DAY FROM DATE): 일만 추출
*/
SELECT * FROM EMPLOYEE;
-- EMPLOYEE 테이블에서 사원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME,
EXTRACT(YEAR FROM HIRE_DATE),
EXTRACT(MONTH FROM HIRE_DATE),
EXTRACT(DAY FROM HIRE_DATE)
FROM EMPLOYEE;

-- ORDER 2, 3, 4; BY
--==========================================================================
--                              <형변환 함수>
--==========================================================================
/*
    TO_CHAR: 숫자나 날짜를 문자 타입으로 변환시켜주는 함수
    
    TO_CHAR(숫자|날짜,[포맷])
*/
------------------------숫자 타입 = > 문자 타입
/*
    9: 해당 자리의 숫자를 의미한다.
        -값이 없을 경우 소수점 이상은 공백, 소수점 이하는 0으로 표시
    0: 해당 자리의 숫자를 의미한다.
        -값이 없을 경우 0으로 표시하며, 숫자의 길이를 고정적으로 표시할때 주로 사용
    FM: 해당자리에 값이 없을 경우 자리차지하지 않음
*/
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '999999') FROM DUAL; --6칸 공간 확보, 왼쪽 정렬 빈칸은 공백
SELECT TO_CHAR(1234, '000000') FROM DUAL; --6칸 공간 확보, 왼쪽 정렬 빈칸은 0으로 채움
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;

SELECT TO_CHAR(1234123, 'L999,999,999') FROM DUAL; -- 3자리마다 콤마(,)

-- EMPLOYEE 테이블에서 사원명, 급여(￦11,111,111), 연봉(￦111,111,111)
SELECT EMP_NAME, TO_CHAR(SALARY, 'L99,999,999') AS 급여, TO_CHAR(SALARY*12, 'L999,999,999') AS 연봉
FROM EMPLOYEE;

SELECT TO_CHAR(123.456, 'FM999990.999')
    , TO_CHAR(1234.56, 'FM9990.99')
    , TO_CHAR(0.1000, 'FM9999.999')
    , TO_CHAR(0.1000, 'FM9990.999')
FROM DUAL;

SELECT TO_CHAR(123.456, '999990.999')
    , TO_CHAR(1234.56, '9990.99')
    , TO_CHAR(0.1000, '9999.999')
    , TO_CHAR(0.1000, '9990.999')
FROM DUAL;
-------------------------------날짜 타입 => 문자 타입
--시간
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- 12시간제 형식
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 24시간제 형식

--날짜
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DL') FROM DUAL;

-- EMPLOYEE 테이블에서 입사일(25-03-20)
SELECT TO_CHAR(HIRE_DATE, 'YY-MM-DD')
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 입사일(2024년 3월 20일 화요일)
SELECT TO_CHAR(HIRE_DATE, 'DL')
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 입사일(25년 03월 20일)
SELECT TO_CHAR(HIRE_DATE, 'YY"년" MM"월" DD"일')
FROM EMPLOYEE;

--년도
/*
    yy 는 무조건 앞에 '20'이 붙는다
    rr 는 50년을 기준으로 50보다 작으면 앞에 '20'붙이고, 50보다 크면 '19'를 붙인다
*/
SELECT TO_CHAR(SYSDATE, 'YYYY')
        , TO_CHAR(SYSDATE, 'YY')
        , TO_CHAR(SYSDATE, 'RRRR')
        , TO_CHAR(SYSDATE, 'RR')
FROM DUAL;

-- 월
SELECT TO_CHAR(SYSDATE, 'MM')
        , TO_CHAR(SYSDATE, 'MON')       -- 영문일때 3글자만
        , TO_CHAR(SYSDATE, 'MONTH')     -- 영문일때는 다출력
        , TO_CHAR(SYSDATE, 'RM')            -- 로마자로
FROM DUAL;

-- 일
SELECT TO_CHAR(SYSDATE, 'DDD')      -- 년을 기준으로 몇일째
        , TO_CHAR(SYSDATE, 'DD')       -- 월을 기준으로 몇일째
        , TO_CHAR(SYSDATE, 'D')         -- 주를 기준으로 몇일째
FROM DUAL;

-- 요일
SELECT TO_CHAR(SYSDATE, 'DAY')      
        , TO_CHAR(SYSDATE, 'DY')     
FROM DUAL;
-----------------------------------------------------------------------
/*
    TO_DATE: 숫자 또는 문자 타입을 날짜 타입으로 변환
    
    TO_DATE(숫자|A문자, [포맷])
*/

SELECT TO_DATE(20241230) FROM DUAL;
SELECT TO_DATE(241230) FROM DUAL;

-- SELECT TO_DATE(050101) FROM DUAL; -- 앞이 0일때 오류
SELECT TO_DATE('050101') FROM DUAL; -- 앞이 0일때는 문자형태로 넣어줘야 한다

-- SELECT TO_DATE('070204 142530', 'YYMMDD HHMISS') FROM DUAL; -- 오류 12시간제로 출력 14시는 없음
-- SELECT TO_DATE('070204 142530', 'YYMMDD HH24MISS') FROM DUAL; -- 변환후 사용

SELECT TO_CHAR(TO_DATE('070204 022530', 'YYMMDD HHMISS'), 'YY-MM-DD HH:MI:SS') FROM DUAL;

SELECT TO_DATE('040325', 'YYMMDD')FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD')FROM DUAL; -- 현재 세기로 반영

SELECT TO_DATE('040325', 'RRMMDD')FROM DUAL;
SELECT TO_DATE('980630', 'RRMMDD')FROM DUAL; -- 50미만일 경우 현제세기, 50이상이면 이전 세기 반영
-------------------------------------------------------------------
/*
    TO_NUMBER: 문자타입을 숫자타입으로 변환
    
    TO_NUMBER(문자,[포맷])
*/
SELECT TO_NUMBER('012341234') FROM DUAL;
SELECT '1000000' + '5000000' FROM DUAL; -- 오라클은 자동 형변환됨
-- SELECT '1,000,000' + '5,000,000' FROM DUAL;         -- 오류 :  특수문자가 포함되어 문자임. 자동형변환 안됨 
SELECT TO_NUMBER('1,000,000', '9,999,999') + TO_NUMBER('5,000,000', '9,999,999') FROM DUAL;
--====================================================================
--                      <NULL 처리 함수>
--====================================================================
/*
    NVL(컬럼, 해당컬럼이 NULL일경우 반환할 값)
*/

SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 전 사원의 이름, 보너스포함 연봉
SELECT EMP_NAME, SALARY*(1+BONUS)*12
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY*(1+NVL(BONUS, 0))*12
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY*NVL(1+BONUS, 1)*12
FROM EMPLOYEE;

-- 사원명, 부서코드(부서가 없으면 '부서없음)
SELECT EMP_NAME, NVL(DEPT_CODE, '부서없음')
FROM EMPLOYEE;
-------------------------------------------------------------------
/*
    NVL2(컬럼, 반환값1, 반환값2)
    - 컬럼에 값이 존재하면 반환값1
    - 컬럼에 값이 존재하지 않으면 반환값2
*/

-- 사원명, 부서(부서에 속해있으면 '부서있음', 부서가 없으면 '부서없음')
SELECT EMP_NAME, NVL2(DEPT_CODE, '부서있음', '부서없음')
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원명, 급여, 보너스, 성과급(보너스를 받는 사람은 30%를 주고, 보너스를 못받는 사람은 10%)
SELECT EMP_NAME, SALARY, BONUS, NVL2(BONUS, SALARY*0.3, SALARY*0.1)
FROM EMPLOYEE;
------------------------------- 종합 문제 ----------------------------------
SELECT * FROM EMPLOYEE;
-- 1. EMPLOYEE테이블에서 사원 명과 직원의 주민번호를 이용하여 생년, 생월, 생일 조회
SELECT SUBSTR(EMP_NO, 1, 2) AS 생년,
    SUBSTR(EMP_NO, 3, 2) AS 생월,
    SUBSTR(EMP_NO, 5, 2) AS 생일
FROM EMPLOYEE;
-- 2. EMPLOYEE테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 바꾸기)
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8) || '******'
FROM EMPLOYEE;
-- 3. EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
--   (단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)
SELECT EMP_NAME, FLOOR(ABS(HIRE_DATE - SYSDATE)) AS 근무일수1, FLOOR(ABS(SYSDATE - HIRE_DATE)) AS 근무일수2
FROM EMPLOYEE;
-- 4. EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) =1;
-- 5. EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) /12) >= 20;
-- 6. EMPLOYEE 테이블에서 사원명, 급여 조회 (단, 급여는 '\9,000,000' 형식으로 표시)
SELECT EMP_NAME, TO_CHAR(SALARY, 'L9,999,999') AS 급여
FROM EMPLOYEE;
-- 7. EMPLOYEE테이블에서 직원 명, 부서코드, 생년월일, 나이 조회
--   (단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며 
--   나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산)
SELECT EMP_NAME, DEPT_CODE,
SUBSTR(EMP_NO, 1, 2) || '년' ||
SUBSTR(EMP_NO, 3, 2) || '월' ||
SUBSTR(EMP_NO, 5, 2) || '일' AS 생년월일,
TO_CHAR(SYSDATE, 'YYYY') -
(CASE WHEN TO_NUMBER(SUBSTR(EMP_NO, 1, 2)) <= TO_NUMBER(TO_CHAR(SYSDATE, 'YY')) 
    THEN 2000 + TO_NUMBER(SUBSTR(EMP_NO, 1, 2)) 
    ELSE 1900 + TO_NUMBER(SUBSTR(EMP_NO, 1, 2)) 
    END) AS 나이
FROM EMPLOYEE;
-- 8. EMPLOYEE테이블에서 부서코드가 D5, D6, D9인 사원만 조회하되 D5면 총무부
--   , D6면 기획부, D9면 영업부로 처리(EMP_ID, EMP_NAME, DEPT_CODE, 총무부)
--    (단, 부서코드 오름차순으로 정렬)
SELECT EMP_ID, EMP_NAME, DEPT_CODE,
CASE WHEN DEPT_CODE = 'D5' THEN '총무부'
    WHEN DEPT_CODE = 'D6' THEN '기획부'
    WHEN DEPT_CODE = 'D9' THEN '영업부'
        END AS 부서
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
ORDER BY DEPT_CODE;
-- 9. EMPLOYEE테이블에서 사번이 201번인 사원명, 주민번호 앞자리, 주민번호 뒷자리, 
--    주민번호 앞자리와 뒷자리의 합 조회
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 6) AS "주민번호 앞자리", SUBSTR(EMP_NO, 8, 16) AS "주민번호 뒷자리",
SUBSTR(EMP_NO, 1, 6) + SUBSTR(EMP_NO, 8, 16) AS 합
FROM EMPLOYEE
WHERE EMP_ID = 201;
-- 10. EMPLOYEE테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 합 조회
SELECT SALARY*NVL(1+BONUS, 1)*12
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
-- 11. EMPLOYEE테이블에서 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
--      전체 직원 수, 2001년, 2002년, 2003년, 2004년
SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS 입사년도, COUNT(*) AS 입사인원
FROM EMPLOYEE
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY 입사년도;
---------------------------------------------------------------------------------------------------------
/*
    * NULLIF(비교대상1, 비교대상2)
      - 두개의 값이 일치하면 NULL반환
      - 두개의 값이 일치하지 않으면 비교대상1의 값 반환
*/
SELECT NULLIF('123','123') FROM DUAL;
SELECT NULLIF('123','345') FROM DUAL;
--====================================================================
--                      <선택 함수>
--====================================================================
/*
    DECODE(비교하고자하는 대상(컬럼|산술연산|함수식), 비교값1, 결과값1, 비교값2, 결과값2 ...)
    
    switch(비교대상) {
        case 비교값1:
         결과값1;
         break;
        case 비교값2:
         결과값2;
    }
*/

-- 사번, 사원명, 주민번호, 성별(남, 여)
SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여', '3', '남', '4', '여') AS 성별
FROM EMPLOYEE;

-- 사원명, 직급코드, 기존급여, 인상된급여
/*
    J7: 급여의 10%인상 (SALARY*1.1)
    J6: 급여의 15%인상 (SALARY*1.15)
    J5: 급여의 20%인상 (SALARY*1.2)
    그외: 급여의 5% 인상 (SALARY*1.05)
*/
SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                'J6', SALARY * 1.15,
                'J5', SALARY * 1.2,
                    SALARY * 1.05) AS "인상된 급여"
FROM EMPLOYEE;
-----------------------------------------------------------------------------TTTTTTTTTT
/*
    CASE WHEN THEN
    END
    
    CASE WHEN 조건식1 THEN 결과값1
        WHEN 조건식2 THEN 결과값2
        ...
        
    IF(조건식)(조건이 참일때 실행)
    ELSE IF(조건식)(조건이 참일때 실행)
    ELSE IF(조건식)(조건이 참일때 실행)
    ...ELSE
    
    ELSE(실행문)
*/

-- 사원명, 급여,(급여에 따른 등급(5백만원 이상이면 '고급 5백~3백 '중급' 나머지 초급))
SELECT EMP_NAME,SALAT,
        CASE WHEN SALARY >= 5000000 THEN '고급'
        CASE WHEN SALARY >= 3000000 THEN '고급'
        ELSE '초급'
        END 등급
FROM EMPLOYEE;

--==============================================================
--                        <그룹 함수>
--==============================================================
/*
    * SUM(숫자타입의 컬럼) : 해당 컬럼 값들의 총 합계를 반환해주는 함수
*/
-- 전사원의 총 급여의 합
SELECT SUM(SALARY) "총급여 합"
FROM EMPLOYEE;

-- 남자사원의 총 급여의 합
SELECT SUM(SALARY) "남자사원의 급여합"
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1','3');

-- 부서코드가 D5인 사원의 연봉의 총합
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 부서코드가 D5인 사원의 보너스를 포함한 연봉의 총합
SELECT SUM(SALARY*NVL(1+BONUS,1)*12) "보너스포함 연봉의 합"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 전사원의 총 급여의 합 형식 \000,000,000
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') "총급여 합"
FROM EMPLOYEE;

---------------------------------------------------------------------------------------------------------
/*
    * AVG(숫자타입의 컬럼) : 해당 컬럼값의 평균을 반환해 주는 함수
*/
-- 전체사원의 급여의 평균
SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

SELECT ROUND(AVG(SALARY), 2)
FROM EMPLOYEE;

---------------------------------------------------------------------------------------------------------
/*
    * MIN(모든타입의 컬럼) : 해당 컬럼값들 중 가장 작은값을 반환해 주는 함수
    * MAX(모든타입의 컬럼) : 해당 컬럼값들 중 가장 큰값을 반환해 주는 함수
*/

SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;
----------------------------------------------------------------------
/*
    COUNT(*|컬럼|DISTINCT 컬럼): 행 갯수 변환
    
    COUNT(*): 조회된 결과의 모든 행의 개수 반환
    COUNT(컬럼): 컬럼의 NULL값을 제외한 행의 갯수 반환
    COUNT(DISTINCT 컬럼): 컬럼값에서 중복을 제거한 행의 갯수 반환
*/
-- 전체 사원의 수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 여자 사원의 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- 보너스를 받는 사원의 수
SELECT COUNT(BONUS)
FROM EMPLOYEE;

-- 현재 사원들이 총 몇개의 부서에 분포되어 있는지(중복제외)
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;
----------------------------------------------------------------------
--03.4.문제2_SCOTT_문제
--SCOTT_연습문제
SELECT * FROM EMPLOYEE;
--1. EMP테이블에서 COMM 의 값이 NULL이 아닌 정보 조회
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;
--2. EMP테이블에서 커미션을 받지 못하는 직원 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE BONUS IS NULL;
--3. EMP테이블에서 관리자가 없는 직원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;
--4. EMP테이블에서 급여를 많이 받는 직원 순으로 조회
SELECT EMP_NAME
FROM EMPLOYEE
ORDER BY SALARY DESC;
--5. EMP테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
SELECT * 
FROM EMPLOYEE
ORDER BY SALARY ASC, BONUS DESC;
--6. EMP테이블에서 사원번호, 사원명,직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리)
SELECT EMP_ID, EMP_NAME, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE;
--7. EMP테이블에서 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬)
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
ORDER BY EMP_ID DESC;
--8. EMP테이블에서 사번, 입사일, 사원명, 급여 조회 
--  (부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리)
SELECT EMP_ID, HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY DEPT_CODE ASC, HIRE_DATE DESC;
--9. 오늘 날짜에 대한 정보 조회
SELECT SYSDATE FROM DUAL;
--10. EMP테이블에서 사번, 사원명, 급여 조회 
--   (단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT EMP_ID, EMP_NAME, FLOOR(SALARY / 100) * 100 AS ROUND_SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
--11. EMP테이블에서 사원번호가 홀수인 사원들을 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;
--12. EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)
SELECT EMP_NAME,
TO_CHAR(HIRE_DATE, 'YYYY') || '년' ||
TO_CHAR(HIRE_DATE, 'MM') || '월' AS 입사일
FROM EMPLOYEE;
--13. EMP테이블에서 9월에 입사한 직원의 정보 조회
SELECT *
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'MM') = '09';
--14. EMP테이블에서 81년도에 입사한 직원 조회
SELECT *
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '1981';
--15. EMP테이블에서 이름이 'E'로 끝나는 직원 조회
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%E';
--16. EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회
--	16-1. LIKE 사용
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '__%R';
--	16-2. SUBSTR() 함수 사용
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NAME, 3, 1) = 'R';
--17. EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 40 * 12)
FROM EMPLOYEE;
--18. EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
SELECT * 
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 38 * 12) <= SYSDATE;
--19. 오늘 날짜에서 년도만 추출
SELECT TO_CHAR(SYSDATE, 'YYYY') AS "현재 연도"
FROM DUAL;





























