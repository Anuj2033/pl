SET SERVEROUTPUT ON;
DECLARE
    v_curr_date DATE;
    v_date_of_issue DATE;
    v_diff NUMBER;
    v_fine NUMBER;
    v_roll_no NUMBER := 11;

BEGIN
    LOOP
    BEGIN
      v_roll_no := &roll_no;
      SELECT date_of_issue INTO v_date_of_issue FROM borrower
      WHERE status = 'I' and roll_no = v_roll_no;

      v_curr_date := SYSDATE;
      v_diff := TRUNC(v_curr_date - v_date_of_issue);
      v_fine := 0;

      IF v_diff > 15 and v_diff < 30 THEN
        v_fine := 5 * v_diff;
        DBMS_OUTPUT.PUT_LINE('Fine' || v_fine);
        INSERT INTO fine VALUES(v_roll_no, v_curr_date, v_fine);
      ELSIF v_diff >= 30 THEN
        v_fine := 30 * v_diff;
        DBMS_OUTPUT.PUT_LINE('Fine' || v_fine);
        INSERT INTO fine VALUES(v_roll_no, v_curr_date, v_fine);
      ELSE
        v_fine := 0;
        INSERT INTO fine VALUES(v_roll_no, v_curr_date, v_fine);
    END IF;
    UPDATE borrower SET status = 'R' WHERE roll_no = v_roll_no;

     EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No active borrower found with roll number: ' || v_roll_no);
                EXIT;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
                EXIT; 
    END;
    END LOOP;
END;
/