SELECT RECURSO, 
        TIPODOC||'-'||ORDEM ORDEM, 
        DECODE(COMPONENTECONF, 0, COMPONENTE, COMPONENTE||'-'||COMPONENTECONF) COMPONENTE, 
        DESCRICAO, 
        UM, 
        DEMANDA, 
        ALMOXDEST, 
        LOCAL, 
        PREFORMAGEM 
 
FROM 
 
(SELECT OPS012_RECURSO RECURSO, 
        OPS012_DATASIMUL DATASIMUL, 
        MAX(OPS012_VERSAO) VERSAO, 
        OPS012_TIPODOC TIPODOC, 
        OPS012_ORDEM ORDEM, 
        OPS012_PRODUTO PRODUTO, 
        OPS012_PRODUTOCONF PRODUTOCONF, 
        RMC001_PRODUTO COMPONENTE, 
        RMC001_PRODUTOCONF COMPONENTECONF, 
        CQFBA019(RMC001_GRUPO, RMC001_EMPRESA, RMC001_PRODUTO, RMC001_PRODUTOCONF) DESCRICAO, 
        RMC001_UM UM, 
       (RMC001_QTDESOL - RMC001_QTDECAN) DEMANDA, 
        ESFBI001(RMC001_GRUPO, RMC001_EMPRESA, RMC001_FILIAL, RMC001_PRODUTO, RMC001_PRODUTOCONF) LOCAL, 
        ECB001_DESCCOMP PREFORMAGEM, 
        RMC001_AXDESTINO ALMOXDEST 
 
FROM OPTBS011, OPTBS012, RMTBC001, ECTBB001 
 
WHERE OPS012_OPS011_ID = OPS011_ID 
   
  AND RMC001_GRUPO = OPS012_GRUPO 
  AND RMC001_EMPRESA = OPS012_EMPRESA 
  AND RMC001_FILIAL = OPS012_FILIAL 
  AND RMC001_TIPODOCOP = OPS012_TIPODOC 
  AND RMC001_ORDEM = OPS012_ORDEM 
  AND RMC001_LINHAOP = OPS012_LINHA 
   
  AND ECB001_GRUPO = OPS012_GRUPO 
  AND ECB001_EMPRESA = OPS012_EMPRESA 
  AND ECB001_PRODUTO = OPS012_PRODUTO 
  AND ECB001_COMPONENTE = RMC001_PRODUTO 
 
  AND OPS012_DATASIMUL BETWEEN :PERIODO 
 
  AND OPS012_RECURSO NOT IN (21, 45, 50, 81, 91, 93) 
  AND RMC001_AXDESTINO = 17 
  AND RMC001_SITUACAO = 1 
  AND OPS011_STATUS = 2 
 
GROUP BY RMC001_GRUPO, RMC001_EMPRESA, RMC001_FILIAL, 
        OPS012_RECURSO, OPS012_DATASIMUL, OPS012_TIPODOC, 
        OPS012_ORDEM, OPS012_PRODUTO, OPS012_PRODUTOCONF, 
        RMC001_PRODUTO, RMC001_PRODUTOCONF, RMC001_UM, 
        RMC001_QTDESOL, RMC001_QTDECAN, RMC001_AXDESTINO, 
        ECB001_DESCCOMP) CORE 
      
WHERE RECURSO :RECURSO 
  AND TIPODOC||'-'||ORDEM :ORDEM 
 
ORDER BY COMPONENTE 