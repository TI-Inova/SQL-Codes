SELECT DECODE(PVA002_PRODUTOCONFG, 0, PVA002_PRODUTOG, PVA002_PRODUTOG||'-'||PVA002_PRODUTOCONFG) PRODUTO_ORIGEM, 
        CQFBA019(PVA002_GRUPO, PVA002_EMPRESA, PVA002_PRODUTOG, PVA002_PRODUTOCONFG) DESCRICAO_ORIGEM, 
         
        DECODE(PVA002_PRODUTOCONF, 0, PVA002_PRODUTO, PVA002_PRODUTO||'-'||PVA002_PRODUTOCONF)PRODUTO_DESTINO, 
        CQFBA019(PVA002_GRUPO, PVA002_EMPRESA, PVA002_PRODUTO, PVA002_PRODUTOCONF) DESCRICAO_DESTINO, 
         
        PVA002_PESO, 
        PVA002_PERCENTUAL, 
        PVA002_DATAINI, 
        PVA002_DATAFIM 
 
FROM PVTBA002 
 
WHERE TO_CHAR(PVA002_PRODUTOG||'-'||PVA002_PRODUTOCONFG) LIKE NVL(:PRODUTO_ORIGEM, '%') 
  AND TO_CHAR(PVA002_PRODUTO||'-'||PVA002_PRODUTOCONF) LIKE NVL(:PRODUTO_DESTINO, '%') 
  AND PVA002_DATAINI BETWEEN :DATAINI  