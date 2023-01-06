CREATE DATABASE COMUNIFLIX;

CREATE TABLE TB_USUARIO (
	ID_USUARIO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NOME VARCHAR(MAX) NOT NULL,
	CPF INT NOT NULL,
	ID_PLANO INT NOT NULL,
	DATA_NASCIMENTO DATE NULL,
	EMAIL VARCHAR(MAX) NOT NULL,
	SENHA VARCHAR(15) NOT NULL
);

CREATE TABLE TB_COLAB (
	ID_COLAB INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	CPF INT NOT NULL,
	DATA_NASCIMENTO DATE NULL,
	EMAIL VARCHAR(MAX) NOT NULL,
	SENHA VARCHAR(15) NOT NULL,
	ID_CARGO INT NOT NULL,
	FERIAS BIT NOT NULL DEFAULT 1,
	DATA_ADMISSAO DATE NULL
);

ALTER TABLE TB_COLAB ADD NOME VARCHAR(150) NOT NULL;

CREATE TABLE TB_CARGO (
	ID_CARGO INT NOT NULL IDENTITY(1,1),
	DESC_CARGO VARCHAR(100) NOT NULL,
	SALARIO FLOAT NOT NULL
);

CREATE TABLE TB_PLANO (
	ID_PLANO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	DESC_PLANO VARCHAR(50) NOT NULL,
	VALOR_PLANO FLOAT NOT NULL,
	MOD_PLANO VARCHAR(30) NOT NULL
);

-- Adicionando primary key na tabela Cargos, campo "ID_CARGO"
ALTER TABLE TB_CARGO ADD PRIMARY KEY (ID_CARGO);

-- Relacionando a tabela de usuários com a tabela de planos
ALTER TABLE TB_USUARIO
WITH CHECK ADD CONSTRAINT REL_01
FOREIGN KEY(ID_PLANO)
REFERENCES TB_PLANO (ID_PLANO);

-- Relacionado a tabela de colaboradores com a tabela de cargos.
ALTER TABLE TB_COLAB
WITH CHECK ADD CONSTRAINT REL_02
FOREIGN KEY(ID_CARGO)
REFERENCES TB_CARGO (ID_CARGO);

-- Adicionando tabela de filmes
CREATE TABLE TB_FILME (
	ID_FILME INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	DESC_FILME VARCHAR(MAX) NOT NULL,
	DURACAO INT NOT NULL,
	FORMATO VARCHAR(10) NULL,
	CLASS_INDICATIVA VARCHAR(5) NULL,
	RESPONSAVEL INT NOT NULL
);

-- Adicionando coluna nome do filme na tabela de filmes
ALTER TABLE TB_FILME ADD NOME_FILME VARCHAR(150) NOT NULL;

CREATE TABLE TB_SERIE (
	ID_SERIE INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NOME_SERIE VARCHAR(200) NOT NULL,
	DESC_SERIE VARCHAR(MAX) NOT NULL,
	TEMPORADA INT NOT NULL DEFAULT 1,
	FORMATO VARCHAR(10) NULL,
	CLASS_INDICATIVA VARCHAR(5) NULL,
	RESPONSAVEL INT NOT NULL
);

CREATE TABLE TB_EPSERIE (
	ID_EP INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	DESC_EP VARCHAR(MAX) NOT NULL,
	SERIE INT NOT NULL,
	DURACAO INT NOT NULL,
);

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

-- Criando a tabela de categorias
CREATE TABLE TB_CATEGORIA (
	ID_CATEGORIA INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	TIPO_CATEGORIA VARCHAR(100) NOT NULL,
	DESC_CATEGORIA VARCHAR(MAX) NOT NULL
);

-- Adicionando coluna categoria nas tabelas Filmes e Series
ALTER TABLE TB_FILME ADD ID_CATEGORIA INT NOT NULL;
ALTER TABLE TB_SERIE ADD ID_CATEGORIA INT NOT NULL;

