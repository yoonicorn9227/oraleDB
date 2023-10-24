select * from departments;

select * from departments order by manager_id asc;

--employees ���̺��� employees_id

select * from employees order by employee_id asc;


--���ǹ� where
select * from employees where employee_id>=200;

select * from employees
where employee_id>=190 and employee_id<=205;


--salary 5000�̻��� ����� �˻��Ͻÿ�.
select * from employees 
where salary >=5000 order by salary asc; -- salary 5000��� ������������ ����.

--��� ,�̸�, ����, �μ�, ���� ������ ���.
select employee_id,emp_name,job_id,department_id,salary from employees;

--���̺��� ������ ����
create table emp2 as select * from employees;

select * from emp2;

--�÷� Ÿ�Ժ���
desc emp2;


--�÷� �̸� ����
alter table emp2 rename column emp_name to e_name; 

--�÷� ������ Ÿ�� ���� ����
-- email �ȿ� �����Ͱ� ���ڰ� �ƴϸ� ������ �ȵ�. [ alter table emp2 modify email number(50);] ��� �����߻�
alter table emp2 modify email varchar2(50); --varchar2(5)���� ����� �ȿ��ִ� �����Ͱ� 5�̻� �Ǵ� �����Ͱ� �־ ����Ұ� (�����߻�)


-- �÷� ����
alter table emp2 drop column creat_date;

--�÷��߰�
alter table emp2 add  create_date date;

--�÷���������
alter table emp2 modify update_date invisible;
alter table emp2 modify update_date visible;
select * from emp2;


--�÷��� ������ ����
insert into emp2 select * from employees;


--Quiz ����̸�, �޿�, �Ի��� emp2 ���̺��� ����̸� �������� ����.
select emp_name,salary,hire_date from emp2 
order by emp_name asc;

--�̸� �޿� �Ի��� ���

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

--������

select emp_name +'a' from employees; --(����) ���ڰ� �ƴϱ� ������ ����Ұ�
--��Ī����, as ������ ������
select salary,salary*12 as y_salary,salary*12*1342 as k_salary from employees; --salary�� �����̱� ������ ���갡�� //  as ������ : �������� Ŀ�����Ҽ� ����

select * from employees;

--���� [nvl(����,0) : null�ΰ�� 0���� ǥ��]
select salary, salary*12,nvl(commission_pct,0) from employees;

select 
salary, 
salary*12 as "����", --�ֵ���ǥ[""] : �ֵ���ǥ �ȿ� �ִ� ���� �״�� ���(���̶��� ��ҹ��� ��� ��������)
(salary*12)*nvl(commission_pct,0) as "�μ�Ƽ��",
(salary*12)+(salary*12)*nvl(commission_pct,0) as "��������" from employees; --nvl(������,0) : ���ڰ� null���̸� 0���� ǥ���ض�

--null�� 0���� ǥ�� : nvl(������,0)
select nvl(manager_id,0) from employees;


--���, ����,����,Ŀ�̼�,����,����+Ŀ�̼��� ����Ͻÿ�.

select  employee_id,
salary,
job_id,
nvl(commission_pct,0) as "Ŀ�̼�",
(salary*12) as "����",
(salary*12)+(salary*12)*nvl(commission_pct,0) as c_salary from employees;


--������ 6000�� ��� �˻�
select * from employees where salary=6000;

--Ŀ�̼��� ���� ����� ����Ͻÿ�. null�� is null
select * from employees where commission_pct is null; --[select * from employees where commission_pct = null;] -> ���Ұ�
select * from employees where commission_pct is  not null; --��񱳺�ȣ(=)�� ��� �ȵ�.


select * from departments;

select * from employees;

--�ǽ� �μ���ȣ �μ����� ����Ͻÿ�.
select department_id as "�μ���ȣ",department_name "�μ���" from departments  
where department_id>=10 and department_id<=40;


select emp_name+"is a" from employees; --����

--����Ÿ���� �ٿ��� ��� [ || ]
select emp_name ||'is a'|| job_id from employees; -- [select concat(concat(emp_name,'is a'),job_id) from employees;]�� ����
select concat(emp_name,job_id) con_name from employees;

select * from stuscore;
select kor,eng,math,kor+eng+math,(kor+eng+math)/3 from stuscore;

select distinct department_id  from employees 
order by department_id asc ;


--quiz JOB_ID �ߺ����� ��� [distinct]
select distinct job_id 
from employees
order by job_id asc; 

--������ 3000,5000,6000�� ��� ���
select *
from employees
where salary=3000 or salary=6000 or salary=7000
order by salary asc;

select*
from employees
where salary>=3000 and salary<10000
order by salary asc;

--������ 5000������ ����� �� +1000 ������ �λ��ؼ� ����Ͻÿ�
select 
salary,salary+1000 as "�����λ�", (salary+1000)*1342 "��ȭ" 
from employees
where salary<=5000;


--�μ���ȣ�� 10, 30, 50���� �����ȣ, �μ���ȣ, ����, ����,�Ի����� ����Ͻÿ�.
select *from employees;

--QUIZ �μ���ȣ�� 10, 20, 30�� ����� �����ȣ, �μ���ȣ, ����, ����, �Ի����� ����Ͻÿ�.
select 
employee_id,department_id,job_id,salary,hire_date --������ ������ (����������)
from employees -- ������ ������ ���̺�
where department_id=10 or department_id=30 or department_id=50 --����
order by employee_id asc, department_id asc; --�������� ����

--QUIZ ������ 4000�̻� 8000���� �����ȣ, ����̸�,�޿�,�μ���ȣ ����Ͻÿ�.
--�߰�QUIZ �Ի����� 2003/09/01 ���� �̸鼭 �������ǿ� �����ϴ� ��������� ��� ����Ͻÿ� 
select 
employee_id, emp_name,salary,hire_date,hire_date+100,department_id
from employees
where salary>=4000 and salary<=8000  and hire_date>'03/09/01'
order  by salary asc;

commit;