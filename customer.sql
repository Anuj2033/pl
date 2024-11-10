CREATE TABLE customer(
    id NUMBER,
    name VARCHAR2(30),
    salary NUMBER
);


INSERT INTO customer(id, name, salary) VALUES(1,'Anuj', 20000);
INSERT INTO customer(iD, name, salary) VALUES(2,'Yash', 30000);
INSERT INTO customer(iD, name, salary) VALUES(3,'Sarang', 50000);
INSERT INTO customer(iD, name, salary) VALUES(4,'Abhi', 35000);


CREATE OR REPLACE TRIGGER disp_salary 
BEFORE INSERT OR DELETE OR UPDATE ON customer
FOR EACH ROW
DECLARE
    v_diff NUMBER;

BEGIN
    v_diff := :NEW.salary - :OLD.salary;
    DBMS_OUTPUT.PUT_LINE('OLD Salary:' || :OLD.salary);
    DBMS_OUTPUT.PUT_LINE('NEW Salary:' || :NEW.salary);
    DBMS_OUTPUT.PUT_LINE('Salary Diff:'|| v_diff);

END;
/

UPDATE customer
SET salary = salary + 500
WHERE name = 'Anuj';
