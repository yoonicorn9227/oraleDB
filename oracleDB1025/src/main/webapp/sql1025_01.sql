select * from employees;

select salary,salary+100,salary-100 from employees;

select sysdate,sysdate+365 from dual; --dual �ӽô������̺�

select 1+3 from dual;

select 1+'3' from dual; --���� 3�� ��Ģ������ �ϸ� ���ڷ� �ڵ���ȯ
-- select 1+'a' from dual; -- (����!) ���ڴ� ��Ģ���� ����
select 'a'+'b' from dual; -- (����!) ���ڴ� ��Ģ���� ���� �ذ����� ['a'||'b'] or [concat]
select 'a'||'b' from dual;
select concat('a','b') from dual;

select * from employees;
--[Quiz] emp_name(email) Į������ ����Ͻÿ�.
--Donald OConnell(DOCONNEL)
select emp_name||'('||email||')' u_nickId from employees;
select concat(emp_name,concat('(',concat(email,')'))) from employees;

-- 00/01/01 ���� �Ի��� ����� ����Ͻÿ�.
--00/01/24, 00-01-01, 2000-01-01 3����� ����������.
select employee_id,emp_name,hire_date from employees --���̺� �ڸ����� Į���� ���ü� ����(��������).
where hire_date>='2000-01-01' --���ǽĿ��� select�� ���ü� ����.
order by hire_date asc
;


--������ �� ����
select count(*) from employees;

--������ ���帹�� �޴� ��� ����̸� (��������)
select max(salary) from employees;

select * from employees
where salary = 24000
;
--(��������) ������ ���帹�� �޴� ����̸�
select * from employees
where salary=(select max(salary) from employees); 


--Ŀ�̼� �ִ�(is not null) ��� ����(is null) ���
select * from employees
where commission_pct is null;


--�μ���ȣ�� 80�� �̻��� ��� ���
select * from employees
where department_id>=80
order by department_id asc;

--�μ���ȣ 80�� �����ϰ� ����Ͻÿ�.
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

--�μ���ȣ�� 50�� �̸鼭 ������ 6000�޷� �̻��� ��� ����Ͻÿ�
select * from employees
where department_id=50 and salary>=6000;

-- ������ 2000�ʰ��̸鼭 3000�̸��λ��
select * from employees 
where salary>2000 and salary<3000
order by salary asc
;

select * from employees 
where salary not between 2000 and 3000
order by salary asc
;


--between A and B (A�� B���� ��� ����) = (A=<X<=B)
select * from employees 
where salary between 2000 and 3000
order by salary asc
;

--�׷��Լ� : avg, count, max, min ���
select avg(salary) from employees;

--��տ��޺��� ���� �޴� ��� (��������)
select * from employees
where salary <=(select avg(salary) from employees)
order by salary desc
;

--�ǽ�) ������ 3000, 4000, 6000�� ������
select * from employees
where salary =3000 or salary=4000 or salary=6000
;

select * from employees 
where salary in(3000,4000,5000)
;

--�ǽ�)�����ȣ 101 151 200�� ����� �����ȣ�� ������ ����Ͻÿ�.
--where in
select employee_id, salary from employees 
where employee_id in(101,151,200)
;
--where or
select employee_id, salary from employees 
where employee_id =101 or employee_id=151 or employee_id=200
;

-- ������ 2000�̸�, 3000�̸��� ����� ����Ͻÿ�.
select * from employees
where salary<2000 or salary>3000
;

select * from employees 
where salary not between 2000 and 3000
;

--�Ի����� 00/01/01 ~ 00/12/31 ����� ����Ͻÿ�.
select * from employees
where hire_date between '00/01/01' and '00/12/31'
;

select * from employees 
where hire_date >= '00/01/01' and hire_date<='00/12/31'
;

--������ ���ϵ� ī��

select emp_name from employees;
-- �빮�� S�� ���۵Ǵ� �̸��� ����Ͻÿ�. [like '(����)%']
select emp_name from employees
where emp_name like 'S%'
;l

--�ҹ��� n�� ������ �̸��� ����Ͻÿ�. [like '%(����)']
select emp_name from employees
where emp_name like '%n'
;

-- ó��, �� , �߰� e�� �ִ� �̸��� ����Ͻÿ�. [like '%(����)%']
select emp_name from employees
where emp_name like '%e%'
;



--bcontent �÷��� 'faucibus' �ܾ �� �ִ� �Խñ��� ����Ͻÿ�.
select * from board;

select * from board
where bcontent like '%faucibus%'
;

--bcontent �÷��� 'ven' �ܾ �� �ִ� �Խñ��� ����Ͻÿ�.
--btitle �÷��� 'ven' �ܾ ���ִ� ���� : 15��
select * from board
where btitle like '%ven%'
;

--btitle �Ǵ� bcontent �÷��� 'ven' �ܾ ���ִ� �Խñ��� ����Ͻÿ�.  :270��
select * from board
where btitle like '%ven%' or bcontent like '%ven%'
;

--bcontent���� �ҹ��� n���� �����ϸ鼭 4���� ���ڴܾ �ִ� �Խñ��� ����Ͻÿ�.
--ex)nibh(�ش� O ) , naabb quisque(�ش�x)
--n____%(n _ _ _ %)
select bcontent from board
where bcontent like '%n____%' -- [%n_ _ _ _%]         [%n_ _ _] : n���� �����ϴ� 4����
;

select emp_name from employees;
select emp_name from employees
where emp_name like 'P__ %';



select emp_name from employees
where emp_name like 'D%'; -- �빮�� D�� �����ϴ� �̸�


select emp_name from employees
where emp_name like '%a%' --�ҹ��� a�� �߰��� ���ִ� �̸�
;

