 --CREARE TABELE

--creare tabel PROFESOR
CREATE TABLE PROFESOR
(
    id_profesor NUMBER(10) CONSTRAINT profesor_pk PRIMARY KEY,
	nume VARCHAR(100) CONSTRAINT nume_profesor NOT NULL,
	prenume VARCHAR(100) CONSTRAINT prenume_profesor NOT NULL,
    data_nastere DATE CONSTRAINT data_nastere_profesor NOT NULL,
    gen VARCHAR(20) CONSTRAINT gen_profesor NOT NULL,
	adresa VARCHAR(100) CONSTRAINT adresa_profesor NOT NULL,
    numar_telefon NUMBER(10) UNIQUE,
    salariu NUMBER(10) CONSTRAINT salariu_angajat NOT NULL,
    materie_predata VARCHAR(100) CONSTRAINT materie_predata_profesor NOT NULL
);
 
--creare tabel SALA
CREATE TABLE SALA
(
    id_sala NUMBER(10) CONSTRAINT sala_pk PRIMARY KEY, 
    denumire VARCHAR(100) CONSTRAINT denumire_sala NOT NULL,
    tip_de_sala VARCHAR(100) CONSTRAINT tip_de_sala NOT NULL,
    capacitate NUMBER(3) CONSTRAINT capacitate_sala NOT NULL
);
 
--creare tabel CLASA
CREATE TABLE CLASA
(
    id_clasa NUMBER(10) CONSTRAINT clasa_pk PRIMARY KEY,
    nume VARCHAR(100) CONSTRAINT denumire_clasa NOT NULL,
    grad NUMBER(2) CONSTRAINT grad_clasa CHECK ( grad IN (9,10,11,12)) NOT NULL, 
    profil VARCHAR(100) CONSTRAINT profil_clasa CHECK ( profil IN ('uman', 'real')) NOT NULL,
    specializare VARCHAR(100) CONSTRAINT specializare_clasa CHECK ( specializare IN ('stiinte sociale', 'filologie', 'matematica-informatica', 'stiinte ale naturii')) NOT NULL,
    id_sala NUMBER(10), CONSTRAINT clasa_fk1 FOREIGN KEY(id_sala) REFERENCES SALA(id_sala),
    id_diriginte NUMBER(10), CONSTRAINT clasa_fk2 FOREIGN KEY(id_diriginte) REFERENCES PROFESOR(id_profesor),
    CONSTRAINT sala_unica UNIQUE(id_sala),
    CONSTRAINT diriginte_unic UNIQUE (id_diriginte)
);

--creare tabel MATERIE
CREATE TABLE MATERIE
(
    id_materie NUMBER(10) CONSTRAINT materie_pk PRIMARY KEY,
    denumire VARCHAR(100) CONSTRAINT denumire_materie NOT NULL
);

--creare tabel ELEV
CREATE TABLE ELEV
(
	id_elev NUMBER(10) CONSTRAINT elev_pk PRIMARY KEY,
    id_clasa NUMBER(10), CONSTRAINT elev_fk FOREIGN KEY(id_clasa) REFERENCES CLASA(id_clasa),
	nume VARCHAR(100) CONSTRAINT nume_elev NOT NULL,
	prenume VARCHAR(100) CONSTRAINT prenume_elev NOT NULL,
	adresa VARCHAR(100) CONSTRAINT adresa_elev NOT NULL,
	gen VARCHAR(50) CONSTRAINT gen_elev NOT NULL,
	data_nastere DATE CONSTRAINT data_nastere_elev NOT NULL
);
 
--creare tabel TUTORE
CREATE TABLE TUTORE
(
    id_tutore NUMBER(10) CONSTRAINT tutore_pk PRIMARY KEY,
	nume VARCHAR(100) CONSTRAINT nume_tutore NOT NULL,
	prenume VARCHAR(100) CONSTRAINT prenume_tutore NOT NULL,
	adresa VARCHAR(100) CONSTRAINT adresa_tutore NOT NULL,
	gen VARCHAR(20) CONSTRAINT gen_tutore NOT NULL,
	data_nastere DATE CONSTRAINT data_nastere_tutore NOT NULL,
    numar_telefon NUMBER(10) UNIQUE
);
 
--creare tabel TUTORE_ELEV
CREATE TABLE TUTORE_ELEV
(
	id_elev NUMBER(10), CONSTRAINT elev_fk1 FOREIGN KEY(id_elev) REFERENCES ELEV(id_elev),
    id_tutore NUMBER(10), CONSTRAINT tutore_fk1 FOREIGN KEY(id_tutore) REFERENCES TUTORE(id_tutore),
    CONSTRAINT tutore_elev_pk PRIMARY KEY(id_elev,id_tutore),
    relatie_tutore_elev VARCHAR(50) CONSTRAINT relatie_c NOT NULL
);
 
--creare tabel NOTA
CREATE TABLE NOTA
(
    id_nota NUMBER(10) CONSTRAINT nota_pk PRIMARY KEY,
    id_elev NUMBER(10), CONSTRAINT nota_fk1 FOREIGN KEY(id_elev) REFERENCES ELEV(id_elev),
    id_materie NUMBER(10), CONSTRAINT nota_fk2 FOREIGN KEY(id_materie) REFERENCES MATERIE(id_materie),
    nota NUMBER(2) CONSTRAINT nota_obtinuta CHECK (nota>0 AND nota<=10) NOT NULL,
    data_obtinerii DATE CONSTRAINT data_obtinerii_notei NOT NULL
);
 
--creare tabel ABSENTA
CREATE TABLE ABSENTA
(
    id_absenta NUMBER(10) CONSTRAINT absenta_pk PRIMARY KEY,
    id_elev NUMBER(10), CONSTRAINT absenta_fk1 FOREIGN KEY(id_elev) REFERENCES ELEV(id_elev),
    id_materie NUMBER(10), CONSTRAINT absenta_fk2 FOREIGN KEY(id_materie) REFERENCES MATERIE(id_materie),
    data_obtinerii DATE CONSTRAINT data_obtinerii_absentei NOT NULL,
    motivare VARCHAR(50) DEFAULT 'nemotivat' CONSTRAINT motivare_absenta CHECK (motivare IN ('motivat', 'nemotivat')),
    dovada_motivare VARCHAR(100) 
);
 
--creare tabel ORAR
CREATE TABLE ORAR 
(
    id_clasa NUMBER(10) CONSTRAINT orar_fk1 REFERENCES CLASA(id_clasa),
    id_materie NUMBER(10) CONSTRAINT orar_fk2 REFERENCES MATERIE(id_materie),
    id_profesor NUMBER(10) CONSTRAINT orar_fk3 REFERENCES PROFESOR(id_profesor),
    id_sala NUMBER(10) CONSTRAINT orar_fk4 REFERENCES SALA(id_sala),
    ziua VARCHAR(20) CHECK (ziua IN ('Luni', 'Marti', 'Miercuri', 'Joi', 'Vineri')),
    ora VARCHAR(10),
    CONSTRAINT PK_COMP_ORAR PRIMARY KEY(id_clasa,id_materie,id_profesor,id_sala,ziua,ora) 
);
  
--INSERARI

--inserari in tabelul PROFESOR
INSERT INTO PROFESOR VALUES (1, 'Popescu', 'Ion', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'masculin', 'Str. Victoriei, Nr. 20, Bucuresti', 0725971632, 5900, 'Matematica');
INSERT INTO PROFESOR VALUES (2, 'Ionescu', 'Ana', TO_DATE('1975-08-20', 'YYYY-MM-DD'), 'feminin', 'Str. Unirii, Nr. 30, Bucuresti', 0748531972, 6000, 'Fizica');
INSERT INTO PROFESOR VALUES (3, 'Radu', 'Mihai', TO_DATE('1982-02-10', 'YYYY-MM-DD'), 'masculin', 'Bd. Carol I, Nr. 15, Bucuresti', 0712730685, 5500, 'Chimie');
INSERT INTO PROFESOR VALUES (4, 'Dumitru', 'Elena', TO_DATE('1988-11-03', 'YYYY-MM-DD'), 'feminin', 'Str. Lipscani, Nr. 25, Bucuresti', 0756197432, 5200, 'Biologie');
INSERT INTO PROFESOR VALUES (5, 'Marinescu', 'Cristian', TO_DATE('1973-07-08', 'YYYY-MM-DD'), 'masculin', 'Bd. Magheru, Nr. 18, Bucuresti', 0754253625, 5800, 'Istorie');
INSERT INTO PROFESOR VALUES (6, 'Stan', 'Andreea', TO_DATE('1985-04-25', 'YYYY-MM-DD'), 'feminin', 'Str. Dorobanti, Nr. 12, Bucuresti', 0744122187, 5300, 'Geografie');
INSERT INTO PROFESOR VALUES (7, 'Moldovan', 'Dorin', TO_DATE('1979-09-18', 'YYYY-MM-DD'), 'masculin', 'Bd. Dacia, Nr. 22, Bucuresti', 0741389613, 5900, 'Informatica');
INSERT INTO PROFESOR VALUES (8, 'Gheorghe', 'Gabriela', TO_DATE('1987-12-07', 'YYYY-MM-DD'), 'feminin', 'Str. Romana, Nr. 8, Bucuresti', 0789413724, 5700, 'Limba romana');
INSERT INTO PROFESOR VALUES (9, 'Cristea', 'Adrian', TO_DATE('1984-06-30', 'YYYY-MM-DD'), 'masculin', 'Bd. Unirii, Nr. 18, Bucuresti', 0741985237, 5400, 'Limba engleza');
INSERT INTO PROFESOR VALUES (10, 'Alexandrescu', 'Camelia', TO_DATE('1981-03-12', 'YYYY-MM-DD'), 'feminin', 'Str. Calea Victoriei, Nr. 7, Bucuresti', 0745982310, 5250, 'Educatie fizica');
SELECT * FROM PROFESOR; 

