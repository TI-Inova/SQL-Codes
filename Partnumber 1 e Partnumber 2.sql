SELECT
  SQL_1.PRODUTO,
  SQL_1.PARAN_PLAN,
  SQL_1.STATUS,
  SQL_1.DESCRICAO,
  SQL_1.DESC_COMP,
  SQL_1.PART_NUMBER,
  SQL_1.FORNECEDOR,
  SQL_1.MARCA,
  SQL_1.IMAGEM,
  SQL_1.LINK,
  SQL_2.PART_NUMBER AS PART_NUMBER_2,
  SQL_2.FORNECEDOR AS FORNECEDOR_2,
  SQL_2.MARCA AS MARCA_2,
  SQL_2.IMAGEM AS IMAGEM_2,
  SQL_2.LINK AS LINK_2,
  SQL_1.LIBRARY_REF,
  SQL_1.LIBRARY_PATH,
  SQL_1.FOOT_PRINT_REF1,
  SQL_1.FOOT_PRINT_REF2,
  SQL_1.FOOT_PRINT_PATH,
  SQL_1.EMBALAGEM,
  SQL_1.CUSTO_PADRAO,
  SQL_1.CUSTO_MEDIO
  --PRIMEIRA PARTE DO SQL 
FROM
  (
    SELECT DISTINCT
      ESA001_PRODUTO AS PRODUTO,
      ESA001_DESCRICAO AS DESCRICAO,
      PAN001_PARTNUMBER AS PART_NUMBER,
      PPA001_PESSOA || ' - ' || PPA001_NOME AS FORNECEDOR,
      TAB003_NOMEMARCA AS MARCA,
      PAN001_IMAGEM AS IMAGEM,
      PAN001_LINKDOC AS LINK,
      CASE ESR001_STATUS
        WHEN 2 THEN 'INATIVO'
        ELSE 'ATIVO'
      END AS STATUS,
      CASE ESP001_TPPLANEJAM
        WHEN 2 THEN 'ATIVO'
        WHEN 4 THEN 'INATIVO'
        ELSE 'OUTROS'
      END AS PARAN_PLAN,
      ESA001_DESCCOMP AS DESC_COMP,
      (
        SELECT
          RFA002_VALOR
        FROM
          RFTBA002
        WHERE
          ROWNUM = 1
          AND RFA002_GRUPO = ESA001_GRUPO
          AND RFA002_EMPRESA = ESA001_EMPRESA
          AND RFA002_PRODUTO = ESA001_PRODUTO
          AND RFA002_CAMPO = 'LIBRARYREF'
      ) AS LIBRARY_REF,
      (
        SELECT
          RFA002_VALOR
        FROM
          RFTBA002
        WHERE
          RFA002_GRUPO = ESA001_GRUPO
          AND RFA002_EMPRESA = ESA001_EMPRESA
          AND RFA002_PRODUTO = ESA001_PRODUTO
          AND RFA002_CAMPO = 'LIBRARYPATH'
      ) LIBRARY_PATH,
      (
        SELECT
          RFA002_VALOR
        FROM
          RFTBA002
        WHERE
          RFA002_GRUPO = ESA001_GRUPO
          AND RFA002_EMPRESA = ESA001_EMPRESA
          AND RFA002_PRODUTO = ESA001_PRODUTO
          AND RFA002_CAMPO = 'FOOTPRINTREF'
      ) FOOT_PRINT_REF1,
      (
        SELECT
          RFA002_VALOR
        FROM
          RFTBA002
        WHERE
          RFA002_GRUPO = ESA001_GRUPO
          AND RFA002_EMPRESA = ESA001_EMPRESA
          AND RFA002_PRODUTO = ESA001_PRODUTO
          AND RFA002_CAMPO = 'FOOTPRINTREF2'
      ) FOOT_PRINT_REF2,
      (
        SELECT
          RFA002_VALOR
        FROM
          RFTBA002
        WHERE
          RFA002_GRUPO = ESA001_GRUPO
          AND RFA002_EMPRESA = ESA001_EMPRESA
          AND RFA002_PRODUTO = ESA001_PRODUTO
          AND RFA002_CAMPO = 'FOOTPRINTPATH'
      ) FOOT_PRINT_PATH,
      ESH001_EMBALAGEM AS EMBALAGEM,
      (
        SELECT
          CUG001_CUSTO
        FROM
          CUTBG001
        WHERE ROWNUM = 1
          AND CUG001_GRUPO = ESP001_GRUPO
          AND CUG001_EMPRESA = ESP001_EMPRESA
          AND CUG001_FILIAL = ESP001_FILIAL
          AND CUG001_PRODUTO = ESP001_PRODUTO
          AND CUG001_PRODUTOCONF = ESP001_PRODUTOCONF
          AND CUG001_TIPOCUSTO = 2 -- Custo M�dio
          
      ) AS CUSTO_MEDIO,
      (
        SELECT
          CUG001_CUSTO
        FROM
          CUTBG001
        WHERE ROWNUM = 1
          AND CUG001_GRUPO = ESP001_GRUPO
          AND CUG001_EMPRESA = ESP001_EMPRESA
          AND CUG001_FILIAL = ESP001_FILIAL
          AND CUG001_PRODUTO = ESP001_PRODUTO
          AND CUG001_PRODUTOCONF = ESP001_PRODUTOCONF
          AND CUG001_TIPOCUSTO = 1 -- Custo Padr�o
          
      ) AS CUSTO_PADRAO
    FROM
      ESTBA001
      JOIN FOTBC001 ON FOC001_GRUPO = ESA001_GRUPO
      AND FOC001_EMPRESA = ESA001_EMPRESA
      AND FOC001_PRODUTO = ESA001_PRODUTO
      JOIN PATBN001 ON PAN001_GRUPO = FOC001_GRUPO
      AND PAN001_EMPRESA = FOC001_EMPRESA
      AND PAN001_FOA001_ID = FOC001_FOA001_ID
      AND PAN001_PRODUTO = FOC001_PRODUTO
      AND PAN001_PRODUTOCONF = FOC001_PRODUTOCONF
      AND PAN001_CODPRODUTO = FOC001_CODPRODUTO
      JOIN PPTBA001 ON PPA001_GRUPO = FOC001_GRUPO
      AND PPA001_EMPRESA = FOC001_EMPRESA
      AND PPA001_PESSOA = FOC001_FORNECEDOR
      JOIN TATBB003 ON TAB003_GRUPO = PAN001_GRUPO
      AND TAB003_EMPRESA = PAN001_EMPRESA
      AND TAB003_NROREGISTRO = PAN001_MARCA
      JOIN ESTBP001 ON ESP001_PRODUTO = FOC001_PRODUTO
      AND ESP001_PRODUTOCONF = FOC001_PRODUTOCONF
      JOIN CUTBG001 ON CUG001_GRUPO = ESP001_GRUPO
      AND CUG001_EMPRESA = ESP001_EMPRESA
      AND CUG001_FILIAL = ESP001_FILIAL
      AND CUG001_PRODUTO = ESP001_PRODUTO
      AND CUG001_PRODUTOCONF = ESP001_PRODUTOCONF
      LEFT JOIN ESTBH001 ON ESH001_GRUPO = ESA001_GRUPO
      AND ESH001_EMPRESA = ESA001_EMPRESA
      AND ESH001_PRODUTO = ESA001_PRODUTO
      JOIN ESTBR001 ON ESR001_GRUPO = ESA001_GRUPO
      AND ESR001_EMPRESA = ESA001_EMPRESA
      AND ESR001_PRODUTO = ESA001_PRODUTO
    WHERE
      ESA001_PRODUTO = :PRODUTO
      AND PAN001_ATIVO = 'S'
      AND ESP001_TPPLANEJAM IN (2, 4)
      AND FOC001_FORNECEDOR NOT IN (928, 5, 2266)
      AND FOC001_FORNECEDOR = ESP001_FORNPADRAO
  ) SQL_1
  --SEGUNDA PARTE DO SQL                  
  JOIN (
    SELECT
      ESA001_PRODUTO AS PRODUTO,
      --ABAIXO O PART NUMBER
      (
        CASE
          WHEN PAN001_PARTNUMBER = (
            SELECT
              PAN001_PARTNUMBER
            FROM
              PATBN001
            WHERE
              PAN001_GRUPO = FOC001_GRUPO
              AND PAN001_EMPRESA = FOC001_EMPRESA
              AND PAN001_FORNECEDOR = TO_NUMBER(ESP001_FORNPADRAO)
              AND PAN001_PRODUTO = FOC001_PRODUTO
              AND PAN001_PRODUTOCONF = FOC001_PRODUTOCONF
              AND PAN001_CODPRODUTO = FOC001_CODPRODUTO
              AND PAN001_ATIVO = 'S'
          ) THEN NULL
          WHEN PAN001_PARTNUMBER <> (
            SELECT
              PAN001_PARTNUMBER
            FROM
              PATBN001
            WHERE
              PAN001_GRUPO = FOC001_GRUPO
              AND PAN001_EMPRESA = FOC001_EMPRESA
              AND PAN001_FORNECEDOR = TO_NUMBER(ESP001_FORNPADRAO)
              AND PAN001_PRODUTO = FOC001_PRODUTO
              AND PAN001_PRODUTOCONF = FOC001_PRODUTOCONF
              AND PAN001_CODPRODUTO = FOC001_CODPRODUTO
              AND PAN001_ATIVO = 'S'
          ) THEN PAN001_PARTNUMBER
          ELSE '(null)'
        END
      ) AS PART_NUMBER,
      --ABAIXO FORNCEDOR
      (
        CASE
          WHEN PAN001_PARTNUMBER <> (
            SELECT
              PAN001_PARTNUMBER
            FROM
              PATBN001
            WHERE
              PAN001_GRUPO = FOC001_GRUPO
              AND PAN001_EMPRESA = FOC001_EMPRESA
              AND PAN001_FORNECEDOR = TO_NUMBER(ESP001_FORNPADRAO)
              AND PAN001_PRODUTO = FOC001_PRODUTO
              AND PAN001_PRODUTOCONF = FOC001_PRODUTOCONF
              AND PAN001_CODPRODUTO = FOC001_CODPRODUTO
              AND PAN001_ATIVO = 'S'
          ) THEN PPA001_PESSOA || ' - ' || PPA001_NOME
          ELSE NULL
        END
      ) AS FORNECEDOR,
      --ABAIXO A MARCA
      (
        CASE
          WHEN PAN001_PARTNUMBER <> (
            SELECT
              PAN001_PARTNUMBER
            FROM
              PATBN001
            WHERE
              PAN001_GRUPO = FOC001_GRUPO
              AND PAN001_EMPRESA = FOC001_EMPRESA
              AND PAN001_FORNECEDOR = TO_NUMBER(ESP001_FORNPADRAO)
              AND PAN001_PRODUTO = FOC001_PRODUTO
              AND PAN001_PRODUTOCONF = FOC001_PRODUTOCONF
              AND PAN001_CODPRODUTO = FOC001_CODPRODUTO
              AND PAN001_ATIVO = 'S'
          ) THEN TAB003_NOMEMARCA
          ELSE NULL
        END
      ) AS MARCA,
      --ABAIXO A IMAGEM
      (
        CASE
          WHEN PAN001_PARTNUMBER <> (
            SELECT
              PAN001_PARTNUMBER
            FROM
              PATBN001
            WHERE
              PAN001_GRUPO = FOC001_GRUPO
              AND PAN001_EMPRESA = FOC001_EMPRESA
              AND PAN001_FORNECEDOR = TO_NUMBER(ESP001_FORNPADRAO)
              AND PAN001_PRODUTO = FOC001_PRODUTO
              AND PAN001_PRODUTOCONF = FOC001_PRODUTOCONF
              AND PAN001_CODPRODUTO = FOC001_CODPRODUTO
              AND PAN001_ATIVO = 'S'
          ) THEN PAN001_IMAGEM
          ELSE NULL
        END
      ) AS IMAGEM,
      --ABAIXO O LINK
      (
        CASE
          WHEN PAN001_PARTNUMBER <> (
            SELECT
              PAN001_PARTNUMBER
            FROM
              PATBN001
            WHERE
              PAN001_GRUPO = FOC001_GRUPO
              AND PAN001_EMPRESA = FOC001_EMPRESA
              AND PAN001_FORNECEDOR = TO_NUMBER(ESP001_FORNPADRAO)
              AND PAN001_PRODUTO = FOC001_PRODUTO
              AND PAN001_PRODUTOCONF = FOC001_PRODUTOCONF
              AND PAN001_CODPRODUTO = FOC001_CODPRODUTO
              AND PAN001_ATIVO = 'S'
          ) THEN PAN001_LINKDOC
          ELSE NULL
        END
      ) AS LINK
    FROM
      ESTBA001
      JOIN FOTBC001 ON FOC001_GRUPO = ESA001_GRUPO
      AND FOC001_EMPRESA = ESA001_EMPRESA
      AND FOC001_PRODUTO = ESA001_PRODUTO
      JOIN PATBN001 ON PAN001_GRUPO = FOC001_GRUPO
      AND PAN001_EMPRESA = FOC001_EMPRESA
      AND PAN001_FOA001_ID = FOC001_FOA001_ID
      AND PAN001_PRODUTO = FOC001_PRODUTO
      AND PAN001_PRODUTOCONF = FOC001_PRODUTOCONF
      AND PAN001_CODPRODUTO = FOC001_CODPRODUTO
      JOIN PPTBA001 ON PPA001_GRUPO = FOC001_GRUPO
      AND PPA001_EMPRESA = FOC001_EMPRESA
      AND PPA001_PESSOA = FOC001_FORNECEDOR
      JOIN TATBB003 ON TAB003_GRUPO = PAN001_GRUPO
      AND TAB003_EMPRESA = PAN001_EMPRESA
      AND TAB003_NROREGISTRO = PAN001_MARCA
      JOIN ESTBP001 ON ESP001_PRODUTO = FOC001_PRODUTO
      AND ESP001_PRODUTOCONF = FOC001_PRODUTOCONF
      JOIN CUTBG001 ON CUG001_GRUPO = ESP001_GRUPO
      AND CUG001_EMPRESA = ESP001_EMPRESA
      AND CUG001_FILIAL = ESP001_FILIAL
      AND CUG001_PRODUTO = ESP001_PRODUTO
      AND CUG001_PRODUTOCONF = ESP001_PRODUTOCONF
      LEFT JOIN ESTBH001 ON ESH001_GRUPO = ESA001_GRUPO
      AND ESH001_EMPRESA = ESA001_EMPRESA
      AND ESH001_PRODUTO = ESA001_PRODUTO
      JOIN ESTBR001 ON ESR001_GRUPO = ESA001_GRUPO
      AND ESR001_EMPRESA = ESA001_EMPRESA
      AND ESR001_PRODUTO = ESA001_PRODUTO
    WHERE
      ROWNUM = 1
      AND ESA001_PRODUTO = :PRODUTO
      AND PAN001_ATIVO = 'S'
      AND FOC001_FORNECEDOR NOT IN (928, 5, 2266)
      AND FOC001_FORNECEDOR = (
        SELECT
          OCA001_FORNECEDOR
        FROM
          (
            SELECT DISTINCT
              CASE
                WHEN OCA001_FORNECEDOR = (
                  SELECT
                    OCA001_FORNECEDOR
                  FROM
                    (
                      SELECT
                        OCA001_FORNECEDOR,
                        MAX(OCA001_DTEMISSAO) AS MAX_DTEMISSAO
                      FROM
                        OCTBB001
                        JOIN ESTBP001 ON ESP001_GRUPO = OCB001_GRUPO
                        AND ESP001_EMPRESA = OCB001_EMPRESA
                        AND ESP001_FILIAL = OCB001_FILIAL
                        AND ESP001_PRODUTO = OCB001_PRODUTO
                        AND ESP001_PRODUTOCONF = OCB001_PRODUTOCONF
                        JOIN OCTBA001 ON OCB001_GRUPO = OCA001_GRUPO
                        AND OCB001_EMPRESA = OCA001_EMPRESA
                        AND OCB001_FILIAL = OCA001_FILIAL
                        AND OCB001_TIPODOC = OCA001_TIPODOC
                        AND OCB001_ORDCOMPRA = OCA001_ORDCOMPRA
                        AND OCA001_FORNECEDOR <> ESP001_FORNPADRAO
                      WHERE ROWNUM = 1
                        AND OCB001_PRODUTO = :PRODUTO
                        
                      GROUP BY
                        OCA001_FORNECEDOR
                      ORDER BY
                        MAX(OCA001_DTEMISSAO) DESC
                    ) OCA001_FORNECEDOR
                  WHERE
                    ROWNUM = 1
                ) THEN OCA001_FORNECEDOR
                ELSE (
                  SELECT
                    FOC001_FORNECEDOR
                  FROM
                    FOTBC001
                    JOIN ESTBP001 ON ESP001_GRUPO = FOC001_GRUPO
                    AND ESP001_EMPRESA = FOC001_EMPRESA
                    AND ESP001_PRODUTO = FOC001_PRODUTO
                    AND ESP001_PRODUTOCONF = FOC001_PRODUTOCONF
                  WHERE ROWNUM = 1
                    AND FOC001_PRODUTO = :PRODUTO
                    AND FOC001_FORNECEDOR <> ESP001_FORNPADRAO
                    AND FOC001_FORNECEDOR NOT IN (928, 5, 2266)
                    
                )
              END OCA001_FORNECEDOR
            FROM
              OCTBA001
          )
      )
  ) SQL_2 ON SQL_1.PRODUTO = SQL_2.PRODUTO
WHERE
  ROWNUM = 1;