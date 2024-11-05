SELECT * 
 
FROM 
 
(SELECT DECODE(ESC001_PRODUTOCONF, 0, ESA001_PRODUTO, ESA001_PRODUTO||'-'||ESC001_PRODUTOCONF) PRODUTO, 
        ESA001_DESCRICAO DESCRICAO, 
        ESA001_UMEST UM, 
         
        ESPGA002.ESFPA002003(ESA001_GRUPO, ESA001_EMPRESA, ESC001_FILIAL, ESA001_PRODUTO, ESC001_PRODUTOCONF, 1) + 
        ESPGA002.ESFPA002003(ESA001_GRUPO, ESA001_EMPRESA, ESC001_FILIAL, ESA001_PRODUTO, ESC001_PRODUTOCONF, 14) + 
        ESPGA002.ESFPA002003(ESA001_GRUPO, ESA001_EMPRESA, ESC001_FILIAL, ESA001_PRODUTO, ESC001_PRODUTOCONF, 17) + 
        ESPGA002.ESFPA002003(ESA001_GRUPO, ESA001_EMPRESA, ESC001_FILIAL, ESA001_PRODUTO, ESC001_PRODUTOCONF, 77) + 
        ESPGA002.ESFPA002003(ESA001_GRUPO, ESA001_EMPRESA, ESC001_FILIAL, ESA001_PRODUTO, ESC001_PRODUTOCONF, 88) ESTOQUE, 
         
        ESPGA002.ESFPA002027(ESA001_GRUPO, ESA001_EMPRESA, ESA001_PRODUTO, ESC001_PRODUTOCONF, NVL(:DATA, SYSDATE), 3, 'L,P,F') DEMANDA, 
         
        ESPGA002.ESFPA002026(ESA001_GRUPO, ESA001_EMPRESA, ESA001_PRODUTO, ESC001_PRODUTOCONF, NULL) -  
        ESPGA002.ESFPA002027(ESA001_GRUPO, ESA001_EMPRESA, ESA001_PRODUTO, ESC001_PRODUTOCONF, NVL(:DATA, SYSDATE), 3, 'L,P,F') SALDO, 
         
        ESP001_SEGURQTDE SEGURANCA, 
 
       (SELECT MIN(OCB001_DTENTREGAPREV) 
        FROM OCTBB001 
        WHERE OCB001_GRUPO = ESA001_GRUPO 
          AND OCB001_EMPRESA = ESA001_EMPRESA 
          AND OCB001_FILIAL = ESC001_FILIAL 
          AND OCB001_PRODUTO = ESA001_PRODUTO 
          AND OCB001_PRODUTOCONF = ESC001_PRODUTOCONF 
          AND OCB001_SITUACAO = 1) DATAPROXENTR, 
         
       (SELECT MIN(OCB001_TIPODOC||'-'||OCB001_ORDCOMPRA) 
        FROM OCTBB001 
        WHERE OCB001_GRUPO = ESA001_GRUPO 
          AND OCB001_EMPRESA = ESA001_EMPRESA 
          AND OCB001_FILIAL = ESC001_FILIAL 
          AND OCB001_PRODUTO = ESA001_PRODUTO 
          AND OCB001_PRODUTOCONF = ESC001_PRODUTOCONF 
          AND OCB001_SITUACAO = 1 
          AND OCB001_DTENTREGAPREV IN (SELECT MIN(OCB001_DTENTREGAPREV) 
                                       FROM OCTBB001 
                                       WHERE OCB001_GRUPO = ESA001_GRUPO 
                                         AND OCB001_EMPRESA = ESA001_EMPRESA 
                                         AND OCB001_FILIAL = ESC001_FILIAL 
                                         AND OCB001_PRODUTO = ESA001_PRODUTO 
                                         AND OCB001_PRODUTOCONF = ESC001_PRODUTOCONF 
                                         AND OCB001_SITUACAO = 1)) ORDEM, 
         
       (SELECT SUM(OCB001_QTDESOL) 
        FROM OCTBB001 
        WHERE TO_CHAR(OCB001_TIPODOC||'-'||OCB001_ORDCOMPRA) = (SELECT MIN(OCB001_TIPODOC||'-'||OCB001_ORDCOMPRA) 
                                                                FROM OCTBB001 
                                                                WHERE OCB001_GRUPO = ESA001_GRUPO 
                                                                  AND OCB001_EMPRESA = ESA001_EMPRESA 
                                                                  AND OCB001_FILIAL = ESC001_FILIAL 
                                                                  AND OCB001_PRODUTO = ESA001_PRODUTO 
                                                                  AND OCB001_PRODUTOCONF = ESC001_PRODUTOCONF 
                                                                  AND OCB001_SITUACAO = 1 
                                                                  AND OCB001_DTENTREGAPREV IN (SELECT MIN(OCB001_DTENTREGAPREV) 
                                                                                               FROM OCTBB001 
                                                                                               WHERE OCB001_GRUPO = ESA001_GRUPO 
                                                                                                 AND OCB001_EMPRESA = ESA001_EMPRESA 
                                                                                                 AND OCB001_FILIAL = ESC001_FILIAL 
                                                                                                 AND OCB001_PRODUTO = ESA001_PRODUTO 
                                                                                                 AND OCB001_PRODUTOCONF = ESC001_PRODUTOCONF 
                                                                                                 AND OCB001_SITUACAO = 1))) QTDPROXENTR 
 
FROM ESTBA001, ESTBC001, ESTBP001 
 
WHERE ESC001_GRUPO = ESA001_GRUPO 
  AND ESC001_EMPRESA = ESA001_EMPRESA 
  AND ESC001_PRODUTO = ESA001_PRODUTO 
   
  AND ESP001_GRUPO = ESC001_GRUPO 
  AND ESP001_EMPRESA = ESC001_EMPRESA 
  AND ESP001_FILIAL = ESC001_FILIAL 
  AND ESP001_PRODUTO = ESC001_PRODUTO 
  AND ESP001_PRODUTOCONF = ESC001_PRODUTOCONF 
   
  AND ESA001_GRUPOPLAN = :GRUPOPLAN 
   
  AND ESC001_FILIAL = 0) CORE 
 
WHERE SALDO < SEGURANCA