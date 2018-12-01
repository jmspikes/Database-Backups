set verify off
set serveroutput on
ACCEPT c_input NUMBER PROMPT "Enter c_id: ";
ACCEPT f_input NUMBER PROMPT "Enter f_id: ";
DECLARE
c Customers.c_id%type;
f Furniture.f_id%type;
BEGIN
	/*data validation*/
	BEGIN
	SELECT c_id INTO c FROM Customers WHERE c_id = &c_input;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		dbms_output.put_line('C_ID not found');
		return;
	END;

	BEGIN
	SELECT f_id INTO f FROM Furniture WHERE f_id = &f_input;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		dbms_output.put_line('F_ID not found');
		return;
	END;
	BEGIN
	SELECT f_id INTO f FROM Check_out WHERE Check_out.f_id = &f_input AND RET_DATE IS NOT NULL AND ROWNUM = 1;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		dbms_output.put_line('Furniture not returned');
		return;
	END;
INSERT INTO Check_out VALUES(&c_input, &f_input, to_date(sysdate), NULL);
dbms_output.put_line('Addition Successful');
END;
/
