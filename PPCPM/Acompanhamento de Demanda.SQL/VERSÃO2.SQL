SELECT PRODUTO, DESCRICAO, UM, ESTOQUE, DEMANDA, 
       (ESTOQUE - DEMANDA) SALDO, 
        SEGURANCA, DATAPROXENTR, ORDEM, FORNECEDOR, QTDPROXENTR  
 
FROM 
 
(SELECT DECODE(ESC001_PRODUTOCONF, 0, ESA001_PRODUTO, ESA001_PRODUTO||'-'||ESC001_PRODUTOCONF) PRODUTO, 
        ESA001_DESCRICAO DESCRICAO, 
        ESA001_UMEST UM, 
 
        ESPGA002.ESFPA002003(ESA001_GRUPO, ESA001_EMPRESA, ESC001_FILIAL, ESA001_PRODUTO, ESC001_PRODUTOCONF, 1) + 
        ESPGA002.ESFPA002003(ESA001_GRUPO, ESA001_EMPRESA, ESC001_FILIAL, ESA001_PRODUTO, ESC001_PRODUTOCONF, 14) + 
        ESPGA002.ESFPA002003(ESA001_GRUPO, ESA001_EMPRESA, ESC001_FILIAL, ESA001_PRODUTO, ESC001_PRODUTOCONF, 17) + 
        ESPGA002.ESFPA002003(ESA001_GRUPO, ESA001_EMPRESA, ESC001_FILIAL, ESA001_PRODUTO, ESC001_PRODUTOCONF, 77) + 
        ESPGA002.ESFPA002003(ESA001_GRUPO, ESA001_EMPRESA, ESC001_FILIAL, ESA001_PRODUTO, ESC001_PRODUTOCONF, 88) ESTOQUE, 
 
       (SELECT SUM(DMA001_QTDESOL - (DMA001_QTDECAN + DMA001_QTDEATE)) 
        FROM DMTBA001 
        WHERE DMA001_GRUPO = ESA001_GRUPO 
          AND DMA001_EMPRESA = ESA001_EMPRESA 
          AND DMA001_FILIAL = ESC001_FILIAL 
          AND DMA001_PRODUTO = ESA001_PRODUTO 
          AND DMA001_PRODUTOCONF = ESC001_PRODUTOCONF) DEMANDA, 
 
        ESP001_SEGURQTDE SEGURANCA, 
 
       (SELECT MIN(OCB001_DTENTREGASOL) 
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
          AND OCB001_DTENTREGASOL IN (SELECT MIN(OCB001_DTENTREGASOL) 
                                       FROM OCTBB001 
                                       WHERE OCB001_GRUPO = ESA001_GRUPO 
                                         AND OCB001_EMPRESA = ESA001_EMPRESA 
                                         AND OCB001_FILIAL = ESC001_FILIAL 
                                         AND OCB001_PRODUTO = ESA001_PRODUTO 
                                         AND OCB001_PRODUTOCONF = ESC001_PRODUTOCONF 
                                         AND OCB001_SITUACAO = 1 
                                         AND OCB001_TIPODOC NOT IN ('OCAIMP', 'OC1IMP'))) ORDEM, 
 
       (SELECT OCA001_FORNECEDOR||'-'||PPA001_NOME 
        FROM OCTBA001, PPTBA001 
        WHERE PPA001_GRUPO = OCA001_GRUPO 
          AND PPA001_EMPRESA = OCA001_EMPRESA 
          AND PPA001_PESSOA = OCA001_FORNECEDOR 
          AND OCA001_TIPODOC||'-'||OCA001_ORDCOMPRA = (SELECT MIN(OCB001_TIPODOC||'-'||OCB001_ORDCOMPRA) 
                                                       FROM OCTBB001 
                                                       WHERE OCB001_GRUPO = ESA001_GRUPO 
                                                         AND OCB001_EMPRESA = ESA001_EMPRESA 
                                                         AND OCB001_FILIAL = ESC001_FILIAL 
                                                         AND OCB001_PRODUTO = ESA001_PRODUTO 
                                                         AND OCB001_PRODUTOCONF = ESC001_PRODUTOCONF 
                                                         AND OCB001_SITUACAO = 1 
                                                         AND OCB001_DTENTREGASOL IN (SELECT MIN(OCB001_DTENTREGASOL) 
                                                                                     FROM OCTBB001 
                                                                                     WHERE OCB001_GRUPO = ESA001_GRUPO 
                                                                                       AND OCB001_EMPRESA = ESA001_EMPRESA 
                                                                                       AND OCB001_FILIAL = ESC001_FILIAL 
                                                                                       AND OCB001_PRODUTO = ESA001_PRODUTO 
                                                                                       AND OCB001_PRODUTOCONF = ESC001_PRODUTOCONF 
                                                                                       AND OCB001_SITUACAO = 1 
                                                                                       AND OCB001_TIPODOC NOT IN ('OCAIMP', 'OC1IMP')))) FORNECEDOR, 
 
       (SELECT SUM(OCB001_QTDESOL - (OCB001_QTDEATE + OCB001_QTDECAN)) 
        FROM OCTBB001 
        WHERE TO_CHAR(OCB001_TIPODOC||'-'||OCB001_ORDCOMPRA||'-'||OCB001_LINHA) = (SELECT MIN(OCB001_TIPODOC||'-'||OCB001_ORDCOMPRA||'-'||OCB001_LINHA) 
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
                                                                                                                     AND OCB001_SITUACAO = 1 
                                                                                                                     AND OCB001_TIPODOC NOT IN ('OCAIMP', 'OC1IMP')))) QTDPROXENTR 
 
 
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
 
WHERE (ESTOQUE - DEMANDA) < SEGURANCA 
 
ORDER BY TO_CHAR(PRODUTO, 999999) 