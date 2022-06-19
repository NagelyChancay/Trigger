--Se procede a crear las tablas con sus respectivos atributos

CREATE TABLE ESTUDIANTE
(
    ID_ESTUDIANTE INTEGER,
    NOMBRE_EST   VARCHAR2(60),
    FECHA_INGRESO_EST DATE,
    NUM_REPETICIONES_EST NUMERIC,
    constraint PK_ESTUDIANTE primary key (ID_ESTUDIANTE)
);

CREATE TABLE MATRICULA
(
    ID_MATRICULA INTEGER,
    ID_ESTUDIANTE INTEGER,
    FECHA_MATRICULA DATE,
    NIVEL_MATRICULA NUMERIC,
    constrainT PK_MATRICULA primary key (ID_MATRICULA)
);

update estudiante set NUM_REPETICIONES_EST =0
truncate table matricula
Delete matricula
Delete estudiante
--Se realizan las inserciones para contar con valores en tabla estudiante y tabla matrícula
INSERT INTO ESTUDIANTE VALUES (1,'Aurora Palma','03-03-2010',0);
INSERT INTO ESTUDIANTE VALUES (2,'Jahaira Delgado','12-05-2011',0);
INSERT INTO ESTUDIANTE VALUES (3,'Lolie Chávez','12-05-2011',0);
INSERT INTO MATRICULA VALUES (1,1,'15-03-2010',1);
INSERT INTO MATRICULA VALUES (2,1,'14-08-2011',1);
INSERT INTO MATRICULA VALUES (3,1,'27-03-2012',1);
INSERT INTO MATRICULA VALUES (4,2,'22-06-2011',1);
INSERT INTO MATRICULA VALUES (5,1,'20-09-2013',1);
INSERT INTO MATRICULA VALUES (6,2,'15-08-2012',1);
INSERT INTO MATRICULA VALUES (7,2,'25-02-2013',1);
INSERT INTO MATRICULA VALUES (8,1,'09-12-2013',1);
INSERT INTO MATRICULA VALUES (9,3,'09-12-2013',1);
select * from matricula
select * from estudiante
--Se inicia con l acreación del trigger
CREATE OR REPLACE TRIGGER CONTROL
BEFORE 
INSERT OR DELETE on MATRICULA
FOR EACH ROW
DECLARE VAL number(4):=0;
BEGIN
    IF INSERTING THEN
        select COUNT(*) into VAL from MATRICULA where ID_ESTUDIANTE = :new.ID_ESTUDIANTE and NIVEL_MATRICULA = :new.NIVEL_MATRICULA;
        If VAL>=1 then
        update ESTUDIANTE set NUM_REPETICIONES_EST = VAL  where ID_ESTUDIANTE = :new.ID_ESTUDIANTE;
        end if;
    ELSIF  DELETING THEN
     select COUNT(*) into VAL from MATRICULA where ID_ESTUDIANTE = :old.ID_ESTUDIANTE and NIVEL_MATRICULA = :old.NIVEL_MATRICULA;
        If VAL>1 then
            update ESTUDIANTE set NUM_REPETICIONES_EST = NUM_REPETICIONES_EST-1 where ID_ESTUDIANTE = :old.ID_ESTUDIANTE;
            end if;
        end if;
end;
select * from matricula