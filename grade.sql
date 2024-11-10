CREATE TABLE stud_marks(
    roll_no NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    total_mark NUMBER
);

CREATE TABLE result(
    roll_no NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    class VARCHAR2(20)
);

INSERT INTO stud_marks VALUES(1,'Anuj', 1500);
INSERT INTO stud_marks VALUES(2,'Abhi', 995);
INSERT INTO stud_marks VALUES(3,'Rahul', 885);
INSERT INTO stud_marks VALUES(4,'Sarang', 900);
INSERT INTO stud_marks VALUES(5,'Yash', 840);


CREATE OR REPLACE PROCEDURE proc_grade(p_student_roll IN NUMBER, p_student_name IN VARCHAR2, p_student_mark IN NUMBER) IS
BEGIN 

    IF p_student_mark <= 1500 AND p_student_mark >= 990 THEN
    	INSERT INTO result VALUES(p_student_roll, p_student_name, 'Distinction');
	ELSIF p_student_mark >= 900 AND p_student_mark <= 989 THEN
        INSERT INTO result VALUES(p_student_roll, p_student_name, 'First Class');
	ELSIF p_student_mark >= 825 AND p_student_mark <= 899 THEN
        INSERT INTO result VALUES(p_student_roll, p_student_name, 'Higher Class');
	ELSE
        INSERT INTO result VALUES(p_student_roll, p_student_name, 'Fail');
	END IF;

END;
/


DECLARE
    v_roll NUMBER;
    v_stud_name VARCHAR2(30);
    v_stud_mark NUMBER;
BEGIN
    FOR stud_record IN (SELECT roll_no, name, total_mark FROM stud_marks) LOOP
        v_roll := stud_record.roll_no;
        v_stud_name := stud_record.name;
        v_stud_mark := stud_record.total_mark;

        proc_grade(v_roll, v_stud_name, v_stud_mark);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Procedure executed for all students.');
END;
/
