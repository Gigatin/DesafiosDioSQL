use oficina;

-- Inserção de Clientes
INSERT INTO Clientes (Nome, Endereco, Telefone, Email, DataRegistro)
VALUES
    ('João Silva', 'Rua A, 123', '(11) 1234-5678', 'joao@email.com', '2023-01-15'),
    ('Maria Santos', 'Avenida B, 456', '(22) 9876-5432', 'maria@email.com', '2023-02-20');

-- Inserção de Veículos
INSERT INTO Veiculos (Modelo, Marca, Ano, Placa, ID_Cliente)
VALUES
    ('Gol', 'Volkswagen', 2020, 'ABC123', 1),
    ('Civic', 'Honda', 2019, 'XYZ789', 2);

-- Inserção de Ordens de Serviço (OS)
INSERT INTO OrdensDeServico (DataAbertura, DescricaoProblema, Status, ID_Cliente, ID_Veiculo)
VALUES
    ('2023-03-01', 'Problema no motor', 'Em andamento', 1, 1),
    ('2023-03-05', 'Troca de óleo', 'Concluído', 2, 2);

-- Inserção de Itens de Serviço
INSERT INTO ItensServico (DescricaoServico, Preco, ID_OS)
VALUES
    ('Substituição de peças', 350.00, 1),
    ('Troca de óleo e filtro', 120.00, 2);

-- Inserção de Mecânicos
INSERT INTO Mecanicos (Nome, Especialidade, DataContratacao)
VALUES
    ('Pedro Souza', 'Mecânico Geral', '2022-05-10'),
    ('Ana Santos', 'Mecânica de Motor', '2023-01-20');

-- Inserção de Alocação de Mecânicos às OS
INSERT INTO AlocacaoMecanicos (ID_Mecanico, ID_OS)
VALUES
    (1, 1),
    (2, 2);

-- Inserção de Peças em Estoque
INSERT INTO PecasEstoque (Nome, Fornecedor, QuantidadeEmEstoque, PrecoPorUnidade)
VALUES
    ('Filtro de Óleo', 'Fornecedor A', 100, 8.50),
    ('Bateria', 'Fornecedor B', 50, 100.00);

-- Inserção de Uso de Peças em OS
INSERT INTO UsoPecas (ID_Peca, QuantidadeUtilizada, ID_OS)
VALUES
    (1, 2, 1),
    (2, 1, 2);

-- Inserção de Pagamentos
INSERT INTO Pagamentos (MetodoPagamento, Valor, Data, ID_OS)
VALUES
    ('Cartão de Crédito', 350.00, '2023-03-05', 1),
    ('Dinheiro', 120.00, '2023-03-10', 2);

-- Inserção de Avaliações
INSERT INTO Avaliacoes (Comentario, Classificacao, ID_Cliente, ID_OS)
VALUES
    ('Ótimo serviço!', 5, 1, 1),
    ('Atendimento excelente!', 4, 2, 2);
    
-- recupera todos os clientes    
 SELECT * FROM Clientes;

-- recupera todos os clientes com o nome 'joão silva'
SELECT * FROM Clientes WHERE Nome = 'João Silva';

-- Recupera veículos e calcula a idade deles em anos:
SELECT Modelo, Marca, Ano, YEAR(CURDATE()) - Ano AS Idade FROM Veiculos;

-- Recupera clientes ordenados por data de registro:
SELECT * FROM Clientes ORDER BY DataRegistro;

-- Recupera a média de classificação das avaliações para os clientes com pelo menos duas avaliações:
SELECT ID_Cliente, AVG(Classificacao) AS MediaClassificacao
FROM Avaliacoes
GROUP BY ID_Cliente
HAVING COUNT(*) >= 2;

-- Recupera informações completas sobre as Ordens de Serviço, incluindo dados do cliente e do veículo:
SELECT O.ID_OS, O.DataAbertura, O.DescricaoProblema, O.Status,
       C.Nome AS NomeCliente, V.Modelo AS ModeloVeiculo
FROM OrdensDeServico AS O
JOIN Clientes AS C ON O.ID_Cliente = C.ID_Cliente
JOIN Veiculos AS V ON O.ID_Veiculo = V.ID_Veiculo;
