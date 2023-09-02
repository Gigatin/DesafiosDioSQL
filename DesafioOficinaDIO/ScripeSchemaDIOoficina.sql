create database oficina;

use oficina;



-- Criação da Tabela de Clientes
CREATE TABLE Clientes (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(255),
    DataRegistro DATE
);

-- Criação da Tabela de Veículos
CREATE TABLE Veiculos (
    ID_Veiculo INT AUTO_INCREMENT PRIMARY KEY,
    Modelo VARCHAR(255),
    Marca VARCHAR(255),
    Ano INT,
    Placa VARCHAR(10),
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Criação da Tabela de Ordens de Serviço (OS)
CREATE TABLE OrdensDeServico (
    ID_OS INT AUTO_INCREMENT PRIMARY KEY,
    DataAbertura DATE,
    DescricaoProblema TEXT,
    Status VARCHAR(20),
    ID_Cliente INT,
    ID_Veiculo INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Veiculo) REFERENCES Veiculos(ID_Veiculo)
);

-- Criação da Tabela de Itens de Serviço
CREATE TABLE ItensServico (
    ID_Item_Servico INT AUTO_INCREMENT PRIMARY KEY,
    DescricaoServico TEXT,
    Preco DECIMAL(10, 2),
    ID_OS INT,
    FOREIGN KEY (ID_OS) REFERENCES OrdensDeServico(ID_OS)
);

-- Criação da Tabela de Mecânicos
CREATE TABLE Mecanicos (
    ID_Mecanico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Especialidade VARCHAR(255),
    DataContratacao DATE
);

-- Criação da Tabela de Alocação de Mecânicos às OS
CREATE TABLE AlocacaoMecanicos (
    ID_Alocacao INT AUTO_INCREMENT PRIMARY KEY,
    ID_Mecanico INT,
    ID_OS INT,
    FOREIGN KEY (ID_Mecanico) REFERENCES Mecanicos(ID_Mecanico),
    FOREIGN KEY (ID_OS) REFERENCES OrdensDeServico(ID_OS)
);

-- Criação da Tabela de Peças em Estoque
CREATE TABLE PecasEstoque (
    ID_Peca INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Fornecedor VARCHAR(255),
    QuantidadeEmEstoque INT,
    PrecoPorUnidade DECIMAL(10, 2)
);

-- Criação da Tabela de Uso de Peças em OS
CREATE TABLE UsoPecas (
    ID_Uso_Peca INT AUTO_INCREMENT PRIMARY KEY,
    ID_Peca INT,
    QuantidadeUtilizada INT,
    ID_OS INT,
    FOREIGN KEY (ID_Peca) REFERENCES PecasEstoque(ID_Peca),
    FOREIGN KEY (ID_OS) REFERENCES OrdensDeServico(ID_OS)
);

-- Criação da Tabela de Pagamentos
CREATE TABLE Pagamentos (
    ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    MetodoPagamento VARCHAR(50),
    Valor DECIMAL(10, 2),
    Data DATE,
    ID_OS INT,
    FOREIGN KEY (ID_OS) REFERENCES OrdensDeServico(ID_OS)
);

-- Criação da Tabela de Avaliações
CREATE TABLE Avaliacoes (
    ID_Avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    Comentario TEXT,
    Classificacao INT,
    ID_Cliente INT,
    ID_OS INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_OS) REFERENCES OrdensDeServico(ID_OS)
);