select emp_name from employees
where emp_name like '%d' --�ҹ��� d�� �ڿ� ���ִ� �̸�
;

--2��° ���ڰ� a�� ��� �̸��� ����Ͻÿ�.
select * from employees
where emp_name like '_a%'
;


--����
--������ ������(asc)���� ����Ͻÿ�
select emp_name, salary from employees
order by salary asc
;


select * from employees;

select employee_id,emp_name,job_id,hire_date from employees
order by hire_date desc
;


--����� ��������
select employee_id,emp_name,job_id,hire_date from employees
order by emp_name desc
;


--�μ���ȣ �������� �̸��� ��������
--�����ȣ, �����, �μ���ȣ, ����. �Ի���, ���޸� ����

select employee_id,emp_name,department_id,job_id,hire_date,salary from employees
order by department_id asc, emp_name desc
;


--�������� ��������(asc) , �Ի��� ��������(desc)
select employee_id,emp_name,department_id,job_id,hire_date,salary from employees
order by salary asc, hire_date desc
;


--�����Լ�(�ֿ��Լ�)
--abs : ���밪
select -10, abs(-10) as "���밪" from dual;

--floor : ����
select 10.54578, floor(10.54578) from dual;

--trunc(��, ������ħ) : Ư���ڸ� ����
select 10.54578, trunc(10.54578,2) from dual;

--round : Ư���ڸ� �ݿø�
select 10.54578, round(10.54578), round(10.54578,3) from dual;


select * from stuscore;
select stunum,name,math, eng, kor+eng,round((kor+math)/2) "�ݿø�" from stuscore;

--�ǽ�)������ ��ȭ�� ȯ��(1342.32\) �ؼ� �Ҽ��� 2�ڸ� �ݿø� ����Ͻÿ�.
--��� ����� ���� ����ȯ�� ����ȯ�� 3�ڸ� �ݿø�

select * from employees;
select employee_id"�����ȣ",emp_name"�����",salary"����",(salary*1342.32)"���� ȯ��",round(salary*1342.32,2)"���� �ݿø�" from employees;

--�ǽ�)�Ի����� ���糯¥���� �ɸ� ���ڸ� ����Ͻÿ�
--�Ҽ��� 3�ڸ����� �ݿø�
select round(sysdate-hire_date,2) "�ٷαⰣ" from employees
;


--�Ի��Ͽ��� ���糯¥���� �ɸ� ���ڸ� ����Ͻÿ�.
--�Ҽ��� �ڸ��� �ݿø�, ���� ������ ȯ���Ͻÿ�.
select emp_name,floor((round(sysdate-hire_date,1))/365) sdate from employees
order by sdate asc
;


select * from member;
select * from employees;

-- MOD : ������ �Լ�
select mod(27,2), mod(27,5), mod(27,7) from dual;


--����� Ȧ�� �� ����� ����Ͻÿ�.(��������)
select * from employees
where mod(employee_id,2)=1
order by employee_id asc
;

--������ ��ȣ�� ¦���� ����� ����Ͻÿ�.
-- ���,�����, �Ի���, ����, ������ ��ȣ, �μ���ȣ
select employee_id,emp_name,hire_date,salary,manager_id,department_id from employees
where mod(manager_id,2)=0
order by employee_id asc
;

select * from board;


-- ��� ��ȸ�� �Ҽ��� ��°�ڸ����� �ݿø�
select round(avg(bhit),1) from board;

--��� ��ȸ�� �Ҽ��� ����
select trunc(avg(bhit)) from board;

-- ��պ��� ���� ��ȸ���� ���� �Խñ� ���
select * from board
where bhit >= (select avg(bhit) from board)
;

select * from employees
where salary >= (select avg(salary) from board);


select to_char(salary,'999,999'),to_char(round(salary*1342.32),'999,999,999') "����ȯ��" from employees; --to_char(�÷���, '000,000') �����ڸ��� ���� ��ǥ

--[������(��ȣ)]
--������� �����
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
board_seq.nextval,'�����Դϴ�.','�����Դϴ�.',sysdate,'aaa',board_seq.currval,0,0,1,'1.jpg' 
); --�������� ���۹�ȣ�� �޾ƿͶ�(��������.nextval) board_seq.currval(�����ȣ�� ���Ͷ�)

commit;

select board_seq.currval from dual;
select board_seq.nextval from dual; --nextval �����ȣ���� ������ ��ȣ�� �����Ͷ�


select member_seq.nextval from dual;


--Quiz dept_seq ����10 ����10
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

--total�� �������� ���������ؼ� ����� ���
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
--���̺� ����
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


--1. emp2 ���̺��� �����ȣ�� employees �����ȣ �Ȱ��� ��ġ ��Ű��
--2.emp2 ���̺��� ������ ��ȣ�� employees ������ ��ȣ�� �˻���.
--3. employess �����ڹ�ȣ�� emp2�� ������ ��ȣ�� �Է½�Ŵ
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




--emp01 ���̺� ����
create table emp01 (
empno number(4) primary key,
ename varchar2(10),
hiredate date
);

--emp01 ���̺� ����
drop table emp01;

--emp01 ���̺� ������ �� �Է�
insert into emp01 values (emp_seq.nextval,'ȫ�浿',sysdate);
insert into emp01 values (emp_seq.nextval,'������',sysdate);
insert into emp01 values (emp_seq.nextval,'�̼���',sysdate);
insert into emp01 values (emp_seq.nextval,'ȫ����', sysdate);
insert into emp01 values (emp_seq.nextval,'ȫ���',sysdate);

commit;
select * from emp01;

select emp_seq.currval from dual;

select employee_id, emp_name,job_id,hire_date from employees
order by hire_date desc;

