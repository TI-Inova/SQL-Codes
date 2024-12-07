SELECT ESA001_PRODUTO CODIGO, 

         

        CASE 

            WHEN ESA001_DESCRICAO LIKE '***%' 

            THEN SUBSTR(ESA001_DESCRICAO, 4) 

            ELSE ESA001_DESCRICAO 

        END DESCRICAO, 

         

        CASE 

            WHEN ESA001_DESCSINT LIKE '***%' 

            THEN SUBSTR(ESA001_DESCSINT, 4) 

            ELSE ESA001_DESCSINT 

        END MODELO, 

         

        COUNT(ORC010_TIPODOC||ORC010_ORDEM||ORC010_LINHA) QTD 

 

FROM ESTBA001, ESTBA008, ORTBC001, ORTBC010 

 

WHERE ORC010_ORC001_ID = ORC001_ID 

 

  AND ORC010_GRUPO = ESA001_GRUPO 

  AND ORC010_EMPRESA = ESA001_EMPRESA 

  AND ORC010_PRODUTO = ESA001_PRODUTO 

 

  AND ESA008_GRUPO = ESA001_GRUPO 

  AND ESA008_EMPRESA = ESA001_EMPRESA 

  AND ESA008_PRODUTO = ESA001_PRODUTO 

   

  AND ORC001_DTEMISSAO BETWEEN :PERIODO AND SYSDATE 

   

  AND ORC010_FILIAL = 0 

   

  AND ESA008_FAMILIA = 23 

  AND ESA008_GRUPOPROD = 45 

  AND ESA008_SUBGRUPO = 1 

 

GROUP BY ESA001_PRODUTO, ESA001_DESCRICAO, ESA001_DESCSINT 

 

ORDER BY ESA001_PRODUTO;