--inserari in tabelul SALA
INSERT INTO SALA VALUES (1, 'Sala 101', 'sala de curs', 30);
INSERT INTO SALA VALUES (2, 'Sala 102', 'sala de curs', 28);
INSERT INTO SALA VALUES (3, 'Sala 103', 'sala de curs', 30);
INSERT INTO SALA VALUES (4, 'Sala 104', 'sala de curs', 30);
INSERT INTO SALA VALUES (5, 'Sala 105', 'sala de curs', 28);
INSERT INTO SALA VALUES (6, 'Laboratorul de fizica', 'laborator de fizica', 30);
INSERT INTO SALA VALUES (7, 'Laboratorul de informatica', 'laborator de informatica', 40);
INSERT INTO SALA VALUES (8, 'Laboratorul de chimie', 'laborator de chimie', 34);
INSERT INTO SALA VALUES (9, 'Laboratorul de biologie', 'laborator de biologie', 32);
INSERT INTO SALA VALUES (10, 'Sala de sport A1', 'Sala de sport', 50);

SELECT * FROM SALA;
 

--inserari in tabelul CLASA
INSERT INTO CLASA
VALUES (1,'Clasa a IX-a A', 9, 'real', 'matematica-informatica', 1, 1);
INSERT INTO CLASA
VALUES (2,'Clasa a IX-a B', 9, 'uman', 'stiinte sociale', 2, 2);
INSERT INTO CLASA
VALUES (3,'Clasa a X-a A', 10, 'real', 'matematica-informatica', 3, 3);
INSERT INTO CLASA
VALUES (4,'Clasa a X-a B', 10, 'real', 'matematica-informatica', 4, 4);
INSERT INTO CLASA
VALUES (5,'Clasa a X-a C', 10, 'real', 'stiinte ale naturii', 5, 5);

SELECT * FROM CLASA;
 
--inserari in tabelul MATERIE
INSERT INTO MATERIE 
VALUES (1, 'Matematica');
INSERT INTO MATERIE
VALUES (2, 'Fizica');
INSERT INTO MATERIE
VALUES (3, 'Chimie');
INSERT INTO MATERIE 
VALUES (4, 'Biologie');
INSERT INTO MATERIE 
VALUES (5, 'Istorie');
INSERT INTO MATERIE 
VALUES (6, 'Geografie');
INSERT INTO MATERIE
VALUES (7, 'Informatica');
INSERT INTO MATERIE
VALUES (8, 'Limba romana');
INSERT INTO MATERIE
VALUES (9, 'Limba engleza');
INSERT INTO MATERIE
VALUES (10, 'Educatie fizica');

SELECT * FROM MATERIE;
 
--inserari in tabelul ELEV
INSERT INTO ELEV VALUES (1, 1, 'Popescu', 'Razvan', 'Str. Masina de Paine, Nr. 18, Bucuresti', 'Masculin', TO_DATE('2005-02-15', 'YYYY-MM-DD'));
INSERT INTO ELEV VALUES (2, 3, 'Cochiorca', 'Oana', 'Str. Principala, Nr. 175, Faraoani, Bacau', 'Feminin', TO_DATE('2006-09-10', 'YYYY-MM-DD'));
INSERT INTO ELEV VALUES (3, 2, 'Pal', 'Francesca', 'Str. Principala, Nr. 183, Faraoani, Bacau', 'Masculin', TO_DATE('2005-10-01', 'YYYY-MM-DD'));
INSERT INTO ELEV VALUES (4, 2, 'Dumitru', 'Elena', 'Str. Rozelor, Nr. 12, Bucuresti', 'Feminin', TO_DATE('2005-03-23', 'YYYY-MM-DD'));
INSERT INTO ELEV VALUES (5, 1, 'Marinescu', 'Cristian', 'Bd. Republicii, Nr. 30, Bucuresti', 'Masculin', TO_DATE('2005-08-18', 'YYYY-MM-DD'));

SELECT * FROM ELEV;
 
--inserari in tabelul TUTORE
INSERT INTO TUTORE VALUES (1, 'Popescu', 'Regina', 'Str. Masina de Paine, Nr. 18, Bucuresti', 'feminin', TO_DATE('1975-05-20', 'YYYY-MM-DD'), 0721234567);
INSERT INTO TUTORE VALUES (2, 'Popescu', 'Aurel', 'Str. Masina de Paine, Nr. 18, Bucuresti', 'masculin', TO_DATE('1970-10-08', 'YYYY-MM-DD'), 0745872369);
INSERT INTO TUTORE VALUES (3, 'Cochiorca', 'Ion', 'Str. Principala, Nr. 175, Faraoani, Bacau', 'Masculin', TO_DATE('1970-07-12', 'YYYY-MM-DD'), 0744928221);
INSERT INTO TUTORE VALUES (4, 'Cochiorca', 'Ana', 'Str. Principala, Nr. 175, Faraoani, Bacau', 'Feminin', TO_DATE('1966-03-30', 'YYYY-MM-DD'), 0744139117);
INSERT INTO TUTORE VALUES (5, 'Pal', 'Francisc', 'Str. Principala, Nr. 183, Faraoani, Bacau', 'Masculin', TO_DATE('1968-10-02', 'YYYY-MM-DD'), 0751234567);
INSERT INTO TUTORE VALUES (6, 'Pal', 'Maria', 'Str. Principala, Nr. 183, Faraoani, Bacau', 'feminin', TO_DATE('1969-02-07', 'YYYY-MM-DD'), 0743657827);
INSERT INTO TUTORE VALUES (7, 'Dumitru', 'Vasile', 'Strada Ion Campineanu 5, Bucuresti', 'masculin', TO_DATE('1980-05-10', 'YYYY-MM-DD'), 0742245653);
INSERT INTO TUTORE VALUES (8, 'Dumitru', 'Ramona', 'Strada Ion Campineanu 5, Bucuresti', 'feminin', TO_DATE('1982-12-17', 'YYYY-MM-DD'), 0761234567);
INSERT INTO TUTORE VALUES (9, 'Marinescu', 'Laurentiu', 'Strada Nicolae Grigorescu 64, Bucuresti', 'masculin', TO_DATE('1982-12-17', 'YYYY-MM-DD'), 0725345670);
INSERT INTO TUTORE VALUES (10, 'Marinescu', 'Lucia', 'Strada Nicolae Grigorescu 64, Bucuresti', 'feminin', TO_DATE('1978-07-18', 'YYYY-MM-DD'), 0776543210);

SELECT * FROM TUTORE;  

--inserari in tabelul TUTORE-ELEV
INSERT INTO TUTORE_ELEV
VALUES(1,1,'mama');
INSERT INTO TUTORE_ELEV
VALUES(1,2,'tata');
INSERT INTO TUTORE_ELEV
VALUES(2,3,'tata');
INSERT INTO TUTORE_ELEV
VALUES(2,4,'mama');
INSERT INTO TUTORE_ELEV
VALUES(3,5,'tata');
INSERT INTO TUTORE_ELEV
VALUES(3,6,'mama'); 
INSERT INTO TUTORE_ELEV
VALUES(4,7,'tata');
INSERT INTO TUTORE_ELEV
VALUES(4,8,'mama');
INSERT INTO TUTORE_ELEV
VALUES(5,9,'tata');
INSERT INTO TUTORE_ELEV
VALUES(5,10,'mama');

SELECT * FROM TUTORE_ELEV;
 
--inserari in tabelul NOTA
INSERT INTO NOTA
VALUES(1, 1, 1, 8, to_date('23-10-2023','DD-MM-YYYY'));
INSERT INTO NOTA
VALUES(2, 1, 1, 10, to_date('11-12-2023','DD-MM-YYYY'));
INSERT INTO NOTA
VALUES(3, 1, 2, 9, to_date('07-11-2023','DD-MM-YYYY'));
INSERT INTO NOTA
VALUES(4, 2, 3, 7, to_date('30-10-2023','DD-MM-YYYY'));
INSERT INTO NOTA
VALUES(5, 2, 3, 9, to_date('09-01-2024','DD-MM-YYYY'));

SELECT * FROM NOTA;
 
--inserari in tabelul ABSENTA
INSERT INTO ABSENTA
VALUES(1, 1, 1, to_date('12-12-2023','DD-MM-YYYY'), 'nemotivat', null);
INSERT INTO ABSENTA
VALUES(2, 1, 1, to_date('15-11-2023','DD-MM-YYYY'), 'nemotivat', null);
INSERT INTO ABSENTA
VALUES(3, 2, 2, to_date('07-12-2023','DD-MM-YYYY'), 'nemotivat', null);
INSERT INTO ABSENTA
VALUES(4, 3, 5, to_date('27-11-2023','DD-MM-YYYY'), 'nemotivat', null);
INSERT INTO ABSENTA
VALUES(5, 4, 6, to_date('20-11-2023','DD-MM-YYYY'), 'nemotivat', null);

SELECT * FROM ABSENTA;
 
--inserari in tabelul ORAR
INSERT INTO ORAR
VALUES(1, 1, 1, 1,'Luni',TO_CHAR(TO_DATE('08:00', 'HH24:MI'), 'HH24:MI'));
INSERT INTO ORAR
VALUES(1, 2, 2, 6,'Luni',TO_CHAR(TO_DATE('09:00', 'HH24:MI'), 'HH24:MI'));
INSERT INTO ORAR
VALUES(1, 3, 3, 8,'Luni',TO_CHAR(TO_DATE('10:00', 'HH24:MI'), 'HH24:MI'));
INSERT INTO ORAR
VALUES(1, 4, 4, 9,'Marti',TO_CHAR(TO_DATE('08:00', 'HH24:MI'), 'HH24:MI'));
INSERT INTO ORAR
VALUES(1, 5, 5, 1,'Marti',TO_CHAR(TO_DATE('09:00', 'HH24:MI'), 'HH24:MI'));
INSERT INTO ORAR
VALUES(1, 10, 10, 10,'Vineri',TO_CHAR(TO_DATE('10:00', 'HH24:MI'), 'HH24:MI'));
INSERT INTO ORAR
VALUES(2, 5, 5, 2, 'Miercuri', TO_CHAR(TO_DATE('08:00', 'HH24:MI'), 'HH24:MI'));
INSERT INTO ORAR
VALUES(2, 6, 6, 2, 'Miercuri', TO_CHAR(TO_DATE('09:00', 'HH24:MI'), 'HH24:MI'));
INSERT INTO ORAR
VALUES(2, 8, 8, 2, 'Joi', TO_CHAR(TO_DATE('08:00', 'HH24:MI'), 'HH24:MI'));
INSERT INTO ORAR
VALUES(2, 9, 9, 2, 'Joi', TO_CHAR(TO_DATE('09:00', 'HH24:MI'), 'HH24:MI'));

