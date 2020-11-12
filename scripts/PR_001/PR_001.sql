--liquibase formatted sql
--changeset sanjib:create-person-table
create  table  PERSON  (  
    ID  int  not  null,  
    FNAME  varchar(100)  not  null  
);
--rollback DROP TABLE
--rollback PERSON