-- Adicionando a relação entre a tabela Categoria e Filme
ALTER TABLE TB_FILME
WITH CHECK ADD CONSTRAINT REL_06
FOREIGN KEY(ID_CATEGORIA)
REFERENCES TB_CATEGORIA (ID_CATEGORIA);

-- Adicionando a relação entre a tabela Categoria e Serie
ALTER TABLE TB_SERIE
WITH CHECK ADD CONSTRAINT REL_07
FOREIGN KEY(ID_CATEGORIA)
REFERENCES TB_CATEGORIA (ID_CATEGORIA);

CREATE TABLE TB_PRODUTO (
	ID_PRODUTO INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	ID_SERIE INT NULL,
	ID_FILME INT NULL,
	NOME_PRODUTO VARCHAR(MAX) NOT NULL,
	DESC_PRODUTO VARCHAR(MAX) NULL,
	VALOR FLOAT NOT NULL,
);

CREATE TABLE TB_PROPAGANDA (
	ID_PROP INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	ID_PLANO INT NULL,
	DESC_PROP VARCHAR(MAX) NOT NULL,
	DURACAO_PROP INT NOT NULL,
);

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

-- Inserindo os dados na tabela de Cargos
INSERT INTO TB_CARGO VALUES 
	('Diretor',14.105),
	('Cinegrafista',5.000),
	('Produtor',7.000),
	('Co-Diretor',12.105),
	('Ator',4.000),
	('Atriz',5.000),
	('Vendedor',1.800),
	('Analista de Marketing',3.580),
	('Faxineiro', 1.250),
	('Editor',3.580),
	('Roteirista', 5.453),
	('Diretor de Elenco', 9.173);

-- Inserindo os dados na tabela de categorias
INSERT INTO TB_CATEGORIA VALUES
	('Terror','gênero cinematográfico que procura uma reação emocional negativa dos espectadores, ao jogar com os medos primários da audiência.'),
	('Comédia','comédia é o uso de humor nas artes cênicas.'),
	('Ação','O gênero tem a simples função de entreter o público, não pretende tratar de temas complexos ou polêmicos.'),
	('Suspense','O suspense prende a atenção porque tudo o que acontece posteriormente na trama está diretamente relacionado com o que se apresenta anteriormente'),
	('Romance','Romance é um gênero textual que consiste em uma narrativa longa, escrita em prosa.'),
	('Syfy','Ficção científica é um gênero da ficção especulativa, que normalmente lida com conceitos ficcionais e imaginativos, relacionados ao futuro, ciência e tecnologia,');

-- Inserindo os dados na tabela de planos
INSERT INTO TB_PLANO VALUES
	('Basic', 12.90, 'Mensal'),
	('Basic+',120.00, 'Anual'),
	('Standard',24.90, 'Mensal'),
	('Standard+',230.00,'Anual'),
	('Premium',35.50,'Mensal'),
	('Premium+',340.00,'Anual');

-- Inserindo os dados na tabela de propagandas
INSERT INTO TB_PROPAGANDA (ID_PLANO, DESC_PROP, DURACAO_PROP) VALUES
	(1,'Colgate Sensodine',180),
	(2,'Vendas Hinode',150),
	(3,'Desodorante Old Spice', 120),
	(1,'Vacina Durateston', 200),
	(2,'Livraria BemTeVi', 90);

INSERT INTO TB_PROPAGANDA (DESC_PROP, DURACAO_PROP) VALUES 	
	('TUDUM COMUNIFLIX', 5);

/* ALTERANDO A COLUNA CPF DAS TABELAS COLAB E USUARIO
PARA INCLUIR O CPF NORMALMENTE E NÃO DAR CONFLITO */
ALTER TABLE TB_COLAB ALTER COLUMN CPF BIGINT;
ALTER TABLE TB_USUARIO ALTER COLUMN CPF BIGINT;

