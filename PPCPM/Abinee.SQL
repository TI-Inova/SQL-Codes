SELECT ESA001_PRODUTO PRODUTO, 
        ESA001_DESCRICAO DESCRICAO, 
 
       (SELECT SUM(ESD003_QUANTIDADE) 
        FROM ESTBD003 
        WHERE ESD003_GRUPO = ESA001_GRUPO 
          AND ESD003_EMPRESA = ESA001_EMPRESA 
          AND ESD003_PRODUTO = ESA001_PRODUTO 
          AND ESD003_FILIAL = 0 
          AND ESD003_PRODUTOCONF = 0 
          AND TO_DATE(ESD003_DATA, 'DD/MM/RRRR')  
                BETWEEN (1||'/'||EXTRACT(MONTH FROM (ADD_MONTHS(SYSDATE, -12)))||'/'||EXTRACT(YEAR FROM(ADD_MONTHS(SYSDATE, -12)))) 
                    AND (1||'/'||EXTRACT(MONTH FROM (ADD_MONTHS(SYSDATE, -1)))||'/'||EXTRACT(YEAR FROM(ADD_MONTHS(SYSDATE, -1))))) CONSUMO, 
 
       (SELECT MAX(SUBSTR(A.OCB001_PRODDESC, (INSTR(A.OCB001_PRODDESC, 'R:')+3), (INSTR(A.OCB001_PRODDESC, 'A:') - (INSTR(A.OCB001_PRODDESC, 'R:')+8)))) 
        FROM OCTBA001 A, OCTBB001 A 
        WHERE A.OCB001_GRUPO = A.OCA001_GRUPO 
          AND A.OCB001_EMPRESA = A.OCA001_EMPRESA 
          AND A.OCB001_FILIAL = A.OCA001_FILIAL 
          AND A.OCB001_TIPODOC = A.OCA001_TIPODOC 
          AND A.OCB001_ORDCOMPRA = A.OCA001_ORDCOMPRA 
          AND A.OCA001_DTINCLUSAO IN (SELECT MAX(B.OCA001_DTINCLUSAO) 
                                      FROM OCTBA001 B, OCTBB001 B 
                                      WHERE B.OCB001_GRUPO = B.OCA001_GRUPO 
                                        AND B.OCB001_EMPRESA = B.OCA001_EMPRESA 
                                        AND B.OCB001_FILIAL = B.OCA001_FILIAL 
                                        AND B.OCB001_TIPODOC = B.OCA001_TIPODOC 
                                        AND B.OCB001_ORDCOMPRA = B.OCA001_ORDCOMPRA 
                                        AND B.OCB001_PRODUTO = A.OCB001_PRODUTO 
                                        AND B.OCB001_PRODUTOCONF = A.OCB001_PRODUTOCONF) 
          AND A.OCB001_GRUPO = ESA001_GRUPO 
          AND A.OCB001_EMPRESA = ESA001_EMPRESA 
          AND A.OCB001_PRODUTO = ESA001_PRODUTO 
          AND A.OCB001_FILIAL = 0) PARTNUMBER, 
 
       (SELECT MAX(SUBSTR(OCB001_PRODDESC, (INSTR(OCB001_PRODDESC, 'A:')+3), LENGTH(OCB001_PRODDESC))) 
        FROM OCTBA001 A, OCTBB001 A 
        WHERE A.OCB001_GRUPO = A.OCA001_GRUPO 
          AND A.OCB001_EMPRESA = A.OCA001_EMPRESA 
          AND A.OCB001_FILIAL = A.OCA001_FILIAL 
          AND A.OCB001_TIPODOC = A.OCA001_TIPODOC 
          AND A.OCB001_ORDCOMPRA = A.OCA001_ORDCOMPRA 
          AND A.OCA001_DTINCLUSAO IN (SELECT MAX(B.OCA001_DTINCLUSAO) 
                                      FROM OCTBA001 B, OCTBB001 B 
                                      WHERE B.OCB001_GRUPO = B.OCA001_GRUPO 
                                        AND B.OCB001_EMPRESA = B.OCA001_EMPRESA 
                                        AND B.OCB001_FILIAL = B.OCA001_FILIAL 
                                        AND B.OCB001_TIPODOC = B.OCA001_TIPODOC 
                                        AND B.OCB001_ORDCOMPRA = B.OCA001_ORDCOMPRA 
                                        AND B.OCB001_PRODUTO = A.OCB001_PRODUTO 
                                        AND B.OCB001_PRODUTOCONF = A.OCB001_PRODUTOCONF) 
          AND A.OCB001_GRUPO = ESA001_GRUPO 
          AND A.OCB001_EMPRESA = ESA001_EMPRESA 
          AND A.OCB001_PRODUTO = ESA001_PRODUTO 
          AND A.OCB001_FILIAL = 0) FABRICANTE, 
 
       (SELECT MAX(PPA001_NOME) 
        FROM OCTBA001 A, OCTBB001 A, PPTBA001 
        WHERE A.OCB001_GRUPO = A.OCA001_GRUPO 
          AND A.OCB001_EMPRESA = A.OCA001_EMPRESA 
          AND A.OCB001_FILIAL = A.OCA001_FILIAL 
          AND A.OCB001_TIPODOC = A.OCA001_TIPODOC 
          AND A.OCB001_ORDCOMPRA = A.OCA001_ORDCOMPRA 
          AND PPA001_GRUPO = A.OCA001_GRUPO 
          AND PPA001_EMPRESA = A.OCA001_EMPRESA 
          AND PPA001_PESSOA = A.OCA001_FORNECEDOR 
          AND A.OCA001_DTINCLUSAO IN (SELECT MAX(B.OCA001_DTINCLUSAO) 
                                      FROM OCTBA001 B, OCTBB001 B 
                                      WHERE B.OCB001_GRUPO = B.OCA001_GRUPO 
                                        AND B.OCB001_EMPRESA = B.OCA001_EMPRESA 
                                        AND B.OCB001_FILIAL = B.OCA001_FILIAL 
                                        AND B.OCB001_TIPODOC = B.OCA001_TIPODOC 
                                        AND B.OCB001_ORDCOMPRA = B.OCA001_ORDCOMPRA 
                                        AND B.OCB001_PRODUTO = A.OCB001_PRODUTO 
                                        AND B.OCB001_PRODUTOCONF = A.OCB001_PRODUTOCONF) 
          AND A.OCB001_GRUPO = ESA001_GRUPO 
          AND A.OCB001_EMPRESA = ESA001_EMPRESA 
          AND A.OCB001_PRODUTO = ESA001_PRODUTO 
          AND A.OCB001_FILIAL = 0) FORNECEDOR, 
 
       (SELECT STRING_AGG(DISTINCT DESCRICAO) 
        FROM 
        (SELECT PRODUTO, 
                CASE 
                    WHEN ESA001_DESCRICAO LIKE '%ACIONADOR%' 
                    THEN ' ACIONADOR ELETRONICO' 
                    WHEN ESA001_DESCRICAO LIKE '%AMPERIMETRO%' OR ESA001_DESCRICAO LIKE '%AMPERÍMETRO%' 
                    THEN ' AMPERIMETRO DIGITAL' 
                    WHEN ESA001_DESCRICAO LIKE '%CHICOTE%' 
                    THEN ' CHICOTE' 
                    WHEN ESA001_DESCRICAO LIKE '%CONTADOR%' 
                    THEN ' CONTADOR DIGITAL' 
                    WHEN ESA001_DESCRICAO LIKE '%CONTROLADOR DIGITAL DE TEMPERATURA%' OR ESA001_DESCRICAO LIKE '%CONTROLADOR DE TEMP%' 
                    THEN ' CONTROLADOR DIGITAL DE TEMPERATURA' 
                    WHEN ESA001_DESCRICAO LIKE '%CONTROLADOR ELETRONICO%' 
                    THEN ' CONTROLADOR ELETRONICO' 
                    WHEN ESA001_DESCRICAO LIKE '%CONTROLADOR LOGICO%' 
                    THEN ' CONTROLADOR LOGICO' 
                    WHEN ESA001_DESCRICAO LIKE '%LAMPADA DE LED%' 
                    THEN ' LAMPADA DE LED' 
                    WHEN ESA001_DESCRICAO LIKE '%PAINEL%' 
                    THEN ' PAINEL ELETRONICO DE MENSAGENS' 
                    WHEN ESA001_DESCRICAO LIKE '%PLACA DE CIRCUITO IMPRESSO%' 
                    THEN ' PLACA DE CIRCUITO IMPRESSO' 
                    WHEN ESA001_DESCRICAO LIKE '%SENSOR DE TEMPERATURA%' 
                    THEN ' SENSOR DE TEMPERATURA' 
                    WHEN ESA001_DESCRICAO LIKE '%TEMPORIZADOR%' 
                    THEN ' TEMPORIZADOR' 
                    WHEN ESA001_DESCRICAO LIKE '%TERMOMETRO DIGITAL%' 
                    THEN ' TERMOMETRO DIGITAL' 
                    WHEN ESA001_DESCRICAO LIKE '%VOLTIMETRO%' 
                    THEN ' VOLTIMETRO DIGITAL'  
                END DESCRICAO, 
                TAA053_CLAFISCAL CLAFISCAL 
        FROM ESTBA001, ESTBA008, TATBA053, 
        (SELECT ECB001_GRUPO GRUPO, 
                ECB001_EMPRESA EMPRESA, 
                ECB001_COMPONENTE COMPONENTE, 
                ECB001_PRODUTO PRODUTO 
        FROM ECTBB001 
        WHERE TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM 
          START WITH ECB001_COMPONENTE = :PRODUTO 
          AND TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM 
          CONNECT BY PRIOR ECB001_PRODUTO = ECB001_COMPONENTE 
          AND TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM) 
        WHERE ESA001_GRUPO = GRUPO 
          AND ESA001_EMPRESA = EMPRESA 
          AND ESA001_PRODUTO = PRODUTO 
          AND ESA008_GRUPO = GRUPO 
          AND ESA008_EMPRESA = EMPRESA 
          AND ESA008_PRODUTO = PRODUTO 
          AND TAA053_GRUPO = ESA001_GRUPO 
          AND TAA053_EMPRESA = ESA001_EMPRESA 
          AND TAA053_CODCLAS = ESA001_CODCLAFIS 
          AND ESA008_AREA = 2 
          AND ESA008_FAMILIA = 23) 
        WHERE DESCRICAO IS NOT NULL) APLICACAO, 
         
       (SELECT STRING_AGG(DISTINCT CLAFISCAL) 
        FROM 
        (SELECT PRODUTO, 
                CASE 
                    WHEN ESA001_DESCRICAO LIKE '%ACIONADOR%' 
                    THEN ' ACIONADOR ELETRONICO' 
                    WHEN ESA001_DESCRICAO LIKE '%AMPERIMETRO%' OR ESA001_DESCRICAO LIKE '%AMPERÍMETRO%' 
                    THEN ' AMPERIMETRO DIGITAL' 
                    WHEN ESA001_DESCRICAO LIKE '%CHICOTE%' 
                    THEN ' CHICOTE' 
                    WHEN ESA001_DESCRICAO LIKE '%CONTADOR%' 
                    THEN ' CONTADOR DIGITAL' 
                    WHEN ESA001_DESCRICAO LIKE '%CONTROLADOR DIGITAL DE TEMPERATURA%' OR ESA001_DESCRICAO LIKE '%CONTROLADOR DE TEMP%' 
                    THEN ' CONTROLADOR DIGITAL DE TEMPERATURA' 
                    WHEN ESA001_DESCRICAO LIKE '%CONTROLADOR ELETRONICO%' 
                    THEN ' CONTROLADOR ELETRONICO' 
                    WHEN ESA001_DESCRICAO LIKE '%CONTROLADOR LOGICO%' 
                    THEN ' CONTROLADOR LOGICO' 
                    WHEN ESA001_DESCRICAO LIKE '%LAMPADA DE LED%' 
                    THEN ' LAMPADA DE LED' 
                    WHEN ESA001_DESCRICAO LIKE '%PAINEL%' 
                    THEN ' PAINEL ELETRONICO DE MENSAGENS' 
                    WHEN ESA001_DESCRICAO LIKE '%PLACA DE CIRCUITO IMPRESSO%' 
                    THEN ' PLACA DE CIRCUITO IMPRESSO' 
                    WHEN ESA001_DESCRICAO LIKE '%SENSOR DE TEMPERATURA%' 
                    THEN ' SENSOR DE TEMPERATURA' 
                    WHEN ESA001_DESCRICAO LIKE '%TEMPORIZADOR%' 
                    THEN ' TEMPORIZADOR' 
                    WHEN ESA001_DESCRICAO LIKE '%TERMOMETRO DIGITAL%' 
                    THEN ' TERMOMETRO DIGITAL' 
                    WHEN ESA001_DESCRICAO LIKE '%VOLTIMETRO%' 
                    THEN ' VOLTIMETRO DIGITAL'  
                END DESCRICAO, 
                TAA053_CLAFISCAL CLAFISCAL 
        FROM ESTBA001, ESTBA008, TATBA053, 
        (SELECT ECB001_GRUPO GRUPO, 
                ECB001_EMPRESA EMPRESA, 
                ECB001_COMPONENTE COMPONENTE, 
                ECB001_PRODUTO PRODUTO 
        FROM ECTBB001 
        WHERE TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM 
          START WITH ECB001_COMPONENTE = :PRODUTO 
          AND TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM 
          CONNECT BY PRIOR ECB001_PRODUTO = ECB001_COMPONENTE 
          AND TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM) 
        WHERE ESA001_GRUPO = GRUPO 
          AND ESA001_EMPRESA = EMPRESA 
          AND ESA001_PRODUTO = PRODUTO 
          AND ESA008_GRUPO = GRUPO 
          AND ESA008_EMPRESA = EMPRESA 
          AND ESA008_PRODUTO = PRODUTO 
          AND TAA053_GRUPO = ESA001_GRUPO 
          AND TAA053_EMPRESA = ESA001_EMPRESA 
          AND TAA053_CODCLAS = ESA001_CODCLAFIS 
          AND ESA008_AREA = 2 
          AND ESA008_FAMILIA = 23) 
        WHERE DESCRICAO IS NOT NULL) CLAFISCAL 
 
FROM ESTBA001 
 
WHERE ESA001_PRODUTO = :PRODUTO 