SELECT * FROM ORAR; 
 
--EXERCITIUL 6
--Definiti un subprogram stocat prin care sa afisati notele si data obtinerii acestora la materiile care au loc intr-o zi specificata 
--pentru un elev al carui nume este dat ca parametru.
CREATE OR REPLACE PROCEDURE p_ex6 ( nume_elev ELEV.nume%TYPE, 
                                    zi ORAR.ziua%TYPE)
    IS
        TYPE t_elev IS VARRAY(100) OF ELEV.nume%TYPE;
        v_elev t_elev;
        TYPE t_materii IS TABLE OF MATERIE.denumire%TYPE INDEX BY PLS_INTEGER;
        materii t_materii;
        TYPE r_note_elev IS RECORD(
                    v_nota NOTA.nota%TYPE,
                    v_data_obtinerii NOTA.data_obtinerii%TYPE );
        TYPE t_note_elev IS TABLE OF NOTA.nota%TYPE;
        TYPE t_data_obtinerii IS TABLE OF NOTA.data_obtinerii%TYPE; 
        note_elev t_note_elev;
        data_obtinerii_note t_data_obtinerii;
        nr_note NUMBER;
        NO_MATERII_FOUND EXCEPTION;
BEGIN
    SELECT nume
    BULK COLLECT INTO v_elev
    FROM ELEV
    WHERE UPPER(nume) = UPPER(nume_elev);
    --daca nu avem niciun elev atunci intram pe exceptia NO_DATA_FOUND
    --daca avem mai multi elevi cu acelasi nume intram pe exceptia de TOO_MANY_ROWS
    IF v_elev.COUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    ELSIF v_elev.COUNT > 1 THEN
        RAISE TOO_MANY_ROWS;
    END IF;
    
    SELECT m.denumire
    BULK COLLECT INTO materii
    FROM ORAR o, MATERIE m, ELEV e
    WHERE UPPER(o.ziua)=UPPER(zi) AND m.id_materie = o.id_materie AND e.id_clasa = o.id_clasa AND UPPER(e.nume)=UPPER(v_elev(1)) ;
    
    --verificam daca se preda vreo materie in ziua respectiva
    IF materii.COUNT = 0 THEN
        RAISE NO_MATERII_FOUND;
    END IF;
    
    FOR i IN materii.FIRST..materii.LAST LOOP
        nr_note :=0;
        note_elev := t_note_elev();
        data_obtinerii_note := t_data_obtinerii();
        SELECT COUNT(n.id_elev)
        INTO nr_note
        FROM NOTA n, ELEV e, MATERIE m
        WHERE n.id_elev=e.id_elev AND n.id_materie=m.id_materie AND UPPER(e.nume)=UPPER(v_elev(1)) AND UPPER(m.denumire)=UPPER(materii(i));
        
        IF nr_note = 0 THEN
            DBMS_OUTPUT.PUT_LINE('La materia ' || INITCAP(materii(i)) || ', elevul ' || INITCAP(v_elev(1)) || ' nu are note');
        ELSE
            note_elev.EXTEND(nr_note);
            data_obtinerii_note.EXTEND(nr_note);
            SELECT n.nota, n.data_obtinerii
            BULK COLLECT INTO note_elev, data_obtinerii_note
            FROM NOTA n, MATERIE m
            WHERE n.id_materie=m.id_materie AND UPPER(m.denumire)=UPPER(materii(i));
            DBMS_OUTPUT.PUT_LINE('La materia ' || INITCAP(materii(i)) || ', elevul ' || INITCAP(v_elev(1)) || ' a obtinut notele: ');
            FOR i IN note_elev.FIRST..note_elev.LAST LOOP
                DBMS_OUTPUT.PUT_LINE('Nota: ' || note_elev(i) || ' obtinuta pe data: ' || data_obtinerii_note(i)); 
            END LOOP;
        END IF;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista elev cu numele dat');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Sunt mai multi elevi cu numele dat');
    WHEN NO_MATERII_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu se preda nicio materie in aceasta zi');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20000, 'Alta eroare');
END p_ex6;
/
--apelare procedura
EXECUTE p_ex6('Popescu', 'Luni');
EXECUTE p_ex6('Popescu', 'Joi');
EXECUTE p_ex6('Cochiorca', 'Luni');
EXECUTE p_ex6('Vasile', 'Luni');
/  
--am introdus un elev pentru a intra pe exceptia too_many_rows
INSERT INTO ELEV
VALUES(6,1,'Cochiorca','Mihai','Str. Principala, Nr. 175, Faraoani, Bacau','Masculin',TO_DATE('2005-05-13', 'YYYY-MM-DD'));
SELECT * FROM ELEV;
--6	1	Cochiorca	Mihai	Str. Principala, Nr. 175, Faraoani, Bacau	Masculin	13-MAY-05
--1	1	Popescu	Razvan	Str. Masina de Paine, Nr. 18, Bucuresti	Masculin	15-FEB-05
--2	3	Cochiorca	Oana	Str. Principala, Nr. 175, Faraoani, Bacau	Feminin	10-SEP-06
--3	2	Pal	Francesca	Str. Principala, Nr. 183, Faraoani, Bacau	Masculin	01-OCT-05
--4	2	Dumitru	Elena	Str. Rozelor, Nr. 12, Bucuresti	Feminin	23-MAR-05
--5	1	Marinescu	Cristian	Bd. Republicii, Nr. 30, Bucuresti	Masculin	18-AUG-05
SELECT * FROM ORAR WHERE id_clasa=1;
--1	1	1	1	Luni	08:00
--1	2	2	6	Luni	09:00
--1	3	3	8	Luni	10:00
--1	4	4	9	Marti	08:00
--1	5	5	1	Marti	09:00
--1	10	10	10	Vineri	10:00
SELECT * FROM NOTA WHERE id_elev=1;
--1	1	1	8	23-OCT-23
--2	1	1	10	11-DEC-23
--3	1	2	9	07-NOV-23
 
--EXERCITIUL 7
--Subprogram stocat independent care utilizeaz? 2 tipuri diferite de cursoare
--Definiti un subprogram stocat prin care sa afisati pentru clasele de un profil dat lista cu elevii care au mai mult de doua absente
--nemotivate la cel putin o materie.
CREATE OR REPLACE PROCEDURE p_ex7 ( v_profil IN CLASA.profil%TYPE)
    IS
        CURSOR clase
        IS
            SELECT id_clasa, nume
            FROM CLASA
            WHERE UPPER(profil)=UPPER(v_profil);
        CURSOR elevi(id CLASA.id_clasa%TYPE)
        IS
            SELECT id_elev, nume, prenume
            FROM ELEV
            WHERE id_clasa=id;
        CURSOR materii(id ELEV.id_elev%TYPE)
        IS
            SELECT DISTINCT(m.denumire) as denumire , m.id_materie as id_materie 
            FROM ELEV e, ABSENTA a, MATERIE m
            WHERE a.id_elev = e.id_elev AND a.id_materie=m.id_materie;
        TYPE r_clase IS RECORD(
            id_clasa CLASA.id_clasa%TYPE,
            nume CLASA.nume%TYPE
        );
        TYPE t_clase IS TABLE OF r_clase;
        tabel_clase t_clase;
        TYPE t_materii IS TABLE OF MATERIE.denumire%TYPE;
        tabel_materii t_materii;
        TYPE r_elev IS RECORD(
            id_elev ELEV.id_elev%TYPE,
            nume ELEV.nume%TYPE,
            prenume ELEV.prenume%TYPE
        );
        TYPE t_elevi IS TABLE OF r_elev;
        elevi_clasa t_elevi := t_elevi();
        TYPE t_tabel_elevi IS TABLE OF ELEV.nume%TYPE;
        tabel_elevi t_tabel_elevi := t_tabel_elevi(); --tabel pentru elevii cu mai mult de doua absente nemotivate
        nr_absente NUMBER :=0;
        nu_exista_clasa EXCEPTION;
        nu_exista_elevi EXCEPTION;
BEGIN
    OPEN clase;
    FETCH clase BULK COLLECT INTO tabel_clase;
    --verifica daca exista clase cu acest profil
    IF tabel_clase.COUNT = 0 THEN
        RAISE nu_exista_clasa;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Pentru clasele de profil: ' || v_profil);
    FOR i IN tabel_clase.FIRST..tabel_clase.LAST LOOP
        elevi_clasa := t_elevi();
        OPEN elevi(tabel_clase(i).id_clasa);
        FETCH elevi BULK COLLECT INTO elevi_clasa;
        --verificam daca exista elevi in clasa
        IF elevi_clasa.COUNT = 0 THEN
            RAISE nu_exista_elevi;
        END IF;
        FOR i IN elevi_clasa.FIRST..elevi_clasa.LAST LOOP
            tabel_materii := t_materii();
            FOR materie IN materii(elevi_clasa(i).id_elev) LOOP
                nr_absente :=0;
                SELECT COUNT(*) INTO nr_absente
                FROM ABSENTA a
                WHERE a.id_materie=materie.id_materie AND a.id_elev=elevi_clasa(i).id_elev AND a.motivare = 'nemotivat';
                IF nr_absente >= 2 THEN
                    tabel_materii.EXTEND(1);
                    tabel_materii(tabel_materii.LAST) := materie.denumire;
                END IF;
            END LOOP;
            --daca elevul are mai mult de doua absente nemotivate il adaugam in tabel
            IF tabel_materii.COUNT > 0 THEN
                tabel_elevi.EXTEND(1);
                tabel_elevi(tabel_elevi.LAST) := elevi_clasa(i).nume;
                DBMS_OUTPUT.PUT_LINE('Elevul ' || elevi_clasa(i).nume || ' ' || elevi_clasa(i).prenume || ' are mai mult de doua absente nemotivate la: ');
                FOR i IN tabel_materii.FIRST..tabel_materii.LAST LOOP
                    DBMS_OUTPUT.PUT_LINE(tabel_materii(i));
                END LOOP;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Elevul ' || elevi_clasa(i).nume || ' ' || elevi_clasa(i).prenume || ' nu are absente nemotivate');
            END IF;
        END LOOP;
        CLOSE elevi;
    END LOOP;
    CLOSE clase;
    IF tabel_elevi.COUNT > 0 THEN
        DBMS_OUTPUT.PUT('Elevii care au mai mult de doua absente la cel putin o materie sunt: ');
        FOR i IN tabel_elevi.FIRST..tabel_elevi.LAST LOOP
            DBMS_OUTPUT.PUT(tabel_elevi(i) || ' ');
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nu sunt elevi care au mai mult de doua absente la cel putin o materie');
    END IF;
