select * from employees;

select salary,salary+100,salary-100 from employees;

select sysdate,sysdate+365 from dual; --dual 임시더미테이블

select 1+3 from dual;

select 1+'3' from dual; --문자 3을 사칙연산을 하면 숫자로 자동변환
-- select 1+'a' from dual; -- (에러!) 문자는 사칙연산 에러
select 'a'+'b' from dual; -- (에러!) 문자는 사칙연산 에러 해결방법은 ['a'||'b'] or [concat]
select 'a'||'b' from dual;
select concat('a','b') from dual;

select * from employees;
--[Quiz] emp_name(email) 칼럼으로 출력하시오.
--Donald OConnell(DOCONNEL)
select emp_name||'('||email||')' u_nickId from employees;
select concat(emp_name,concat('(',concat(email,')'))) from employees;

-- 00/01/01 이후 입사한 사원을 출력하시오.
--00/01/24, 00-01-01, 2000-01-01 3개모두 같은형태임.
select employee_id,emp_name,hire_date from employees --테이블 자리에는 칼럼도 들어올수 있음(이중쿼리).
where hire_date>='2000-01-01' --조건식에도 select이 들어올수 있음.
order by hire_date asc
;


--데이터 열 갯수
select count(*) from employees;

--봉급을 가장많이 받는 사람 사원이름 (이중쿼리)
select max(salary) from employees;

select * from employees
where salary = 24000
;
--(이중쿼리) 봉급을 가장많이 받는 사원이름
select * from employees
where salary=(select max(salary) from employees); 


--커미션 있는(is not null) 사람 없는(is null) 사람
select * from employees
where commission_pct is null;


--부서번호가 80번 이상인 사원 출력
select * from employees
where department_id>=80
order by department_id asc;

--부서번호 80만 제외하고 출력하시오.
--where not
select * from employees
where not department_id = 80
order by department_id asc
;

-- <> != not
select * from employees 
where department_id !=80
order by department_id asc
;

--부서번호가 50번 이면서 연봉이 6000달러 이상인 사원 출력하시오
select * from employees
where department_id=50 and salary>=6000;

-- 봉급이 2000초과이면서 3000미만인사람
select * from employees 
where salary>2000 and salary<3000
order by salary asc
;

select * from employees 
where salary not between 2000 and 3000
order by salary asc
;


--between A and B (A와 B값은 모두 포함) = (A=<X<=B)
select * from employees 
where salary between 2000 and 3000
order by salary asc
;

--그룹함수 : avg, count, max, min 등등
select avg(salary) from employees;

--평균월급보다 낮게 받는 사람 (이중쿼리)
select * from employees
where salary <=(select avg(salary) from employees)
order by salary desc
;

--실습) 월급이 3000, 4000, 6000인 사람출력
select * from employees
where salary =3000 or salary=4000 or salary=6000
;

select * from employees 
where salary in(3000,4000,5000)
;

--실습)사원번호 101 151 200인 사원의 사원번호와 월급을 출력하시오.
--where in
select employee_id, salary from employees 
where employee_id in(101,151,200)
;
--where or
select employee_id, salary from employees 
where employee_id =101 or employee_id=151 or employee_id=200
;

-- 월급이 2000미만, 3000미만인 사원을 출력하시오.
select * from employees
where salary<2000 or salary>3000
;

select * from employees 
where salary not between 2000 and 3000
;

--입사일이 00/01/01 ~ 00/12/31 사원을 출력하시오.
select * from employees
where hire_date between '00/01/01' and '00/12/31'
;

select * from employees 
where hire_date >= '00/01/01' and hire_date<='00/12/31'
;

--연산자 와일드 카드

select emp_name from employees;
-- 대문자 S로 시작되는 이름을 출력하시오. [like '(문자)%']
select emp_name from employees
where emp_name like 'S%'
;l

--소문자 n로 끝나는 이름을 출력하시오. [like '%(문자)']
select emp_name from employees
where emp_name like '%n'
;

-- 처음, 끝 , 중간 e가 있는 이름을 출력하시오. [like '%(문자)%']
select emp_name from employees
where emp_name like '%e%'
;



