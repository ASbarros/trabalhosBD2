(1)

CREATE SEQUENCE hangar_sequence
 START WITH 10
 INCREMENT BY 1;

DECLARE
UltimoValor hangar.num_col%TYPE;

BEGIN
INSERT INTO hangar (numhang, caphang, lochang)
VALUES (hangar_sequence.NEXTVAL, 2, 'lapa');

SELECT hangar_sequence.CURRVAL INTO UltimoValor
FROM dual;

DBMS_OUTPUT.PUT_LINE(UltimoValor);

END;


(2)

DECLARE 
    numero NUMBER := 0;
    aux hangar.numhang%type;
    CURSOR c_numero IS
        SELECT numhang
        FROM hangar;
    TYPE Tipo_hangar IS TABLE OF Hangar.numhang%TYPE
    INDEX BY BINARY_INTEGER;

    angar Tipo_hangar;
BEGIN
    OPEN c_numero;
    LOOP
        FETCH c_numero INTO aux;
        EXIT WHEN c_numero % NOTFOUND;
        numero := numero + 1;
        angar(numero) := aux;
    END LOOP;
    aux := angar(numero);
    aux := aux + 1;
    DBMS_OUTPUT.PUT_LINE('Numero do hangar ' || angar(numero));
    CLOSE c_numero;
    INSERT INTO hangar(numhang, caphang, lochang)
    VALUES (aux,2,'lapa');
END;

(3)

DECLARE 
TYPE Tipo_Numeros IS TABLE OF temp.num_col%TYPE INDEX BY BINARY_INTEGER;
    Numeros Tipo_Numeros; 
BEGIN SELECT num_col AS numCol
    BULK COLLECT      
    INTO Numeros 
    FROM temp 
    WHERE rownum <40; 
    DBMS_OUTPUT.PUT_LINE(Numeros.COUNT || ' linhas recuperadas.'); 
    FOR Contador IN 1..Numeros.COUNT LOOP 
        DBMS_OUTPUT.PUT_LINE(Numeros(Contador)); 
    END LOOP; 
END;

-------->>>apenas qdo o bulk collect é usado no select, pois tem a clausula where,
-------->>>o rownum eh apenas um 'contador de linhas',
-------->>>no fetch, por exemplo nao tem como usar o rownum propriamente dito.

(4)
--resposta 19
CREATE TABLE Temp AS ( SELECT P.NRegAvi, Z.ValAlu/COUNT(*) AS ValAluPorPessoa
                            FROM Possui P, Aviao A, Armazenado_Em Z
                            WHERE P.NRegAvi = A.NRegAvi
                                AND A.NRegAvi = Z.NRegAvi
                                AND P.DataV is NULL
                                AND Z.DataFim IS NULL
                            GROUP BY P.NRegAvi, Z.ValAlu);


SELECT C.NomeCorp AS NOMEPROPRIETARIO, SUM(T.ValAluPorPessoa)
FROM Corporacao C, Possui P, Temp T
WHERE C.NumProp = P.NumProp
AND P.NRegAvi = T.NRegAvi
GROUP BY C.NomeCorp

UNION

SELECT O.NomePes AS NOMEPROPRIETARIO, SUM(T.ValAluPorPessoa)
FROM Pessoa O, Possui P, Temp T
WHERE O.NumProp = P.NumProp
AND P.NRegAvi = T.NRegAvi
GROUP BY O.NomePes;

--resolucao da 4
DECLARE
    NumProp Proprietario.NumProp%TYPE;
    aux Proprietario.NumProp%TYPE;
    nome varchar2(255);
    donoPessoa pessoa.cpfpes%TYPE;
    donoCorp Corporacao.NomeCorp%TYPE;
    valor NUMBER:=0;
    CURSOR c_numprop IS
        SELECT P.NRegAvi, Z.ValAlu/COUNT(*) AS ValAluPorPessoa
            FROM Possui P, Aviao A, Armazenado_Em Z
            WHERE P.NRegAvi = A.NRegAvi
                AND A.NRegAvi = Z.NRegAvi
                AND P.DataV IS NULL
                AND Z.DataFim IS NULL
            GROUP BY P.NRegAvi, Z.ValAlu;
    CURSOR c_pessoa IS
        SELECT cpfpes, NumProp,NomePes
            FROM pessoa
            WHERE NumProp IS NOT NULL;
    CURSOR c_corporacao IS
        SELECT NomeCorp,NumProp
            FROM Corporacao
            WHERE NumProp IS NOT NULL;
BEGIN
    OPEN c_numprop;
        LOOP
            FETCH c_numprop INTO NumProp,valor;
            EXIT WHEN c_numprop%NOTFOUND;
            OPEN c_corporacao;
                LOOP
                    FETCH c_corporacao INTO donoCorp,aux;
                    EXIT WHEN c_corporacao%NOTFOUND;
                    IF aux = NumProp THEN
                       DBMS_OUTPUT.PUT_LINE('dono do aviao: '||donoCorp||' valor do aluguel: '||valor); 
                    END IF;
                END LOOP;
            CLOSE c_corporacao;
            OPEN c_pessoa;
                LOOP
                    FETCH c_pessoa INTO donoPessoa,aux,Nome;
                    EXIT WHEN c_pessoa%NOTFOUND;
                    IF aux = NumProp THEN
                        DBMS_OUTPUT.PUT_LINE('dono do aviao: '||nome||' valor do aluguel: '||valor);
                    END IF;
                END LOOP;
            CLOSE c_pessoa;
            DBMS_OUTPUT.PUT_LINE(NumProp);
        END LOOP;
    CLOSE c_numprop;
END;

-->>> a solucao ficou bem mais extença se comparada ao gabarito da questao 19
-->>> mas eu entendi melhor o decorrer da solucao, ficou mais 'aberto', mais claro pra mim
-->> antes eu nao tinha conseguido fazer a questao, mas usando plsql eu consegui...