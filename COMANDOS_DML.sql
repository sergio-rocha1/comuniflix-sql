-- GERADOR DE REGISTROS NA TB_COLAB --

DECLARE @contador INT = 1;
WHILE @contador <= 50
BEGIN
    DECLARE @nome VARCHAR(50);
    DECLARE @sobrenome VARCHAR(50);
    DECLARE @cpf BIGINT;
    DECLARE @id_cargo INT;
    DECLARE @data_admissao DATE;
	DECLARE @data_nascimento DATE;
    DECLARE @email VARCHAR(100);
    DECLARE @senha VARCHAR(10);
	DECLARE @dominio VARCHAR (100);
	DECLARE @ferias INT;

    -- AQUI GERA O NOME DO CLIENTE --
    SET @nome = (
        SELECT TOP 1 Nome
        FROM (
            VALUES
                ('Augusto'),
                ('Maria'),
                ('Pedro'),
                ('Ana'),
                ('Carlos'),
                ('Laura'),
                ('Lucas'),
                ('Mariana'),
                ('Rafael'),
                ('Vitória'),
                ('Sergio'),
                ('Fernanda'),
                ('Gustavo'),
                ('Camila'),
                ('Rodrigo'),
                ('Amanda'),
                ('Luisa'),
                ('Eduardo'),
                ('Juliana'),
                ('Ricardo')
        ) AS Nomes(Nome)
        WHERE Nome NOT IN (SELECT NOME FROM TB_USUARIO) -- Evita nomes duplicados
		AND Nome IS NOT NULL
        ORDER BY NEWID()
    );

	-- AQUI GERA O SOBRENOME DO CLIENTE --
    SET @sobrenome = (
        SELECT TOP 1 Sobrenome
        FROM (
            VALUES
                ('Silva'),
                ('Santos'),
                ('Almeida'),
                ('Costa'),
                ('Pereira'),
                ('Oliveira'),
                ('Rodrigues'),
                ('Gomes'),
                ('Souza'),
                ('Ferreira'),
                ('Lima'),
                ('Rocha'),
                ('Carvalho'),
                ('Cardoso'),
                ('Mendes'),
                ('Castro'),
                ('Nunes'),
                ('Cunha'),
                ('Santos'),
                ('Borges')
        ) AS Sobrenomes(Sobrenome)
        ORDER BY NEWID()
    );

	select * from TB_COLAB

   -- Cria os registros com uma ordem randômica e seta eles na variável --
    SET @cpf = CAST(10000000000 + RAND() * 90000000000 AS BIGINT);
    SET @id_cargo = CAST(RAND() * 9 + 2 AS INT); -- Gera o cargo, entre 2 e 11;
    SET @data_nascimento = CAST(DATEADD(DAY, -CAST(RAND() * DATEDIFF(DAY, '1930-01-01', GETDATE()) AS INT), GETDATE()) AS DATE);
    SET @data_admissao = CAST(DATEADD(DAY, -RAND() * DATEDIFF(DAY, '2013-01-01', GETDATE()), GETDATE()) AS DATE); -- Gera a data de admissão desde 2013 até a data atual
    SET @nome = @nome + ' ' + @sobrenome;  -- Concatena nome e sobrenome
    SET @senha = UPPER(SUBSTRING(REPLACE(CONVERT(VARCHAR(50), NEWID()), '-', ''), 1, 10)); -- Converte NEWID em String, para arrumar a formatação.
    SET @senha = LEFT(@senha, 10);  -- Redundância para garantir apenas 10 caracteres na senha.
	SET @ferias = CAST(RAND() * 2 AS INT); -- Gera um valor para informar se já tirou férias ou não


    -- Gera o email entre Gmail, Yahoo ou Hotmail --
	SET @dominio = (
	SELECT TOP 1 Email
	FROM (VALUES 
	('gmail.com'),
	('yahoo.com'),
	('hotmail.com')
	) AS Emails(email)
	WHERE Email NOT IN (SELECT email FROM TB_USUARIO)
	AND email IS NOT NULL
	ORDER BY NEWID()
	);
    SET @email =
        LOWER(
            REPLACE(@nome, ' ', '') + CAST(@contador AS VARCHAR) + '@' + @dominio );
    
    
    -- Inserir registro na tabela TB_USUARIO
    INSERT INTO TB_COLAB(NOME, CPF, DATA_NASCIMENTO, ID_CARGO, FERIAS, DATA_ADMISSAO, EMAIL, SENHA)
    VALUES (@nome, @cpf, @data_nascimento, @id_cargo, @ferias, @data_admissao, @email, @senha);
	SET @contador = @contador + 1;
END;	

