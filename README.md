# -SQL-Trigger-Automation
SQL triggers for enforcing salary validation, preventing deletion of experienced teachers, and logging insert/delete actions in a teacher database.

This repository contains SQL scripts demonstrating the use of triggers in a database. It includes the creation of a teachers table, along with BEFORE INSERT, AFTER INSERT, BEFORE DELETE, and AFTER DELETE triggers to enforce business rules (e.g., preventing negative salaries or deleting experienced teachers) and log actions in a teacher_log table.

1.  Create a table named teachers with fields id, name, subject, experience and salary and insert 8 rows.
   create table Teachers(
   Id int primary key,
   Name varchar(50),
   Subject varchar(100),
   Experience decimal(3,1),
   Salary INT);

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


  2. Create a before insert trigger named before_insert_teacher that will raise an error “salary cannot be negative” if the salary inserted to the table is less than zero.

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

3. Create an after insert trigger named after_insert_teacher that inserts a row with teacher_id,action, timestamp to a table called teacher_log when a new entry gets 
   inserted to the teacher table. tecaher_id -> column of teacher table, action -> the trigger action, timestamp -> time at which the new row has got inserted.

   create table teacher_log

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


4. Create a before delete trigger that will raise an error when you try to delete a row that has experience greater than 10 years.
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

5. Create an after delete trigger that will insert a row to teacher_log table when that row is deleted from teacher table.

    delimiter ##
    create trigger after_delete
    after delete on Teachers
    for each row
    begin 
           insert into teacher_log(teacher_id,action,timestamp) values (old.id,'resigned',now());
    end ##
    delimiter ;

    

    

    
       
