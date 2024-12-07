SELECT DECODE(JN_OPERATION, 1, 'Inclusão') OPERACAO, 
        PVB001_ANO ANO, 
        PVB001_PERIODO PERIODO, 
        DECODE(PVB001_PRODUTOCONF, 0, PVB001_PRODUTO, PVB001_PRODUTO||'-'||PVB001_PRODUTOCONF) PRODUTO, 
        PVB001_QTDEPREV QTDPREV, 
        NULL QTDPREV_ANT, 
        JN_ORACLE_USER USUARIO, 
        TO_CHAR(JN_DATETIME, 'DD/MM/RRRR HH24:MI') DATA_ALT 
 
FROM PVTBB001_JN 
 
WHERE JN_NOTES LIKE ('%PVTGB001J2') 
  AND JN_OPERATION = 1  
 
  AND TO_CHAR(JN_DATETIME, 'DD/MM/YYYY') = TO_CHAR(SYSDATE, 'DD/MM/YYYY') 
  AND TO_CHAR(JN_DATETIME, 'HH') = (TO_CHAR(SYSDATE, 'HH') - 1) 
 
UNION 
 
SELECT DECODE(JN_OPERATION, 2, 'Alteração', 3, 'Exclusão') OPERACAO, 
        PVB001_ANO ANO, 
        PVB001_PERIODO PERIODO, 
        DECODE(PVB001_PRODUTOCONF, 0, PVB001_PRODUTO, PVB001_PRODUTO||'-'||PVB001_PRODUTOCONF) PRODUTO, 
        PVB001_QTDEPREV QTDPREV, 
       (SELECT QTDEPREV_ANT 
        FROM (SELECT PVB001_QTDEPREV QTDEPREV, 
                    LAG(PVB001_QTDEPREV, 1) OVER(ORDER BY JN_DATETIME) QTDEPREV_ANT, 
                    TO_CHAR(JN_DATETIME, 'DD/MM/RRRR HH24:MI:SS') DATA 
              FROM PVTBB001_JN 
              WHERE PVB001_PRODUTO = A.PVB001_PRODUTO 
                AND PVB001_PRODUTOCONF = A.PVB001_PRODUTOCONF 
                AND PVB001_ANO = A.PVB001_ANO 
                AND PVB001_PERIODO = A.PVB001_PERIODO) 
        WHERE DATA LIKE TO_CHAR(A.JN_DATETIME, 'DD/MM/RRRR HH24:MI:SS')) QTDPREV_ANT, 
         
        JN_ORACLE_USER USUARIO, 
        TO_CHAR(JN_DATETIME, 'DD/MM/RRRR HH24:MI') DATA_ALT 
 
FROM PVTBB001_JN A 
 
WHERE JN_NOTES LIKE ('%PVTGB001J2') 
  AND JN_OPERATION IN (2,3)   
  AND TO_CHAR(JN_DATETIME, 'DD/MM/YYYY') = TO_CHAR(SYSDATE, 'DD/MM/YYYY') 
  AND TO_CHAR(JN_DATETIME, 'HH') = (TO_CHAR(SYSDATE, 'HH') - 1) 
 
ORDER BY DATA_ALT DESC 