-- Inserindo os dados na tabela de usuários
INSERT INTO TB_USUARIO VALUES
	('Emilly Letícia Lopes',47713815937,1,'1977-05-05','emilly_lopes@aiesec.net','x3oPFldtSW');

INSERT INTO TB_USUARIO VALUES
	('Milena Joana Milena Castro',40670973289,2,'1947-05-08','milena_castro@unitau.com.br','bB64Z6Q0gG'),
	('Sebastião Gustavo da Cruz',01415285756,3,'1943-01-23','sebastiao.gustavo.dacruz@gmx.de','QLPe5OZZpz'),
	('Sônia Betina Alessandra Gomes',61827064145,4,'1990-04-24','soniabetinagomes@termakui.com.br','ERu63dIREc'),
	('Lucas Yuri Kevin da Rocha',24422864831,5,'1993-07-15','lucas-darocha83@iclaud.com','Heba1dYUWB'),
	('Enzo Yago de Paula',18966693520,6,'1991-06-21','enzo-depaula71@oas.com','I62JLEMK1m');

INSERT INTO TB_USUARIO VALUES
	('Juca Ribeiro da Silva',40870953280,3,'1940-11-08','juca_rib@gerdau.com.br','bB64Z6Q0gG'),
	('Luiz Inácio Lula da Silva',01423285778,3,'1950-01-23','lulinha.inacio@pt.com.br','QLPe5OZZpz'),
	('Jair Messias Bolsonaro',61822064057,5,'1950-01-24','messias.jair@pl.com.br','ERu63dIREc'),
	('Padre Kelson Kelmon Kelvin',01422864681,2,'1968-09-15','candidato.padre@ptb.com','Heba1dYUWB'),
	('Simone Tebet',01866793520,2,'1982-10-21','simone.teb@mdb.com','I62JLEMK1m');


/* ALTERANDO A COLUNA SALARIO DA TABELA DE CARGOS
PARA INCLUIR O SALARIO NORMALMENTE NO FORMATO CORRETO */
ALTER TABLE TB_CARGO ALTER COLUMN SALARIO MONEY;

-- Atualizando valores da tabela para se adequar ao formato MONEY
UPDATE TB_CARGO SET SALARIO = 14105 WHERE ID_CARGO=1;
UPDATE TB_CARGO SET SALARIO = 5050 WHERE ID_CARGO=2;
UPDATE TB_CARGO SET SALARIO = 7102 WHERE ID_CARGO=3;
UPDATE TB_CARGO SET SALARIO = 12105 WHERE ID_CARGO=4;
UPDATE TB_CARGO SET SALARIO = 4356 WHERE ID_CARGO=5;
UPDATE TB_CARGO SET SALARIO = 5125 WHERE ID_CARGO=6;
UPDATE TB_CARGO SET SALARIO = 1805 WHERE ID_CARGO=7;
UPDATE TB_CARGO SET SALARIO = 3580 WHERE ID_CARGO=8;
UPDATE TB_CARGO SET SALARIO = 1250 WHERE ID_CARGO=9;
UPDATE TB_CARGO SET SALARIO = 3580 WHERE ID_CARGO=10;
UPDATE TB_CARGO SET SALARIO = 5453 WHERE ID_CARGO=11;
UPDATE TB_CARGO SET SALARIO = 9173 WHERE ID_CARGO=23;

