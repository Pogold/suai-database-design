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
    (procedure_name,procedure_cost,procedure_equipment)
VALUES
('Электрокардиография' , 1500, ('Электрокардиограф','19.08.15', 50000)),
('Гастроскопия' , 2500, ('Эндоскоп','21.10.10', 80000)),
('Флюорография' , 1400, ('Аппарат флюорографический','16.08.13', 85000)),
('Лазерная терапия' , 1600, ('Лазер','19.08.15', 75000)),
('ОФЭКТ' , 3500,('Томограф','19.08.15', 95000));

INSERT INTO shedule
    (day_id,day_name,sg_flag)
VALUES
(0,'Воскресенье', 1),
(1,'Понедельник', 0),
(2,'Вторник' ,  0),
(3,'Среда' , 0),
(4,'Четверг' ,  0),
(5,'Пятница' , 1),
(6,'Суббота' , 1);

INSERT INTO visit
    (visit_date,patient_id,doctor_id,day_id)
VALUES
('06.02.17',6 , 6, 0),
('13.04.19',5, 5, 1);


INSERT INTO procedur
    (visit_date,patient_id,doctor_id,day_id,Type_procedure_id)
VALUES
('01.01.22',1 , 2, 2,1),
('02.11.21',3 , 3, 3,2);


INSERT INTO reception
    (visit_date,patient_id,doctor_id,day_id,type_recept)
VALUES
('08.01.22',5 , 4, 5,'Консультация'),
('04.11.21',6 , 2, 6,'Первичный прием');


SELECT * FROM ONLY visit WHERE visit_date='06.02.17';
SELECT * FROM procedur WHERE visit_date='02.11.21';
SELECT * FROM reception WHERE visit_date='04.11.21';
SELECT * FROM  visit WHERE visit_date='01.01.22';


DROP FUNCTION find_doctor_use_eq(VARCHAR,VARCHAR);
CREATE OR REPLACE FUNCTION find_doctor_use_eq(VARCHAR,VARCHAR) RETURNS SETOF RECORD AS
$$
    SELECT count(procedur.visit_id) FROM
        procedur join type_procedure on procedur.Type_procedure_id=type_procedure.type_procedure_id 
		join doctor on procedur.Doctor_id=doctor.doctor_id
		WHERE (doctor.doctor_surname=$1) and ((type_procedure.procedure_equipment).eq_name=$2);
$$
    IMMUTABLE
    LANGUAGE sql;

select * from find_doctor_use_eq('Иванова','Электрокардиограф') as (counter varchar(20));

DROP OPERATOR ! (VARCHAR,VARCHAR);

CREATE OPERATOR !(
	LEFTARG  = VARCHAR,
    RIGHTARG  = VARCHAR,
    function = find_doctor_use_eq,
    commutator = !
    );
	
SELECT  'Иванова'!'Электрокардиограф' as counter ;

Агрегатная функция:
DROP FUNCTION  min_cost_eq_pr;
DROP AGGREGATE min(equip);

CREATE OR REPLACE FUNCTION min_cost_eq_pr(equip,equip) RETURNS equip AS
$$
BEGIN
    IF $1 IS NULL
    THEN RETURN $2;
    ELSEIF $2 IS NULL
    THEN RETURN $1;
    ELSEIF $1.eq_price IS NULL
    THEN RETURN $2;
    ELSEIF $2.eq_price IS NULL
    THEN RETURN $1;
    ELSEIF ($1.eq_price < $2.eq_price)
    THEN RETURN $1;
    ELSE RETURN $2;
END IF;
END;
$$
    IMMUTABLE
    LANGUAGE plpgsql;


CREATE AGGREGATE min(equip)
(
    sfunc = min_cost_eq_pr,
    stype = equip
);


SELECT * FROM type_procedure;
SELECT  min(procedure_equipment) FROM type_procedure;
