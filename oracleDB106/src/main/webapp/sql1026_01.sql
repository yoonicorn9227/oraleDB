--[복습]
--사원번호가 홀수인 사원을 출력하시오.

select * from employees
where mod(employee_id,2)=1
order by employee_id asc
;

--board 
select * from board;
desc board;


select sysdate from dual; -- 현재날짜 출력

select * from board
order by bno desc
;

insert into board values (
board_seq.nextval,'이벤트 진행','내용입니다.',sysdate,'ccc',board_seq.currval,0,0,1,''
);
insert into board values (
board_seq.nextval,'게시글을 등록합니다.','게시글 내용입니다.',sysdate,'ccc',board_seq.currval,0,0,1,'2.jpg'
);
insert into board values (
board_seq.nextval,'게시글을 등록합니다.2','게시글 내용입니다.2',sysdate,'ccc',board_seq.currval,0,0,1,'3.jpg'
);



--날짜

select sysdate-1 "어제",sysdate"오늘",sysdate+1 "내일" 
from dual;

select bdate from board
order by bdate desc
;

--현재날짜 기준 5일 이전에 게시글을 출력하시오.
--번호, 제목, 작성일만 출력.
select sysdate-5 from dual;


select * from board;

select bno, btitle,bdate from board
where bdate > sysdate-5
order by bdate desc
;


--employees 현재날짜 기준 입사일에서 현재날짜까지의 기간을 출력하시요.
--소숫점 절사
--사원번호, 사원명, 입사일, 월급, 부서번호
select employee_id, emp_name,hire_date, salary, department_id, 
trunc(sysdate-hire_date) "근로기간" 
from employees;

--다가올 요일을 출력(next_day)
select next_day(sysdate,'목요일') from dual;
select next_day(sysdate,'목') from dual;
select next_day(sysdate,7) from dual;

--현재 입력한 날의 마지막일 출력하시오.(last_day)
select last_day(sysdate) from dual;
select last_day('20231101') from dual;
select last_day('20220201') from dual;

-- 현재날짜에서 입력한 개월수 전후날짜 :  add_months
select add_months(sysdate,-2) from dual;
select add_months(sysdate,+12) from dual;
select add_months('20220101',+6) from dual; -- 입력한 날짜에서 6개월 후



--현재달에서 입사한 달까지의 개월 수 : months_between
select  round(months_between(sysdate, hire_date))||'개월' from employees;


--현재 1년동안 게시글이 작성된 글을 출력하시오. 
select * from board
where  bdate > add_months(sysdate,-6)
order by bdate desc
;


--날짜 중 년 월 일만 출력하시오.
select extract(year from bdate) from board;
select extract(month from bdate) from board;
select extract(day from badate) from board;


--3,5,7월에 입력한 게시글 출력
select bno,btitle,bdate from board
where extract(month from bdate) in (3,5,7)
order by bdate asc
;



--날짜 round, trunc
select bno,btitle,bdate from board; --날짜의 round(DATE,'month') 또는 round(DATE,'mm') : 15일기준으로 15일 미만 버림 and 이상 月수를 한칸 반올림 2023-12-15 -> 2024-01-01
select bdate,round(bdate,'month'),trunc(bdate,'mm') from board; --날짜의 ,trunc(DATE,'month') 또는 trunc(DATE,'mm')  : 해당 개월 수 첫째날만 출력

select round(to_date('2023-10-15'),'month') from dual; -- to_date('yyyy-mm-dd') : 문자형태[yyyy-mm-dd]를 날짜형태로 형변환



--[날짜형 변환함수]
-- to_char
select bdate from board;
select to_char((bdate),'YYYY-MM-DD DY') from board;
select to_char((bdate),'YYYY-MM-DD DAY HH:MI:SS') 
from board
order by bdate desc
;

select bno,btitle,bcontent,to_char((bdate),'YYYY"년"MM"월"DD"일"DAY') bdate from board
order by bdate desc;

--퀴즈  employees 테이블에서 입사일(2023-11-01 화요일)형식으로 출력
select to_char((hire_date),'YYYY-MM-DD DAY') from employees
order by hire_date desc
;

--
select to_char(bdate,'YYYY-MM-DD AM HH12:MI:SS') from board
order by bdate desc;

select to_char(bdate,'YYYY-MM-DD AM HH24:MI:SS') from board
order by bdate desc;


