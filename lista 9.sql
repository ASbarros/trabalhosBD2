1)
DECLARE 
    nome_piloto VARCHAR2(200);
    modelo_aviao VARCHAR2(200);
    CURSOR c_pilotos IS
        SELECT pe.nomepes, pa.modtipoavi
        FROM piloto po, pessoa p, pilota pa
        WHERE po.cpfpes = p.cpfpes
            AND pa.cpfpes = po.cpfpes;
BEGIN  
    OPEN c_pilotos;
    LOOP
        FETCH c_pilotos INTO nome_piloto, modelo_aviao;
        EXIT WHEN c_pilotos % NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Usuario '|| nome_piloto || '. Autorizado a pilotar ' || modelo_aviao||'.');
    END LOOP;
    CLOSE c_pilotos;
END;

2)
DECLARE 
    numero NUMBER := 0;
    aux NUMBER;
    CURSOR c_numero IS
        SELECT cpfpes
        FROM EMPREGADO;
BEGIN
    OPEN c_numero;
    LOOP
        FETCH c_numero INTO aux;
        EXIT WHEN c_numero % NOTFOUND;
        numero := numero + 1;

    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Numero de empregados ' || numero);
    CLOSE c_numero;
END;

3)
DECLARE
    somatorio NUMBER := 0;
    soma NUMBER := 0;
    numhang Hangar.numhang%TYPE;
    numhangsum armazenado_em.valalu%TYPE;
    CURSOR c_hang IS
        SELECT DISTINCT h.numhang
        FROM hangar h, armazenado_em a
        WHERE a.numhang = h.numhang
        AND a.datafim IS NOT NULL
        ORDER BY h.numhang;
    CURSOR c_somatorio IS
        SELECT a.valalu, h.numhang
        FROM hangar h, armazenado_em a
        WHERE a.numhang = h.numhang
        AND a.datafim IS NOT NULL
        ORDER BY a.valalu;
BEGIN
    OPEN c_hang;
    LOOP
        FETCH c_hang INTO numhang;
        EXIT WHEN c_hang % NOTFOUND;
        OPEN c_somatorio;
        soma := 0;
        LOOP
            FETCH c_somatorio INTO somatorio, numhangsum;
            EXIT WHEN c_somatorio % NOTFOUND;
            IF numhangsum = numhang THEN
                soma := soma + somatorio;
            END IF;
        END LOOP;
        CLOSE c_somatorio;
        DBMS_OUTPUT.PUT_LINE('Hangar: ' || numhang || ' faturamento: ' || soma);
    END LOOP;
    CLOSE c_hang;
END;

SELECT *, SUM(a.valalu)
FROM hangar h, armazenado_em a
WHERE a.numhang = h.numhang
    AND a.datafim IS NOT NULL
GROUP BY h.numhang;