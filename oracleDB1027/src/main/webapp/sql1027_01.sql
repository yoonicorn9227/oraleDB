select sysdate from dual;

select sysdate+1 from dual; --현재날짜에서 다음날 날짜

select add_months(sysdate,1) from dual; -- 현재날짜에서 한달뒤의 날짜 

select last_day(sysdate) from dual; -- 현재날짜에서 마지막 달의 날짜

select last_day('2023-01-01') from dual; --2023-01-01의 마지막 날짜


--현재날짜에서 년도, 달, 일만 추출
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select exrtract(day from sysdate) from dual;

--날짜에서 날짜를 빼면 기간의 일을 알수 있음.
select sysdate-bdate from board; --
select trunc(sysdate-bdate) ||'일' from board;

--1. 지난 개월수를 알려면(months_between(sysdate-특정날짜 컬럼)
select bdate, trunc(months_between(sysdate,bdate))||'개월' from board;


--2. 날짜출력 포맷 설정(to_char) : 날짜포맷을 문자형으로 형변환
select sysdate from dual;
select to_char(sysdate,'YYYY-MM-DD AM HH:MI:SS DAY') from dual;
select to_char(sysdate,'YYYY-MM-DD AM HH24:MI:SS DAY') from dual;
select to_char(sysdate,'YYYY"년"MM"월"DD"일" DAY, DY') from dual;


--숫자 -> 문자로 형변환, 천단위 표시 , 원화표시
select 1234500 from dual;
select to_char(1234500,'999,999,999') from dual; --천단위 표시
select trim(to_char(1234500,'999,999,999')) from dual; -- 공백제거
select to_char(1234500,'000,999,999') from dual; -- 공백자리에는 0으로 표시
select to_char(1234500,'L999,999,999') from dual; --천단위 표시 + 원화표시(L : 나라별 통화표시)
select to_char(1234500,'$999,999,999') from dual; --천단위 표시 + $표시


select '20231027' from dual; --문자로 날짜출력
select to_date('20231027') from dual; --문자형을 날짜로 출력
--퀴즈) 한달을 추가한 날짜출력
select '20231027' from dual;
select  add_months('20231027',1) from dual;
--문자-> 날짜 형변환, 기존의 날짜가 얼만큼 지났는지 확인
select sysdate - to_date('202310-01','YYYY-MM-DD') from dual;


--nvl(commission_pct,0) : null값을 0으로 표기해라
--퀴즈 manager_id null값에 ceo
select manager_id from employees;
select nvl(manager_id,0) from employees;
--숫자를 문자형변환 하고 CEO 글자를 입력
select nvl(to_char(manager_id),'CEO') from employees;

--그룹함수 
select salary, to_char(sum(salary),'$999,999,999'), to_char(avg(salary),'$999,999,999')  from employees
group by salary
;
      
select avg(salary) from employees;
-- 환율 1324.32 곱해서 천단위 \표시
select to_char(avg(salary)*1342.32,'L999,999,999') from employees;


--그룹함수 활용
select max(salary), min(salary) from employees;
select department_id from employees;
select emp_name ,max(salary) from employees 
where department_id = 50
group by emp_name
;

select emp_name, salary from employees
where salary = (select max(salary) from employees)
;


select department_id, max(salary), min(salary) from employees
group by department_id;


select emp_name, max(salary) from employees
group by emp_name
;


--count(*) : null값은 카운트 안되지만 * 는 카운트 된다.

select count(*) from employees;
select count(manager_id) from employees; --null값이 있어서 카운트 안됨.






--각반의 1등과 꼴찌출력하시오.
select * from stuscore;

select name, max(rank),min(rank) from stuscore
group by name;



select id from board;

select emp_name from employees;
--대소문자 구분없이 데이터 검색(컬럼명 like('%대문자%') or 컬럼명 like('%d%') 
select emp_name from employees
where emp_name like ('%D%') or emp_name like('%d%');

--대소문자 구분없이 데이터 검색(lower(컬럼명) like('%d%')) : 모두다 소문자로 바꿔서 검색 
select emp_name from employees
where  lower (emp_name) like('%d%');

--LPAD, RPAD 좌/우측 특정문자 채우기

select to_char(12,'000,000') from dual;
select LPAD(12,6,'0') from dual; -- 좍측을 0으로 채워넣기 (천단위 표시가 안됨)



--LTRIM RTRIM 좌/우측 공백제거

--sucbstr(컬럼명, 3,2) : 컬럼 데이터 문자에서 3번째 부터  2글자 가져와라
select id from board;
select substr(id,3,3) from board; --id에서 문자 3번째에서 3글자 뽑아와라

--bdate테이블에서 202308 으로 출력
select bdate from board;
select to_char(bdate,'YYYYMM') from board; --먼저 형변환
select substr(to_char(bdate, 'YYYYMM'),1,6) from board; --형변환후substr 사용

--instr(indexOf같은 개념) : 위치값 출력
select id from board;
select id,instr(id,'ff') from board;

select id,instr(id,'ff') 위치값 from board --해당하는 문자가 없으면 위치값은 0
where instr(id,'ff') !='0'; 

--length(컬럼명) : 컬럼명 안에 데이터 문자길이 
select id,length (id) from board;


--hire_date -- substr 월을 출력하시오
select hire_date from employees;
select substr(hire_date,4,2) from employees;


select to_char(hire_date,'YYYYMMDD') from employees;

-- 퀴즈)이름에서 3부터 3개와 월을 함께 출력하시오.
--최종 결과값 : aaa 06
select emp_name, hire_date from employees;
select substr(emp_name,3,3)||substr(hire_date,4,2) from employees;


--last_day() : 마지막날짜
select hire_date,last_day(hire_date) from employees;


--테이블 복사 : 테이블 생성되면서 모든 데이터 추가
create table fboard as select * from board; -- 테이블 복사

select bhit, bhit+100 from board;

update board
set bhit = bhit+100;

select a.bno, a.bhit, b.bno, b.bhit from board a, fboard b;

rollback; --다시 rollback 이전상태로 돌아감.

update board
set bhit = bhit+1
where bno=31; -- 게시글 넘버가 31 클릭할때 마다 조회수 1씩 증가




update fboard
set bhit=1;
select bhit from fboard;
commit;

select bno,bhit from board;

--업데이트 해서 데이터값 수정해서 넣기 방법
update fboard a
set bhit = (select bhit from board b where a.bno=b.bno)
;
rollback;


--alter테이블 구조변경/구조삭제 / 테이블 모든 로우삭제 truncate


desc fboard;

alter table fboard --fboard테이블에서 컬럼추가 
add userid varchar2(30)
;

select userid from fboard;
--id 1번쨰 부터 3개, bdate 월을 합친 값을 userid에 입력하시오;
select substr(id,1,3) ||substr(bdate,4,2) from fboard;

update fboard a
set userid = (
select substr(id,1,3) || substr(bdate,4,2) from fboard b where a.bno = b.bno)
;

---테이블의 컬럼명 변경(rename)
alter table fboard 
rename column userid to uuid
;

--테이블의 컬럼타입 변경(modify)
alter table fboard
modify uuid varchar(40)
;

--테이블 컬럼추가(add)
alter table fboard
add u_id varchar2(30)
;

desc fboard;
--컬럼삭제 

desc fboard;



