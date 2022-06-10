 select p.patient_id,
p.patient_surname 
from procedure_ pr
 join patient p
on pr.Patient_patient_id=p.patient_id 
 join type_procedure tp
on pr.type_procedure_type_procedure_id=tp.type_procedure_id 
where tp.procedure_name like "%Лазер%"


select tp.type_procedure_id,
tp.procedure_name from procedure_ pr
  right join type_procedure tp
on pr.type_procedure_type_procedure_id=tp.type_procedure_id 
where pr.type_procedure_type_procedure_id is null 
and tp.procedure_flag=1;