--bcontent 컬럼에 'faucibus' 단어가 들어가 있는 게시글을 출력하시오.
select * from board;

select * from board
where bcontent like '%faucibus%'
;

--bcontent 컬럼에 'ven' 단어가 들어가 있는 게시글을 출력하시오.
--btitle 컬럼에 'ven' 단어가 들어가있는 개수 : 15개
select * from board
where btitle like '%ven%'
;

--btitle 또는 bcontent 컬럼에 'ven' 단어가 들어가있는 게시글을 출력하시오.  :270개
select * from board
where btitle like '%ven%' or bcontent like '%ven%'
;

--bcontent에서 소문자 n으로 시작하면서 4개의 문자단어가 있는 게시글을 출력하시오.
--ex)nibh(해당 O ) , naabb quisque(해당x)
--n____%(n _ _ _ %)
select bcontent from board
where bcontent like '%n____%' -- [%n_ _ _ _%]         [%n_ _ _] : n으로 시작하는 4글자
;

select emp_name from employees;
select emp_name from employees
where emp_name like 'P__ %';



select emp_name from employees
where emp_name like 'D%'; -- 대문자 D로 시작하는 이름


select emp_name from employees
where emp_name like '%a%' --소문자 a가 중간에 들어가있는 이름
;

select emp_name from employees
where emp_name like '%d' --소문자 d가 뒤에 들어가있는 이름
;

--2번째 글자가 a인 사원 이름을 출력하시오.
select * from employees
where emp_name like '_a%'
;


--정열
--월급을 낮은순(asc)부터 출력하시오
select emp_name, salary from employees
order by salary asc
;


select * from employees;

select employee_id,emp_name,job_id,hire_date from employees
order by hire_date desc
;


--사원명 역순정렬
select employee_id,emp_name,job_id,hire_date from employees
order by emp_name desc
;


--부서번호 순차정렬 이름은 역순정렬
--사원번호, 사원명, 부서번호, 직급. 입사일, 월급만 정렬

select employee_id,emp_name,department_id,job_id,hire_date,salary from employees
order by department_id asc, emp_name desc
;


--월급으로 순차정렬(asc) , 입사일 역순정렬(desc)
select employee_id,emp_name,department_id,job_id,hire_date,salary from employees
order by salary asc, hire_date desc
;


--숫자함수(주요함수)
--abs : 절대값
select -10, abs(-10) as "절대값" from dual;

--floor : 버림
select 10.54578, floor(10.54578) from dual;

--trunc(값, 버림위침) : 특정자리 버림
select 10.54578, trunc(10.54578,2) from dual;

--round : 특정자리 반올림
select 10.54578, round(10.54578), round(10.54578,3) from dual;


select * from stuscore;
select stunum,name,math, eng, kor+eng,round((kor+math)/2) "반올림" from stuscore;

--실습)월급을 원화로 환산(1342.32\) 해서 소수점 2자리 반올림 출력하시오.
--사원 사원명 월급 월급환산 월급환산 3자리 반올림

select * from employees;
select employee_id"사원번호",emp_name"사원명",salary"월급",(salary*1342.32)"월급 환산",round(salary*1342.32,2)"월급 반올림" from employees;

--실습)입사일이 현재날짜까지 걸린 일자를 출력하시오
--소숫점 3자리에서 반올림
select round(sysdate-hire_date,2) "근로기간" from employees
;


--입사일에서 현재날짜까지 걸린 일자를 출력하시오.
--소숫점 자리는 반올림, 일을 년으로 환산하시오.
select emp_name,floor((round(sysdate-hire_date,1))/365) sdate from employees
order by sdate asc
;


select * from member;
select * from employees;

-- MOD : 나머지 함수
select mod(27,2), mod(27,5), mod(27,7) from dual;


--사번이 홀수 인 사원을 출력하시오.(순차정렬)
select * from employees
where mod(employee_id,2)=1
order by employee_id asc
;

--관리자 번호가 짝수인 사원을 출력하시오.
-- 사번,사원명, 입사일, 월급, 관리자 번호, 부서번호
select employee_id,emp_name,hire_date,salary,manager_id,department_id from employees
where mod(manager_id,2)=0
order by employee_id asc
;

