use employees;
create table Teachers(
Id int primary key,
Name varchar(50),
Subject varchar(100),
Experience decimal(3,1),
Salary INT);

drop table teachers;

insert into Teachers (Id,Name,subject,Experience,Salary)
values
(1, 'Manju','Science',10,'500000'),
(2,'Rekha','Chemistry',12,700000),
(3,'Nikhil','English',10,'500000'),
(4,'Paul','Hindi',6,'50000'),
(5,'Ritu','Maths',9,80000),
(6,'Sindhu','Social studies',7,60000),
(7,'Meera','IT',9,'400000'),
(8,'Akhil','Malayalam',15,'600000');

select * from Teachers;


delimiter ##
create trigger before_insert_teacher
before insert on Teachers
for each row
begin
	if new.salary<0 then 
    signal sqlstate '45000' set message_text='salary cannot be negative';
    end if;
end ##
delimiter ;

insert into Teachers (Id,Name,subject,Experience,Salary)
values
(10, 'Anju','Hindi',5,'468000');



create table teacher_log (
	Log_Id int Auto_increment primary key,
	teacher_id int ,
    action varchar(25),
    timestamp timestamp default current_timestamp   
)

delimiter ##
create trigger after_insert_teacher
after insert on Teachers
for each row
begin 
       insert into teacher_log(teacher_id,action,timestamp) values (new.id,'Joined',now());
end ##
delimiter ;


select * from teacher_log;


delimiter ##
create trigger before_delete_trigger
before delete on Teachers
for each row
begin 
  if old.Experience>10 then
	signal sqlstate '45000' 
	set message_text='Cannot delete teachers with more than 10 years of experience';
	end if;
end ##
delimiter ;

delete from Teachers where Id=2


delimiter ##
create trigger after_delete
after delete on Teachers
for each row
begin 
       insert into teacher_log(teacher_id,action,timestamp) values (old.id,'resigned',now());
end ##
delimiter ;
delete from Teachers where Id=4

	






		