insert  doctor  set doctor_name="Артем",doctor_surname="Ермаков",
doctor_patronymic="Вадимович",doctor_phone="+79879336854";

insert  doctor  set doctor_name="Екатерина",doctor_surname="Гришко",
doctor_patronymic="Сергеевна",doctor_phone="+79879336854";


UPDATE polyclinic.patient SET patient_name='Мария' WHERE patient_id=2;
UPDATE polyclinic.doctor SET doctor_phone='+79635602120' WHERE doctor_surname='Ермаков';

delete from type_procedure where  procedure_cost >2000;
delete from doctor  where  doctor_name='Екатерина';


MERGE INTO Patient AS target 
USING New_patient AS source
ON target.patient_id = source.patient_id 
WHEN NOT MATCHED THEN INSERT ( source.patient_id, source.patient_name, source.patient_surname, source.patient_patronymic, source.patient_phone)
WHEN  MATCHED THEN UPDATE SET
 target.patient_name = source.patient_name,
 target.patient_surname =source.patient_surname, 
target.patient_patronymic =source.patient_patronymic, 
target.patient_phone =source.patient_phone


INSERT INTO doctor
    (doctor_name,doctor_surname,doctor_patronymic,doctor_phone)
VALUES
('Артем', 'Ермаков', 'Вадимович','+79879336854'),
('Ирина' , 'Иванова', 'Валерьевна','+74567854674'),
('Екатерина' , 'Гришко', 'Сергеевна','+79879336854'),
('Ирина' , 'Николаева', 'Валерьевна','+75685241245'),
('Алики' , 'Анастасидис', 'Якимовна','+79875468985'),
('Екатерина' , 'Белоусова', 'Алексеевна','+73249658748');

INSERT INTO patient
    (patient_name,patient_surname,patient_patronymic,patient_phone)
VALUES
('Иван' , 'Иванов', 'Иванович','+74443332211'),
('Екатерина' , 'Павлова', 'Леонидовна','+79875787878'),
('Олег' , 'Нечипоренко', 'Андреевич','+78005355555'),
('Степан' , 'Насимов', 'Антонович','+71478883423'),
('Ольга' , 'Добренькая', 'Сергеевна','+73240058748'),
('Алена' , 'Серпова', 'Алексеевна','+73240059708');

INSERT INTO type_procedure
    (procedure_name,procedure_cost,procedure_equipment,procedure_flag)
VALUES
('Электрокардиография' , 1500, 'Электрокардиограф',1),
('Гастроскопия' , 2500, 'Эндоскоп',1),
('Флюорография' , 1400, 'Аппарат флюорографический',1),
('Лазерная терапия' , 1600, 'Лазер',1),
('Первичный прием' , 1200, '',0),
('Вторичный прием' , 1000, '',0),
('ОФЭКТ' , 3500, 'Томограф', '',1);

INSERT INTO procedures
    (Patient_id,Doctor_id,Type_procedure_id,procedure_data)
VALUES
(1 , 2, 3,'21.10.20'),
(4 , 3, 4,'21.09.23'),
(3 , 1, 1,'21.08.12'),
(3 , 1, 5,'21.07.10'),
(1 , 4, 7,'21.06.22'),
(5 , 6, 7,'21.05.17'),
(2 , 5, 3,'21.04.19');
(1 , 2, 3,'21.10.14');
(1 , 2, 1,'21.10.14');
