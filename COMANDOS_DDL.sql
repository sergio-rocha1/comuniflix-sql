CREATE DATABASE COMUNIFLIX;

/* ==== TABELAS DO BANCO DE DADOS ==== */
CREATE TABLE TB_USUARIO (
	ID_USUARIO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NOME VARCHAR(MAX) NOT NULL,
	CPF BIGINT NOT NULL,
	ID_PLANO INT NOT NULL,
	DATA_NASCIMENTO DATE NULL,
	EMAIL VARCHAR(MAX) NOT NULL,
	SENHA VARCHAR(15) NOT NULL
);

CREATE TABLE TB_COLAB (
	ID_COLAB INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	CPF BIGINT NOT NULL,
	DATA_NASCIMENTO DATE NULL,
	EMAIL VARCHAR(MAX) NOT NULL,
	SENHA VARCHAR(15) NOT NULL,
	ID_CARGO INT NOT NULL,
	FERIAS BIT NOT NULL DEFAULT 1,
	DATA_ADMISSAO DATE NULL,
	NOME VARCHAR(150) NOT NULL
);

CREATE TABLE TB_CARGO (
	ID_CARGO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	DESC_CARGO VARCHAR(100) NOT NULL,
	SALARIO MONEY NOT NULL
);

CREATE TABLE TB_PLANO (
	ID_PLANO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	DESC_PLANO VARCHAR(50) NOT NULL,
	VALOR_PLANO FLOAT NOT NULL,
	ID_MOD_PLANO INT NOT NULL
);

CREATE TABLE TB_FILME (
	ID_FILME INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	NOME_FILME VARCHAR(150) NOT NULL,
	DESC_FILME VARCHAR(MAX) NOT NULL,
	DURACAO INT NOT NULL,
	RESPONSAVEL INT NOT NULL,
	ID_CATEGORIA INT NOT NULL,
	ID_FORMATO INT NOT NULL,
	ID_CLASS_INDICATIVA INT NOT NULL
);

CREATE TABLE TB_SERIE (
	ID_SERIE INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NOME_SERIE VARCHAR(200) NOT NULL,
	DESC_SERIE VARCHAR(MAX) NOT NULL,
	TEMPORADA INT NOT NULL DEFAULT 1,
	RESPONSAVEL INT NOT NULL,
	ID_CATEGORIA INT NOT NULL,
	ID_FORMATO INT NOT NULL,
	ID_CLASS_INDICATIVA INT NOT NULL
);

CREATE TABLE TB_EPSERIE (
	ID_EP INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	DESC_EP VARCHAR(MAX) NOT NULL,
	SERIE INT NOT NULL,
	DURACAO INT NOT NULL,
);

CREATE TABLE TB_CATEGORIA (
	ID_CATEGORIA INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	TIPO_CATEGORIA VARCHAR(100) NOT NULL,
	DESC_CATEGORIA VARCHAR(MAX) NOT NULL
);

CREATE TABLE TB_PRODUTO (
	ID_PRODUTO INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	ID_SERIE INT NULL,
	ID_FILME INT NULL,
	NOME_PRODUTO VARCHAR(MAX) NOT NULL,
	DESC_PRODUTO VARCHAR(MAX) NULL,
	VALOR MONEY NOT NULL,
	ESTOQUE INT NOT NULL DEFAULT 1
);

CREATE TABLE TB_PROPAGANDA (
	ID_PROP INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	ID_PLANO INT NULL,
	DESC_PROP VARCHAR(MAX) NOT NULL,
	DURACAO_PROP INT NOT NULL,
);

-- NORMALIZA��O DE TABELAS E VIEW

-- Adicionado tabela Formato
CREATE TABLE TB_FORMATO (
	ID_FORMATO INT PRIMARY KEY NOT NULL,
	DESCRICAO VARCHAR(40) NOT NULL
);

-- Adicionado tabela Classifica��o Indicativa
CREATE TABLE TB_CLASS_INDICATIVA (
	ID_CLASS_INDICATIVA INT NOT NULL PRIMARY KEY,
	DESCRICAO VARCHAR(40) NOT NULL
);

-- Adicionado tabela tipo plano
CREATE TABLE TB_TIPO_PLANO (
	ID_MOD_PLANO INT NOT NULL PRIMARY KEY,
	DESCRICAO VARCHAR(40) NOT NULL
);

-- Criando tabela de vendas para inclus�o das vendas dos produtos por usuario
CREATE TABLE TB_VENDA (
	ID_VENDA INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	ID_PRODUTO INT NOT NULL,
	QUANTIDADE INT NOT NULL,
	ID_USUARIO INT NOT NULL,
	DATA_VENDA DATE NOT NULL
);

-- Criado 18/05/2023
CREATE TABLE TB_FOLHA_PAGAMENTO (
  ID_COLAB INT NOT NULL PRIMARY KEY,
  CUSTO_COLAB MONEY NOT NULL,
  SALARIO_LIQUIDO MONEY NOT NULL
);

/* ==== RELACIONAMENTO DAS TABELAS DO BANCO ==== */

-- Relacionando a tabela de usu�rios com a tabela de planos
ALTER TABLE TB_USUARIO
WITH CHECK ADD CONSTRAINT REL_01
FOREIGN KEY(ID_PLANO)
REFERENCES TB_PLANO (ID_PLANO);