--[문자형 변환함슈]--
--숫자를 문자로 변환
select to_char(123456789) from dual; --숫자이지만 문자로 출력됨
select to_char(123456789,'999,999,999,999') from dual; --자리수 동일하게 해줄것 아니면 ####으로 출력 
select to_char(123456789,'000,999,999,999') from dual; --000,999,999,999 빈공백을 0으로 표시
select to_char(123,'000000000')from dual;
select to_char(123456789,'$999,999,999,999') from dual; --달러표시['$999,999,999,999']
select to_char(123456789,'L999,999,999,999') from dual; --해당나라 화폐단위로 표시 [L999,999,999,999]

--trim 앞뒤 공백제거함수
select to_char(123456,'L999,999,999') from dual; --공백발생
select trim (to_char(123456,'L999,999,999')) from dual; --공백제거

--퀴즈 
-- salary 달러표시와 천단위표시
--salary*1342 원화표시와 천단위표시, 소숫점 1자리까지 반올림 표시
select  salary,to_char(salary,'$999,999,999'),salary*1342.42 ,to_char(round(salary*1342.42,1),'L999,999,999') 
from employees;


--퀴즈
--12345를 총 9자리까지 표시하는데, 빈공백은 0으로 표기
select to_char(12345,'000000000') 
from dual;


--퀴즈2
--12,345 총 9자리 까지 표시하는데 천단위 표기 빈공백은 삭제
select trim(to_char(12345,'L999,999,999')) 
from dual
;

--퀴즈3
--board 테이블에서 bdate와 비교해서 20231023 숫자와 같은 날 입력한 게시글을 출력하시오.
select bno,btitle,bdate
from board
where bdate = to_date('20231023','YYYYMMDD') 
order by bdate desc
;

--퀴즈4
--숫자 20200101 부터 현재까지 기간이 얼마나지났는지 출력하시오.

select trunc(sysdate-to_date('20200101','YYYYMMDD'))
from dual;


--퀴즈5
--자기 태어난 날을 기준으로 얼마나 지났는지 출력하시오.
select trunc(sysdate-to_date('19960601','YYYYMMDD')) "살아온날"
from dual;

-- 자기가 태어난날 기준으로 현재까지의 개월수 출력
select trunc(months_between(sysdate,to_date('19920207','YYYYMMDD')))
from dual;


--퀴즈6

--[문자를 숫자로 형변환함수]--
--20,000 10,000과 차이를 출력하시오.
select to_number('20,000','99,999') from dual;
select to_number('10,000','99,999') from dual;

select to_number('20,000','99,999') - to_number('10,000','99,999') from dual;

select emp_name, to_char(salary,'$999,999') from employees;


--퀴즈7
--연봉 + 커미션포함
-- 연봉 = 월급 * 12개월 + (월급*12*커미션) 을 출력하시오.
--사원번호, 사원명, 월급,월급*12,년봉
select employee_id, emp_name,salary,salary*12,salary*12+(salary*12*nvl(commission_pct,0)) y_sal 
from employees
;

select manager_id from employees
where manager_id is null;



--CEO라는 글자로 표시해서 출력하시오.
--숫자를 문자로 형변환후 CEO 글자출력
select nvl(to_char(manager_id),'CEO') from employees;


--[그룹함수]--
--게시글 조회수 총합을 출력하시오.(천단위 표시)
--1.합계표시
select trim( to_char(sum(bhit),'999,999,999')) from board;
--2.평균표시
select trim(to_char(avg(bhit),'999,999,999')) from board;

--실습) 월급의 평균(소숫점 2자리까지 반올림)
select round(avg(salary),2) from employees;

--단일함수 그룹함수 출력같이 안됨.
select emp_name, avg(salary) from employees; -- (에러발생) 단일함수와 그룹함수는 함께 출력이 불가능!

-- MIN 최소값, MAX최대값, AVG 평균, COUNT갯수, SUM합계
select min(salary), max(salary), avg(salary), count(*) from employees;


--부서번호가 50인 ,사원들의 월급 합계, 평균을 출력하시오.
select to_char(sum(salary),'$999,999,999'), to_char(round(avg(salary),2),'$999,999,999') 
from employees
where department_id = 50;


select department_id,sum(salary) ,avg(salary)
from employees
group by department_id --단일함수와 그룹함수 그룹핑 할때 사용 [group by 단일함수]
order by department_id asc
;


