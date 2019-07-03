1)
SELECT COUNT(*)
FROM EMPREGADO E, PESSOA P
WHERE SEXOPES LIKE 'M'
   AND P.CPFPES = P.CPFPES;

2)
SELECT COUNT(*)
FROM EMPREGADO E, PESSOA P
WHERE UPPER(P.NOMEPES) LIKE '%MARIA%'
   AND P.CPFPES = P.CPFPES;

3)
SELECT COUNT(*), MAX(SALEMP), MIN(SALEMP), SUM(SALEMP), AVG(SALEMP)
FROM EMPREGADO 

4)
SELECT COUNT(*)
FROM HANGAR H,ARMAZENADO_EM Z, AVIAO A
WHERE UPPER(LOCHANG) LIKE 'JUIZ DE FORA'
   AND H.NUMHANG = Z.NUMHANG
   AND Z.NREGAVI = A.NREGAVI

5)
SELECT NREGAVI, COUNT(*)
FROM POSSUI 
WHERE DATAV IS NULL
GROUP BY A.NREGAVI

6)
SELECT CODTRABSERV, SUM(HORASERV), AVG(HORASERV)
FROM SERVICO
GROUP BY CODTRABSERV

7)
SELECT NREGAVI, SUM(HORASERV)
FROM SERVICO
GROUP BY NREGAVI

8)
SELECT P.NOMEPES, COUNT(*)
FROM PILOTO I, PESSOA P
WHERE I.CPFPES = P.CPFPES
GROUP BY P.NOMEPES, P.CPFPES

9)
SELECT P.NOMEPES, COUNT(*)
FROM MANTEM M, EMPREGADO E, PESSOA P
WHERE M.CPFPES = E.CPFPES AND P.CPFPES = E.CPFPES
GROUP BY P.NOMEPES, P.CPFPES

10)
SELECT NREGAVI, COUNT(*)
FROM MANTEM
GROUP BY NREGAVI

11)
SELECT NREGAVI, COUNT(DISTINCT CPFPES)
FROM MANTEM 
GROUP BY NREGAVI;

12)
SELECT NREGAVI, COUNT(*) AS SERVICOS
FROM SERVICO
GROUP BY NREGAVI
ORDER BY SERVICOS DESC

13)
SELECT A.NREGAVI
FROM AVIAO A, POSSUI P
WHERE A.NREGAVI = P.NREGAVI AND P.DATAV IS NULL
GROUP BY A.NREGAVI
HAVING COUNT(*) >=3

14)
SELECT P.NOMEPES, COUNT(*)
FROM TRABALHA_EM T, EMPREGADO E, PESSOA P
WHERE T.CPFPES = E.CPFPES AND P.CPFPES = E.CPFPES
GROUP BY P.NOMEPES
HAVING COUNT(*) > 3

15)
SELECT P.NOMEPES, COUNT(S.NREGAVI) AS NAVI
FROM EMPREGADO E, MANTEM M, SERVICO S, PESSOA P
WHERE P.CPFPES = E.CPFPES 
  AND E.CPFPES = M.CPFPES 
  AND M.NREGAVI = S.NREGAVI
  AND M.DATASERV = S.DATASERV
  AND M.CODTRABSERV = S.CODTRABSERV
GROUP BY P.NOMEPES
HAVING COUNT(S.NREGAVI) > 3

16)
SELECT H.LOCHANG, A.VALALU*1.1 AS VALOR
FROM HANGAR H, ARMAZENADO_EM A
WHERE H.NUMHANG = A.NUMHANG

17)
SELECT NREGAVI
FROM ARMAZENADO_EM
WHERE MONTHS_BETWEEN(SYSDATE,DATAINI) >= 12 AND DATAFIM IS NULL;

18)
SELECT COUNT(*)
FROM POSSUI
WHERE DATAC BETWEEN '01/03/2019' AND '30/03/2019'

19)
CREATE OR REPLACE VIEW v_ModTipoAvi_NumProprietarios AS
SELECT A.ModTipoAvi, COUNT(*) AS NumProprietarios
FROM AVIAO A, POSSUI P
WHERE A.NREGAVI = P.NREGAVI
   AND P.DATAV IS NULL
GROUP BY A.ModTipoAvi;

CREATE OR REPLACE VIEW v_ModTipoAvi_NumAvioes AS
SELECT A.ModTipoAvi, COUNT(*) AS NumAvioes
FROM AVIAO A
GROUP BY A.ModTipoAvi;

CREATE OR REPLACE VIEW v_Media_ModAvioes_Proprietarios AS
SELECT A.ModTipoAvi, (A.NumProprietarios / B.NumAvioes) Media
FROM v_ModTipoAvi_NumProprietarios A, v_ModTipoAvi_NumAvioes B
WHERE A.ModTipoAvi = B.ModTipoAvi;

20)
SELECT T.ModTipoAvi, COUNT(E.CPFPes)
FROM TRABALHA_EM T, EMPREGADO E
WHERE T.CPFPes = E.CPFPes
AND E.SalEmp > 2500
GROUP BY T.ModTipoAvi
HAVING COUNT(T.CPFPes) >= 5;

21)
UPDATE ARMAZENADO_EM
SET VALALU = VALALU * 1.1
WHERE DATAFIM IS NULL;