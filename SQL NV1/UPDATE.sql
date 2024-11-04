UPDATE produtos SET quantidade = 130 /*Aqui vamos identificar a tabela a qual vamos atualizar, em seguida oque vamos alterar*/
WHERE produto = 'ventilador'; /*Aqio as condições que estão sendo alteradas e quais condições devem atender de acordo com o SET*/

SELECT * FROM  produtos; /*Consultando a tabela para conferir o UPDATE*/