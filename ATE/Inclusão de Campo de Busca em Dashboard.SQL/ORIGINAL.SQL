SELECT B.ESA001_PRODUTO||' - '||B.ESA001_DESCSINT PRODUTO, 
       SUBSTR(B.ESA001_DESCRICAO,1,3) ATIVO, 
       NVL((SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'CODIGO ANTIGO' ),(SELECT PVA003_PRODUTO||' - '||A.ESA001_DESCSINT 
                                                     FROM PVTBA003,ESTBA001 A  
                                                    WHERE PVA003_GRUPO = A.ESA001_GRUPO 
                                                      AND PVA003_EMPRESA = A.ESA001_EMPRESA 
                                                      AND PVA003_PRODUTO = A.ESA001_PRODUTO 
                                                      AND TRUNC(SYSDATE) BETWEEN (PVA003_DATAINI) AND (PVA003_DATAFIM) 
                                                      AND ROWNUM = 1 
                                                      AND EXISTS (SELECT 1 
                                                                    FROM PVTBA002 
                                                                   WHERE PVA002_GRUPO = PVA003_GRUPO 
                                                                     AND PVA002_EMPRESA = PVA003_EMPRESA 
                                                                     AND PVA002_PRODUTOG = PVA003_PRODUTO 
                                                                     AND PVA002_PRODUTOCONFG = PVA003_PRODUTOCONF 
                                                                     AND PVA002_DATAINI = PVA003_DATAINI 
                                                                     AND PVA002_DATAFIM = PVA003_DATAFIM 
                                                                     AND PVA002_GRUPO = B.ESA001_GRUPO 
                                                                     AND PVA002_EMPRESA = B.ESA001_EMPRESA 
                                                                     AND PVA002_PRODUTO = B.ESA001_PRODUTO))) CODIGO_ANTIGO, 
       (SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'CLIENTE' ) CLIENTE, 
       ESA021_SOFTWARE SOFTWARE, 
       (SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'MANUAL') MANUAL, 
       ESA021_VERSAO VERSAO, 
       NVL((SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'DESCRITIVO'),'.') DESCRITIVO_TESTE, 
        (SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'SCRIPT') SCRIPT, 
         (SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'ETIQUETA') IMAGEM  , 
           (SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'CODPS') PS 
  FROM ESTBA001 B,ESTBA021 
 WHERE B.ESA001_GRUPO   = ESA021_GRUPO (+) 
   AND B.ESA001_EMPRESA = ESA021_EMPRESA (+) 
   AND B.ESA001_PRODUTO = ESA021_PRODUTO (+) 
   AND NVL((SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'DESCRITIVO'),'.') LIKE NVL(:DESCRITIVO,'%') 
   AND B.ESA001_PRODUTO   LIKE '%'||:CODIGO||'%' 
   AND B.ESA001_DESCRICAO LIKE '%'||:DESCRICAO||'%' 
   AND ((ESA021_VERSAO   LIKE '%'||:FIRMWARE||'%'  AND :FIRMWARE IS NOT NULL) OR (:FIRMWARE IS NULL)) 
   AND EXISTS (SELECT 1 
                 FROM ESTBA008 
                WHERE ESA008_GRUPO   = B.ESA001_GRUPO 
                  AND ESA008_EMPRESA = B.ESA001_EMPRESA 
                  AND ESA008_PRODUTO = B.ESA001_PRODUTO 
                  AND ESA008_AREA    = 2 
                  AND ESA008_FAMILIA = 23)   
    AND not EXISTS (SELECT 1  
                 FROM RFTBB003 
                WHERE RFB003_GRUPO   = ESA001_GRUPO 
                  AND RFB003_EMPRESA = ESA001_EMPRESA 
                  AND RFB003_PRODUTO = ESA001_PRODUTO 
                  AND RFB003_CAMPO  IN ('FIRMWARE','SCRIPT') 
                  AND RFB003_VALOR IS NOT NULL) 
   UNION 
   SELECT B.ESA001_PRODUTO||' - '||B.ESA001_DESCSINT PRODUTO, 
        SUBSTR(B.ESA001_DESCRICAO,1,3) ATIVO, 
       NVL((SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'CODIGO ANTIGO' ),(SELECT PVA003_PRODUTO||' - '||A.ESA001_DESCSINT 
                                                     FROM PVTBA003,ESTBA001 A  
                                                    WHERE PVA003_GRUPO = A.ESA001_GRUPO 
                                                      AND PVA003_EMPRESA = A.ESA001_EMPRESA 
                                                      AND PVA003_PRODUTO = A.ESA001_PRODUTO 
                                                      AND TRUNC(SYSDATE) BETWEEN (PVA003_DATAINI) AND (PVA003_DATAFIM) 
                                                      AND ROWNUM = 1 
                                                      AND EXISTS (SELECT 1 
                                                                    FROM PVTBA002 
                                                                   WHERE PVA002_GRUPO = PVA003_GRUPO 
                                                                     AND PVA002_EMPRESA = PVA003_EMPRESA 
                                                                     AND PVA002_PRODUTOG = PVA003_PRODUTO 
                                                                     AND PVA002_PRODUTOCONFG = PVA003_PRODUTOCONF 
                                                                     AND PVA002_DATAINI = PVA003_DATAINI 
                                                                     AND PVA002_DATAFIM = PVA003_DATAFIM 
                                                                     AND PVA002_GRUPO = B.ESA001_GRUPO 
                                                                     AND PVA002_EMPRESA = B.ESA001_EMPRESA 
                                                                     AND PVA002_PRODUTO = B.ESA001_PRODUTO))) CODIGO_ANTIGO, 
       (SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'CLIENTE') CLIENTE, 
       ESA021_SOFTWARE SOFTWARE, 
       (SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'MANUAL') MANUAL, 
        (SELECT RFB003_VALOR 
           FROM RFTBB003 
          WHERE RFB003_GRUPO   = RFB001_GRUPO 
            AND RFB003_EMPRESA = RFB001_EMPRESA 
            AND RFB003_PRODUTO = RFB001_PRODUTO 
            AND RFB003_SEQOPER = RFB001_SEQOPER 
            AND RFB003_CAMPO   = 'FIRMWARE')    VERSAO, 
       NVL((SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'DESCRITIVO'),'.') DESCRITIVO_TESTE, 
        (SELECT RFB003_VALOR 
          FROM RFTBB003 
         WHERE RFB003_GRUPO   = RFB001_GRUPO 
           AND RFB003_EMPRESA = RFB001_EMPRESA 
           AND RFB003_PRODUTO = RFB001_PRODUTO 
           AND RFB003_SEQOPER = RFB001_SEQOPER 
           AND RFB003_CAMPO   = 'SCRIPT') SCRIPT, 
         (SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'ETIQUETA') IMAGEM  , 
           (SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'CODPS') PS 
  FROM ESTBA001 B,ESTBA021, RFTBB001 
 WHERE B.ESA001_GRUPO   = ESA021_GRUPO (+) 
   AND B.ESA001_EMPRESA = ESA021_EMPRESA (+) 
   AND B.ESA001_PRODUTO = ESA021_PRODUTO (+) 
   AND B.ESA001_GRUPO = RFB001_GRUPO 
   AND B.ESA001_EMPRESA = RFB001_EMPRESA 
   AND B.ESA001_PRODUTO = RFB001_PRODUTO 
   AND RFB001_OPERACAO = 18 
   AND NVL((SELECT RFA002_VALOR 
          FROM RFTBA002 
         WHERE RFA002_GRUPO   = B.ESA001_GRUPO 
           AND RFA002_EMPRESA = B.ESA001_EMPRESA 
           AND RFA002_PRODUTO = B.ESA001_PRODUTO 
           AND RFA002_CAMPO   = 'DESCRITIVO'),'.') LIKE NVL(:DESCRITIVO,'%') 
   AND B.ESA001_PRODUTO   LIKE '%'||:CODIGO||'%' 
   AND ESA001_DESCRICAO LIKE '%'||:DESCRICAO||'%' 
   AND  EXISTS (SELECT 1 
                 FROM ESTBA008 
                WHERE ESA008_GRUPO   = B.ESA001_GRUPO 
                  AND ESA008_EMPRESA = B.ESA001_EMPRESA 
                  AND ESA008_PRODUTO = B.ESA001_PRODUTO 
                  AND ESA008_AREA    = 2 
                  AND ESA008_FAMILIA = 23)   
    AND EXISTS (SELECT 1  
                 FROM RFTBB003 
                WHERE RFB003_GRUPO   = RFB001_GRUPO 
                  AND RFB003_EMPRESA = RFB001_EMPRESA 
                  AND RFB003_PRODUTO = RFB001_PRODUTO 
                  AND RFB003_SEQOPER = RFB001_SEQOPER 
                  AND RFB003_CAMPO  IN ('FIRMWARE','SCRIPT') 
                  AND RFB003_VALOR IS NOT NULL 
                  AND RFB003_VALOR LIKE '%'||:FIRMWARE||'%') 
    ORDER BY 1 