EXCEPTION
    WHEN nu_exista_clasa THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista clase cu profilul ' || v_profil);
    WHEN nu_exista_elevi THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu toate clasele de profil ' || v_profil || ' au elevi');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20000, 'Alta eroare');
END p_ex7;
/
--inserez inca o absenta pentru elevul cu id-ul 4 la materia cu id-ul 6(unde mai are o absenta)
INSERT INTO ABSENTA
VALUES(6,4,6,TO_DATE('10-10-2023','DD-MM-YYYY'),'nemotivat',null);

SELECT * FROM ABSENTA;
--1	1	1	12-DEC-23	nemotivat	
--2	1	1	15-NOV-23	nemotivat	
--3	2	2	07-DEC-23	nemotivat	
--4	3	5	27-NOV-23	nemotivat	
--5	4	6	20-NOV-23	nemotivat	
--6	4	6	10-OCT-23	nemotivat	

SELECT * FROM CLASA;
--1	Clasa a IX-a A	9	real	matematica-informatica	1	1
--2	Clasa a IX-a B	9	uman	stiinte sociale	2	2
--3	Clasa a X-a A	10	real	matematica-informatica	3	3
--4	Clasa a X-a B	10	real	matematica-informatica	4	4
--5	Clasa a X-a C	10	real	stiinte ale naturii	5	5

SELECT * FROM ELEV;
--6	1	Cochiorca	Mihai	Str. Principala, Nr. 175, Faraoani, Bacau	Masculin	13-MAY-05
--1	1	Popescu	Razvan	Str. Masina de Paine, Nr. 18, Bucuresti	Masculin	15-FEB-05
--2	3	Cochiorca	Oana	Str. Principala, Nr. 175, Faraoani, Bacau	Feminin	10-SEP-06
--3	2	Pal	Francesca	Str. Principala, Nr. 183, Faraoani, Bacau	Masculin	01-OCT-05
--4	2	Dumitru	Elena	Str. Rozelor, Nr. 12, Bucuresti	Feminin	23-MAR-05
--5	1	Marinescu	Cristian	Bd. Republicii, Nr. 30, Bucuresti	Masculin	18-AUG-05

EXECUTE p_ex7('uman');
EXECUTE p_ex7('real'); --ORA-20000: Nu toate clasele de profil real au elevi
EXECUTE p_ex7('tehnologic'); --ORA-20000: Nu exista clase cu profilul tehnologic
/
--EXERCITIUL 8
--Definiti un subprogram stocat independent de tip functie prin care sa obtineti salariul mediu
--al profesorilor care nu predau in sala de curs pentru clasele a caror specializare este data
--exceptii predefinite 
--1.cazul in care nu exista nicio clasa cu aceasta specializare
--2.cazul in care nu exista profesori care sa predea la clasele date
--3.cazul in care nu exista profesori care sa nu predea in sala de curs pentru clasele date
CREATE OR REPLACE FUNCTION f_ex8 ( v_specializare IN CLASA.specializare%TYPE)
    RETURN NUMBER
    IS
        CURSOR profesori_clasa
        IS
            SELECT o.id_profesor
            FROM ORAR o, CLASA c
            WHERE o.id_clasa = c.id_clasa AND UPPER(c.specializare) = UPPER(v_specializare); 
        CURSOR c_profesori(id PROFESOR.id_profesor%TYPE)
        IS
            SELECT p.salariu
            FROM ORAR o, PROFESOR p, SALA s
            WHERE o.id_profesor=id AND p.id_profesor=o.id_profesor AND UPPER(s.tip_de_sala) != UPPER('sala de curs') AND o.id_sala=s.id_sala;
        nr_clase NUMBER;  
        TYPE t_clase IS TABLE OF CLASA.id_clasa%TYPE;
        tabel_clase t_clase;
        TYPE t_profesori IS TABLE OF PROFESOR.id_profesor%TYPE;
        tabel_profesori t_profesori;
        TYPE t_salarii IS TABLE OF PROFESOR.salariu%TYPE;
        tabel_salarii t_salarii := t_salarii();
        salariu NUMBER :=0;
        salariu_mediu NUMBER :=0;
        nr_profesori NUMBER :=0;
        NO_CLASA_FOUND EXCEPTION;
        NO_PROFESOR_FOUND EXCEPTION;
        NO_PROFESOR_FOUND2 EXCEPTION;
    BEGIN
        SELECT id_clasa
        BULK COLLECT INTO tabel_clase
        FROM CLASA
        WHERE UPPER(specializare) = UPPER(v_specializare);
        --daca nu exista clase cu specializarea data intra pe exceptia no_clasa_found
        IF tabel_clase.COUNT = 0 THEN
            RAISE NO_CLASA_FOUND;
        ELSE
            OPEN profesori_clasa;
            FETCH profesori_clasa BULK COLLECT INTO tabel_profesori;
            CLOSE profesori_clasa;
            --daca nu exista profesori care predau la aceasta specializare
            IF tabel_profesori.COUNT = 0 THEN 
                RAISE NO_PROFESOR_FOUND;
            ELSE
                FOR i IN tabel_profesori.FIRST..tabel_profesori.LAST LOOP
                    salariu := 0; 
                    OPEN c_profesori(tabel_profesori(i));
                    FETCH  c_profesori INTO salariu;
                    CLOSE c_profesori;
                    IF salariu > 0 THEN
                        DBMS_OUTPUT.PUT_LINE(salariu);
                        salariu_mediu := salariu_mediu+salariu;
                        nr_profesori := nr_profesori + 1;
                    END IF;
                END LOOP;
                --daca nu exista profesori care nu predau in sala de curs la aceasta specializare
                IF salariu_mediu = 0 THEN
                    RAISE NO_PROFESOR_FOUND2;
                ELSE
                    salariu_mediu := salariu_mediu / nr_profesori;
                    RETURN salariu_mediu;
                END IF;
            END IF;
        END IF;

EXCEPTION
    WHEN NO_CLASA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,'Nu exista clase cu specializarea ' || v_specializare);
        RETURN -1;
    WHEN NO_PROFESOR_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,'Nu exista profesori care predau la clasele cu specializarea ' || v_specializare);
        RETURN -2;
    WHEN NO_PROFESOR_FOUND2 THEN
        RAISE_APPLICATION_ERROR(-20000,'Nu exista profesori care nu predau in sala de curs la clasele cu specializarea ' || v_specializare); 
        RETURN -3;
END f_ex8;
/
SELECT * FROM CLASA;
--1	Clasa a IX-a A	9	real	matematica-informatica	1	1
--2	Clasa a IX-a B	9	uman	stiinte sociale	2	2
--3	Clasa a X-a A	10	real	matematica-informatica	3	3
--4	Clasa a X-a B	10	real	matematica-informatica	4	4
--5	Clasa a X-a C	10	real	stiinte ale naturii	5	5
SELECT * FROM ORAR;
--1	1	1	1	Luni	08:00
--1	2	2	6	Luni	09:00
--1	3	3	8	Luni	10:00
--1	4	4	9	Marti	08:00
--1	5	5	1	Marti	09:00
--1	10	10	10	Vineri	10:00
--2	5	5	2	Miercuri	08:00
--2	6	6	2	Miercuri	09:00
--2	8	8	2	Joi	08:00
--2	9	9	2	Joi	09:00
SELECT * FROM PROFESOR;
--1	Popescu	Ion	15-MAY-80	masculin	Str. Victoriei, Nr. 20, Bucuresti
--2	Ionescu	Ana	20-AUG-75	feminin	Str. Unirii, Nr. 30, Bucuresti
--3	Radu	Mihai	10-FEB-82	masculin	Bd. Carol I, Nr. 15, Bucuresti
--4	Dumitru	Elena	03-NOV-88	feminin	Str. Lipscani, Nr. 25, Bucuresti
--5	Marinescu	Cristian	08-JUL-73	masculin	Bd. Magheru, Nr. 18, Bucuresti
--6	Stan	Andreea	25-APR-85	feminin	Str. Dorobanti, Nr. 12, Bucuresti
--7	Moldovan	Dorin	18-SEP-79	masculin	Bd. Dacia, Nr. 22, Bucuresti
--8	Gheorghe	Gabriela	07-DEC-87	feminin	Str. Romana, Nr. 8, Bucuresti
--9	Cristea	Adrian	30-JUN-84	masculin	Bd. Unirii, Nr. 18, Bucuresti
--10	Alexandrescu	Camelia	12-MAR-81	feminin	Str. Calea Victoriei, Nr. 7, Bucuresti
--apelare functie pentru toate cazurile
DECLARE
    rezultat NUMBER;
    v_specializare CLASA.specializare%TYPE := 'matematica-informatica';
BEGIN
    rezultat := f_ex8(v_specializare);
    DBMS_OUTPUT.PUT_LINE('Salariul mediu al profesorilor care nu predau in sala de curs pentru clasele cu specializarea ' || v_specializare || ' este ' || rezultat);
