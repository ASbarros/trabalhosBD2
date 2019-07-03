1
)
CREATE OR REPLACE VIEW V_NOME_PILOTO AS
SELECT P.NOMEPES
FROM PESSOA P, PILOTO I
WHERE P.CPFPES = I.CPFPES
;

2)
CREATE OR REPLACE VIEW V_NOME_SAL_MOD_EMP AS
SELECT P.NOMEPES, E.SALEMP, T.MODTIPOAVI
FROM PESSOA P, EMPREGADO E, TRABALHA_EM T
WHERE P.CPFPES = E.CPFPES
    AND T.CPFPES = E.CPFPES
;

3)
CREATE OR REPLACE VIEW V_NUMPILOTO_PORFABRICAN
(FAB,NUMPILOTO) AS
SELECT T.FABTIPOAVI, COUNT(*)
FROM PILOTA P, TIPO_AVIAO T
WHERE P.MODTIPOAVI = T.MODTIPOAVI
GROUP BY T.FABTIPOAVI
;

4)
CREATE VIEW V_EMP_SERV
(
    NOME,
    TOTALSERV
)
AS
    SELECT P.NOMEPES, COUNT(*)
    FROM PESSOA P, EMPREGADO E, MANTEM M
    WHERE P.CPFPES = E.CPFPES
        AND E.CPFPES = M.CPFPES
    GROUP BY P.NOMEPES
;

5)
CREATE VIEW V_TOTAL_MEDIA_PORTURNO
(
    TOTAL,
    MEDIA,
    TURNO
)
AS
    SELECT SUM(SALEMP), AVG(SALEMP), TUREMP
    FROM EMPREGADO
    GROUP BY TUREMP
;

6)
CREATE VIEW V_HANG_AVI
(
    NUMHANG,
    LOCHANG,
    MODTIPOAVI,
    TOTAL
)
AS
    SELECT H.NUMHANG, H.LOCHANG, A.MODTIPOAVI, COUNT(*)
    FROM HANGAR H, ARMAZENADO_EM Z, AVIAO A, POSSUI P
    WHERE H.NUMHANG = Z.NUMHANG
        AND Z.NREGAVI = A.NREGAVI
        AND P.NREGAVI = A.NREGAVI
        AND Z.DATAFIM IS NULL
        AND P.DATAV IS NULL
    GROUP BY H.NUMHANG, H.LOCHANG, A.MODTIPOAVI
;

7)
CREATE VIEW  V_PILOTO_FABRI
(
    PILOTO,
    FABRICANTE,
    TOTAL_AVIAO
)
AS
    SELECT PE.NOMEPES, T.FABTIPOAVI, COUNT(*)
    FROM PESSOA PE, PILOTO PO , PILOTA PA, TIPO_AVIAO T, AVIAO A
    WHERE PO.CPFPES = PE.CPFPES
        AND PA.CPFPES = PO.CPFPES
        AND PA.MODTIPOAVI = T.MODTIPOAVI
        AND A.MODTIPOAVI = T.MODTIPOAVI
    GROUP BY PE.NOMEPES, T.FABTIPOAVI
;

8)
CREATE VIEW  V_EMP_AVIAO
(
    EMPREGADO,
    NAVI,
    NUMSERV
)
AS
    SELECT P.NOMEPES, A.NREGAVI, COUNT(*)
    FROM EMPREGADO E, TRABALHA_EM TR, TIPO_AVIAO TI, AVIAO A, PESSOA P
    WHERE TR.CPFPES = E.CPFPES
        AND P.CPFPES = E.CPFPES
        AND TR.MODTIPOAVI = TI.MODTIPOAVI
        AND A.MODTIPOAVI = TI.MODTIPOAVI
    GROUP BY P.NOMEPES,A.NREGAVI

9)
CREATE OR REPLACE VIEW V_NUMPROP
(
    NREGAVI,
    NUMPROP
)
AS
SELECT A.NREGAVI, COUNT(*)
FROM AVIAO A, POSSUI P
WHERE P.NREGAVI = A.NREGAVI
    AND P.DATAV IS NULL
GROUP BY A.NREGAVI

CREATE OR REPLACE VIEW V_AVIAO
(
    MODTIPOAVI,
    NUMAVIAO
)
AS
SELECT T.MODTIPOAVI, COUNT(*)
FROM TIPO_AVIAO T , AVIAO A
WHERE T.MODTIPOAVI = A.MODTIPOAVI
GROUP BY T.MODTIPOAVI

CREATE OR REPLACE VIEW V_MEDIA
(MODTIPOAVI,MEDIAPROP) AS
SELECT A.MODTIPOAVI, A.NUMAVIAO/N.NUMPROP
FROM V_AVIAO A, V_NUMPROP N
WHERE A.MODTIPOAVI = N.MODTIPOAVI
GROUP BY A.MODTIPOAVI
;

10)
CREATE OR REPLACE VIEW V_NOME_EMP AS
SELECT P.NOMEPES, (COUNT(*)/ S.SERV) AS MEDIA
FROM PESSOA P, EMPREGADO E, V_SERV S
WHERE P.CPFPES = E.CPFPES
    AND S.CPFPES = E.CPFPES
