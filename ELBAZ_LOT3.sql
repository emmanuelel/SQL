REM *** --> LOT 3
REM ***--> Mise en place du Trigger « CALCULSOLDE »


CREATE OR REPLACE TRIGGER CALCULSOLDE
AFTER INSERT  OR DELETE ON OPERATION
FOR EACH ROW
BEGIN
IF INSERTING THEN
RAISE_APPLICATION_ERROR (-20001, 'Insertion impossible');
ELSIF UPDATING THEN
RAISE_APPLICATION_ERROR (-20001, ' Modification impossible');

ELSIF DELETING THEN 
RAISE_APPLICATION_ERROR (-20001, 'Suppression impossible');

SELECT IdOperation  FROM OPERATION,COMPTE
WHERE IdOperation=p_Idopt AND Operation.IdCompte=COMPTE.IdCompte AND COMPTE.IdBanque = BANQUE.IdBANQUE
UPDATE COMPTE
SET SoldeCompte=SoldeCompte + :NEW.MontantOperation WHERE IdOperation=:NEW.IdOperation;
END IF;
END;
/

select * from OPERATION;
select * from Compte;
