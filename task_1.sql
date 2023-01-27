drop table if exists employees;
drop table if exists departments;
create table departments
(
    id        serial primary key,
    parent_id integer references departments (id) on delete set null,
    name      character varying
);


create table employees
(
    id            serial primary key,
    name          character varying,
    department_id integer references departments (id) on delete set null
);




insert into departments(id, parent_id, name) values
  (1, null, 'it departament'),
  (2, 1, 'support'),
  (3, 2, 'call senter'),
  (4, 2, 'first line'),
  (5, 2, 'second line'),
  (6, 5, 'managment'),
  (7, 5, 'tech support'),
  (8, 1, 'programmist'),
  (9, 8, 'front'),
  (10, 8, 'back');
  
 
insert into employees(id, name, department_id) values 
  (1, 'Ivan', 1),
  (2, 'Max', 2),
  (3, 'Kate', 3),
  (4,  'Alex', 4),
  (5, 'Mike', 5),
  (6, 'Nik', 6),
  (7, 'Vik', 7),
  (8, 'Roma', 8),
  (9, 'Andrey', 9),
  (10, 'Sveta', 10);
  

with recursive available_departaments as (
	
   select
  	employees.id as id,
  	employees.name as employees_name,
  	departments.name as departments_name,
  	departments.id as parent_id 
   from employees
      join departments
          on departments.id = employees.department_id

   union

   select 
   	available_departaments.id,
   	available_departaments.employees_name as employees_name,
   	departments.name as departments_name, 
   	departments.id as parent_id
   from departments
      join available_departaments
          on available_departaments.parent_id = departments.parent_id
          
)

select
 employees_name,
 array_agg(parent_id) as available_departaments_id,
 array_agg(departments_name) as available_departaments_id
from available_departaments GROUP BY employees_name;


 