--퀴즈
--날짜, 게시글 개수를 출력하시오.
select bdate,count(*) from board
group by bdate
order by bdate asc
;

--년도의 월별개수를 출력하시오.

select to_char(bdate,'YYYYMM') 년월 ,count(to_char(bdate,'YYYYMM')) 년월별갯수
from board
group by to_char(bdate,'YYYYMM')
order by to_char(bdate,'YYYYMM')
;

select count(*) from board;



select bdate,count(*) from board
group by bdate
order by bdate asc
;

select add_months(bdate,1)
from board
;

--년,월,일 출력
select extract(year from bdate) from board; --년 출력
select extract(month from bdate) from board; --월 출력
select extract(day from bdate) from board; -- 일 출력

--년도와 상관없이 월별 게시글수 출력
select extract(month from bdate), count(extract(month from bdate))
from board
group by extract(month from bdate)
order by extract(month from bdate)
;



--
select count(*) from employees;
select count(employee_id) from employees; -- 107개
select count(manager_id) from employees; --null값이 있어서 하나 적개 나온다.

--단일 함수 사용은 group by 절에 추가해서 사용해야함.
select department_id, count(*) from employees
group by department_id
order by department_id
;


-- 조회수가 가장 낮은 게시글의 제목, 내용을 출력하시오.
select bno, btitle, min(bhit) from board
group by bno, btitle 
; -- 원하는 결과 출력안됨. 

--조회수가 가장 낮은 게시글을 출력하시오.
select * from board
where bhit = (select min(bhit) from board)
;

--조회수가 가장 높은 게시글을 출력하시오.
select * from board
where bhit = (select max(bhit) from board)
;

--[문자함수]--
--concat

select emp_name from employees;
--대소문자 구분없이 si 가 포함된 이름을 모두 출력하시오.(like 사용)
--si sI Si SI
select  emp_name   
from employees 
where emp_name like('%si%')  or emp_name like('sI') or  emp_name like('%SI%') or emp_name like('%Si%')
;


--대소문자 구분없이 da가 포함된 이름을 모두출력하시오.
--1.
select emp_name
from employees
where emp_name like('%DA%') or emp_name like('%Da%') or emp_name like('%dA%') or emp_name like('%da%')
;

--2. lower 함수 사용 문자를 모두 소문자변환
select emp_name
from employees
where lower(emp_name) like('%da%')
;

--3. upper 함수 사용 문자를 모두 대문자변환
select emp_name
from employees
where upper(emp_name) like('%DA%')
;


--4.initcap (첫글자만 대문자)


--employees에서 사원명 모두 대문자
select upper(emp_name) from employees;
select lower(emp_name) from employees; 
select initcap(emp_name) from employees;  --4.initcap (첫글자만 대문자)


--LPAD : 왼쪽편에 자리수를 만들어서 지정한 문자(0)를 채워 출력. 
select LPAD(12345,10,'0') from dual;

