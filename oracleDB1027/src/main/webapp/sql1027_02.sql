--컬럼삭제 
alter table fboard
drop column uuid;

desc fboard


--테이블 생성 및 데이터 복사
create table  emp02 as select * from employees ;


--테이블명 변경
--rename emp2 to emp02;
--테이블 삭제
--drop table emp2;




--무결성 제약조건
desc mem;

create table mem(
id varchar2(30) primary key, --null 허용 안됨 & 중복허용안됨 primary key = (not null & unique)
pw varchar2(30) not null,
name varchar2(30) not null, --중복은 가능
phone varchar2(6),
gender varchar2(1) check(gender in('M','F')), --M과 F만 들어감 
hobby varchar2(80),
mlevel number(2)  check(mlevel between 1 and 10), --1~10사이 값 가능
mdate date default sysdate -- 입력하지 않은면 현재날짜 등록.
);

insert into mem values (
'aaa','1111','홍길동','010-1111-1111','M','game','1',sysdate
);


insert into mem (id,pw,name) values (
'bbb','1111','유관순'
);


insert into mem(id,pw,name,gender) values ( -- id : bbb는 primary key로 null 값과 중복이 허용이 안됨으로 무결성 제약조건 에러발생!
'ccc','1111','이순신','M'                          --      M 또는 F 를 제외한 문자값을 넣을 경우 에러 발생 (소문자도 안됨)            
);

commit;

select * from mem;

desc member;


--foreign key : 부모테이블에 있는 primary key로 입력된 값만 가져 올수 있음.


--오라클의 switch, if 조건문 : dcode
-- dcode는 같은 값인 경우만 비교 가능함.
select * from employeess;

select department_id from employees;

select department_id, department_name from departments;
--10 총무기획부 20마케팅 30구매/생산부 40인사부 50배송부 출력하시오.(2가지방법)
select department_id from employees;

-- 1가지 : decode 조건문
select department_id, 
decode(department_id,
10,'총무기획부',
20,'마케팅',
30,'구매/생산부',
40,'인사부',
50,'배송부'
)
from employees;


--2가지 : 테이블조인
select a.department_id, a.department_name from departments a, employees b
where a.department_id = b.department_id
;

--학생성적 테이블
create table sscore (
sno number(4) primary key, --점수에 부여되는 순번
sid varchar2(20),
total number(3) default 0
);

insert into sscore values (
sscore_seq.nextval,'a1',50
);


insert into sscore values (
sscore_seq.nextval,'a2',90
);

insert into sscore values (
sscore_seq.nextval,'a3',80
);

insert into sscore values (
sscore_seq.nextval,'a4',10
);


insert into sscore values (
sscore_seq.nextval,'a5',100
);


insert into sscore values (
sscore_seq.nextval,'a6',70
);

insert into sscore values (
sscore_seq.nextval,'a7',60
);
insert into sscore values (
sscore_seq.nextval,'a8',30
);
insert into sscore values (
sscore_seq.nextval,'a9',20
);

insert into sscore values (
sscore_seq.nextval,'a10',80
);
select * from sscore;

select sno, sid, total, decode(total, 
10,'F',
20,'F',
30,'F',
40,'F',
50,'F',
60,'F',
70,'D',
80,'B',
90,'A',
100,'A'
) as grade from sscore;


--case(구간조건을 설정가능 구간조건에 따른 값을 리턴 할 수 있음.) // decode는 특정값만 설정
select avg from stuscore;

select avg,
case 
when avg >= 90 then 'A'
when avg >= 80 then 'B'
when avg >= 70 then 'C'
when avg >= 60 then 'D'
when avg < 60 then 'F'
end as 학점 
from stuscore;


--월급이 3000 : E등급 4000~5000: D등습 6000~8000 : C등급, 9000~10000미만 :B등급, 10000이상이면 A등급
select salary from employees;

select salary,
case
--when salary < 3000 then 'E'
--when salary >= in(4000,5000) then 'D'
--when salary >= in(6000,8000) then 'C'
--when salary >= in(9000,9999) then 'B'
--when salary >=10000 then 'A'
when salary >= 10000 then 'A'
when salary >= 8001 then  'B'
when salary >= 5001 then  'C'
when salary >= 3000  then  'D'
when salary < 3000 then  'E'
end as 등급
from employees;