-- Relacionado a tabela de colaboradores com a tabela de cargos.
ALTER TABLE TB_COLAB
WITH CHECK ADD CONSTRAINT REL_02
FOREIGN KEY(ID_CARGO)
REFERENCES TB_CARGO (ID_CARGO);

-- Adicionando chave estrangeira na tabela de filmes
ALTER TABLE TB_FILME
WITH CHECK ADD CONSTRAINT REL_03
FOREIGN KEY(RESPONSAVEL)
REFERENCES TB_COLAB (ID_COLAB);

-- Adicionando chave estrangeira na tabela de series
ALTER TABLE TB_SERIE
WITH CHECK ADD CONSTRAINT REL_04
FOREIGN KEY(RESPONSAVEL)
REFERENCES TB_COLAB (ID_COLAB);

-- Adicionando chave estrangeira na tabela de ep_series
ALTER TABLE TB_EPSERIE
WITH CHECK ADD CONSTRAINT REL_05
FOREIGN KEY(SERIE)
REFERENCES TB_SERIE (ID_SERIE);

-- Adicionando a rela��o entre a tabela Categoria e Filme
ALTER TABLE TB_FILME
WITH CHECK ADD CONSTRAINT REL_06
FOREIGN KEY(ID_CATEGORIA)
REFERENCES TB_CATEGORIA (ID_CATEGORIA);

-- Adicionando a rela��o entre a tabela Categoria e Serie
ALTER TABLE TB_SERIE
WITH CHECK ADD CONSTRAINT REL_07
FOREIGN KEY(ID_CATEGORIA)
REFERENCES TB_CATEGORIA (ID_CATEGORIA);

-- Adicionando chave estrangeira entre a tabela de Produto e a Tabela de Filme
ALTER TABLE TB_PRODUTO
WITH CHECK ADD CONSTRAINT REL_08
FOREIGN KEY(ID_FILME)
REFERENCES TB_FILME (ID_FILME);

-- Adicionando chave estrangeira entre a tabela de Produto e a Tabela de Serie
ALTER TABLE TB_PRODUTO
WITH CHECK ADD CONSTRAINT REL_09
FOREIGN KEY(ID_SERIE)
REFERENCES TB_SERIE (ID_SERIE);

-- Adicionando chave estrangeira entre a tabela de Propaganda e a Tabela de Plano
ALTER TABLE TB_PROPAGANDA
WITH CHECK ADD CONSTRAINT REL_10
FOREIGN KEY(ID_PLANO)
REFERENCES TB_PLANO (ID_PLANO);

-- Adicionado chave estrangeira na tabela filmes, que relaciona
-- com a tabela formato, com referencia o ID_FORMATO
ALTER TABLE TB_FILME
WITH CHECK ADD CONSTRAINT REL_11
FOREIGN KEY(ID_FORMATO)
REFERENCES TB_FORMATO (ID_FORMATO);

-- Adicionado chave estrangeira na tabela filmes, que relaciona
-- com a tabela classifica��o indicativa, com referencia o ID_CLASS_INDICATIVA
ALTER TABLE TB_FILME
WITH CHECK ADD CONSTRAINT REL_12
FOREIGN KEY(ID_CLASS_INDICATIVA)
REFERENCES TB_CLASS_INDICATIVA (ID_CLASS_INDICATIVA);

-- Adicionado chave estrangeira na tabela Plano, que relaciona
-- com a tabela MOD_PLANO, com referencia o ID_MOD_PLANO
ALTER TABLE TB_PLANO
WITH CHECK ADD CONSTRAINT REL_13
FOREIGN KEY(ID_MOD_PLANO)
REFERENCES TB_TIPO_PLANO (ID_MOD_PLANO);

-- Adicionado chave estrangeira na tabela SERIE, que relaciona
-- com a tabela formato, com referencia o ID_FORMATO
ALTER TABLE TB_SERIE
WITH CHECK ADD CONSTRAINT REL_14
FOREIGN KEY(ID_FORMATO)
REFERENCES TB_FORMATO (ID_FORMATO);

-- Adicionado chave estrangeira na tabela SERIE, que relaciona
-- com a tabela classifica��o indicativa, com referencia o ID_CLASS_INDICATIVA
ALTER TABLE TB_SERIE
WITH CHECK ADD CONSTRAINT REL_15
FOREIGN KEY(ID_CLASS_INDICATIVA)
REFERENCES TB_CLASS_INDICATIVA (ID_CLASS_INDICATIVA);


-- Relacionado a tabela de VENDAS com a tabela de PRODUTO.
ALTER TABLE TB_VENDA
WITH CHECK ADD CONSTRAINT REL_16
FOREIGN KEY(ID_PRODUTO)
REFERENCES TB_PRODUTO (ID_PRODUTO);

-- Relacionado a tabela de VENDAS com a tabela de USUARIOS.
ALTER TABLE TB_VENDA
WITH CHECK ADD CONSTRAINT REL_17
FOREIGN KEY(ID_USUARIO)
REFERENCES TB_USUARIO (ID_USUARIO);

ALTER TABLE TB_FOLHA_PAGAMENTO
WITH CHECK ADD CONSTRAINT REL_18
FOREIGN KEY(ID_COLAB)
REFERENCES TB_COLAB (ID_COLAB);