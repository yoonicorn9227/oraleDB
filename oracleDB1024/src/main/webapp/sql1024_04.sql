select * from departments;

select * from departments order by manager_id asc;

--employees 테이블에서 employees_id

select * from employees order by employee_id asc;


--조건문 where
select * from employees where employee_id>=200;

select * from employees
where employee_id>=190 and employee_id<=205;


--salary 5000이상인 사원을 검색하시오.
select * from employees 
where salary >=5000 order by salary asc; -- salary 5000사원 내림차순으로 정렬.

--사번 ,이름, 직급, 부서, 월급 순으로 출력.
select employee_id,emp_name,job_id,department_id,salary from employees;

--테이블의 데이터 복사
create table emp2 as select * from employees;

select * from emp2;

--컬럼 타입보기
desc emp2;


--컬럼 이름 변경
alter table emp2 rename column emp_name to e_name; 

--컬럼 데이터 타입 길이 변경
-- email 안에 데이터가 숫자가 아니면 변경이 안됨. [ alter table emp2 modify email number(50);] 경우 에러발생
alter table emp2 modify email varchar2(50); --varchar2(5)으로 변경시 안에있는 데이터가 5이상 되는 데이터가 있어서 변경불가 (에러발생)


-- 컬럼 삭제
alter table emp2 drop column creat_date;

--컬럼추가
alter table emp2 add  create_date date;

--컬럼순서변경
alter table emp2 modify update_date invisible;
alter table emp2 modify update_date visible;
select * from emp2;


--컬럼의 데이터 복사
insert into emp2 select * from employees;


--Quiz 사원이름, 급여, 입사일 emp2 테이블의 사원이름 내림차순 정렬.
select emp_name,salary,hire_date from emp2 
order by emp_name asc;

--이름 급여 입사일 출력

alter table emp2 modify salary invisible;
alter table emp2 modify manager_id invisible;
alter table emp2 modify commission_pct invisible;
alter table emp2 modify retire_date invisible;
alter table emp2 modify department_id invisible;
alter table emp2 modify job_id invisible;

alter table emp2 modify SALARY visible;
alter table emp2 modify MANAGER_ID visible;
alter table emp2 modify COMMISSION_PCT visible;
alter table emp2 modify retire_date visible;
alter table emp2 modify department_id visible;
alter table emp2 modify job_id visible;

insert into emp2 (employee_id,emp_name) select employ_name from employees;

--연산자

select emp_name +'a' from employees; --(에러) 숫자가 아니기 때문에 연산불가
--별칭선언, as 생략이 가능함
select salary,salary*12 as y_salary,salary*12*1342 as k_salary from employees; --salary는 숫자이기 때문에 연산가능 //  as 변수명 : 변수명을 커스텀할수 있음

select * from employees;

--연봉 [nvl(변수,0) : null인경우 0으로 표시]
select salary, salary*12,nvl(commission_pct,0) from employees;

select 
salary, 
salary*12 as "연봉", --쌍따옴표[""] : 쌍따옴표 안에 있는 문자 그대로 출력(사이띄우기 대소문자 등등 구현가능)
(salary*12)*nvl(commission_pct,0) as "인센티브",
(salary*12)+(salary*12)*nvl(commission_pct,0) as "실제연봉" from employees; --nvl(변수명,0) : 숫자가 null값이면 0으로 표현해라

--null값 0으로 표현 : nvl(변수명,0)
select nvl(manager_id,0) from employees;


--사번, 월급,직급,커미션,연봉,연봉+커미션을 출력하시오.

select  employee_id,
salary,
job_id,
nvl(commission_pct,0) as "커미션",
(salary*12) as "연봉",
(salary*12)+(salary*12)*nvl(commission_pct,0) as c_salary from employees;


--월급이 6000인 사원 검색
select * from employees where salary=6000;

--커미션이 없는 사람만 출력하시오. null비교 is null
select * from employees where commission_pct is null; --[select * from employees where commission_pct = null;] -> 사용불가
select * from employees where commission_pct is  not null; --등가비교부호(=)는 사용 안됨.


select * from departments;

select * from employees;

--실습 부서번호 부서명을 출력하시오.
select department_id as "부서번호",department_name "부서명" from departments  
where department_id>=10 and department_id<=40;


select emp_name+"is a" from employees; --오류

--문자타입을 붙여서 출력 [ || ]
select emp_name ||'is a'|| job_id from employees; -- [select concat(concat(emp_name,'is a'),job_id) from employees;]와 동일
select concat(emp_name,job_id) con_name from employees;

select * from stuscore;
select kor,eng,math,kor+eng+math,(kor+eng+math)/3 from stuscore;

select distinct department_id  from employees 
order by department_id asc ;


--quiz JOB_ID 중복제거 출력 [distinct]
select distinct job_id 
from employees
order by job_id asc; 

--월급이 3000,5000,6000인 사람 출력
select *
from employees
where salary=3000 or salary=6000 or salary=7000
order by salary asc;

select*
from employees
where salary>=3000 and salary<10000
order by salary asc;

--월급이 5000이하인 사람에 게 +1000 월급을 인상해서 출력하시오
select 
salary,salary+1000 as "월급인상", (salary+1000)*1342 "원화" 
from employees
where salary<=5000;


--부서번호가 10, 30, 50번인 사원번호, 부서번호, 직급, 월급,입사일을 출력하시오.
select *from employees;

--QUIZ 부서번호가 10, 20, 30인 사원의 사원번호, 부서번호, 직급, 월급, 입사일을 출력하시오.
select 
employee_id,department_id,job_id,salary,hire_date --가져올 데이터 (조건충족시)
from employees -- 데이터 가져올 테이블
where department_id=10 or department_id=30 or department_id=50 --조건
order by employee_id asc, department_id asc; --내림차순 정렬

--QUIZ 월급이 4000이상 8000이하 사원번호, 사원이름,급여,부서번호 출력하시오.
--추가QUIZ 입사일이 2003/09/01 이후 이면서 위에조건에 충족하는 사원데이터 출력 출력하시오 
select 
employee_id, emp_name,salary,hire_date,hire_date+100,department_id
from employees
where salary>=4000 and salary<=8000  and hire_date>'03/09/01'
order  by salary asc;

commit;