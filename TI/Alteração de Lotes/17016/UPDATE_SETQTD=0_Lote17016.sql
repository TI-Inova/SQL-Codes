UPDATE ESTBK002
SET ESK002_QUANTIDADE = 0
WHERE ESK002_CONTENEDOR IN
(SELECT ESK010_CONTENEDOR CONTENEDOR
FROM ESTBK001,
ESTBK002,
ESTBK010,
ESTBA001
WHERE ESK010_GRUPO = ESK001_GRUPO
AND ESK010_EMPRESA = ESK001_EMPRESA
AND ESK010_FILIAL = ESK001_FILIAL
AND ESK010_CONTENEDOR = ESK001_CONTENEDOR
AND ESK002_GRUPO = ESK001_GRUPO
AND ESK002_EMPRESA = ESK001_EMPRESA
AND ESK002_FILIAL = ESK001_FILIAL
AND ESK002_CONTENEDOR = ESK001_CONTENEDOR
AND ESA001_PRODUTO = ESK002_PRODUTO
AND ESK001_ALMOXARIFADO = 1
AND ESK002_PRODUTO IN (17016)
AND ESK010_ETIQUETA NOT IN (2072792,2072801,2072800,2072804,2072803,2072802,2072799,1570059,1570042,1570045,2087285,2087286,2087287));