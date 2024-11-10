CREATE OR REPLACE FUNCTION calAge( 
    birth_date IN DATE, 
    months OUT NUMBER, 
    days OUT NUMBER 
) RETURN NUMBER IS 
    current_date DATE := SYSDATE; 
    years_diff NUMBER; 
    month_diff NUMBER; 
    days_diff NUMBER; 
    total_years NUMBER; 
 
BEGIN 
    years_diff := EXTRACT(YEAR FROM current_date) - EXTRACT(YEAR FROM birth_date); 
 
    month_diff := EXTRACT(MONTH FROM current_date) - EXTRACT(MONTH FROM birth_date); 
     
    days_diff := EXTRACT(DAY FROM current_date) - EXTRACT(DAY FROM birth_date); 
     
    IF month_diff < 0 THEN 
        years_diff := years_diff - 1; 
        month_diff := month_diff + 12; 
    END IF; 
     
    IF days_diff < 0 THEN 
        month_diff := month_diff - 1; 
        days_diff := days_diff + TO_NUMBER(EXTRACT(DAY FROM LAST_DAY(current_date))); 
    END IF; 
 
    months := month_diff; 
    days := days_diff; 
 
    total_years := years_diff; 
    RETURN total_years; 
 
END calAge;
/

SET SERVEROUTPUT ON;

DECLARE 
    months_diff NUMBER; 
    days_diff NUMBER; 
    total_years NUMBER; 
BEGIN 
    total_years := calAge(TO_DATE('2003-12-20', 'YYYY-MM-DD'), months_diff, days_diff); 
    DBMS_OUTPUT.PUT_LINE('Age: ' || total_years || ' years, ' || months_diff || ' months, ' || days_diff || ' days'); 
END; 
/