-- Inserindo os dados na tabela de colaboradores
INSERT INTO TB_COLAB VALUES
    (99785463210, '1983-02-02','wen9014@uorak.com','Joaofoiaguerra',1,0, '2022-01-10','Wedel Marties Santos'),
    (65734303011, '1992-04-05','raimundo_aragao@jotace.eti.br','EAiGfz1X2K',2,0, '2021-05-21','Raimundo Donato'),
    (43824447487, '1980-07-21','vinicius_ribeiro@p4ed.com','FlJ7xhbpOn',3,0, '2021-06-21','Vinicios de Morais Oliveira'),
    (85326962870, '1992-06-06','debora.amanda.dapaz@comprehense.com.br','Pmiina5mNR',4,0, '2021-06-21','Debora Amanda da Paz'),
    (49737386388, '2004-06-20','marlene-santos93@vivo.com.br','Oc8YEp17xT',5,0, '2021-05-21','Marlene dos santos'),
    (18336009590, '1988-05-23', 'pedro_porto@royalplas.com.br','bxKtoMXmL8', 6,0, '2022-06-13','Pedro Henrique Carlos Eduardo Porto'),
    (17728581708, '1982-02-15', 'oliver_luiz_fogaca@liv.com','XktDEyNUQ8', 7,1, '2020-05-02','Oliver Luiz Fogaça'),
    (98130025140, '1978-04-21', 'juliorafaelramos@boiago.com.br','Q4FE1ajOfK',8,1,'2020-04-03','Julio Rafael Henry Ramos'),
    (65425785100, '1969-04-16', 'debora.kamilly.freitas@ibest.com.br','e06CFGBlHf',9,0,    '2021-08-10','Débora Kamilly Joana Freitas'),
    (93056347106, '2000-10-21', 'heitor.kaue.sales@cressem.com.br', 'n4AkL8DshZ',10,0, '2021-08-11','Heitor Kauê Thomas Sales'),
	(70922070024, '1992-01-20','beatriz-darosa83@uol.om.br', '1L7tEnT86d',1,0,'2022-05-13','Beatriz Manuela da Rosa'),
    (27210569723, '1992-02-02','sebastiana_rosa_depaula@acaoi.com.br', 'L6b9Bzrut4',1,0,'2021-08-22','Sebastiana Rosa de Paula'),
    (13087733741, '1992-11-02','isabela_moura@quimicaindaiatuba.com.br', 'boG1DJb50A',4,0,'2022-06-15','Isabela Tatiane Josefa Moura'),
    (13636760408, '1992-01-08','marcelanicolerezende@rauh.net','c7XDlTE0KQ',4,1,'2020-03-04','Marcela Nicole Bruna Rezende');

-- Inserindo os dados na tabela de filmes
INSERT INTO TB_FILME (NOME_FILME, DESC_FILME, DURACAO, FORMATO, CLASS_INDICATIVA, RESPONSAVEL, ID_CATEGORIA) VALUES
	('Velozes e furiosos 5: Operacao Rio', 
	'Dominic Toretto foi resgatado da prisão por sua irmã Mia e Brian O Conner, que realizam um ousado resgate sobre rodas. Logo em seguida, ele desaparece. Brian e Mia vão até o Rio de Janeiro, onde encontram Vince', 130, 'MP4','14+', 12, 3),
	('Invocacao do Mal',
	'Um casal muda para uma casa nova ao lado de suas cinco filhas. Inexplicavelmente, estranhos acontecimentos começam a assustar as crianças, o pai e, principalmente, a mãe. Preocupada com algumas manchas que aparecem em seu corpo e com uma sequência de sustos que levou, ela decide procurar um famoso casal de investigadores paranormais',110, 'AVI', '14+', 1, 1),
	('O senhor das armas',
	'Yuri Orlov é um traficante de armas que realiza negócios nos mais variados locais do planeta. Estando constantemente em perigosas zonas de guerra',122, 'MP4', 'L', 4, 3),
	('V de vinganca',
	'Em uma Inglaterra do futuro, onde está em vigor um regime totalitário, vive Evey Hammond. Ela é salva de uma situação de vida ou morte por um homem mascarado, conhecido apenas pelo codinome V, que é extremamente carismático e habilidoso na arte do combate e da destruição',130, 'AVI', 'L', 13, 6),
	('Harry Potter e a pedra filosofal',
	'Harry Potter é um garoto órfão de 10 anos que vive infeliz com seus tios, os Dursley. Até que, repentinamente, ele recebe uma carta contendo um convite para ingressar em Hogwarts, uma famosa escola especializada em formar jovens bruxos.',152, 'MP4', 'L', 14, 3);

