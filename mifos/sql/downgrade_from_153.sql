ALTER TABLE LOAN_ACCOUNT DROP COLUMN PARENT_ACCOUNT_ID;

DELETE FROM ACCOUNT_TYPE WHERE ACCOUNT_TYPE_ID= 4;

UPDATE DATABASE_VERSION SET DATABASE_VERSION = 152 WHERE DATABASE_VERSION = 153;