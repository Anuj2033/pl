CREATE TABLE library(
    name VARCHAR2(30),
    category VARCHAR2(30)
);

CREATE TABLE library_audit(
    name VARCHAR2(30),
    category VARCHAR2(30)
);



INSERT INTO library VALUES('Python', 'Porgramming');
INSERT INTO library VALUES('C++', 'Porgramming');
INSERT INTO library VALUES('Steve Jobs', 'Bio');
INSERT INTO library VALUES('Physics', 'Sci');


SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER update_value
AFTER UPDATE OR DELETE on library
FOR EACH ROW

BEGIN
    INSERT INTO library_audit VALUES(:OLD.name, :OLD.category);
END;
/

UPDATE library
SET name = 'Chemistry'
WHERE category = 'Sci';


