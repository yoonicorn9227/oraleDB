drop table member;

create table member (
id varchar2(20) primary key, --중복입력 안된과 null값입력 안됨.
pw varchar2(20),
name varchar2(20),
phone varchar2(20),
gender varchar2(6),
hobby varchar2(80)
);


insert into member(id,pw,name,phone,gender,hobby) values ( --데이터 값 입력
'aaa','1111','홍길동','010-1111-1111','M','game,golf,run'
);

insert into member values (
'bbb','1111','유관순','010-2222-2222','F','golf,book'
);

insert into member values (
'ccc','1111','이순신','010-3333-3333','M','cook,book'
);

insert into member values (
'ddd','1111','강감찬','010-4444-4444','M','game,run,book'
);


---insert into member values ( -- primary key오인해서 중복값과 null값은 안됨 : 입력시 (error)무결성 제약조건에 위배 
--'','2222','김구','010-5555-5555','M','golf,book,cook'
--);

--delete member where;
commit; --저장

select * from member;

delete member where id='ccc';

select * from member;

update member set phone='010-3333-3333' where id='ddd'; --id가 ddd인 사람의 phone번호 수정

select * from member;

commit;

select * from tab; --내가가지고 있는 테이블 모두보기.

desc member; --
desc employees; --employees 테이블의 칼럼과 칼럼타입 확인.


select create_date from employees;

select * from member;


select id,name from member; --MEMBER테이블에서 id랑 name칼럼만 보고 싶음

select * from employees;

select emp_name, employee_id, salary*1342*12, commission_pct from employees order by salary desc; --asc : 낮은순 desc : 높은순

desc employees;

select  hire_date,sysdate from employees;










