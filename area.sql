SET SERVEROUTPUT ON;

CREATE TABLE Area(
    radius NUMBER,
    area NUMBER
);

DECLARE 
    v_radius NUMBER;
    pi CONSTANT NUMBER := 3.14;
    v_area NUMBER;


BEGIN
    FOR v_radius IN 5..9 LOOP 
        v_area := v_radius * pi;
        INSERT INTO Area VALUES(v_radius, v_area);
    END LOOP;
END;
/