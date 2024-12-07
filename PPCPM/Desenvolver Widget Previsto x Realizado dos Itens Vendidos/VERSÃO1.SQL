SELECT PERIODO||'-'||ANO PERIODO, 
        DECODE(PRODUTOCONF, 0, PRODUTO, PRODUTO||'-'||PRODUTOCONF) PRODUTO, 
        DESCRICAO, 
        SEGMENTO, 
        QTDPREV, 
        QTDVEND, 
        UM, 
        MARGEM 
 
FROM 
 
(SELECT PVB001_ANO ANO , 
        PVB001_PERIODO PERIODO, 
        NSB001_PRODUTO PRODUTO, 
        NSB001_PRODUTOCONF PRODUTOCONF, 
        NSB001_PRODDESC DESCRICAO, 
        TAA054_DESCRICAO SEGMENTO, 
        PVB001_QTDEPREV QTDPREV, 
        SUM(NSB001_QTDE) QTDVEND, 
        NSB001_UMVENDA UM, 
        (ROUND(SUM(NSB001_QTDE)/PVB001_QTDEPREV,3)*100)-100 AS MARGEM 
 
FROM PVTBB001, NSTBA001, NSTBB001, TATBA008, TATBA054, PPTBA004 
 
WHERE NSB001_TIPODOC = NSA001_TIPODOC 
  AND NSB001_NOTA = NSA001_NOTA 
  AND NSB001_SERIE = NSA001_SERIE 
  AND NSB001_PRODUTO = PVB001_PRODUTO 
  AND NSB001_PRODUTOCONF = PVB001_PRODUTOCONF 
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
  AND PVB001_QTDEPREV > 0 
 
GROUP BY PVB001_ANO, 
        PVB001_PERIODO, 
        NSB001_PRODUTO, 
        NSB001_PRODUTOCONF, 
        NSB001_PRODDESC, 
        TAA054_DESCRICAO, 
        PVB001_QTDEPREV, 
        NSB001_UMVENDA) 
 
WHERE MARGEM NOT BETWEEN -15 AND 15 
  AND SEGMENTO :SEGMENTO 
 
ORDER BY MARGEM DESC 