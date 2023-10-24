# Banco de Dados Ecommerce

Este repositório contém um banco de dados denominado "Ecommerce" e uma análise de exemplo das consultas SQL que podem ser usadas com esse banco de dados.

## Tabelas

O banco de dados "Ecommerce" é composto pelas seguintes tabelas:

- **clients**: Informações sobre os clientes do ecommerce, como nome, CPF e endereço.

- **product**: Detalhes dos produtos, incluindo nome, classificação para crianças, categoria e tamanho.

- **payments**: Registros de informações de pagamento dos clientes, incluindo tipo de pagamento e limite disponível.

- **orders**: Informações sobre os pedidos dos clientes, incluindo status, descrição do pedido, valor de envio e pagamento em dinheiro.

- **productStorage**: Dados de estoque, incluindo a localização e quantidade disponível dos produtos.

- **supplier**: Informações sobre os fornecedores, como nome social, CNPJ e informações de contato.

- **seller**: Detalhes dos vendedores, incluindo nome social, nome abreviado, CNPJ, CPF e informações de contato.

- **productSeller**: Relação entre vendedores e produtos, com informações sobre a quantidade de produtos vendidos por cada vendedor.

- **productOrder**: Relação entre produtos e pedidos, com detalhes sobre a quantidade de produtos em cada pedido e seu status de disponibilidade.

- **storageLocation**: Relação entre produtos e locais de estoque, mostrando a localização de cada produto no estoque.

- **productSupplier**: Relação entre fornecedores e produtos, incluindo a quantidade de produtos fornecidos por cada fornecedor.

## Exemplos de Consultas SQL

Aqui estão alguns exemplos de consultas SQL que podem ser usadas para analisar os dados do banco de dados "Ecommerce":

## Exemplos de Consultas SQL

Aqui estão alguns exemplos de consultas SQL que podem ser usadas para analisar os dados do banco de dados "Ecommerce":

-- Selecionar todos os registros da tabela de produtos vendidos
 ```sql   
   SELECT * FROM productSeller;
 ```

-- Selecionar clientes e pedidos correspondentes
 ```sql 
SELECT * FROM clients c, orders o WHERE c.idClient = idOrderClient;
 ```

-- Selecionar nomes de clientes e status de pedidos
 ```sql  
SELECT CONCAT(Fname, ' ', Lname) AS Client, idOrder AS Request, orderStatus AS Status
FROM clients c, orders o WHERE c.idClient = idOrderClient;
 ```

-- Inserir um novo pedido
 ```sql 
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
VALUES (2, DEFAULT, 'compra via aplicativo', NULL, 1);
 ```

-- Contagem de pedidos por cliente
 ```sql 
SELECT c.idClient, Fname, COUNT(*) AS Number_of_orders
FROM clients c
INNER JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY idClient;
 ```

-- Seleciona produtos em estoque
 ```sql 
SELECT Pname, size, quantity
FROM product p
INNER JOIN productStorage ps ON p.idProduct = ps.idLproduct
WHERE quantity > 0;
 ```

-- Calcula o valor total de pedidos confirmados
 ```sql 
SELECT SUM(sendValue) AS TotalValue
FROM orders
WHERE orderStatus = 'confirmado';

 ```

## Exemplos de Triggers que pensei para esse projeto


-- Trigger para atualizar o estoque
 ```sql 
CREATE TRIGGER update_stock
AFTER INSERT ON productOrder
FOR EACH ROW
BEGIN
    DECLARE product_quantity INT;
    SELECT quantity INTO product_quantity
    FROM productStorage
    WHERE idProdstorage = NEW.idPOproduct;
    
    IF product_quantity >= NEW.poQuantity THEN
        UPDATE productStorage
        SET quantity = quantity - NEW.poQuantity
        WHERE idProdstorage = NEW.idPOproduct;
    ELSE
        -- Ação a ser tomada se o estoque for insuficiente
        -- Pode ser um log de erro ou um aviso.
    END IF;
END;
 ```

-- Trigger para calcular a media de avaliação dos produtos
 ```sql 
CREATE TRIGGER calculate_average_rating
AFTER INSERT ON productOrder
FOR EACH ROW
BEGIN
    UPDATE product
    SET avaliacao = (avaliacao * 0.8) + (NEW.poQuantity * 0.2)
    WHERE idProduct = NEW.idPOproduct;
END;
 ```

Conclusão
Este banco de dados "Ecommerce" é útil para rastrear pedidos, produtos, clientes e fornecedores em um ambiente de comércio eletrônico. As consultas SQL fornecidas são exemplos de como extrair informações valiosas para análise e tomada de decisões. O conhecimento e o uso adequado dessas consultas são essenciais para gerenciar eficazmente operações de comércio eletrônico.

Sinta-se à vontade para explorar o banco de dados e utilizar as consultas para análises adicionais.