GROUP BY P.NOMEPES

CREATE OR REPLACE VIEW V_SERV AS
SELECT CPFPES, COUNT(DISTINCT NREGAVI) SERV
FROM MANTEM
GROUP BY CPFPES




11)
CREATE OR REPLACE VIEW V_FAB_SERV AS
SELECT T.FABTIPOAVI, COUNT(*)
FROM TIPO_AVIAO T, AVIAO A, SERVICO S
WHERE T.MODTIPOAVI = A.MODTIPOAVI
GROUP BY T.MODTIPOAVI
;

12)
CREATE OR REPLACE VIEW V_AVIAOES AS
SELECT NREGAVI, MODTIPOAVI
FROM TIPO_AVIAO
WHERE MODTIPOAVI LIKE '747-400';

SELECT *
FROM V_AVIAOES;

UPDATE V_AVIAOES
SET MODTIPOAVI = 'CRJ200'

SELECT *
FROM V_AVIAOES

SELECT *
FROM AVIAO

o comando nao apresentou erro, mas a atualizacao nao eh na view, apenas na tabela base

13)
CREATE OR REPLACE VIEW V_AVIAOES AS
SELECT NREGAVI, MODTIPOAVI
FROM TIPO_AVIAO
WHERE MODTIPOAVI LIKE 'CRJ200';
WITH CHECK OPTION;

SELECT *
FROM V_AVIAOES;

UPDATE V_AVIAOES 
SET MODTIPOAVI = '747-400'

SELECT *
FROM V_AVIAOES

SELECT *
FROM AVIAO

aconteceu um erro, ORA-01402: violação da cláusula where da
view WITH CHECK OPTION pois '747-400' viola a condição de seleção utilizada na
elaboração da view.

14)
CREATE OR REPLACE VIEW V_FAB_PILOTO AS
SELECT T.FABTIPOAVI, P.NOMEPES 
FROM TIPO_AVIAO T, PILOTA PA, PILOTO PO, PESSOA P 
WHERE P.CPFPES = PO.CPFPES
    AND PO.CPFPES = PA.CPFPES
    AND PA.MODTIPOAVI = T.MODTIPOAVI

SELECT *
FROM V_FAB_PILOTO 

UPDATE V_FAB_PILOTO 
SET P.NOMEPES = 'Alexandre'

a atualizacao nao foi realizada , ORA-01779: não é possível modificar uma coluna que mapeie uma tabela não preservada pela chave




-----------------------------------------------------------------------------------------------------------------------------------------------
1)
CREATE TABLE EDIFICIO(
    CODEDI NUMBER PRIMARY KEY,
    NUMEDI NUMBER NOT NULL,
    RUAEDI VARCHAR2(200),
    BAIEDI VARCHAR2(100)
);

CREATE TABLE APARTAMENTO(
    CODAPT NUMBER PRIMARY KEY,
    NUMAPT NUMBER,
    AREAAPT NUMBER NOT NULL,
    CODEDI NUMBER
);

ALTER TABLE APARTAMENTO
ADD CONSTRAINT FK_APARTAMENTO_CODEDI
FOREIGN KEY (CODEDI) REFERENCES EDIFICIO(CODEDI) ON DELETE CASCADE;

2)
INSERT INTO EDIFICIO(CODEDI,NUMEDI,RUAEDI,BAIEDI)
VALUES 1,1,'bom jardim','bela vista';

INSERT INTO EDIFICIO(CODEDI,NUMEDI,RUAEDI,BAIEDI)
VALUES CODEDI = 2,NUMEDI=2,RUAEDI='senhor mauricio',BAIEDI='esperanca';

INSERT INTO EDIFICIO(CODEDI,NUMEDI,RUAEDI,BAIEDI)
VALUES CODEDI = 3,NUMEDI=3,RUAEDI='padim siso',BAIEDI='bela vista';

UPINSERT INTO DATE EDIFICIO(CODEDI,NUMEDI,RUAEDI,BAIEDI)
VALUES CODEDI = 1,NUMEDI=1,RUAEDI='bom jardim',BAIEDI='bela vista';

INSERT INTO EDIFICIO(CODEDI,NUMEDI,RUAEDI,BAIEDI)
VALUES CODEDI = 2,NUMEDI=2,RUAEDI='senhor mauricio',BAIEDI='esperanca';

INSERT INTO APARTAMENTO(CODAPT,NUMAPT,AREAAPT,CODEDI)
VALUES CODAPT = 1,NUMAPT=1,AREAAPT=200,CODEDI=1;

INSERT INTO APARTAMENTO(CODAPT,NUMAPT,AREAAPT,CODEDI)
VALUES CODAPT = 2,NUMAPT=1,AREAAPT=200,CODEDI=2;

INSERT INTO APARTAMENTO(CODAPT,NUMAPT,AREAAPT,CODEDI)
VALUES CODAPT = 2,NUMAPT=1,AREAAPT=200,CODEDI=2;

SELECT *
FROM APARTAMENTO;