-- GERADOR DE REGISTROS NA TB_USUARIO --
DECLARE @contador INT = 1;
WHILE @contador <= 50
BEGIN
    DECLARE @nome VARCHAR(50);
    DECLARE @sobrenome VARCHAR(50);
    DECLARE @cpf BIGINT;
    DECLARE @id_plano INT;
    DECLARE @data_nascimento DATE;
    DECLARE @email VARCHAR(100);
    DECLARE @senha VARCHAR(10);
	DECLARE @dominio VARCHAR (100);
    
    -- AQUI GERA O NOME DO CLIENTE --
    SET @nome = (
        SELECT TOP 1 Nome
        FROM (
            VALUES
                ('João'),
                ('Maria'),
                ('Pedro'),
                ('Ana'),
                ('Carlos'),
                ('Laura'),
                ('Lucas'),
                ('Mariana'),
                ('Rafael'),
                ('Vitória'),
                ('José'),
                ('Fernanda'),
                ('Gustavo'),
                ('Camila'),
                ('Rodrigo'),
                ('Amanda'),
                ('Luisa'),
                ('Diego'),
                ('Juliana'),
                ('Ricardo')
        ) AS Nomes(Nome)
        WHERE Nome NOT IN (SELECT NOME FROM TB_USUARIO) -- Evita nomes duplicados NESSA execução 
		AND Nome IS NOT NULL
        ORDER BY NEWID() -- Embaralha o nome do 
    );

	-- AQUI GERA O SOBRENOME DO CLIENTE --
    SET @sobrenome = (
        SELECT TOP 1 Sobrenome
        FROM (
            VALUES
                ('Silva'),
                ('Santos'),
                ('Almeida'),
                ('Costa'),
                ('Pereira'),
                ('Oliveira'),
                ('Rodrigues'),
                ('Gomes'),
                ('Souza'),
                ('Ferreira'),
                ('Lima'),
                ('Rocha'),
                ('Carvalho'),
                ('Cardoso'),
                ('Mendes'),
                ('Castro'),
                ('Nunes'),
                ('Cunha'),
                ('Santos'),
                ('Costa')
        ) AS Sobrenomes(Sobrenome)
        ORDER BY NEWID()
    );

	-- Cria os registros com uma ordem randômica e seta eles na variável --
    SET @cpf = CAST(10000000000 + RAND() * 90000000000 AS BIGINT);   -- Gera um CPF, e altera de decimal RAND() para BIGINT através do valor 90000.....
    SET @id_plano = CAST(RAND() * 6 + 1 AS INT);  -- Gera um ID aleatório da TB_PLANO de um plano entre 1 e 6
    SET @data_nascimento = CAST(DATEADD(DAY, -CAST(RAND() * DATEDIFF(DAY, '1930-01-01', GETDATE()) AS INT), GETDATE()) AS DATE);  -- Gera uma data de nascimento, desde 1930.
	SET @nome = @nome + ' ' + @sobrenome;  -- Concatena nome e sobrenome
	SET @senha = UPPER(SUBSTRING(REPLACE(CONVERT(VARCHAR(50), NEWID()), '-', ''), 1, 10)); -- Formata e gera o valor, NEWID gera identificador, CONVERT troca pra String, REPLACE tira os hífens, SUBSTRING extrai os 10 primeiros e UPPER deixa em maíusculo.
	SET @senha = LEFT(@senha, 10); -- Redundância para confirmar 10 caracteres na senha

    -- Gera o email entre Gmail, Yahoo ou Hotmail --
	SET @dominio = (
	SELECT TOP 1 Email
	FROM (VALUES 
	('gmail.com'),
	('yahoo.com'),
	('hotmail.com')
	) AS Emails(email)
	WHERE Email NOT IN (SELECT email FROM TB_USUARIO)
	AND email IS NOT NULL
	ORDER BY NEWID()
	);
    SET @email =
        LOWER(
            REPLACE(@nome, ' ', '') + CAST(@contador AS VARCHAR) + '@' + @dominio );
    
    
    -- Inserir registro na tabela TB_USUARIO
    INSERT INTO TB_USUARIO (NOME, CPF, ID_PLANO, DATA_NASCIMENTO, EMAIL, SENHA)
    VALUES (@nome, @cpf, @id_plano, @data_nascimento, @email, @senha);
	SET @contador = @contador + 1;
END;	


 -- GERADOR DE VENDA 