-- Inserindo os dados na tabela de séries
INSERT INTO TB_SERIE VALUES
    ('A Garota da memória seletiva', 'história de uma garota que tem uma memória seletiva e sofre na faculdade com isso gerando várias confusão',2,
    'AVI','L',12,2),
    ('O Mão de VACA','A história de um homen que não gastava dinheiro por nada até que sua mão se tornou a pata de um vaca',1,
    'AVI','18+',1,1),
    ('Castanha no Incrivel Mundo da lua', 'Uma castanha se desprende da arvore e vai parar no surprender mundo da lua',1,
    'MP4','14+',13,6),
    ('OUTFIT de meio milhão de dollars', 'Um jovem encontra um outfit capaz de realizar açoes incriveis e usa para combater o crime',2,
    'MP4','16+',14,3);

/* ALTERANDO A COLUNA VALOR DA TABELA DE PRODUTO
PARA INCLUIR OS VALORES NORMALMENTE NO FORMATO CORRETO */
ALTER TABLE TB_PRODUTO ALTER COLUMN VALOR MONEY;

-- Inserindo os dados na tabela de produtos
INSERT INTO TB_PRODUTO (NOME_PRODUTO, DESC_PRODUTO,VALOR) VALUES
	('Camiseta Comuniflix','Camisetas P ao GG para assinantes do Comuniflix', 35.90),
	('Caneca Comuniflix','Caneca personalizada 200ml para assinantes Comuniflix', 50.99);

INSERT INTO TB_PRODUTO (ID_SERIE, NOME_PRODUTO, DESC_PRODUTO, VALOR) VALUES
	(9, 'Chapeu Ritalina','Chapeu para amantes da série "A garota da memória seletiva"', 69.50),
	(10, 'Livro como enriquecer sem gastar um tustao','Livro com 250 páginas de como enriquecer sem tirar um real do bolso', 25.20),
	(11, 'Snack Pringles','Snacks de batatas com todos os sabores da marca Pringles', 20.99),
	(12, 'Relógio Calvis Kelson','Relógio rolex oliginal da calves kelson', 149.90);

INSERT INTO TB_PRODUTO (ID_FILME, NOME_PRODUTO, DESC_PRODUTO, VALOR) VALUES
	(1, 'Action Figure Toretto','Action figure do Dominic Toretto falando "It is Brazil"', 322),
	(2, 'Adesivo Pentagrama','Adesivo contendo pentagrama referente ao filme Invocacao do mal', 13),
	(3, 'Airsoft Ak-47','Ak-47 airsoft com disponibilidade para 1000 bolinhas, com modo simultaneo e rajada', 599.90),
	(4, 'Mascará V de vingança','Mascara oliginal que foi usada no filme V de vingança', 1130.45),
	(5, 'Varinha das varinhas','Varinha feita com madeira de sabugueiro, possuindo comprimento de 38,1 cm de comprimento e um núcleo de pelo da cauda de testrálio', 109.50);

-- Inserindo os dados na tabela filha "EP Serie"
-- Inserindo episodios da série "A garota da memória seletiva"
INSERT INTO TB_EPSERIE VALUES
    ('O Inicio do esquecimento', 9, 60),
    ('Esqueci de esquecer e acabei lembrando', 9, 55),
    ('Pensei que namorava mas so eu sabia', 9, 50),
    ('O grande dia P/1', 9, 58),
    ('O grande dia P/2', 9, 60),
    ('O grande esquecimento da minha vida', 9, 65);

-- Inserindo episodios da série "O Mao de Vaca"
INSERT INTO TB_EPSERIE VALUES
    ('A maldição', 10, 66),
    ('O encontro Inesperado', 10, 50),
    ('A Grande morte', 10, 60);

-- Inserindo episodios da série "Castanha no Incrivel Mundo da Lua"
INSERT INTO TB_EPSERIE VALUES
    ('A queda',11 ,53),
    ('A viagem',11, 52),
    ('Descoberta',11, 50);