alter table emp02
add rank varchar2(10);

update emp02 a
set rank = (
select
case 
when salary >= 10000 then 'A' 
when salary >= 8001 then  'B' 
when salary >= 5001 then  'C' 
when salary >= 3000  then  'D'
when salary < 3000 then  'E'
end as rank2
from emp02 b where a.employee_id = b.employee_id);


select salary, rank from emp02;

select * from emp02;





--사원중에 평균월급 이하로 받는 사원을 출력하시오.
-- select가 2개이상 들어가는 것 : 서브쿼리
select emp_name, salary from employees
where salary < = (select avg(salary) from employees);

select bhit, bhit+100 from fboard;
update fboard
set bhit = bhit+100;

commit;

select bno,bhit from fboard; 
--커밋 이후 복구 fboard 조회수 복구 
select bno,bhit from board;


--계획 : 원본 테이블 board의 조회수 값을 수정된 테이블 조회수에 데이터 덮어씌우기
select a.bhit, b.bhit from fboard a, board b;


--수정코드 : 업데이트 씌우기 사용
update fboard a
set bhit = (
select bhit from board b where a.bno = b.bno
);


-----반복실습
create table fboard as select * from board; --데이터복사 및 생성

select bhit from fboard;
select bhit from board;


select a.bhit, b.bhit from fboard a, board b
where a.bno = b.bno
; --조인



desc member;
-----외래키 실습
create table nboard(
bno number(4) primary key,
id varchar2(20), 
btitle varchar2(1000) not null,
bcontent varchar2(4000),
bdate date,
constraint fk_nboard foreign key(id) references member(id) -- foreign key(외래키) 등록 이름 : fk_nboard
);

select * from nboard;
select * from member;

insert into nboard values(nboard_seq.nextval,'aaa','제목1','내용1',sysdate);
insert into nboard values(nboard_seq.nextval,'bbb','제목2','내용2',sysdate);
insert into nboard values(nboard_seq.nextval,'ccc','제목3','내용3',sysdate); --member 테이블에 ccc라는 id가 없음(select * from member;) 확인
insert into nboard values(nboard_seq.nextval,'ddd','제목4','내용4',sysdate);
insert into nboard values(nboard_seq.nextval,'aaa','제목5','내용5',sysdate);
insert into nboard values(nboard_seq.nextval,'aaa','제목6','내용6',sysdate);
insert into nboard values(nboard_seq.nextval,'aaa','제목7','내용7',sysdate);
insert into member values('eee','2222','김구','010-5555-5555','M','golf,book,cook');
commit;


select * from member;
select * from nboard;

delete member
where id ='ddd';


--외래키로 등록, primary key테이블의 데이터가 삭제되면 외래키에 있는 데이터도 모두 삭제 처리
alter table nboard
add constraint fk_nboard foreign key(id) references member(id)
on delete cascade
;

--primary key 테이블의 데이터가 삭제되면 외래키에 있는 데이터의 id만 null값으로 변경
alter table nboard
add constraint fk_board_id foreign key(id) references member(id)
on delete set null
;



alter table nboard
drop constraint fk_nboard;



delete member
where id ='aaa'
;

select * from nboard;


--실습 커미션 받는 부서명만 출력
select * from  employees;

--1. where 조건문 사용
-- null값을 제외한 row를 검색한 후 그룹함수를 적용해서 출력.
select department_id, count(commission_pct) from employees
where commission_pct is not null
group by department_id;


--2번쨰 방법 : having함수
select * from  employees;
select department_id, count(commission_pct) from employees
group by department_id
having count(commission_pct)!=0; --그룹함수에서 그룹함수의 값의 조건을 처리하려면 having 명령어를 사용함

select department_id, commission_pct from employees;


--부서별로 평균이 전체평균이상의 월급만 출력하시오.
--1.부서별 평균을 출력하시오.
select department_id, avg(salary)  from employees
group by department_id;
--2. 전체 평균을 출력하시오.
select avg(salary) from employees;


select department_id, avg(salary)  from employees
group by department_id
having  avg(salary) > (select avg(salary) from employees)
;


