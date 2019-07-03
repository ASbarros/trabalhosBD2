DECLARE
    CURSOR c_emp_ser_avi IS
        SELECT E.cpfpes, COUNT(*) AS total
        FROM Empregado E, Mantem M, Servico S
        WHERE E.cpfpes = M.cpfpes
            AND M.nregavi = S.nregavi
        GROUP BY E.cpfpes;
    TYPE Tipo_emp_ser_avi IS TABLE OF c_emp_ser_avi%ROWTYPE
    INDEX BY BINARY_INTEGER;
    v_emp_ser_avi Tipo_emp_ser_avi;
    CURSOR c_emp_avi_dist IS
        SELECT E.cpfpes, COUNT(DISTINCT S.nregavi) AS distintos
        FROM Empregado E, Mantem M, Servico S
        WHERE E.cpfpes = M.cpfpes
            AND M.nregavi = S.nregavi
        GROUP BY E.cpfpes;
    TYPE Tipo_emp_avi_dist IS TABLE OF c_emp_avi_dist%ROWTYPE
    INDEX BY BINARY_INTEGER;--18
    v_emp_avi_dist Tipo_emp_avi_dist;
    CURSOR c_empregado IS
        SELECT E.cpfpes, P.nomepes
        FROM Empregado E, Pessoa P
        WHERE E.cpfpes = P.cpfpes;
    TYPE Tipo_empregado IS TABLE OF c_empregado%ROWTYPE
    INDEX BY BINARY_INTEGER;
    Empregado Tipo_empregado;
    TYPE Tipo_emp_media IS RECORD(
        empregado number,
        media number:=0 );
    resposta Tipo_emp_media;--30
BEGIN
    OPEN c_emp_ser_avi;
        LOOP
            FETCH c_emp_ser_avi INTO v_emp_ser_avi;
            EXIT WHEN c_emp_ser_avi%NOTFOUND;
            OPEN c_emp_avi_dist;
                LOOP
                    FETCH c_emp_avi_dist INTO v_emp_avi_dist;
                    EXIT WHEN c_emp_avi_dist%NOTFOUND;
                    IF v_emp_ser_avi.cpfpes = v_emp_avi_dist.cpfpes THEN--40
                        OPEN c_empregado;
                            LOOP
                                FETCH c_empregado INTO Empregado;
                                EXIT WHEN c_empregado%NOTFOUND;
                                IF v_emp_ser_avi.cpfpes = c_empregado.cpfpes THEN
                                    DBMS_OUTPUT.PUT_LINE('NOME DO EMPREGADO' || c_empregado.nomepes||'media'||v_emp_ser_avi.total/v_emp_avi_dist.distintos);
                                END IF;
                            END LOOP;
                        CLOSE c_empregado;
                    END IF;--50
                END LOOP;
            CLOSE c_emp_avi_dist;
        END LOOP;
    CLOSE c_emp_ser_avi;
END;

