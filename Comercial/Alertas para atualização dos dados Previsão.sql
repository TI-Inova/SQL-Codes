SELECT  '<span class="badge badge-danger" >'||'Período da Previsão de Vendas não Preenchido'||'</span>' SITUACAO, 

        '<span class="badge badge-danger" >'||PERIODO||'</span>' 

 

FROM 

 

(SELECT TO_CHAR(CDA003_DATA, 'MM')||'/'||TO_CHAR(CDA003_DATA, 'RRRR') PERIODO, 

 

       (SELECT  PVB001_PERIODO||'/'||PVB001_ANO PERIODO 

        FROM PVTBB001 

        WHERE PVB001_QTDEPREV <> 0 

          AND PVB001_PERIODO = TO_CHAR(CDA003_DATA, 'MM') 

          AND PVB001_ANO = TO_CHAR(CDA003_DATA, 'RRRR') 

        GROUP BY PVB001_ANO, PVB001_PERIODO) PERIODO_PREV 

 

FROM CDTBA003 

 

WHERE CDA003_CALENDARIO = 'EFFECTIVE' 

  AND TO_DATE('01/'||TO_CHAR(CDA003_DATA, 'MM')||'/'||TO_CHAR(CDA003_DATA, 'RRRR')) BETWEEN TO_DATE('01/'||TO_CHAR(SYSDATE, 'MM')||'/'||TO_CHAR(SYSDATE, 'RRRR'))  

                                                                                        AND TO_DATE('01/'||TO_CHAR((SYSDATE + 365), 'MM')||'/'||TO_CHAR((SYSDATE + 365), 'RRRR')) 

 

GROUP BY TO_CHAR(CDA003_DATA, 'MM'), TO_CHAR(CDA003_DATA, 'RRRR')) 

 

WHERE PERIODO_PREV IS NULL 