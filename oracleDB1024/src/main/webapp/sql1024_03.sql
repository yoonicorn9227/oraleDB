select * from employees;

--[sysdate : 현재날짜 출력], [round : 반올림]
select hire_date,sysdate,round(sysdate-hire_date) from employees; -- [sysdate - hire_date] :고용된 날짜에서 현재날짜까지의 기간.  round( ) :반올림

--중복방지 : [distinct]
select distinct department_id from employees order by department_id asc; --department_id칼럼중 중복된것은 빼고[distinct]  (내림[asc],올림[dcsc]) 출력 [oder by] : 정렬

select * from departments;

SELECT * FROM DEPARTMENTS; --대소문자 구분 안함.

desc stuscore;

select emp_name from employees; 


--변수, 테이블명, 컬럼명은 대소문자 구분없음.  데이터값은 대소문자구분
select emp_name from employees where emp_name='Pat Fay'; -- 들어가있는 대소문자는 구문 pat fay는 검색안됨.