DECLARE @contador INT = 1;
WHILE @contador <= 50
BEGIN
    DECLARE @id_produto INT;
    DECLARE @qtd INT;
    DECLARE @id_usuario INT;
    DECLARE @max_usu INT;
    DECLARE @data_venda DATETIME;

	-- Seleciona o maior usuário das TB_USUARIO, para não fazer um insert maior que o do usuário existente --
    SELECT @max_usu = MAX(ID_USUARIO) FROM TB_USUARIO;

    -- Cria os registros com uma ordem randômica e seta eles na variável --
	SET @id_produto = CAST((RAND() * 12) + 1 AS INT);   --- ID_Produto gera o ID do produto de 1 a 12.
    SET @qtd = CAST((RAND() * (50)) + 1 AS INT);  --- Gera uma quantidade aleatória de venda até 50.
    SET @id_usuario = CAST((RAND() * (@max_usu - 1)) + 1 AS INT);  -- Gera um ID_Usuário baseado no ultimo usuario na TB_USUARIO
    SET @data_venda = DATEADD(DAY, -CAST(RAND() * DATEDIFF(DAY, '2013-01-01', GETDATE()) AS INT), GETDATE());  -- Gera uma data de venda a partir do ano 2013. 

	-- Insere os registros na Tabela TB_VENDA -- 
    INSERT INTO TB_VENDA(ID_PRODUTO, QUANTIDADE, ID_USUARIO, DATA_VENDA)
    VALUES (@id_produto, @qtd, @id_usuario, @data_venda);

    SET @contador = @contador + 1;
END;

-- Inserindo os dados na tabela de Cargos
INSERT INTO TB_CARGO VALUES 
    ('Diretor',14105.20),
    ('Cinegrafista',5000.99),
    ('Produtor',7000.70),
    ('Co-Diretor',12105.22),
    ('Ator',4000.47),
    ('Atriz',5000.99),
    ('Vendedor',1800.44),
    ('Analista de Marketing',3580.50),
    ('Faxineiro', 1250.70),
    ('Editor',3580.00),
    ('Roteirista', 5453.35),
    ('Diretor de Elenco', 9173.05);

--Inserindo os formatos do plano
INSERT INTO TB_FORMATO VALUES
('MP4'),
('AVI');

--Inserindo as classes indicativas
INSERT INTO TB_CLASS_INDICATIVA VALUES
('L'),
('14+'),
('16+'),
('18+');

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
	('Basic', 12.90, 1),
	('Basic+',120.00, 2),
	('Standard',24.90, 1),
	('Standard+',230.00,2),
	('Premium',35.50,1),
	('Premium+',340.00,2);

-- Inserindo os dados do Tipo Plano
INSERT INTO TB_TIPO_PLANO VALUES
('Mensal'),
('Trimestral'),
('Anual');

-- Inserindo os dados na tabela de propagandas
INSERT INTO TB_PROPAGANDA (ID_PLANO, DESC_PROP, DURACAO_PROP) VALUES
	(1,'Colgate Sensodine',180),
	(2,'Vendas Hinode',150),
	(3,'Desodorante Old Spice', 120),
	(1,'Vacina Durateston', 200),
	(2,'Livraria BemTeVi', 90);

INSERT INTO TB_PROPAGANDA (DESC_PROP, DURACAO_PROP) VALUES 	
	('TUDUM COMUNIFLIX', 5);

-- Inserindo os dados na tabela de filmes
INSERT INTO TB_FILME (NOME_FILME, DESC_FILME, DURACAO, ID_FORMATO,ID_CLASS_INDICATIVA, RESPONSAVEL, ID_CATEGORIA) VALUES
	('Velozes e furiosos 5: Operacao Rio', 'Dominic Toretto foi resgatado da prisão por sua irmã Mia e Brian O Conner, que realizam um ousado resgate sobre rodas. Logo em seguida, ele desaparece. Brian e Mia vão até o Rio de Janeiro, onde encontram Vince', 130, 1, 2, 12, 3),
	('Invocacao do Mal',
	'Um casal muda para uma casa nova ao lado de suas cinco filhas. Inexplicavelmente, estranhos acontecimentos começam a assustar as crianças, o pai e, principalmente, a mãe. Preocupada com algumas manchas que aparecem em seu corpo e com uma sequência de sustos que levou, ela decide procurar um famoso casal de investigadores paranormais',110, 2, 2, 1, 1),
	('O senhor das armas',
	'Yuri Orlov é um traficante de armas que realiza negócios nos mais variados locais do planeta. Estando constantemente em perigosas zonas de guerra',122, 1, 1, 4, 3),
	('V de vinganca',
	'Em uma Inglaterra do futuro, onde está em vigor um regime totalitário, vive Evey Hammond. Ela é salva de uma situação de vida ou morte por um homem mascarado, conhecido apenas pelo codinome V, que é extremamente carismático e habilidoso na arte do combate e da destruição',130, 2, 1, 13, 6),
	('Harry Potter e a pedra filosofal',
	'Harry Potter é um garoto órfão de 10 anos que vive infeliz com seus tios, os Dursley. Até que, repentinamente, ele recebe uma carta contendo um convite para ingressar em Hogwarts, uma famosa escola especializada em formar jovens bruxos.',152, 1, 1, 14, 3);

