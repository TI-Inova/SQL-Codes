SELECT COMPRADOR, 

        COUNT(PRODUTO) SKU, 

        SUM(VLRTOTAL) TOTAL, 

        MOEDA, 

         

       (SELECT '<span class="badge badge-danger" >'||OCA001_TIPODOC||'-'||OCA001_ORDCOMPRA||'</span>' 

                 

        FROM OCTBA001, MITBA001 

         

        WHERE MIA001_MOEDA = OCA001_MOEDA 

          AND OCA001_COMPRADOR = COMPRADOR 

          AND MIA001_SIGLA = MOEDA 

           

          AND OCA001_TOTALOC IN (SELECT MAX(OCA001_TOTALOC) 

                                 FROM OCTBA001, MITBA001 

                                 WHERE MIA001_MOEDA = OCA001_MOEDA 

                                   AND OCA001_COMPRADOR = COMPRADOR 

                                   AND MIA001_SIGLA = MOEDA 

                                   AND TO_CHAR(OCA001_DTEMISSAO, 'MM') LIKE NVL(:MES, TO_CHAR(SYSDATE, 'MM')) 

                                   AND TO_CHAR(OCA001_DTEMISSAO, 'YYYY') LIKE NVL(:ANO, TO_CHAR(SYSDATE, 'YYYY'))) 

           

          AND TO_CHAR(OCA001_DTEMISSAO, 'MM') LIKE NVL(:MES, TO_CHAR(SYSDATE, 'MM')) 

          AND TO_CHAR(OCA001_DTEMISSAO, 'YYYY') LIKE NVL(:ANO, TO_CHAR(SYSDATE, 'YYYY'))) ORDEM_RELEVANTE, 

         

       (SELECT '<span class="badge badge-danger" >'||TO_CHAR(OCA001_TOTALOC, 'L999G999G990D00')||'</span>' 

                 

        FROM OCTBA001, MITBA001 

         

        WHERE MIA001_MOEDA = OCA001_MOEDA 

          AND OCA001_COMPRADOR = COMPRADOR 

          AND MIA001_SIGLA = MOEDA 

           

          AND OCA001_TOTALOC IN (SELECT MAX(OCA001_TOTALOC) 

                                 FROM OCTBA001, MITBA001 

                                 WHERE MIA001_MOEDA = OCA001_MOEDA 

                                   AND OCA001_COMPRADOR = COMPRADOR 

                                   AND MIA001_SIGLA = MOEDA 

                                   AND TO_CHAR(OCA001_DTEMISSAO, 'MM') LIKE NVL(:MES, TO_CHAR(SYSDATE, 'MM')) 

                                   AND TO_CHAR(OCA001_DTEMISSAO, 'YYYY') LIKE NVL(:ANO, TO_CHAR(SYSDATE, 'YYYY'))) 

           

          AND TO_CHAR(OCA001_DTEMISSAO, 'MM') LIKE NVL(:MES, TO_CHAR(SYSDATE, 'MM')) 

          AND TO_CHAR(OCA001_DTEMISSAO, 'YYYY') LIKE NVL(:ANO, TO_CHAR(SYSDATE, 'YYYY'))) TOTAL_RELEVANTE, 

 

          '<span class="badge badge-danger" >'||MOEDA||'</span>' MOEDA_RELEVANTE 

           

FROM 

 

(SELECT OCA001_COMPRADOR COMPRADOR,  

        OCB001_PRODUTO PRODUTO, 

        MIA001_SIGLA MOEDA, 

        SUM(OCB001_VLRTOTAL) VLRTOTAL 

         

FROM OCTBA001, OCTBB001, MITBA001 

 

WHERE OCB001_GRUPO = OCA001_GRUPO 

  AND OCB001_EMPRESA = OCA001_EMPRESA 

  AND OCB001_FILIAL = OCA001_FILIAL 

  AND OCB001_TIPODOC = OCA001_TIPODOC 

  AND OCB001_ORDCOMPRA = OCA001_ORDCOMPRA 

   

  AND MIA001_MOEDA = OCA001_MOEDA 

   

  AND TO_CHAR(OCA001_DTEMISSAO, 'MM') LIKE NVL(:MES, TO_CHAR(SYSDATE, 'MM')) 

  AND TO_CHAR(OCA001_DTEMISSAO, 'YYYY') LIKE NVL(:ANO, TO_CHAR(SYSDATE, 'YYYY')) 

 

GROUP BY OCA001_COMPRADOR, OCB001_PRODUTO, OCA001_DTEMISSAO, MIA001_SIGLA) 

   

GROUP BY COMPRADOR, MOEDA 

 

ORDER BY COMPRADOR, TOTAL DESC 