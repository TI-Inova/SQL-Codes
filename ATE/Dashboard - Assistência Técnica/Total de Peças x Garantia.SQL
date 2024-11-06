SELECT (SELECT DECODE(STRING_AGG(PERIODO), 1, 'JANEIRO', 
                                           2, 'FEVEREIRO', 
                                           3, 'MARÇO', 
                                           4, 'ABRIL', 
                                           5, 'MAIO', 
                                           6, 'JUNHO', 
                                           7, 'JULIO', 
                                           8, 'AGOSTO', 
                                           9, 'SETEMBRO', 
                                          10, 'OUTUBRO', 
                                          11, 'NOVEMBRO', 
                                          12, 'DEZEMBRO', 
                                              'PERIODO MISTO') 
        FROM 
       (SELECT TO_CHAR(ORC001_DTFINALIZADO, 'MM') PERIODO 
        FROM ORTBC001, ORTBC010 
        WHERE ORC010_ORC001_ID = ORC001_ID 
          AND ORC001_DTFINALIZADO BETWEEN :PERIODO 
        GROUP BY TO_CHAR(ORC001_DTFINALIZADO, 'MM'))) PERIODO, 
 
    NVL((SELECT COUNT(*) FROM 
        (SELECT ORC001_PESSOA PESSOA, 
                            ORC001_ORDEM ORDEM, 
                            ORC001_DTEMISSAO DATAEMISSAO, 
                            ORC001_DTPRZENTREGA DATAPRAZO, 
                            ORC001_DTFINALIZADO DATAFINALIZADO, 
                            ORC001_STATUS STATUS, 
                            ORC010_PRODUTO PRODUTO, 
                            ORC010_PRODUTOCONF PRODUTOCONF, 
                            ORC010_ATENDENTE ATENDENTE, 
                            ORC010_GARANTIA GARANTIA, 
                            ORC010_TAB166_ID MOTIVO, 
                       NVL((SELECT PPA004_GRUPOPESSOA FROM PPTBA004 
                            WHERE PPA004_PESSOA = ORC001_PESSOA 
                              AND PPA004_SEGMENTO IN (11, 12, 999)),0) AGRUPAMENTO 
        FROM ORTBC001, ORTBC010 
        WHERE ORC010_ORC001_ID = ORC001_ID) 
        WHERE DATAFINALIZADO BETWEEN :PERIODO 
          AND STATUS = 2 
          AND MOTIVO = 1),0) MOTIVO1, 
     
    NVL((SELECT COUNT(*) FROM 
        (SELECT ORC001_PESSOA PESSOA, 
                            ORC001_ORDEM ORDEM, 
                            ORC001_DTEMISSAO DATAEMISSAO, 
                            ORC001_DTPRZENTREGA DATAPRAZO, 
                            ORC001_DTFINALIZADO DATAFINALIZADO, 
                            ORC001_STATUS STATUS, 
                            ORC010_PRODUTO PRODUTO, 
                            ORC010_PRODUTOCONF PRODUTOCONF, 
                            ORC010_ATENDENTE ATENDENTE, 
                            ORC010_GARANTIA GARANTIA, 
                            ORC010_TAB166_ID MOTIVO, 
                       NVL((SELECT PPA004_GRUPOPESSOA FROM PPTBA004 
                            WHERE PPA004_PESSOA = ORC001_PESSOA 
                              AND PPA004_SEGMENTO IN (11, 12, 999)),0) AGRUPAMENTO 
        FROM ORTBC001, ORTBC010 
        WHERE ORC010_ORC001_ID = ORC001_ID) 
        WHERE DATAFINALIZADO BETWEEN :PERIODO 
          AND STATUS = 2 
          AND MOTIVO = 2),0) MOTIVO2, 
     
    NVL((SELECT COUNT(*) FROM 
        (SELECT ORC001_PESSOA PESSOA, 
                            ORC001_ORDEM ORDEM, 
                            ORC001_DTEMISSAO DATAEMISSAO, 
                            ORC001_DTPRZENTREGA DATAPRAZO, 
                            ORC001_DTFINALIZADO DATAFINALIZADO, 
                            ORC001_STATUS STATUS, 
                            ORC010_PRODUTO PRODUTO, 
                            ORC010_PRODUTOCONF PRODUTOCONF, 
                            ORC010_ATENDENTE ATENDENTE, 
                            ORC010_GARANTIA GARANTIA, 
                            ORC010_TAB166_ID MOTIVO, 
                       NVL((SELECT PPA004_GRUPOPESSOA FROM PPTBA004 
                            WHERE PPA004_PESSOA = ORC001_PESSOA 
                              AND PPA004_SEGMENTO IN (11, 12, 999)),0) AGRUPAMENTO 
        FROM ORTBC001, ORTBC010 
        WHERE ORC010_ORC001_ID = ORC001_ID) 
        WHERE DATAFINALIZADO BETWEEN :PERIODO 
          AND STATUS = 2 
          AND MOTIVO = 3),0) MOTIVO3, 
     
    NVL((SELECT COUNT(*) FROM 
        (SELECT ORC001_PESSOA PESSOA, 
                            ORC001_ORDEM ORDEM, 
                            ORC001_DTEMISSAO DATAEMISSAO, 
                            ORC001_DTPRZENTREGA DATAPRAZO, 
                            ORC001_DTFINALIZADO DATAFINALIZADO, 
                            ORC001_STATUS STATUS, 
                            ORC010_PRODUTO PRODUTO, 
                            ORC010_PRODUTOCONF PRODUTOCONF, 
                            ORC010_ATENDENTE ATENDENTE, 
                            ORC010_GARANTIA GARANTIA, 
                            ORC010_TAB166_ID MOTIVO, 
                       NVL((SELECT PPA004_GRUPOPESSOA FROM PPTBA004 
                            WHERE PPA004_PESSOA = ORC001_PESSOA 
                              AND PPA004_SEGMENTO IN (11, 12, 999)),0) AGRUPAMENTO 
        FROM ORTBC001, ORTBC010 
        WHERE ORC010_ORC001_ID = ORC001_ID) 
        WHERE DATAFINALIZADO BETWEEN :PERIODO 
          AND STATUS = 2 
          AND MOTIVO = 4),0) MOTIVO4, 
     
    NVL((SELECT COUNT(*) FROM 
        (SELECT ORC001_PESSOA PESSOA, 
                            ORC001_ORDEM ORDEM, 
                            ORC001_DTEMISSAO DATAEMISSAO, 
                            ORC001_DTPRZENTREGA DATAPRAZO, 
                            ORC001_DTFINALIZADO DATAFINALIZADO, 
                            ORC001_STATUS STATUS, 
                            ORC010_PRODUTO PRODUTO, 
                            ORC010_PRODUTOCONF PRODUTOCONF, 
                            ORC010_ATENDENTE ATENDENTE, 
                            ORC010_GARANTIA GARANTIA, 
                            ORC010_TAB166_ID MOTIVO, 
                       NVL((SELECT PPA004_GRUPOPESSOA FROM PPTBA004 
                            WHERE PPA004_PESSOA = ORC001_PESSOA 
                              AND PPA004_SEGMENTO IN (11, 12, 999)),0) AGRUPAMENTO 
        FROM ORTBC001, ORTBC010 
        WHERE ORC010_ORC001_ID = ORC001_ID) 
        WHERE DATAFINALIZADO BETWEEN :PERIODO 
          AND STATUS = 2 
          AND MOTIVO = 5),0) MOTIVO5, 
     
    NVL((SELECT COUNT(*) FROM 
        (SELECT ORC001_PESSOA PESSOA, 
                            ORC001_ORDEM ORDEM, 
                            ORC001_DTEMISSAO DATAEMISSAO, 
                            ORC001_DTPRZENTREGA DATAPRAZO, 
                            ORC001_DTFINALIZADO DATAFINALIZADO, 
                            ORC001_STATUS STATUS, 
                            ORC010_PRODUTO PRODUTO, 
                            ORC010_PRODUTOCONF PRODUTOCONF, 
                            ORC010_ATENDENTE ATENDENTE, 
                            ORC010_GARANTIA GARANTIA, 
                            ORC010_TAB166_ID MOTIVO, 
                       NVL((SELECT PPA004_GRUPOPESSOA FROM PPTBA004 
                            WHERE PPA004_PESSOA = ORC001_PESSOA 
                              AND PPA004_SEGMENTO IN (11, 12, 999)),0) AGRUPAMENTO 
        FROM ORTBC001, ORTBC010 
        WHERE ORC010_ORC001_ID = ORC001_ID) 
        WHERE DATAFINALIZADO BETWEEN :PERIODO 
          AND STATUS = 2 
          AND MOTIVO = 6),0) MOTIVO6, 
     
    NVL((SELECT COUNT(*) FROM 
        (SELECT ORC001_PESSOA PESSOA, 
                            ORC001_ORDEM ORDEM, 
                            ORC001_DTEMISSAO DATAEMISSAO, 
                            ORC001_DTPRZENTREGA DATAPRAZO, 
                            ORC001_DTFINALIZADO DATAFINALIZADO, 
                            ORC001_STATUS STATUS, 
                            ORC010_PRODUTO PRODUTO, 
                            ORC010_PRODUTOCONF PRODUTOCONF, 
                            ORC010_ATENDENTE ATENDENTE, 
                            ORC010_GARANTIA GARANTIA, 
                            ORC010_TAB166_ID MOTIVO, 
                       NVL((SELECT PPA004_GRUPOPESSOA FROM PPTBA004 
                            WHERE PPA004_PESSOA = ORC001_PESSOA 
                              AND PPA004_SEGMENTO IN (11, 12, 999)),0) AGRUPAMENTO 
        FROM ORTBC001, ORTBC010 
        WHERE ORC010_ORC001_ID = ORC001_ID) 
        WHERE DATAFINALIZADO BETWEEN :PERIODO 
          AND STATUS = 2 
          AND MOTIVO = 7),0) MOTIVO7, 
     
    NVL((SELECT COUNT(*) FROM 
        (SELECT ORC001_PESSOA PESSOA, 
                            ORC001_ORDEM ORDEM, 
                            ORC001_DTEMISSAO DATAEMISSAO, 
                            ORC001_DTPRZENTREGA DATAPRAZO, 
                            ORC001_DTFINALIZADO DATAFINALIZADO, 
                            ORC001_STATUS STATUS, 
                            ORC010_PRODUTO PRODUTO, 
                            ORC010_PRODUTOCONF PRODUTOCONF, 
                            ORC010_ATENDENTE ATENDENTE, 
                            ORC010_GARANTIA GARANTIA, 
                            ORC010_TAB166_ID MOTIVO, 
                       NVL((SELECT PPA004_GRUPOPESSOA FROM PPTBA004 
                            WHERE PPA004_PESSOA = ORC001_PESSOA 
                              AND PPA004_SEGMENTO IN (11, 12, 999)),0) AGRUPAMENTO 
        FROM ORTBC001, ORTBC010 
        WHERE ORC010_ORC001_ID = ORC001_ID) 
        WHERE DATAFINALIZADO BETWEEN :PERIODO 
          AND STATUS = 2 
          AND MOTIVO IS NULL),0) SEM_MOTIVO 
 
FROM DUAL 