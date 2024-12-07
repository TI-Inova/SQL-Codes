/*Explosão */

SELECT ECB001_GRUPO GRUPO, 

        ECB001_EMPRESA EMPRESA, 

        LEVEL NIVEL, 

        ECB001_COMPONENTE COMPONENTE, 

        CQFBA019(ECB001_GRUPO, ECB001_EMPRESA, ECB001_COMPONENTE, 0) DESCRICAO_COMPONENTE, 

        ECB001_PRODUTO PRODUTO, 

        CQFBA019(ECB001_GRUPO, ECB001_EMPRESA, ECB001_PRODUTO, 0) DESCRICAO_PRODUTO, 

        ECB001_QTDE QTD, 

        ECB001_UM UM 

 

FROM ECTBB001 

 

WHERE TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM 

  START WITH ECB001_PRODUTO = :PRODUTO 

  AND TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM 

  CONNECT BY PRIOR ECB001_COMPONENTE = ECB001_PRODUTO 

  AND TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM 

 

/*Implosão */

SELECT ECB001_GRUPO GRUPO, 

        ECB001_EMPRESA EMPRESA, 

        LEVEL NIVEL, 

        ECB001_COMPONENTE COMPONENTE, 

        CQFBA019(ECB001_GRUPO, ECB001_EMPRESA, ECB001_COMPONENTE, 0) DESCRICAO_COMPONENTE, 

        ECB001_PRODUTO PRODUTO, 

        CQFBA019(ECB001_GRUPO, ECB001_EMPRESA, ECB001_PRODUTO, 0) DESCRICAO_PRODUTO, 

        ECB001_QTDE QTD, 

        ECB001_UM UM 

 

FROM ECTBB001 

 

WHERE TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM 

  START WITH ECB001_COMPONENTE = :COMPONENTE 

  AND TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM 

  CONNECT BY PRIOR ECB001_PRODUTO = ECB001_COMPONENTE 

  AND TRUNC(SYSDATE) BETWEEN ECB001_DTVALINI AND ECB001_DTVALFIM 