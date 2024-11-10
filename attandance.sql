CREATE TABLE Student(
    roll_no NUMBER,
    name VARCHAR2(30),
    attendance NUMBER,
    status VARCHAR2(30) DEFAULT 'Not Detained'
);


INSERT INTO Student(roll_no, name, attendance) VALUES(1, 'Sarang', 68);
INSERT INTO Student(roll_no, name, attendance) VALUES(2, 'Anuj', 78);
INSERT INTO Student(roll_no, name, attendance) VALUES(3, 'Yash', 23);
INSERT INTO Student(roll_no, name, attendance) VALUES(4, 'Sakshi', 89);

DECLARE
    v_roll_no     NUMBER;
    v_attendance  NUMBER;
    v_status      VARCHAR2(30);

BEGIN
    v_roll_no := &roll_no;

    SELECT attendance INTO v_attendance 
    FROM Student
    WHERE roll_no = v_roll_no;

    IF v_attendance < 75 THEN
        v_status := 'Detained';
        DBMS_OUTPUT.PUT_LINE('Term Not Granted');
    ELSE
        v_status := 'Not Detained';
        DBMS_OUTPUT.PUT_LINE('Term Granted');
    END IF;

    UPDATE Student 
    SET status = v_status
    WHERE roll_no = v_roll_no;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No student data found for roll number ' || v_roll_no);

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);

END;
/
