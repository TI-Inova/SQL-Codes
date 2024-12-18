SELECT NETBF001.DATE_CREATED AS DATA,
       NEF001_RECEBIMENTO AS RECEBIMENTO,
       NEF001_FORNECEDOR ||' - '|| PPA001_NOME AS FORNECEDOR,
       NEF001_TIPODOC ||' - '|| NEF001_NOTA AS NOTA,
       NETBF001.CREATED_BY AS RESPONSAVEL

FROM NETBF001, PPTBA001

WHERE NEF001_GRUPO = PPA001_GRUPO
  AND NEF001_EMPRESA = PPA001_EMPRESA
  AND NEF001_FORNECEDOR = PPA001_PESSOA

/*FILTROS*/
  AND NEF001_TIPODOC IN ('NFEASS','NFASSD','NFEASP')
  AND NEF001_CONFIRMADO = 'N'
  AND NETBF001.DATE_CREATED >= '01/01/2023'
  
ORDER BY NETBF001.DATE_CREATED DESC;

/*TABELAS*/
--NETBF001

/*CAMPOS*/
--NEF001_RECEBIMENTO, 
--NEF001_FORNECEDOR, 
--NEF001_TIPODOC, 
--NEF001_NOTA, 
--DATE_CREATED, 
--CREATED_BY