--LPAD : 오른쪽편에 자리수를 만들어서 지정한 문자(#)를 채워 출력. 
select RPAD(12345,10,'#')from dual;


--12345를 10자리로 천단위 표시와 원화 표시를 추가해서 출력하시오.
select to_char(12345,'L0,000,000,000') from dual;



--trim
--LTRIM : 왼쪽공백제거 / RTRIM : 오른쪽 공백제거/ TRIM : 모든공백제거
--'    ABC DEF   C    '

--replace 공백제거
select * from employees;

--job_id ASST --> SS --> I  따라서 AIIT

select job_id, replace(job_id, 'SS','I') from employees;

--emp_name 안에 있는  모든공백제거
select emp_name, replace(emp_name,' ','')from employees;
select  '   ABC DEF   C    ', replace('   ABC DEF   C    ',' ','') from dual;

select job_id from emp2;
--SH_CLERK - > CLERK 변경해서 저장

update emp2
set job_id = 'CLERK'
where job_id = 'SH_CLERK'
;


select replace(job_id,'SH_CLERK','CLERK') from emp2;



--substr(이름,4,3) : 이름에서 4번째 글자부터 3개 가져와라 : 해당컬럼에서 4번째 글자부터 2개를 짤라와서 출력.

-- 4번째 부터 이름 3개를 가져옴
select emp_name,substr(emp_name,4,3) from employees;


--
select hire_date from employees;
--이름 5개와 입사년도를 출력하시오. 
-- Donald(1995) 식으로 출력
select substr(emp_name,1,5) || to_char(hire_date,'(YYYY)') from employees;
select substr(emp_name,1,6) ||'('|| to_char(hire_date,'YYYY') ||')' from employees;


select * from employees;

--입사일이 06월 사람중에 이름이 소문자 d가 들어가 있는 사원을 출력하시오.
select * from employees
where extract(month from hire_date) = 6  
and  lower(emp_name) like ('%d%')
;


SELECT * FROM EMPLOYEES
WHERE EXTRACT(MONTH FROM HIRE_DATE) = 6
AND EMP_NAME LIKE ('%d%');

------
--bhit+100 데이터 값을 bhit에 업데이트
update board
set bhit =1
;

rollback;

select  bno, bhit, bhit+100 from board;

update board a
set bhit = (select bhit+100 from board b  where a.bno=b.bno ) 
;
select bhit from board;



--SH_CLEARK 를CLERK 로 바꿔서 업데이트
select employee_id, job_id from emp2;
update emp2 a
set job_id = (select replace(job_id,'SH_CLERK','CLERK') from emp2 b where a.employee_id = b.employee_id )
;
--rollback;


--게시글의 날짜를 1씩 증가해서 update하시오.
--bdate
select bdate from board;

update board a 
set bdate = (select bdate+1 from board b where a.bno = b.bno)
;

--rollback;

select * from stuscore;

update stuscore 
set rank =0
;

commit;

--학생성적 등수 데이터 업데이트해서 저장------------------------

select rank from stuscore;
select b_num, b_rank from
(select stunum b_num, rank() over (order by total desc) b_rank  from stuscore)
;


update stuscore a
set rank = (select  b_rank from
(select stunum b_num, rank() over (order by total desc) b_rank  from stuscore b) where a.stunum =b_num)
;

--rollback;

select * from stuscore;
-------------------------------------


--length : 공백포함한 글자길이
select length(emp_name), emp_name from employees;

select round(avg(length(emp_name)),1) from employees;

--이름을 평균절사 길이만큼만 출력하시오.
select substr(emp_name,1,avg(length(emp_name))) from employees
;





--employees 폰번호에 있는 5번째 3개와 이름 1번쨰 부터 5번째까지 2개를 함께 출력하시오. 
select substr(phone_number,5,3) || substr(emp_name,1,5) from employees;


--instr 찾고자 하는 위치값을 리턴하는 함수
select * from employees;
select instr(emp_name,'o') from employees
where employee_id = 198
;


select instr(emp_name,' ') from employees; --이름의 빈공백이 위치하는 자리수 출력 / 없으면 -1값 출력
select instr(emp_name,' ')+1 from employees;


--1번째 공백이후부터 이름가져오기(성씨와 이름을 분리할떄 활용)
select substr(emp_name,5) from employees;
select substr(emp_name,instr(emp_name,' ')+1) from employees;



--주민번호 앞자리 가져오기
select substr('920207-1101234',1,instr('920207-1101234','-')-1) from dual;

--주민번호 뒷자리 가져오기
select substr('920207-1101234',instr('920207-1101234','-')+1) from dual;

--employees의 phone_number 첫번째 점 기준으로 앞부분과 뒷부분 출력하시오.
select phone_number from employees;

select substr(phone_number,instr(phone_number,'.')+1) from employees;


select instr('123.456.789','.') from dual; -- 점이 있는 위치값
select instr('123.456.789','.',2,2) from dual; -- 첫번째 숫자 -- 시작위치 두번째 숫자 점의 두번쨰 위치값
select instr('123.456.789','.',-1,1) from dual;


select * from member;
--전화번호 - 첫번째 값, 두번째, 세번째 값을 출력하시오. 
--010
--1111
--1111

select substr(phone,1,instr(phone,'-')-1) from member; --010
select substr(phone,instr(phone,'-')+1,4) from member; -- 1111 (중간번호)
select substr(phone,instr(phone,'-',1,2)+1,4) from member; --1111 (마지막 번호)

select phone_number from employees;
--폰번호에서 123이 포함되어 있는 폰번호를 출력하시오.

select phone_number from employees
where phone_number like ('%123%');




--부서별 최대 월급을 출력하시오.

select department_id,max(salary) 월급최대값 ,min(salary) 월급최소값  ,count(*) from employees
group by department_id
order by department_id desc;

select emp_name , to_char(hire_date,'YYYY"년"MM"월"DD"일"DAY') from employee
