CREATE DATABASE BDA_VENDA;

USE  BDA_VENDA;


-- 1 CRIAR TABELA CLIENTE 
CREATE TABLE CLIENTE (
codcliente bigint not null,
cliente varchar (50) not null,
cpf bigint,
endereco varchar (50),
primary key(codcliente)
)

SELECT * FROM CLIENTE

-- 2 CRIAR TABELA PRODUTO 
CREATE TABLE PRODUTO (
codproduto bigint not null,
descricaoproduto varchar (50) not null,
unidade char(2)not null,
preco decimal(8,2)not null,
primary key(codproduto)
)

SELECT * FROM PRODUTO

-- 3 CRIAR TABELA TIPOS DE PAGAMENTO 
CREATE TABLE TIPO_PAGAMENTO (
codtppagamento bigint not null,
descricaopagamento varchar (50) not null,
primary key (codtppagamento )
)

SELECT * FROM TIPO_PAGAMENTO

-- 4 CRIAR TABELA VENDA
CREATE TABLE VENDA (
nota bigint not null,
datavenda date not null,
valorvenda float not null,
codcliente bigint not null,
codtppagamento bigint not null,

primary key(nota, datavenda),
foreign key(codcliente) references CLIENTE,
foreign key(codtppagamento) references TIPO_PAGAMENTO,
)

SELECT * FROM VENDA

-- 5 CRIAR TABALA ITENS VENDAS  
CREATE TABLE ITENS_VENDAS (
nota bigint not null,
datavenda date not null,
codproduto bigint not null,
qtd int not null,

primary key (nota , datavenda, codproduto),
foreign key (nota, datavenda ) references VENDA,
foreign key (codproduto) references Produto(codproduto)
)

SELECT * FROM ITENS_VENDAS

-- 1 PROCEDURE INSERIR,UPDATE,DELETE NOVO CLIENTE --------------------------------

CREATE PROCEDURE spinsertcliente
(
@cd_client bigint,
@nome_cliente varchar(50),
@cpf_cliente bigint,
@endereco_cliente varchar(50),
@opcao INT
 
)
AS 
IF     @opcao = 1 
BEGIN 
INSERT INTO CLIENTE(codcliente,cliente,cpf,endereco) 
VALUES (@cd_client,@nome_cliente,@cpf_cliente,@endereco_cliente) 
END;

ELSE IF @opcao = 2 
BEGIN 
UPDATE CLIENTE SET codcliente = 1000 where @nome_cliente = 'FERNANDO'
END;

ELSE IF @opcao = 3
BEGIN 
DELETE FROM CLIENTE where codcliente = 1;
END;

EXEC spinsertcliente
@cd_client = 001,
@nome_cliente ='FERNANDO',
@cpf_cliente = 123456789,
@endereco_cliente = 'RUA ROMARIO DE SOUZA BORGES',
@opcao = 1

SELECT * FROM CLIENTE

-- 2  PROCEDURE INSERIR,UPDATE,DELETE NOVO PRODUTO -------------------------------------

CREATE PROCEDURE  spinsertProduto
(
@cd_pro bigint,
@desc varchar(50),
@un char(2),
@pc decimal,
@opcao INT
)
AS 
IF		@opcao = 1
BEGIN
INSERT INTO PRODUTO (codproduto,descricaoproduto,unidade,preco) 
VALUES (@cd_pro,@desc,@un,@pc) 
END;

ELSE IF @opcao = 2
BEGIN
UPDATE PRODUTO SET codproduto = 1234 where @desc = 'AVARIA'
END;

ELSE IF @opcao = 3
BEGIN
DELETE FROM  PRODUTO where descricaoproduto = 'INUTILIZAVEL'
END;

EXEC spinsertProduto
@cd_pro = 004,
@desc = 'MONITOR 39 LCD',
@un = PC,
@pc = 123,
@opcao = 1

SELECT * FROM PRODUTO

--3  PROCEDURE INSERIR,UPDATE,DELETE NOVO TIPO_PAGAMENTO NA TABELA -----------------------

CREATE PROCEDURE spinserttipo_pagamento
(
@codtppagamento bigint,
@descricaopagamento varchar (50),
@opcao int
)
AS
IF		@opcao = 1
BEGIN 
INSERT INTO TIPO_PAGAMENTO (codtppagamento,descricaopagamento) 
VALUES (@codtppagamento,@descricaopagamento) 
END;

ELSE IF  @opcao = 2
BEGIN
UPDATE TIPO_PAGAMENTO SET codtppagamento = 200 where @descricaopagamento = 'REFATURA'
END;

ELSE IF @opcao = 3
BEGIN 
DELETE FROM TIPO_PAGAMENTO where codtppagamento = 100;
END;

EXEC spinserttipo_pagamento
@codtppagamento = 098,
@descricaopagamento ='CREDIARIO',
@opcao = 1

SELECT * FROM TIPO_PAGAMENTO

-- 4 PROCEDURE INSERIR NOVA VENDA ------------------------------------
CREATE PROCEDURE spinsertvendas
(
@nota bigint,
@data_venda date,
@valor_venda float,
@cod_cliente bigint,
@cod_tppagamento bigint,
@opcao int
)
AS
IF    @opcao = 1
BEGIN
INSERT INTO VENDA (nota,datavenda,valorvenda,codcliente,codtppagamento)
VALUES (@nota,@data_venda,@valor_venda,@cod_cliente,@cod_tppagamento)
END;

ELSE IF  @opcao = 2 
BEGIN
UPDATE VENDA SET codtppagamento = 300 where @nota = 100
END;

ELSE IF  @OPCAO = 3
BEGIN 
DELETE FROM VENDA where codcliente = 790
END;

EXEC spinsertvendas
@nota = 1234567,
@data_venda = '21-11-2019',
@valor_venda = 1548.10,
@cod_cliente = 003,
@cod_tppagamento = 789,
@opcao = 1

SELECT * FROM VENDA

-- 5 PROCEDURE INSERIR NOVA ITENS_VENDA ------------------------------------
CREATE PROCEDURE spinsertItensVendas
(
@nota_venda bigint,
@data_venda date,
@cod_produto bigint,
@q_td int ,
@opcao int
)
AS 
IF    @opcao = 1
BEGIN
INSERT INTO ITENS_VENDAS (nota,datavenda,codproduto,qtd)
VALUES(@nota_venda,@data_venda,@cod_produto,@q_td)
END;

ELSE IF @opcao = 2
BEGIN
UPDATE ITENS_VENDAS SET codproduto = 130 where @nota_venda = 123.456
END;

ELSE IF  @opcao = 3
BEGIN  
DELETE FROM  ITENS_VENDAS where nota =  799
END;

EXEC spinsertItensVendas
@nota_venda = 1234567,
@data_venda = '2019-11-21',
@cod_produto = 004,
@q_td = 2,
@opcao = 1

SELECT * FROM ITENS_VENDAS

drop database BDA_VENDA
----------------------------------------------------------------------------

--FUNCAO

CREATE FUNCTION fnRetornaAno (@data date)
RETURNS int
AS
BEGIN
DECLARE @ano int
SET @ano = YEAR(@data)
RETURN @ano

END;

SELECT dbo.fnRetornaAno(getdate())

SELECT dbo.fnRetornaAno(VENDA.datavenda) FROM dbo.VENDA

---------------------------------------------------------------------------------

--TRIGGER 

CREATE TRIGGER trgINSERT_CLIENTE
ON CLIENTE 
FOR INSERT
AS
BEGIN 
SELECT * FROM  cliente where cliente = 'JOAO '
END;
SELECT * FROM  CLIENTE