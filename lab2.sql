CREATE TABLE Patient (
  patient_id INT NOT NULL AUTO_INCREMENT,
  patient_name VARCHAR(50) NOT NULL,
  patient_surname VARCHAR(50) NOT NULL,
  patient_patronymic VARCHAR(50) NOT NULL,
  patient_phone VARCHAR(12) NULL,
  PRIMARY KEY (patient_id))

CREATE TABLE Doctor (
  doctor_id INT NOT NULL AUTO_INCREMENT,
  doctor_name VARCHAR(50) NOT NULL,
  doctor_surname VARCHAR(50) NOT NULL,
  doctor_patronymic VARCHAR(50) NOT NULL,
  doctor_phone VARCHAR(12) NULL,
  PRIMARY KEY (doctor_id))

CREATE TABLE Type_procedure (
  type_procedure_id INT NOT NULL AUTO_INCREMENT,
  procedure_name VARCHAR(50) NOT NULL,
  procedure_cost INT NULL ,
  procedure_equipment VARCHAR(50) NULL,
  procedure_flag INT NOT NULL,
  PRIMARY KEY (type_procedure_id))

CREATE TABLE Procedure (
  procedure_id INT NOT NULL AUTO_INCREMENT,
  Patient_patient_id INT NOT NULL,
  Doctor_doctor_id INT NOT NULL,
  Type_procedure_type_procedure_id INT NOT NULL,
  procedure_data DATE ,
  PRIMARY KEY (procedure_id),
    FOREIGN KEY (Doctor_doctor_id)
    REFERENCES Doctor (doctor_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (Type_procedure_type_procedure_id)
    REFERENCES Type_procedure (type_procedure_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (Patient_patient_id)
    REFERENCES Patient (patient_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)


ALTER TABLE doctor
  ADD age INT NULL
    AFTER doctor_surname;
ALTER TABLE doctor drop age;
