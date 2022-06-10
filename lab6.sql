delimiter //
create procedure ins_proc (d_name varchar(50),d_surname varchar (50),d_patronymic varchar(50),
p_name varchar(50),p_surname varchar (50),p_patronymic varchar(50),tp_name varchar (50),tp_cost int,tp_fl int, pr_data date)
BEGIN
declare id_p_new int;
declare id_d_new int;
declare id_tp_new int;
if exists(select * from patient p where p.patient_name=p_name and p.patient_surname=p_surname and p.patient_patronymic=p_patronymic )
  then select patient_id into id_p_new from patient p
  where p.patient_name=p_name and p.patient_surname=p_surname and p.patient_patronymic=p_patronymic;
  else begin 
  insert into patient(patient_name,patient_surname,patient_patronymic) values(p_name,p_surname,p_patronymic);
  set id_p_new= (last_insert_id());
  end;
end if;
if exists(select * from doctor d where d.doctor_name=d_name and d.doctor_surname=d_surname and d.doctor_patronymic=d_patronymic )
 then select doctor_id into id_d_new from doctor d
 where d.doctor_name=d_name and d.doctor_surname=d_surname and d.doctor_patronymic=d_patronymic;
 else begin 
 insert into doctor(doctor_name,doctor_surname,doctor_patronymic) values(d_name,d_surname,d_patronymic);
 set id_d_new=(last_insert_id());
 end;
end if;
if exists(select * from type_procedure tp where tp.procedure_name=tp_name and tp.procedure_cost=tp_cost and tp.procedure_flag=tp_fl )
 then select type_procedure_id into id_tp_new from type_procedure tp
 where tp.procedure_name=tp_name and tp.procedure_cost=tp_cost and tp.procedure_flag=tp_fl;
 else begin 
 insert into type_procedure(procedure_name,procedure_cost,procedure_flag) values(tp_name,tp_cost,tp_fl);
 set id_tp_new= (last_insert_id());
 end;
end if;
insert into procedures(patient_id,doctor_id,type_procedure_id,procedure_data) values(id_p_new,id_d_new,id_tp_new,pr_data);
END; //
delimiter;


call  ins_proc('Доктор','Докторов','Докторович','Пациент','Пациентов','Пациентович','Анализ крови',300,1,'2021.12.01');

drop procedure del_proc;
delimiter //
create procedure del_proc (id_proc int)
BEGIN
declare id_tp int;

select p.Type_procedure_id into id_tp from procedures p where p.procedure_id=id_proc; 
delete from procedures p where p.procedure_id=id_proc; 

if not exists (select * from procedures p where p.Type_procedure_id=id_tp ) 
then delete from type_procedure tp where tp.type_procedure_id=id_tp; 
end if;
END; //
delimiter;

call del_proc(77);


delimiter //
create procedure del_pat (id_p int)
BEGIN
delete from procedures p where p.patient_id=id_p; 
delete from patient p where p.patient_id=id_p;
END; //
delimiter;
Вызов процедуры:
call del_pat(36);


delimiter //
create procedure count_doc (out cnt_doc int)
BEGIN
select ifnull(count(d.doctor_id),0) into cnt_doc from doctor d;
END; //
delimiter;


call count_doc (@cnt_doc );
select @cnt_doc;


delimiter //
create procedure cas_statistics ()
BEGIN
create temporary table if not exists cas_stat
(
id_stat int auto_increment primary key,
id_tp int,
nm_tp varchar(50),
count_pr int,
sum_tp int);

insert into cas_stat(id_tp,nm_tp,count_pr,sum_tp)
select  tp.type_procedure_id id_tp , 
tp.procedure_name  nm_tp , 
count(pr.procedure_id) count_pr,
sum(tp.procedure_cost ) sum_tp 
from type_procedure tp 
left join procedures pr  on tp.type_procedure_id=pr.type_procedure_id  
group by tp.type_procedure_id , tp.procedure_name;

select * from cas_stat;
drop table cas_stat;
END; //

call cas_statistics;