-- Inserindo os dados na tabela de séries
INSERT INTO TB_SERIE (NOME_SERIE, DESC_SERIE, TEMPORADA, RESPONSAVEL, ID_CATEGORIA, ID_FORMATO, ID_CLASS_INDICATIVA)
VALUES
('A Garota da memória seletiva', 'história de uma garota que tem uma memória seletiva e sofre na faculdade com isso gerando várias confusão', 2, 12, 2, 2, 3),
('O Mão de VACA', 'A história de um homem que não gastava dinheiro por nada até que sua mão se tornou a pata de uma vaca', 1, 1, 1, 2, 3),
('Castanha no Incrível Mundo da lua', 'Uma castanha se desprende da árvore e vai parar no surpreendente mundo da lua', 1, 13, 6, 1, 3),
('OUTFIT de meio milhão de dollars', 'Um jovem encontra um outfit capaz de realizar ações incríveis e usa para combater o crime', 2, 14, 3, 1, 3);

-- Inserindo os dados na tabela de produtos
INSERT INTO TB_PRODUTO (NOME_PRODUTO, DESC_PRODUTO,VALOR) VALUES
	('Camiseta Comuniflix','Camisetas P ao GG para assinantes do Comuniflix', 35.90),
	('Caneca Comuniflix','Caneca personalizada 200ml para assinantes Comuniflix', 50.99);

INSERT INTO TB_PRODUTO (ID_SERIE, NOME_PRODUTO, DESC_PRODUTO, VALOR) VALUES
	(1, 'Chapeu Ritalina','Chapeu para amantes da série "A garota da memória seletiva"', 69.50),
	(2, 'Livro como enriquecer sem gastar um tustao','Livro com 250 páginas de como enriquecer sem tirar um real do bolso', 25.20),
	(3, 'Snack Pringles','Snacks de batatas com todos os sabores da marca Pringles', 20.99),
	(4, 'Relógio Calvis Kelson','Relógio rolex oliginal da calves kelson', 149.90);

INSERT INTO TB_PRODUTO (ID_FILME, NOME_PRODUTO, DESC_PRODUTO, VALOR) VALUES
	(1, 'Action Figure Toretto','Action figure do Dominic Toretto falando "It is Brazil"', 322),
	(2, 'Adesivo Pentagrama','Adesivo contendo pentagrama referente ao filme Invocacao do mal', 13),
	(3, 'Airsoft Ak-47','Ak-47 airsoft com disponibilidade para 1000 bolinhas, com modo simultaneo e rajada', 599.90),
	(4, 'Mascará V de vingança','Mascara oliginal que foi usada no filme V de vingança', 1130.45),
	(5, 'Varinha das varinhas','Varinha feita com madeira de sabugueiro, possuindo comprimento de 38,1 cm de comprimento e um núcleo de pelo da cauda de testrálio', 109.50);

-- Inserindo os dados na tabela filha "EP Serie"

-- Inserindo episodios da série "A garota da memória seletiva"
INSERT INTO TB_EPSERIE VALUES
    ('O Inicio do esquecimento', 1, 60),
    ('Esqueci de esquecer e acabei lembrando', 1, 55),
    ('Pensei que namorava mas so eu sabia', 1, 50),
    ('O grande dia P/1', 1, 58),
    ('O grande dia P/2', 1, 60),
    ('O grande esquecimento da minha vida', 1, 65);

-- Inserindo episodios da série "O Mao de Vaca"
INSERT INTO TB_EPSERIE VALUES
    ('A maldição', 2, 66),
    ('O encontro Inesperado', 2, 50),
    ('A Grande morte', 2, 60);

-- Inserindo episodios da série "Castanha no Incrivel Mundo da Lua"
INSERT INTO TB_EPSERIE VALUES
    ('A queda',3 ,53),
    ('A viagem',3, 52),
    ('Descoberta',3, 50);

-- Inserindo episodios da série "OUTFIT de meio milhao de dollars"
INSERT INTO TB_EPSERIE VALUES
    ('A grande compra',4, 55),
    ('A virada',4, 53),
    ('Batalha pela vida',4,63),
    ('Estou vivo',4, 61),
    ('Luta inesquecivel',4, 62),
    ('O fim',4, 65);
--Inserindod os valores dos EP Serie

INSERT INTO TB_EPSERIE VALUES
('O Inicio do esquecimento',1,60),
('Esqueci de esquecer e acabei lembrando',1,57),
('Pensei que namorava mas so eu sabia',1,58),
('O grande dia P/1',1,55),
('O grande dia P/2',1,60),
('O grande esquecimento da minha vida',1,55),
('A maldição',2,60),
('O encontro Inesperado',2,55),
('A Grande morte',2,58),
('A queda',3,56),
('A viagem',3,60),
('Descoberta',3,75),
('A grande compra',4,54),
('A virada',4,55),
('Batalha pela vida',4,52),
('Estou vivo',4,58),
('Luta inesquecivel',4,56),
('O fim',4,55);
