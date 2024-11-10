CREATE TABLE N_roll(
    name VARCHAR2(30),
    roll_no NUMBER
);

CREATE TABLE O_roll(
    name VARCHAR2(30),
    roll_no NUMBER
);


INSERT INTO O_roll VALUES('Anuj', 1);
INSERT INTO O_roll VALUES('Abhishek', 2);
INSERT INTO O_roll VALUES('Priya', 3);
INSERT INTO O_roll VALUES('Priya', 3);


SET SERVEROUTPUT ON;

DECLARE
    c_roll NUMBER;
    c_name VARCHAR2(30);
    c_count NUMBER;

    CURSOR track_new_roll IS SELECT name, roll_no FROM O_roll;


BEGIN
    OPEN track_new_roll;
    LOOP
        FETCH track_new_roll INTO c_name, c_roll;
        EXIT WHEN track_new_roll%NOTFOUND;
        SELECT COUNT(*) INTO c_count 
        FROM N_roll 
        WHERE roll_no = c_roll;

        IF c_count = 0 THEN
            INSERT INTO N_roll VALUES(c_name, c_roll);
        ELSE
            DBMS_OUTPUT.PUT_LINE(c_name || ' ' || 'Already present in the table');
        END IF;
    
        
    END LOOP;

    CLOSE track_new_roll;

END;
/