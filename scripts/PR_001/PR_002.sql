--liquibase formatted sql
--changeset sanjib:create-greetings_hello-procedure
CREATE OR REPLACE PROCEDURE greetings_hello 
AS 
BEGIN 
   dbms_output.put_line('Hello World!'); 
END; 
/
--rollback DROP PROCEDURE
--rollback greetings_hello