select * from board;


-- 평균 조회수 소숫점 둘째자리에서 반올림
select round(avg(bhit),1) from board;

--평균 조회수 소숫점 버림
select trunc(avg(bhit)) from board;

-- 평균보다 높은 조회수를 가진 게시글 출력
select * from board
where bhit >= (select avg(bhit) from board)
;

select * from employees
where salary >= (select avg(salary) from board);


select to_char(salary,'999,999'),to_char(round(salary*1342.32),'999,999,999') "월급환산" from employees; --to_char(컬럼명, '000,000') 숫자자리수 구분 쉼표

--[시퀀스(번호)]
--▼시퀀스 만들기
create sequence board_seq
start with 1001
increment by 1
minvalue 1
maxvalue 99999
nocycle
nocache
;

--
select * from board
order by bno desc
;

insert into board values ( 
board_seq.nextval,'제목입니다.','내용입니다.',sysdate,'aaa',board_seq.currval,0,0,1,'1.jpg' 
); --시퀀명의 시작번호를 받아와라(시퀀스명.nextval) board_seq.currval(현재번호를 들고와라)

commit;

select board_seq.currval from dual;
select board_seq.nextval from dual; --nextval 현재번호에서 증가된 번호를 가져와라


select member_seq.nextval from dual;


--Quiz dept_seq 시작10 증분10
create sequence dept_seq
start with 10
increment by 10
minvalue 1
maxvalue 99999
nocycle
nocache
;


select dept_seq.nextval from dual;


desc stuscore;

select * from stuscore;
commit;



select * from stuscore
order by total desc
;

select stunum,name, total, rank() over (order by total desc) m_rank,rank
from stuscore
;

--total를 기준으로 역순정렬해서 등수를 출력
select stunum,rank()over (order by total desc)
from stuscore
where stunum = 83
;

select * from stuscore a, member b;

select employee_id,emp_name,employees.department_id,department_name,parent_id 
from employees a, departments b
where a.department_id = b.department_id
;

select*from departments;
select*from employees;


select deparment_id,department_name from departments;

select * from departments;


update stuscore a 
set rank=1;

update stuscore a
set rank = ( -- select stunum,rank from stuscore
select b_rank from
(select stunum b_num, rank() over (order by total desc) as b_rank from stuscore) b
where a.stunum = b.b_num
);

select * from stuscore;

--emp2
--drop table emp2;
--테이블 복사
create table emp2 as select * from employees;

update emp2 set manager_id='';

commit;

select * from emp2;

update (select manager_id a_m , b.employees b_m
from emp2 a, employees b
where a.employee_id = b.employee_id)
set a_m = b_m
;


select salary from employees
where salary >= (select avg(salary) from employees)
;


--1. emp2 테이블의 사원번호와 employees 사원번호 똑같이 일치 시키기
--2.emp2 테이블의 관리자 번호와 employees 관리자 번호를 검색함.
--3. employess 관리자번호를 emp2의 관리자 번호에 입력시킴
update 
(select a.manager_id a_m,b.manager_id b_m from emp2 a , employees b where a.employee_id = b.employee_id)
set a_m = b_m;



create sequence emp_seq 
start with 1
increment by 1
minvalue 1
maxvalue 100000
nocycle
nocache
;




--emp01 테이블 생성
create table emp01 (
empno number(4) primary key,
ename varchar2(10),
hiredate date
);

--emp01 테이블 삭제
drop table emp01;

--emp01 테이블 데이터 값 입력
insert into emp01 values (emp_seq.nextval,'홍길동',sysdate);
insert into emp01 values (emp_seq.nextval,'유관순',sysdate);
insert into emp01 values (emp_seq.nextval,'이순신',sysdate);
insert into emp01 values (emp_seq.nextval,'홍길자', sysdate);
insert into emp01 values (emp_seq.nextval,'홍길순',sysdate);

commit;
select * from emp01;

select emp_seq.currval from dual;

select employee_id, emp_name,job_id,hire_date from employees
order by hire_date desc;