-- Inserindo episodios da série "OUTFIT de meio milhao de dollars"
INSERT INTO TB_EPSERIE VALUES
    ('A grande compra',12, 55),
    ('A virada',12, 53),
    ('Batalha pela vida',12,63),
    ('Estou vivo',12, 61),
    ('Luta inesquecivel',12, 62),
    ('O fim',12, 65);


/* Consulta de todos os colaboradores que tem cargos de "Diretor" e "Co-Diretor".
Usado INNER JOIN para buscar quais são os colaboradores e seus respectivos cargos. */
SELECT C.ID_COLAB, C.NOME, C.ID_CARGO, E.DESC_CARGO FROM TB_COLAB C
    INNER JOIN TB_CARGO E
    ON C.ID_CARGO = E.ID_CARGO
	WHERE C.ID_CARGO = 1 OR C.ID_CARGO = 4
	ORDER BY ID_CARGO ASC;

/* Consulta de qual a quantidade de filmes que existem por categoria
Usado COUNT para quantificar a quantidade de categorias,
Usado INNER JOIN para realizar a ligação entre a tabela FILMES e CATEGORIA,
Usado GROUP BY para realizar o agrupamento por tipo de categoria */
SELECT COUNT(F.ID_CATEGORIA) AS QTD_CATEGORIA, C.TIPO_CATEGORIA FROM TB_FILME F
	INNER JOIN TB_CATEGORIA C
	ON F.ID_CATEGORIA = C.ID_CATEGORIA
	GROUP BY (C.TIPO_CATEGORIA);

/* Consulta para buscar qual o custo com pessoas que a COMUNIFLIX tem.
Usado INNER JOIN relacionando a tabela de COLAB com a tabela de CARGOS para buscar o salário dos colabs
Usado SUM para realizar a soma de todos os salários relacionados aos cargos dos colaboradores */
SELECT SUM(G.SALARIO) AS CUSTO_PESSOAS FROM TB_COLAB C
	INNER JOIN TB_CARGO G
	ON C.ID_CARGO = G.ID_CARGO;

/* Consulta para buscar qual o ID e o NOME do produto que contém o maior preço
Usado MAX para identificar qual o maior valor de produtos
Usado SUB-QUERY para identificar qual o ID e o NOME desse produto */
SELECT P.ID_PRODUTO, P.NOME_PRODUTO, X.MAIOR_PRECO 
	FROM (SELECT MAX(VALOR) AS MAIOR_PRECO FROM TB_PRODUTO) X, TB_PRODUTO P
	WHERE X.MAIOR_PRECO = P.VALOR;

SELECT TOP 1 ID_PRODUTO, NOME_PRODUTO, MAX(VALOR) AS MAIOR_PRECO 
	FROM TB_PRODUTO 
	GROUP BY ID_PRODUTO, NOME_PRODUTO 
	ORDER BY MAIOR_PRECO DESC;


/* Consulta buscando quais são os planos com mais de 3 usuários utilizando.
Usado INNER JOIN para buscar a descrição dos planos relacionados aos usuários
Usado COUNT para buscar a quantidade de planos que são utilizados pelos usuários
Usado GROUP BY para agrupar a quantidade por Plano.
Usado HAVING para filtrar a quantidade de planos maior ou igual a 3. */
SELECT COUNT(U.ID_PLANO) AS QTD_PLANOS, P.DESC_PLANO FROM TB_USUARIO U
	INNER JOIN TB_PLANO P
	ON U.ID_PLANO = P.ID_PLANO
	GROUP BY P.DESC_PLANO
	HAVING COUNT(U.ID_PLANO) >= 3;

/* Consulta buscando quais são os usuários que tem o plano igual a 2, somente caso
seja encontrado alguma propaganda relacionada ao ID_PLANO = 2.
Usado EXISTS para identificar se existe propagandas com ID_PLANO = 2. */
SELECT * FROM TB_USUARIO 
	WHERE ID_PLANO = 2
	AND EXISTS (SELECT ID_PLANO FROM TB_PROPAGANDA WHERE ID_PLANO = 2);