END;
/
DECLARE
    rezultat NUMBER;
    v_specializare CLASA.specializare%TYPE := 'stiinte sociale';
BEGIN
    rezultat := f_ex8(v_specializare);
    DBMS_OUTPUT.PUT_LINE('Salariul mediu al profesorilor care nu predau in sala de curs pentru clasele cu specializarea ' || v_specializare || ' este ' || rezultat);
END;
/
DECLARE
    rezultat NUMBER;
    v_specializare CLASA.specializare%TYPE := 'stiinte ale naturii';
BEGIN
    rezultat := f_ex8(v_specializare);
    DBMS_OUTPUT.PUT_LINE('Salariul mediu al profesorilor care nu predau in sala de curs pentru clasele cu specializarea ' || v_specializare || ' este ' || rezultat);
END;
/
DECLARE
    rezultat NUMBER;
    v_specializare CLASA.specializare%TYPE := 'filologie';
BEGIN
    rezultat := f_ex8(v_specializare);
    DBMS_OUTPUT.PUT_LINE('Salariul mediu al profesorilor care nu predau in sala de curs pentru clasele cu specializarea ' || v_specializare || ' este ' || rezultat);
END;
/

--EXERCITIUL 9
--Definiti un subprogram stocat indepedent de tip procedura care sa afiseze orarul 
--unei clase din care face parte un elev dat prin nume 
--si sa se obtina nr de ore pentru o zi data
CREATE OR REPLACE PROCEDURE p_ex9(v_nume IN ELEV.nume%TYPE,
                                    zi IN VARCHAR2,
                                    nr_ore OUT NUMBER
                                  )
    IS
        TYPE r_orar IS RECORD (
                    ora ORAR.ora%TYPE,
                    denumire_materie MATERIE.denumire%TYPE,
                    nume_profesor PROFESOR.nume%TYPE,
                    prenume_profesor PROFESOR.prenume%TYPE,
                    denumire_sala SALA.denumire%TYPE
                );
        TYPE t_orar_clasa IS TABLE OF r_orar;
        tabel_orar t_orar_clasa;
        TYPE t_zile IS TABLE OF ORAR.ziua%TYPE;
        tabel_zile t_zile;
        
        nr_elevi NUMBER;
        
        CURSOR zile
        IS
            SELECT DISTINCT(o.ziua)
            FROM ORAR o, ELEV e
            WHERE o.id_clasa=e.id_clasa AND UPPER(e.nume) = UPPER(v_nume);
            
        CURSOR orar_clasa(v_zi ORAR.ziua%TYPE)
        IS
            SELECT o.ora, m.denumire, p.nume, p.prenume, s.denumire
            FROM ORAR o
            JOIN MATERIE m ON o.id_materie = m.id_materie
            JOIN PROFESOR p ON o.id_profesor = p.id_profesor
            JOIN SALA s ON o.id_sala = s.id_sala
            JOIN ELEV e ON o.id_clasa = e.id_clasa
            WHERE UPPER(e.nume) = UPPER(v_nume) AND UPPER(o.ziua) = UPPER(v_zi);
        ZI_INVALIDA EXCEPTION; --definim exceptia in care se da o zi invalida
        NO_ORAR EXCEPTION; --definim exceptia in care elevul nu are orar
    BEGIN
        IF INITCAP(zi) NOT IN ('Luni', 'Marti', 'Miercuri', 'Joi', 'Vineri', 'Sambata', 'Duminica') THEN
            RAISE ZI_INVALIDA;
        END IF;
        SELECT COUNT(*) INTO nr_elevi
        FROM ELEV
        WHERE UPPER(nume) = UPPER(v_nume);
        IF nr_elevi = 0 THEN
            RAISE NO_DATA_FOUND;
        ELSIF nr_elevi > 1 THEN 
            RAISE TOO_MANY_ROWS;
        ELSE
            OPEN zile;
            FETCH zile BULK COLLECT INTO tabel_zile;
            IF tabel_zile.COUNT = 0 THEN
                RAISE NO_ORAR;
            ELSE
                FOR i IN tabel_zile.FIRST..tabel_zile.LAST LOOP
                    OPEN orar_clasa(tabel_zile(i));
                    FETCH orar_clasa BULK COLLECT INTO tabel_orar;
                    CLOSE orar_clasa;
                    IF tabel_orar.COUNT = 0 THEN
                        DBMS_OUTPUT.PUT_LINE(tabel_zile(i) || ', elevul ' || v_nume ||' nu are ore'); 
                    ELSE
                        IF UPPER(zi) = UPPER(tabel_zile(i)) THEN
                            nr_ore := tabel_orar.COUNT;
                        END IF;
                        DBMS_OUTPUT.PUT_LINE(tabel_zile(i) || ', elevul ' || v_nume ||' are urmatoarele ore:');
                        FOR i IN tabel_orar.FIRST..tabel_orar.LAST LOOP
                            DBMS_OUTPUT.PUT_LINE('Ora: ' || tabel_orar(i).ora || ', Materia: ' || tabel_orar(i).denumire_materie);
                            DBMS_OUTPUT.PUT_LINE('Preda profesorul: ' || tabel_orar(i).nume_profesor || ' ' || tabel_orar(i).prenume_profesor);
                            DBMS_OUTPUT.PUT_LINE('Ora are loc in ' || tabel_orar(i).denumire_sala);
                        END LOOP;
                        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
                    END IF;
                END LOOP;
            END IF;
            CLOSE zile;
        END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista elev cu numele dat');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Exista mai multi elevi cu numele ' || v_nume);
    WHEN NO_ORAR THEN
        RAISE_APPLICATION_ERROR(-20000, 'Elevul nu are orar!');
    WHEN ZI_INVALIDA THEN
        RAISE_APPLICATION_ERROR(-20000, 'Zi invalida!');
END p_ex9;
/
--inserez un nou elev pentru a intra pe exceptia no_orar
INSERT INTO ELEV 
VALUES (7, 4, 'Stan', 'Andreea', 'Str. Reinvierii, Nr. 4, Bucuresti', 'Feminin', TO_DATE('2006-04-25', 'YYYY-MM-DD'));

SELECT * FROM ELEV;
--6	1	Cochiorca	Mihai	Str. Principala, Nr. 175, Faraoani, Bacau	Masculin	13-MAY-05
--7	4	Stan	Andreea	Str. Reinvierii, Nr. 4, Bucuresti	Feminin	25-APR-06
--1	1	Popescu	Razvan	Str. Masina de Paine, Nr. 18, Bucuresti	Masculin	15-FEB-05
--2	3	Cochiorca	Oana	Str. Principala, Nr. 175, Faraoani, Bacau	Feminin	10-SEP-06
--3	2	Pal	Francesca	Str. Principala, Nr. 183, Faraoani, Bacau	Masculin	01-OCT-05
--4	2	Dumitru	Elena	Str. Rozelor, Nr. 12, Bucuresti	Feminin	23-MAR-05
--5	1	Marinescu	Cristian	Bd. Republicii, Nr. 30, Bucuresti	Masculin	18-AUG-05
SELECT * FROM ORAR;
--1	1	1	1	Luni	08:00
--1	2	2	6	Luni	09:00
--1	3	3	8	Luni	10:00
--1	4	4	9	Marti	08:00
--1	5	5	1	Marti	09:00
--1	10	10	10	Vineri	10:00
--2	5	5	2	Miercuri	08:00
--2	6	6	2	Miercuri	09:00
--2	8	8	2	Joi	08:00
--2	9	9	2	Joi	09:00
DECLARE
    rezultat NUMBER;
    zi VARCHAR2(100) := 'Luni';
    nume ELEV.nume%TYPE := 'Popescu';
BEGIN
    p_ex9(nume,zi, rezultat);
    IF rezultat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Elevul are ' || rezultat || ' ore ' || lower(zi));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Elevul nu are ore ' || lower(zi));
    END IF;
END;
/
DECLARE
    rezultat NUMBER;
    zi VARCHAR2(100) := 'Luni';
    nume ELEV.nume%TYPE := 'Cochiorca';
BEGIN
    p_ex9(nume,zi, rezultat);
    IF rezultat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Elevul are ' || rezultat || ' ore ' || lower(zi));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Elevul nu are ore ' || lower(zi));
    END IF;
END;
/
DECLARE
    rezultat NUMBER;
    zi VARCHAR2(100) := 'Luni';
    nume ELEV.nume%TYPE := 'Dobre';
BEGIN
    p_ex9(nume,zi, rezultat);
    IF rezultat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Elevul are ' || rezultat || ' ore ' || lower(zi));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Elevul nu are ore ' || lower(zi));
    END IF;
END;
/
DECLARE
    rezultat NUMBER;
    zi VARCHAR2(100) := 'Craciun';
    nume ELEV.nume%TYPE := 'Popescu';
BEGIN
    p_ex9(nume,zi, rezultat);
    IF rezultat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Elevul are ' || rezultat || ' ore ' || lower(zi));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Elevul nu are ore ' || lower(zi));
    END IF;
END;
/
DECLARE
    rezultat NUMBER;
    zi VARCHAR2(100) := 'Duminica';
    nume ELEV.nume%TYPE := 'Stan';
BEGIN
    p_ex9(nume,zi, rezultat);
    IF rezultat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Elevul are ' || rezultat || ' ore ' || lower(zi));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Elevul nu are ore ' || lower(zi));
    END IF;
END;
/

--EXERCITIUL 10
--Creati un trigger care sa se declanseze atunci cand incercati sa modificati tabela ABSENTA
--in afara programului scolar (nu se afla in intervalul orar 8-14, si zilele Luni-Vineri)
CREATE OR REPLACE TRIGGER t_ex10 
    BEFORE INSERT OR DELETE OR UPDATE on ABSENTA 
