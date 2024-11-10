CREATE TABLE Employee (
    Emp_no NUMBER,
    Emp_name VARCHAR2(30),
    Emp_salary NUMBER
);

CREATE TABLE Tracking (
    Emp_no NUMBER,
    Emp_salary NUMBER
);


INSERT INTO Employee VALUES(1, 'Anuj', 70000);
INSERT INTO Employee VALUES(2, 'Abhi', 80000);
INSERT INTO Employee VALUES(3, 'Inshwari', 46000);


SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER track_salary_change
AFTER INSERT OR UPDATE ON Employee
FOR EACH ROW 
BEGIN

    IF :NEW.Emp_salary < 50000 THEN
        INSERT INTO Tracking VALUES(:NEW.Emp_no, :NEW.Emp_salary);
    END IF;

END;
/

UPDATE Employee
SET Emp_salary = 2500
WHERE Emp_no = 1;