/* Consulta buscando quais são os usuários que tem o plano igual a 5, somente caso não exista
nenhuma propaganda com ID_PLANO = 5 */
SELECT * FROM TB_USUARIO
	WHERE ID_PLANO = 5
	AND NOT EXISTS (SELECT * FROM TB_PROPAGANDA WHERE ID_PLANO = 5);


/* Consulta da série que tenha o ID = 10 somente caso, exista episódios na tabela de episodios
com o ID = 10 
Usado IN para realizar a busca na tabela EPSERIE */
SELECT * FROM TB_SERIE
	WHERE ID_SERIE IN (SELECT ID_SERIE FROM TB_EPSERIE WHERE ID_SERIE = 10);

/* Consulta de todos os filmes que não sejam de TERROR (ID 1) ou SYFY (ID 6).
Usado NOT IN para realizar a busca */
SELECT * FROM TB_FILME
	WHERE ID_CATEGORIA NOT IN (1,6);

/* Consulta de todos os colaboradores que foram admitidos entre Janeiro e Junho.
Usado função MONTH para buscar o mês da coluna no formato de data
Usado o BETWEEN para fazer a busca entre os meses selecionados
Usado ORDER BY para ordenar as datas por mês e por ano */
SELECT NOME, CPF, FORMAT(DATA_ADMISSAO, '%M/%y') AS DATA_ADMISSAO FROM TB_COLAB
	WHERE MONTH(DATA_ADMISSAO) BETWEEN 01 AND 06
	ORDER BY MONTH(DATA_ADMISSAO), YEAR(DATA_ADMISSAO);

/* Consulta de todos os planos que contenham valor médio abaixo de 100 reais.
Usado INNER JOIN entre a tabela de Usuários e Plano para buscar a quantidade de usuários, a descrição e o valor do plano de cada usuário.
Usado função AVG para calcular a média.
Usado GROUP BY para agrupar o resultado da média.
Usado HAVING para filtrar somente valores médios abaixo de 100 reais. */
SELECT U.ID_PLANO, P.DESC_PLANO, AVG(P.VALOR_PLANO) AS VALOR_MEDIO FROM TB_USUARIO U 
	INNER JOIN TB_PLANO P
	ON U.ID_PLANO = P.ID_PLANO
	GROUP BY U.ID_PLANO, P.DESC_PLANO
	HAVING AVG(P.VALOR_PLANO) < 100;


-- TERCEIRO MOMENTO -- NORMALIZAÇÃO DE TABELAS E VIEW

-- Adicionado tabela Formato
CREATE TABLE TB_FORMATO (
	ID_FORMATO INT PRIMARY KEY NOT NULL,
	DESCRICAO VARCHAR(40) NOT NULL
);

-- Adicionado tabela Classificação Indicativa
CREATE TABLE TB_CLASS_INDICATIVA (
	ID_CLASS_INDICATIVA INT NOT NULL PRIMARY KEY,
	DESCRICAO VARCHAR(40) NOT NULL
);

-- Adicionado tabela tipo plano
CREATE TABLE TB_TIPO_PLANO (
	ID_MOD_PLANO INT NOT NULL PRIMARY KEY,
	DESCRICAO VARCHAR(40) NOT NULL
);

-- Adicionado campos nas respectivas tabela para relacionar
ALTER TABLE TB_FILME ADD ID_FORMATO INT NULL;
ALTER TABLE TB_FILME ADD ID_CLASS_INDICATIVA INT NULL;
ALTER TABLE TB_PLANO ADD ID_MOD_PLANO INT NULL;

-- Adicionado chave estrangeira na tabela filmes, que relaciona
-- com a tabela formato, com referencia o ID_FORMATO
ALTER TABLE TB_FILME
WITH CHECK ADD CONSTRAINT REL_11
FOREIGN KEY(ID_FORMATO)
REFERENCES TB_FORMATO (ID_FORMATO);