BEGIN 
    IF TO_CHAR(SYSDATE, 'DAY') IN ('SATURDAY', 'SUNDAY') OR (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 8 AND 14) THEN 
        IF INSERTING THEN 
            RAISE_APPLICATION_ERROR(-20000,'Adaugarea unei absente este permisa doar in timpul programului scolar!'); 
        ELSIF DELETING THEN 
            RAISE_APPLICATION_ERROR(-20000,'Stergerea unei absente este permisa doar in timpul programului scolar!'); 
        ELSE  
            RAISE_APPLICATION_ERROR(-20000,'Modificarea unei absente este permisa doar in timpul programului scolar!');  
        END IF; 
    END IF; 
END; 
/ 

INSERT INTO ABSENTA
VALUES (1,1,1,SYSDATE,1,'nemotivat',null);

--Creati un trigger care sa se declanseze atunci cand se doreste sa se faca operatii de insert sau delete
--asupra tabelului TUTORE_ELEV astfel incat un elev sa nu poata avea mai mult de doi tutori dar sa aiba cel putin un tutore
CREATE OR REPLACE PACKAGE pachet_elevi 
AS 
   TYPE r_tutori_elev IS RECORD  
    (id TUTORE_ELEV.id_elev%TYPE, 
     nr_tutori NUMBER(1)); 
   TYPE t_tutori_elev IS TABLE OF r_tutori_elev 
        INDEX BY PLS_INTEGER; 
   tutori_elev t_tutori_elev; 
END; 
/
CREATE OR REPLACE TRIGGER trig_comanda 
BEFORE INSERT OR DELETE
       ON TUTORE_ELEV 
BEGIN 
  SELECT id_elev, COUNT(*)  
  BULK COLLECT INTO pachet_elevi.tutori_elev 
  FROM  TUTORE_ELEV 
  GROUP BY id_elev; 
END; 
/ 
CREATE OR REPLACE TRIGGER trig_linie 
BEFORE INSERT OR DELETE
ON TUTORE_ELEV 
FOR EACH ROW 
BEGIN
  FOR i in 1..pachet_elevi.tutori_elev.last LOOP
    DBMS_OUTPUT.PUT_LINE(pachet_elevi.tutori_elev(i).nr_tutori);
    IF pachet_elevi.tutori_elev(i).id = :NEW.id_elev AND pachet_elevi.tutori_elev(i).nr_tutori =2 THEN 
            RAISE_APPLICATION_ERROR(-20000,'elevul cu id-ul ' || :NEW.id_elev ||' nu poate avea mai mult de doi tutori'); 
    ELSIF pachet_elevi.tutori_elev(i).id = :OLD.id_elev AND pachet_elevi.tutori_elev(i).nr_tutori = 1 THEN 
        RAISE_APPLICATION_ERROR(-20000,'elevul cu id-ul ' || :OLD.id_elev || ' are cel putin un tutore!');  
    END IF; 
  END LOOP; 
END; 
/
--declansare trigger
SELECT * FROM TUTORE_ELEV WHERE ID_ELEV=2;
--2	3	tata
--2	4	mama
INSERT INTO TUTORE_ELEV
VALUES (2,5,'unchi'); 
--ORA-20000: elevul cu id-ul 2 nu poate avea mai mult de doi tutori 
DELETE FROM TUTORE_ELEV WHERE id_elev=2 and id_tutore=4;--primul delete a functionat
DELETE FROM TUTORE_ELEV WHERE id_elev=2 and id_tutore=3;--al doilea -> s-a declansat trigger
ROLLBACK;

--EXERCITIUL 11
--Creati o vizualizare care sa cuprinda elevii si denumirea claselor din care fac parte
--Creati un trigger care atunci cand se incearca transferul unui elev intr-o clasa noua sa se modifice id-ul clasei
--al elevului corespunzator sau sa il introduca in baza de date. Transferul unui elev este permis doar daca
--in clasa nu sunt mai mult de 4 elevi

CREATE OR REPLACE VIEW clase 
AS 
SELECT e.*, c.nume as nume_clasa
FROM   CLASA c, ELEV e
WHERE  e.id_clasa=c.id_clasa;

SELECT * FROM CLASE;

CREATE OR REPLACE FUNCTION exista_elev(id ELEV.id_elev%TYPE)
RETURN NUMBER
IS
    nr NUMBER(1);
BEGIN
    SELECT count(*) into nr
    FROM ELEV
    WHERE id_elev=id;
    return nr;
END exista_elev;
/
CREATE OR REPLACE TRIGGER actualizeaza_clasa
    INSTEAD OF INSERT OR DELETE OR UPDATE ON clase
    FOR EACH ROW
DECLARE 
    nr_elevi NUMBER(1); 
    CURSOR c_id(v_nume CLASA.nume%TYPE)
    IS
        SELECT id_clasa
        FROM CLASA
        WHERE UPPER(nume) = UPPER(v_nume);
    id CLASA.id_clasa%TYPE;
BEGIN
IF INSERTING THEN 
    -- inserarea in vizualizare determina inserarea 
    -- in ELEV daca mai este loc in clasa
    -- se verifica id-ul elevului sa fie corespunzator
    IF exista_elev(:NEW.id_elev) = 1 THEN
        RAISE_APPLICATION_ERROR(-20000,'Exista deja elevul cu id-ul ' || :NEW.id_elev);
    ELSE
        --se verifica daca elevul se poate transfera
        SELECT COUNT(*) INTO nr_elevi
        FROM ELEV
        WHERE id_clasa = :NEW.id_clasa;
        IF nr_elevi > 3 THEN
            RAISE_APPLICATION_ERROR(-20000,'Nu se poate transfera elevul in clasa ' || :NEW.nume_clasa);
        END IF;
        INSERT INTO ELEV
        VALUES (:NEW.id_elev, :NEW.id_clasa, :NEW.nume, :NEW.prenume,
               :NEW.adresa,:NEW.gen,:NEW.data_nastere);
    END IF;
ELSIF DELETING THEN
   -- stergerea unui elev din vizualizare determina
   -- stergerea din ELEV
   DELETE FROM ELEV
   WHERE  id_elev = :OLD.id_elev;
ELSIF UPDATING ('id_clasa') THEN
    --transferul unui elev din vizualizare determina modificarea id_clasa al elevului in tabela ELEV
    --se verifica daca elevul se poate transfera
    SELECT COUNT(*) INTO nr_elevi
    FROM ELEV
    WHERE id_clasa = :NEW.id_clasa;
    IF nr_elevi > 3 THEN
        RAISE_APPLICATION_ERROR(-20000,'Nu se poate transfera elevul in clasa ' || :NEW.nume_clasa);
    END IF;
    --altfel se face transferul	
    UPDATE ELEV
    SET id_clasa=:NEW.id_clasa
    WHERE id_elev = :NEW.id_elev;
ELSIF UPDATING ('nume_clasa') THEN
    SELECT COUNT(*) INTO nr_elevi
    FROM ELEV e, CLASA c
    WHERE e.id_clasa = c.id_clasa AND UPPER(c.nume) = UPPER(:NEW.nume_clasa);
    IF nr_elevi > 3 THEN
        RAISE_APPLICATION_ERROR(-20000,'Nu se poate transfera elevul in clasa ' || :NEW.nume_clasa);
    END IF;
    OPEN c_id(:NEW.nume_clasa);
    FETCH c_id INTO id;
    UPDATE ELEV
    SET id_clasa=id
    WHERE id_elev = :NEW.id_elev;
    CLOSE c_id;
ELSE
     RAISE_APPLICATION_ERROR(-20000, 'Se pot face operatiuni doar asupra clasei din care face parte elevul');
END IF;
END;
/

--declansare trigger actualizeaza_clasa
--ORA-20000: Nu se poate transfera elevul in clasa Clasa a IX-a A
UPDATE clase
SET nume_clasa='Clasa a IX-a A'
WHERE id_elev=7;

--EXERCITIUL 12
--Creati tabelul audit_com_12 cu urmatoarele campuri: 
-- - utilizator (numele utilizatorului)
-- - nume_bd (numele bazei de date)
-- - eveniment (evenimentul sistem)
-- - nume_obiect (numele obiectului)
-- - data (data producerii evenimentului) 
--Definiti un declansator care sa introduca date in acest tabel dupa ce utilizatorul a folosit o comanda LDD 
CREATE TABLE audit_com_12
   (utilizator     VARCHAR2(30),
    nume_bd        VARCHAR2(50),
    eveniment      VARCHAR2(20),
    nume_obiect    VARCHAR2(30),
    data           DATE);
CREATE OR REPLACE TRIGGER trig_ex12_com
  AFTER CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
  INSERT INTO audit_com_12
  VALUES (SYS.LOGIN_USER, SYS.DATABASE_NAME, SYS.SYSEVENT, 
          SYS.DICTIONARY_OBJ_NAME, SYSDATE);
END;
/

--declansare trigger
CREATE INDEX ind_com ON elev(nume);
DROP INDEX ind_com;
SELECT * FROM audit_com_12;
--OANAA	XE	CREATE	IND_COM	12-JAN-24
--OANAA	XE	DROP	IND_COM	12-JAN-24

--EXERCITIUL 13
CREATE OR REPLACE PACKAGE pachet_ex13 AS
    PROCEDURE p_ex6 ( nume_elev ELEV.nume%TYPE, zi ORAR.ziua%TYPE);
    PROCEDURE p_ex7 ( v_profil IN CLASA.profil%TYPE);
    FUNCTION f_ex8 ( v_specializare IN CLASA.specializare%TYPE)RETURN NUMBER;
    PROCEDURE p_ex9(v_nume IN ELEV.nume%TYPE,zi IN VARCHAR2,nr_ore OUT NUMBER);
END pachet_ex13;
/
CREATE OR REPLACE PACKAGE BODY pachet_ex13 
AS
PROCEDURE p_ex6 ( nume_elev ELEV.nume%TYPE, zi ORAR.ziua%TYPE)
    IS
        TYPE t_elev IS VARRAY(100) OF ELEV.nume%TYPE;
        v_elev t_elev;
        TYPE t_materii IS TABLE OF MATERIE.denumire%TYPE INDEX BY PLS_INTEGER;
        materii t_materii;
        TYPE r_note_elev IS RECORD(
                    v_nota NOTA.nota%TYPE,
                    v_data_obtinerii NOTA.data_obtinerii%TYPE );
        TYPE t_note_elev IS TABLE OF NOTA.nota%TYPE;
        TYPE t_data_obtinerii IS TABLE OF NOTA.data_obtinerii%TYPE; 
        note_elev t_note_elev;
        data_obtinerii_note t_data_obtinerii;
        nr_note NUMBER;
        NO_MATERII_FOUND EXCEPTION;
