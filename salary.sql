CREATE TABLE emp (
    emp_no NUMBER PRIMARY KEY,
    salary NUMBER
);

CREATE TABLE increment_salary (
    emp_no NUMBER,
    salary NUMBER,
    FOREIGN KEY (emp_no) REFERENCES emp(emp_no)
);


INSERT INTO emp (emp_no, salary) VALUES (1, 3000);
INSERT INTO emp (emp_no, salary) VALUES (2, 4000);
INSERT INTO emp (emp_no, salary) VALUES (3, 2500);
INSERT INTO emp (emp_no, salary) VALUES (4, 5000);
INSERT INTO emp (emp_no, salary) VALUES (5, 3500);


SET SERVEROUTPUT ON;

DECLARE

    avg_salary NUMBER;

BEGIN

    SELECT AVG(salary) INTO avg_salary FROM emp;

    FOR emp_rec IN(SELECT emp_no, salary FROM emp WHERE salary < avg_salary) LOOP
        UPDATE emp
        SET salary = salary * 1.10
        WHERE emp_no = emp_rec.emp_no;

        INSERT INTO increment_salary(emp_no, salary) VALUES(emp_rec.emp_no, emp_rec.salary * 1.10);
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occured' || SQLERRM);

END;
/