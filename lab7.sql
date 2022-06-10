DROP TRIGGER count_proc_after_insert;
delimiter //
create trigger count_proc_after_insert
after insert on procedures
for each row
begin
update polyclinic.patient
set countprocedure=countprocedure+1
where patient_id = NEW.Patient_id;
end
//
delimiter ;

DROP TRIGGER IF EXISTS count_proc_after_update;
delimiter //
create trigger count_proc_after_update
after update on procedures
for each row
begin
update polyclinic.patient
set countprocedure=countprocedure-1
where patient_id = OLD.Patient_id;
update polyclinic.patient
set countprocedure=countprocedure+1
where patient_id = NEW.Patient_id;
end
//
delimiter ;

DROP TRIGGER IF EXISTS count_proc_after_delete;
delimiter //
create trigger count_proc_after_delete
after delete on procedures
for each row
begin
update polyclinic.patient
set countprocedure=countprocedure-1
where patient_id = OLD.Patient_id;
end
//
delimiter ;


DROP Trigger IF EXISTS before_delete_patient;
delimiter //
CREATE TRIGGER before_delete_patient
BEFORE DELETE ON polyclinic.patient FOR EACH ROW
BEGIN
DELETE FROM procedures WHERE Patient_id=OLD.patient_id;
END
//
delimiter ;

CREATE TABLE IF NOT EXISTS backup_doctor (
id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
row_id INT(11) UNSIGNED NOT NULL,
Doctor_surname TEXT NOT NULL,
kindOfAction VARCHAR(10)
) ENGINE=MYISAM;

DROP Trigger IF EXISTS update_doctor;
DROP Trigger IF EXISTS delete_doctor;

DELIMITER //
CREATE TRIGGER update_doctor before update ON polyclinic.doctor
FOR EACH ROW BEGIN
INSERT INTO backup_doctor Set row_id = OLD.doctor_id, Doctor_surname =
OLD.Doctor_surname, kindOfAction='изменение';
END;
//

DELIMITER //
CREATE TRIGGER delete_doctor before delete ON polyclinic.doctor
FOR EACH ROW BEGIN
INSERT INTO backup_doctor Set row_id = OLD.doctor_id, Doctor_surname =
OLD.Doctor_surname ,kindOfAction ='удаление';
END;
//

Drop trigger IF EXISTS correct_surname_patient;
delimiter //
create trigger correct_surname_patient 
before insert on patient
for each row
begin
set NEW.patient_name = trim(concat(upper(left(NEW.patient_name,1)), lower(substr(NEW.patient_name FROM 2))));
set NEW.patient_surname = trim(concat(upper(left(NEW. patient_surname,1)), lower(substr(NEW.patient_surname FROM 2))));
set NEW.patient_patronymic = trim(concat(upper(left(NEW. patient_patronymic,1)), lower(substr(NEW.patient_patronymic FROM 2))));
end
//
delimiter ;