BEGIN
    SELECT nume
    BULK COLLECT INTO v_elev
    FROM ELEV
    WHERE UPPER(nume) = UPPER(nume_elev);
    --daca nu avem niciun elev atunci intram pe exceptia NO_DATA_FOUND
    --daca avem mai multi elevi cu acelasi nume intram pe exceptia de TOO_MANY_ROWS
    IF v_elev.COUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    ELSIF v_elev.COUNT > 1 THEN
        RAISE TOO_MANY_ROWS;
    END IF;
    
    SELECT m.denumire
    BULK COLLECT INTO materii
    FROM ORAR o, MATERIE m, ELEV e
    WHERE UPPER(o.ziua)=UPPER(zi) AND m.id_materie = o.id_materie AND e.id_clasa = o.id_clasa AND UPPER(e.nume)=UPPER(v_elev(1)) ;
    
    --verificam daca se preda vreo materie in ziua respectiva
    IF materii.COUNT = 0 THEN
        RAISE NO_MATERII_FOUND;
    END IF;
    
    FOR i IN materii.FIRST..materii.LAST LOOP
        nr_note :=0;
        note_elev := t_note_elev();
        data_obtinerii_note := t_data_obtinerii();
        SELECT COUNT(n.id_elev)
        INTO nr_note
        FROM NOTA n, ELEV e, MATERIE m
        WHERE n.id_elev=e.id_elev AND n.id_materie=m.id_materie AND UPPER(e.nume)=UPPER(v_elev(1)) AND UPPER(m.denumire)=UPPER(materii(i));
        
        IF nr_note = 0 THEN
            DBMS_OUTPUT.PUT_LINE('La materia ' || INITCAP(materii(i)) || ', elevul ' || INITCAP(v_elev(1)) || ' nu are note');
        ELSE
            note_elev.EXTEND(nr_note);
            data_obtinerii_note.EXTEND(nr_note);
            SELECT n.nota, n.data_obtinerii
            BULK COLLECT INTO note_elev, data_obtinerii_note
            FROM NOTA n, MATERIE m
            WHERE n.id_materie=m.id_materie AND UPPER(m.denumire)=UPPER(materii(i));
            DBMS_OUTPUT.PUT_LINE('La materia ' || INITCAP(materii(i)) || ', elevul ' || INITCAP(v_elev(1)) || ' a obtinut notele: ');
            FOR i IN note_elev.FIRST..note_elev.LAST LOOP
                DBMS_OUTPUT.PUT_LINE('Nota: ' || note_elev(i) || ' obtinuta pe data: ' || data_obtinerii_note(i)); 
            END LOOP;
        END IF;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista elev cu numele dat');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Sunt mai multi elevi cu numele dat');
    WHEN NO_MATERII_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu se preda nicio materie in aceasta zi');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20000, 'Alta eroare');
END p_ex6;

PROCEDURE p_ex7 ( v_profil IN CLASA.profil%TYPE)
    IS
        CURSOR clase
        IS
            SELECT id_clasa, nume
            FROM CLASA
            WHERE UPPER(profil)=UPPER(v_profil);
        CURSOR elevi(id CLASA.id_clasa%TYPE)
        IS
            SELECT id_elev, nume, prenume
            FROM ELEV
            WHERE id_clasa=id;
        CURSOR materii(id ELEV.id_elev%TYPE)
        IS
            SELECT DISTINCT(m.denumire) as denumire , m.id_materie as id_materie 
            FROM ELEV e, ABSENTA a, MATERIE m
            WHERE a.id_elev = e.id_elev AND a.id_materie=m.id_materie;
        TYPE r_clase IS RECORD(
            id_clasa CLASA.id_clasa%TYPE,
            nume CLASA.nume%TYPE
        );
        TYPE t_clase IS TABLE OF r_clase;
        tabel_clase t_clase;
        TYPE t_materii IS TABLE OF MATERIE.denumire%TYPE;
        tabel_materii t_materii;
        TYPE r_elev IS RECORD(
            id_elev ELEV.id_elev%TYPE,
            nume ELEV.nume%TYPE,
            prenume ELEV.prenume%TYPE
        );
        TYPE t_elevi IS TABLE OF r_elev;
        elevi_clasa t_elevi := t_elevi();
        TYPE t_tabel_elevi IS TABLE OF ELEV.nume%TYPE;
        tabel_elevi t_tabel_elevi := t_tabel_elevi(); --tabel pentru elevii cu mai mult de doua absente nemotivate
        nr_absente NUMBER :=0;
        nu_exista_clasa EXCEPTION;
        nu_exista_elevi EXCEPTION;
BEGIN
    OPEN clase;
    FETCH clase BULK COLLECT INTO tabel_clase;
    --verifica daca exista clase cu acest profil
    IF tabel_clase.COUNT = 0 THEN
        RAISE nu_exista_clasa;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Pentru clasele de profil: ' || v_profil);
    FOR i IN tabel_clase.FIRST..tabel_clase.LAST LOOP
        elevi_clasa := t_elevi();
        OPEN elevi(tabel_clase(i).id_clasa);
        FETCH elevi BULK COLLECT INTO elevi_clasa;
        --verificam daca exista elevi in clasa
        IF elevi_clasa.COUNT = 0 THEN
            RAISE nu_exista_elevi;
        END IF;
        FOR i IN elevi_clasa.FIRST..elevi_clasa.LAST LOOP
            tabel_materii := t_materii();
            FOR materie IN materii(elevi_clasa(i).id_elev) LOOP
                nr_absente :=0;
                SELECT COUNT(*) INTO nr_absente
                FROM ABSENTA a
                WHERE a.id_materie=materie.id_materie AND a.id_elev=elevi_clasa(i).id_elev AND a.motivare = 'nemotivat';
                IF nr_absente >= 2 THEN
                    tabel_materii.EXTEND(1);
                    tabel_materii(tabel_materii.LAST) := materie.denumire;
                END IF;
            END LOOP;
            --daca elevul are mai mult de doua absente nemotivate il adaugam in tabel
            IF tabel_materii.COUNT > 0 THEN
                tabel_elevi.EXTEND(1);
                tabel_elevi(tabel_elevi.LAST) := elevi_clasa(i).nume;
                DBMS_OUTPUT.PUT_LINE('Elevul ' || elevi_clasa(i).nume || ' ' || elevi_clasa(i).prenume || ' are mai mult de doua absente nemotivate la: ');
                FOR i IN tabel_materii.FIRST..tabel_materii.LAST LOOP
                    DBMS_OUTPUT.PUT_LINE(tabel_materii(i));
                END LOOP;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Elevul ' || elevi_clasa(i).nume || ' ' || elevi_clasa(i).prenume || ' nu are absente nemotivate');
            END IF;
        END LOOP;
        CLOSE elevi;
    END LOOP;
    CLOSE clase;
    IF tabel_elevi.COUNT > 0 THEN
        DBMS_OUTPUT.PUT('Elevii care au mai mult de doua absente la cel putin o materie sunt: ');
        FOR i IN tabel_elevi.FIRST..tabel_elevi.LAST LOOP
            DBMS_OUTPUT.PUT(tabel_elevi(i) || ' ');
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nu sunt elevi care au mai mult de doua absente la cel putin o materie');
    END IF;
EXCEPTION
    WHEN nu_exista_clasa THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista clase cu profilul ' || v_profil);
    WHEN nu_exista_elevi THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu toate clasele de profil ' || v_profil || ' au elevi');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error Message: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20000, 'Alta eroare');
END p_ex7;

FUNCTION f_ex8 ( v_specializare IN CLASA.specializare%TYPE)
    RETURN NUMBER
    IS
        CURSOR profesori_clasa
        IS
            SELECT o.id_profesor
            FROM ORAR o, CLASA c
            WHERE o.id_clasa = c.id_clasa AND UPPER(c.specializare) = UPPER(v_specializare); 
        CURSOR c_profesori(id PROFESOR.id_profesor%TYPE)
        IS
            SELECT p.salariu
            FROM ORAR o, PROFESOR p, SALA s
            WHERE o.id_profesor=id AND p.id_profesor=o.id_profesor AND UPPER(s.tip_de_sala) != UPPER('sala de curs') AND o.id_sala=s.id_sala;
        nr_clase NUMBER;  
        TYPE t_clase IS TABLE OF CLASA.id_clasa%TYPE;
        tabel_clase t_clase;
        TYPE t_profesori IS TABLE OF PROFESOR.id_profesor%TYPE;
        tabel_profesori t_profesori;
        TYPE t_salarii IS TABLE OF PROFESOR.salariu%TYPE;
        tabel_salarii t_salarii := t_salarii();
        salariu NUMBER :=0;
        salariu_mediu NUMBER :=0;
        nr_profesori NUMBER :=0;
        NO_CLASA_FOUND EXCEPTION;
        NO_PROFESOR_FOUND EXCEPTION;
        NO_PROFESOR_FOUND2 EXCEPTION;
    BEGIN
        SELECT id_clasa
        BULK COLLECT INTO tabel_clase
        FROM CLASA
        WHERE UPPER(specializare) = UPPER(v_specializare);
        --daca nu exista clase cu specializarea data intra pe exceptia no_clasa_found
        IF tabel_clase.COUNT = 0 THEN
            RAISE NO_CLASA_FOUND;
        ELSE
            OPEN profesori_clasa;
            FETCH profesori_clasa BULK COLLECT INTO tabel_profesori;
            CLOSE profesori_clasa;
            --daca nu exista profesori care predau la aceasta specializare
            IF tabel_profesori.COUNT = 0 THEN 
                RAISE NO_PROFESOR_FOUND;
            ELSE
                FOR i IN tabel_profesori.FIRST..tabel_profesori.LAST LOOP
                    salariu := 0; 
                    OPEN c_profesori(tabel_profesori(i));
                    FETCH  c_profesori INTO salariu;
                    CLOSE c_profesori;
                    IF salariu > 0 THEN
                        DBMS_OUTPUT.PUT_LINE(salariu);
                        salariu_mediu := salariu_mediu+salariu;
                        nr_profesori := nr_profesori + 1;
                    END IF;
                END LOOP;
                --daca nu exista profesori care nu predau in sala de curs la aceasta specializare
                IF salariu_mediu = 0 THEN
                    RAISE NO_PROFESOR_FOUND2;
                ELSE
                    salariu_mediu := salariu_mediu / nr_profesori;
                    RETURN salariu_mediu;
                END IF;
            END IF;
        END IF;

