SELECT PERIODO||'/'||ANO PERIODO, 
        DECODE(PRODUTOCONF, 0, PRODUTO, PRODUTO||'-'||PRODUTOCONF) PRODUTO, 
        DESCRICAO, 
        SEGMENTO, 
        QTDVEND, 
        UM 
FROM 
 
(SELECT PVB001_GRUPO GRUPO, 
        PVB001_EMPRESA EMPRESA, 
        PVB001_FILIAL FILIAL, 
        TO_CHAR(NSA001_DTEMISSAO, 'YYYY') ANO, 
        TO_CHAR(NSA001_DTEMISSAO, 'MM') PERIODO, 
        NSB001_PRODUTO PRODUTO, 
        NSB001_PRODUTOCONF PRODUTOCONF, 
        NSB001_PRODDESC DESCRICAO, 
        TAA054_DESCRICAO SEGMENTO, 
        SUM(NSB001_QTDE) QTDVEND, 
        NSB001_UMVENDA UM 
 
FROM PVTBB001, NSTBA001, NSTBB001, TATBA008, TATBA054, PPTBA004, ESTBP001 
 
WHERE PVB001_GRUPO = NSA001_GRUPO 
  AND PVB001_EMPRESA = NSA001_EMPRESA 
  AND PVB001_FILIAL = NSA001_FILIAL 
 
  AND PVB001_GRUPO = NSB001_GRUPO 
  AND PVB001_EMPRESA = NSB001_EMPRESA 
  AND PVB001_FILIAL = NSB001_FILIAL 
  AND PVB001_PRODUTO = NSB001_PRODUTO 
  AND PVB001_PRODUTOCONF = NSB001_PRODUTOCONF 
 
  AND NSB001_TIPODOC = NSA001_TIPODOC 
  AND NSB001_NOTA = NSA001_NOTA 
  AND NSB001_SERIE = NSA001_SERIE 
   
  AND ESP001_GRUPO = PVB001_GRUPO 
  AND ESP001_EMPRESA = PVB001_EMPRESA 
  AND ESP001_FILIAL = PVB001_FILIAL 
  AND ESP001_PRODUTO = PVB001_PRODUTO 
  AND ESP001_PRODUTOCONF = PVB001_PRODUTOCONF 
 
  AND TAA008_CONDICAO = NSA001_CONDICAO 
   
  AND PPA004_PESSOA = NSA001_CLIENTE 
   
  AND TAA054_SEGMENTO = PPA004_SEGMENTO 
  AND TAA054_GRUPOPESSOA = PPA004_GRUPOPESSOA 
   
 
  AND PVB001_ANO = NVL(:ANO, TO_CHAR(SYSDATE, 'YYYY')) 
  AND PVB001_PERIODO = NVL(:MES, TO_CHAR(SYSDATE, 'MM')) 
     
  AND TO_CHAR(NSA001_DTEMISSAO, 'YYYY') = PVB001_ANO 
  AND TO_CHAR(NSA001_DTEMISSAO, 'MM') = PVB001_PERIODO 
   
  AND NSA001_CANCELADA LIKE 'N' 
  AND TAA008_FATURAMENTO LIKE 'S' 
  AND PPA004_SEGMENTO NOT IN (21, 51) 
  AND ESP001_TPPLANEJAM NOT IN (4) 
  AND NSB001_QTDE > 0 
  AND PVB001_QTDEPREV = 0 
 
GROUP BY PVB001_GRUPO, PVB001_EMPRESA, PVB001_FILIAL, 
        TO_CHAR(NSA001_DTEMISSAO, 'YYYY'), TO_CHAR(NSA001_DTEMISSAO, 'MM'), 
        NSB001_PRODUTO, NSB001_PRODUTOCONF, NSB001_PRODDESC, 
        TAA054_DESCRICAO, NSB001_UMVENDA) 
 
WHERE SEGMENTO :SEGMENTO 
 
ORDER BY TO_CHAR(QTDVEND, 999999) DESC 