-- Adicionado chave estrangeira na tabela filmes, que relaciona
-- com a tabela classificação indicativa, com referencia o ID_CLASS_INDICATIVA
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

-- ATUALIZANDO OS REGISTROS CONFORME REDUNDANCIA
UPDATE TB_FILME SET ID_FORMATO = 1 WHERE FORMATO = 'MP4';
UPDATE TB_FILME SET ID_CLASS_INDICATIVA = 2 WHERE FORMATO = 'AVI';

-- REMOVENDO COLUNAS FORMATO E CLASS_INDICATIVA DA TABELA FILME
ALTER TABLE TB_FILME DROP COLUMN FORMATO;
ALTER TABLE TB_FILME DROP COLUMN CLASS_INDICATIVA;

-- Adicionado campos nas respectivas tabela para relacionar
ALTER TABLE TB_SERIE ADD ID_FORMATO INT NULL;
ALTER TABLE TB_SERIE ADD ID_CLASS_INDICATIVA INT NULL;

-- Adicionado chave estrangeira na tabela SERIE, que relaciona
-- com a tabela formato, com referencia o ID_FORMATO
ALTER TABLE TB_SERIE
WITH CHECK ADD CONSTRAINT REL_14
FOREIGN KEY(ID_FORMATO)
REFERENCES TB_FORMATO (ID_FORMATO);

-- Adicionado chave estrangeira na tabela SERIE, que relaciona
-- com a tabela classificação indicativa, com referencia o ID_CLASS_INDICATIVA
ALTER TABLE TB_SERIE
WITH CHECK ADD CONSTRAINT REL_15
FOREIGN KEY(ID_CLASS_INDICATIVA)
REFERENCES TB_CLASS_INDICATIVA (ID_CLASS_INDICATIVA);

-- Inserindo as classificações 18+ e 16+
INSERT INTO TB_CLASS_INDICATIVA VALUES (3,'18+'), (4,'16+');

-- Atualizando os registros da tabela Formato e Class indicativa para remover as colunas redundantes
UPDATE TB_SERIE SET ID_FORMATO = 1 WHERE FORMATO = 'MP4';
UPDATE TB_SERIE SET ID_FORMATO = 2 WHERE FORMATO = 'AVI';
UPDATE TB_SERIE SET ID_CLASS_INDICATIVA = 1 WHERE CLASS_INDICATIVA = '14+';
UPDATE TB_SERIE SET ID_CLASS_INDICATIVA = 2 WHERE CLASS_INDICATIVA = 'L';
UPDATE TB_SERIE SET ID_CLASS_INDICATIVA = 3 WHERE CLASS_INDICATIVA = '18+';
UPDATE TB_SERIE SET ID_CLASS_INDICATIVA = 4 WHERE CLASS_INDICATIVA = '16+';

-- Removendo colunas redundantes
ALTER TABLE TB_SERIE DROP COLUMN FORMATO;
ALTER TABLE TB_SERIE DROP COLUMN CLASS_INDICATIVA;
ALTER TABLE TB_PLANO DROP COLUMN MOD_PLANO;

-- CRIAÇÃO DA VIEW
CREATE VIEW TOP_PLANO AS
	SELECT TOP 3 COUNT(U.ID_PLANO) AS QTD_PLANOS, P.DESC_PLANO FROM TB_USUARIO U
		INNER JOIN TB_PLANO P
		ON U.ID_PLANO = P.ID_PLANO
		GROUP BY P.DESC_PLANO
		ORDER BY QTD_PLANOS DESC;

SELECT * FROM TOP_PLANO;


-- Criando indice não clusterizado
CREATE NONCLUSTERED INDEX Indice_Nao_Clusterizado ON 
TB_COLAB(CPF) 
INCLUDE(NOME, EMAIL)

SELECT * FROM TB_COLAB
	WHERE CPF LIKE '%0';

SELECT * FROM TB_SERIE;



