SELECT NSA001_CLIENTE ||' - '|| NSA001_NOME AS FORNECEDOR,
       NSA001_DTEMISSAO AS DATA_EMISSAO,
       NSA001_TIPODOC ||' - '|| NSA001_NOTA AS NOTA, 
       NSA001_SERIE AS SERIE, 
       NSB001_PRODUTO || ' - ' || NSB001_PRODDESC AS ITEM,
       NSB001_QTDE AS QUANTIDADE,
       NSB001_NATUREZA AS NATUREZA, 
       NSB001_OPERACAO AS OPERACAO,
       DVS001_NRODEVOL AS NR_DEVOL,
       DVS001_TOTALDEVOLVIDO AS TOTAL_DEVOL
       
FROM NSTBA001

JOIN NSTBB001 ON NSA001_GRUPO = NSB001_GRUPO
             AND NSA001_EMPRESA = NSB001_EMPRESA
             AND NSA001_FILIAL = NSB001_FILIAL
             AND NSA001_CLIENTE = (SELECT NEA001_FORNECEDOR
                                     FROM NETBA001
                                    WHERE NEA001_GRUPO = NSA001_GRUPO
                                      AND NEA001_EMPRESA = NSA001_EMPRESA
                                      AND NEA001_FILIAL = NSA001_FILIAL
                                      AND NEA001_FORNECEDOR = NSA001_CLIENTE
                                      AND ROWNUM = 1)
             AND NSA001_TIPODOC = NSB001_TIPODOC
             AND NSA001_NOTA = NSB001_NOTA
             AND NSA001_SERIE = NSB001_SERIE
             

LEFT JOIN DVTBS001 ON NSA001_GRUPO = DVS001_GRUPO
                  AND NSA001_EMPRESA = DVS001_EMPRESA
                  AND NSA001_FILIAL = DVS001_FILIAL
                  AND NSA001_CLIENTE = (SELECT NEA001_FORNECEDOR
                                          FROM NETBA001
                                         WHERE NEA001_GRUPO = NSA001_GRUPO
                                           AND NEA001_EMPRESA = NSA001_EMPRESA
                                           AND NEA001_FILIAL = NSA001_FILIAL
                                           AND NEA001_FORNECEDOR = NSA001_CLIENTE
                                           AND ROWNUM = 1)
                  AND NSA001_TIPODOC = DVS001_TIPODOC
                  AND NSA001_NOTA = DVS001_NOTA
                  AND NSA001_SERIE = DVS001_SERIE
                  
WHERE (:TIPO_OPERACAO = 1 AND NSB001_OPERACAO IN (59508, 59512, 69504, 69505, 69506)) -- Operações teste saída
OR (:TIPO_OPERACAO = 2 AND NSB001_OPERACAO IN (59121, 59122, 59123, 69121, 69122)) -- Operações demonstração saída

ORDER BY NSA001_DTEMISSAO DESC;