EXCEPTION
    WHEN NO_CLASA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,'Nu exista clase cu specializarea ' || v_specializare);
        RETURN -1;
    WHEN NO_PROFESOR_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,'Nu exista profesori care predau la clasele cu specializarea ' || v_specializare);
        RETURN -2;
    WHEN NO_PROFESOR_FOUND2 THEN
        RAISE_APPLICATION_ERROR(-20000,'Nu exista profesori care nu predau in sala de curs la clasele cu specializarea ' || v_specializare); 
        RETURN -3;
END f_ex8;

PROCEDURE p_ex9(v_nume IN ELEV.nume%TYPE, zi IN VARCHAR2, nr_ore OUT NUMBER)
    IS
        TYPE r_orar IS RECORD (
                    ora ORAR.ora%TYPE,
                    denumire_materie MATERIE.denumire%TYPE,
                    nume_profesor PROFESOR.nume%TYPE,
                    prenume_profesor PROFESOR.prenume%TYPE,
                    denumire_sala SALA.denumire%TYPE
                );
        TYPE t_orar_clasa IS TABLE OF r_orar;
        tabel_orar t_orar_clasa;
        TYPE t_zile IS TABLE OF ORAR.ziua%TYPE;
        tabel_zile t_zile;
        
        nr_elevi NUMBER;
        
        CURSOR zile
        IS
            SELECT DISTINCT(o.ziua)
            FROM ORAR o, ELEV e
            WHERE o.id_clasa=e.id_clasa AND UPPER(e.nume) = UPPER(v_nume);
            
        CURSOR orar_clasa(v_zi ORAR.ziua%TYPE)
        IS
            SELECT o.ora, m.denumire, p.nume, p.prenume, s.denumire
            FROM ORAR o
            JOIN MATERIE m ON o.id_materie = m.id_materie
            JOIN PROFESOR p ON o.id_profesor = p.id_profesor
            JOIN SALA s ON o.id_sala = s.id_sala
            JOIN ELEV e ON o.id_clasa = e.id_clasa
            WHERE UPPER(e.nume) = UPPER(v_nume) AND UPPER(o.ziua) = UPPER(v_zi);
        ZI_INVALIDA EXCEPTION; --definim exceptia in care se da o zi din weekend
        NO_ORAR EXCEPTION; --definim exceptia in care elevul nu are orar
    BEGIN
        IF INITCAP(zi) NOT IN ('Luni', 'Marti', 'Miercuri', 'Joi', 'Vineri', 'Sambata', 'Duminica') THEN
            RAISE ZI_INVALIDA;
        END IF;
        SELECT COUNT(*) INTO nr_elevi
        FROM ELEV
        WHERE UPPER(nume) = UPPER(v_nume);
        IF nr_elevi = 0 THEN
            RAISE NO_DATA_FOUND;
        ELSIF nr_elevi > 1 THEN 
            RAISE TOO_MANY_ROWS;
        ELSE
            OPEN zile;
            FETCH zile BULK COLLECT INTO tabel_zile;
            IF tabel_zile.COUNT = 0 THEN
                RAISE NO_ORAR;
            ELSE
                FOR i IN tabel_zile.FIRST..tabel_zile.LAST LOOP
                    OPEN orar_clasa(tabel_zile(i));
                    FETCH orar_clasa BULK COLLECT INTO tabel_orar;
                    CLOSE orar_clasa;
                    IF tabel_orar.COUNT = 0 THEN
                        DBMS_OUTPUT.PUT_LINE(tabel_zile(i) || ', elevul ' || v_nume ||' nu are ore'); 
                    ELSE
                        IF UPPER(zi) = UPPER(tabel_zile(i)) THEN
                            nr_ore := tabel_orar.COUNT;
                        END IF;
                        DBMS_OUTPUT.PUT_LINE(tabel_zile(i) || ', elevul ' || v_nume ||' are urmatoarele ore:');
                        FOR i IN tabel_orar.FIRST..tabel_orar.LAST LOOP
                            DBMS_OUTPUT.PUT_LINE('Ora: ' || tabel_orar(i).ora || ', Materia: ' || tabel_orar(i).denumire_materie);
                            DBMS_OUTPUT.PUT_LINE('Preda profesorul: ' || tabel_orar(i).nume_profesor || ' ' || tabel_orar(i).prenume_profesor);
                            DBMS_OUTPUT.PUT_LINE('Ora are loc in ' || tabel_orar(i).denumire_sala);
                        END LOOP;
                        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
                    END IF;
                END LOOP;
            END IF;
            CLOSE zile;
        END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista elev cu numele dat');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20000, 'Exista mai multi elevi cu numele ' || v_nume);
    WHEN NO_ORAR THEN
        RAISE_APPLICATION_ERROR(-20000, 'Elevul nu are orar!');
    WHEN ZI_INVALIDA THEN
        RAISE_APPLICATION_ERROR(-20000, 'Zi invalida!');
END p_ex9;
END pachet_ex13;
/
--apelare pachet
--apelare procedura p_ex6 din pachet
EXECUTE pachet_ex13.p_ex6('Popescu', 'Luni');
EXECUTE pachet_ex13.p_ex6('Popescu', 'Joi');
EXECUTE pachet_ex13.p_ex6('Cochiorca', 'Luni');
EXECUTE pachet_ex13.p_ex6('Vasile', 'Luni');
/
--apelare functie f_ex7 din pachet
EXECUTE pachet_ex13.p_ex7('uman');
EXECUTE pachet_ex13.p_ex7('real'); 
EXECUTE pachet_ex13.p_ex7('tehnologic'); 
/
--apelare procedura p_ex8 din pachet
DECLARE
    rezultat NUMBER;
    v_specializare CLASA.specializare%TYPE := 'matematica-informatica';
BEGIN
    rezultat := pachet_ex13.f_ex8(v_specializare);
    DBMS_OUTPUT.PUT_LINE('Salariul mediu al profesorilor care nu predau in sala de curs pentru clasele cu specializarea ' || v_specializare || ' este ' || rezultat);
END;
/
DECLARE
    rezultat NUMBER;
    v_specializare CLASA.specializare%TYPE := 'stiinte sociale';
BEGIN
    rezultat := pachet_ex13.f_ex8(v_specializare);
    DBMS_OUTPUT.PUT_LINE('Salariul mediu al profesorilor care nu predau in sala de curs pentru clasele cu specializarea ' || v_specializare || ' este ' || rezultat);
END;
/
DECLARE
    rezultat NUMBER;
    v_specializare CLASA.specializare%TYPE := 'stiinte ale naturii';
BEGIN
    rezultat := pachet_ex13.f_ex8(v_specializare);
    DBMS_OUTPUT.PUT_LINE('Salariul mediu al profesorilor care nu predau in sala de curs pentru clasele cu specializarea ' || v_specializare || ' este ' || rezultat);
END;
/
DECLARE
    rezultat NUMBER;
    v_specializare CLASA.specializare%TYPE := 'filologie';
BEGIN
    rezultat := pachet_ex13.f_ex8(v_specializare);
    DBMS_OUTPUT.PUT_LINE('Salariul mediu al profesorilor care nu predau in sala de curs pentru clasele cu specializarea ' || v_specializare || ' este ' || rezultat);
END;
/

--apelare procedura p_ex9 din pachet
DECLARE
    rezultat NUMBER;
    zi VARCHAR2(100) := 'Luni';
    nume ELEV.nume%TYPE := 'Popescu';
BEGIN
    pachet_ex13.p_ex9(nume,zi, rezultat);
    IF rezultat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Elevul are ' || rezultat || ' ore ' || lower(zi));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Elevul nu are ore ' || lower(zi));
    END IF;
END;
/
DECLARE
    rezultat NUMBER;
    zi VARCHAR2(100) := 'Luni';
    nume ELEV.nume%TYPE := 'Cochiorca';
BEGIN
    pachet_ex13.p_ex9(nume,zi, rezultat);
    IF rezultat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Elevul are ' || rezultat || ' ore ' || lower(zi));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Elevul nu are ore ' || lower(zi));
    END IF;
END;
/
DECLARE
    rezultat NUMBER;
    zi VARCHAR2(100) := 'Luni';
    nume ELEV.nume%TYPE := 'Dobre';
BEGIN
    pachet_ex13.p_ex9(nume,zi, rezultat);
    IF rezultat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Elevul are ' || rezultat || ' ore ' || lower(zi));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Elevul nu are ore ' || lower(zi));
    END IF;
END;
/
DECLARE
    rezultat NUMBER;
    zi VARCHAR2(100) := 'Craciun';
    nume ELEV.nume%TYPE := 'Popescu';
BEGIN
    pachet_ex13.p_ex9(nume,zi, rezultat);
    IF rezultat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Elevul are ' || rezultat || ' ore ' || lower(zi));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Elevul nu are ore ' || lower(zi));
    END IF;
END;
/
DECLARE
    rezultat NUMBER;
    zi VARCHAR2(100) := 'Duminica';
    nume ELEV.nume%TYPE := 'Stan';
BEGIN
    pachet_ex13.p_ex9(nume,zi, rezultat);
    IF rezultat IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Elevul are ' || rezultat || ' ore ' || lower(zi));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Elevul nu are ore ' || lower(zi));
    END IF;
END;
/
 