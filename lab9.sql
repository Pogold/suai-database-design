CREATE TYPE public.recept AS ENUM
    ('Первичный прием', 'Вторичный прием', 'Консультация');

  CREATE TYPE equip AS (
    eq_name           VARCHAR(50),
    eq_date_prod     date,
    eq_price         numeric
);


CREATE TABLE Patient (
  patient_id SERIAL NOT NULL ,
  patient_name VARCHAR(50) NOT NULL,
  patient_surname VARCHAR(50) NOT NULL,
  patient_patronymic VARCHAR(50) NOT NULL,
  patient_phone VARCHAR(12) NULL,
  PRIMARY KEY (patient_id));

CREATE TABLE Doctor (
  doctor_id SERIAL NOT NULL ,
  doctor_name VARCHAR(50) NOT NULL,
  doctor_surname VARCHAR(50) NOT NULL,
  doctor_patronymic VARCHAR(50) NOT NULL,
  doctor_phone VARCHAR(12) NULL,
  PRIMARY KEY (doctor_id));
  
CREATE TABLE Type_procedure (
  type_procedure_id SERIAL NOT NULL,
  procedure_name VARCHAR(50) NOT NULL,
  procedure_cost INT NULL ,
  procedure_equipment equip NULL
  PRIMARY KEY (type_procedure_id));

CREATE TABLE shedule (
  day_id INT NOT NULL ,
  day_name VARCHAR(20) NOT NULL,
  sg_flag INT NOT NULL,
  PRIMARY KEY (day_id));

  
  CREATE TABLE IF NOT EXISTS visit
(
    visit_id  SERIAL  NOT NULL,
    visit_date DATE NOT NULL,
    Patient_id INT NOT NULL,
    Doctor_id INT NOT NULL,
	Day_id INT NOT NULL,
  PRIMARY KEY (visit_id),
    FOREIGN KEY (Doctor_id)
    REFERENCES Doctor (doctor_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (Patient_id)
    REFERENCES Patient (patient_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	FOREIGN KEY (Day_id)
    REFERENCES shedule (Day_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE procedur (
    Type_procedure_id INT NOT NULL,
    PRIMARY KEY (visit_id),
    FOREIGN KEY (Doctor_id)
    REFERENCES Doctor (doctor_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (Type_procedure_id)
    REFERENCES Type_procedure (type_procedure_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (Patient_id)
    REFERENCES Patient (patient_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	FOREIGN KEY (Day_id)
    REFERENCES shedule (Day_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
 ) INHERITS (visit);
 
 CREATE TABLE reception (
    Type_recept recept NOT NULL,
    PRIMARY KEY (visit_id),
    FOREIGN KEY (Doctor_id)
    REFERENCES Doctor (doctor_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (Patient_id)
    REFERENCES Patient (patient_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	FOREIGN KEY (Day_id)
    REFERENCES shedule (Day_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) INHERITS (visit);
