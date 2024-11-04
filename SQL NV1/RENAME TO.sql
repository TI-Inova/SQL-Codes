ALTER TABLE orders /*Aqui a tabela que vai ser alterada*/
RENAME order_amt TO bill; /*após a condição RENAME escolhemos a coluna que vai ser renomeada em seguida TO onde definimos o nome que a coluna vai receber*/

SELECT * FROM orders;