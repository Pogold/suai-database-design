select distinct
tp.type_procedure_id,tp.procedure_name from procedures pr
join patient p
on pr.patient_id=p.patient_id
join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
where p.patient_surname="Иванов" and p.patient_name="Иван" and p.patient_patronymic="Иванович" and tp.procedure_cost <= ALL ( select  tp.procedure_cost from procedures pr
 join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
 join patient p
on pr.patient_id=p.patient_id
 where p.patient_surname="Иванов" and p.patient_name="Иван" and p.patient_patronymic="Иванович");



select distinct
tp.type_procedure_id,tp.procedure_name from procedures pr
join patient p
on pr.patient_id=p.patient_id
join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
where p.patient_surname="Иванов" and p.patient_name="Иван" and p.patient_patronymic="Иванович"  and tp.procedure_cost = ( select  min(tp.procedure_cost) from procedures pr
 join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
 join patient p
on pr.patient_id=p.patient_id
 where p.patient_surname="Иванов" and p.patient_name="Иван" and p.patient_patronymic="Иванович");




select  p.patient_id,p.patient_surname from procedures pr
join patient p
on pr.patient_id=p.patient_id
join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
where tp.procedure_flag=1
group by pr.patient_id,p.patient_surname
having count(pr.procedure_id)=(select max(q.cnt) from
(select count(pr.procedure_id) as cnt 
from procedures pr 
join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
where tp.procedure_flag=1 group by patient_id) q );



select  d.doctor_id,d.doctor_surname
from doctor d
where not exists
(select * from type_procedure tp  where tp.procedure_name like "%графия%" and not exists 
(select * from procedures pr2
where pr2.Doctor_id=d.doctor_id and
pr2.Type_procedure_id=tp.type_procedure_id));


select distinct  d.doctor_id, d.doctor_surname from procedures pr
join doctor d
on pr.doctor_id=d.doctor_id
join patient p
on pr.patient_id=p.patient_id
join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
where  p.patient_surname ="Иванов" and p.patient_name="Иван" and p.patient_patronymic="Иванович"  and tp.procedure_flag =1
and pr.doctor_id not in (select  pr.doctor_id from procedures pr
join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
join patient p
on pr.patient_id=p.patient_id where
tp.procedure_flag = 0 and  p.patient_surname ="Иванов" and p.patient_name="Иван" and p.patient_patronymic="Иванович");


select distinct  d.doctor_id, d.doctor_surname from procedures pr
join doctor d
on pr.doctor_id=d.doctor_id
join patient p
on pr.patient_id=p.patient_id
join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
where  p.patient_surname ="Иванов" and p.patient_name="Иван" and p.patient_patronymic="Иванович"  and tp.procedure_flag =1
except (select  pr.doctor_id, d.doctor_surname  from procedures pr
join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
join patient p
on pr.patient_id=p.patient_id where
tp.procedure_flag = 0 and  p.patient_surname ="Иванов" and p.patient_name="Иван" and p.patient_patronymic="Иванович");



select distinct  d.doctor_id,d.doctor_surname from procedures pr
join doctor d
on pr.doctor_id=d.doctor_id
join patient p
on pr.patient_id=p.patient_id
join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
left join (select  pr.doctor_id from procedures pr
join type_procedure tp
on pr.type_procedure_id=tp.type_procedure_id
join patient p
on pr.patient_id=p.patient_id where
tp.procedure_flag = 0 and  p.patient_surname ="Иванов" and p.patient_name="Иван" and p.patient_patronymic="Иванович") q on pr.doctor_id=q.doctor_id
where  p.patient_surname ="Иванов" and p.patient_name="Иван" and p.patient_patronymic="Иванович"
 and tp.procedure_flag =1  and q.doctor_id is  null  ;
