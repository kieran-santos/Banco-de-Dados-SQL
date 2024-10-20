#Verifica a versão do Banco de dados
SELECT VERSION();


#Mostra todos os bancos de dados disponíveis ao usuário 
SHOW DATABASES;


#Criação de uma nova instancia de banco de dados
#SINTAXE: CREATE DATABASE nomedobancodedados
CREATE DATABASE sistema;
 
 
#Conexão a determinado banco de dados 
#SINTAXE: USE nomedobancodedados
USE sistema;


#Mostra todas as tabelas do Banco de Dados selecionado
SHOW TABLES;


#Lista as características da tabela (Atributos criados)
#SINTAXE: DESCRIBE nomedatabela
DESCRIBE cliente;


#Atenção.... Cuidado com este comando
#Caso seu usuário tenha permissão total no banco....
#Irá apagar a tabela selecionada. Com todos os dados...!
DROP TABLE nomedatabela;


#Mostra os indices criados para a tabela
#  Indices pode ser:
#	- Chaves Primárias
#	- Chaves Extrangeiras
#	- Campos Unicos (UNIQUE)
SHOW INDEX FROM equipamento;


#Apaga a instação do Banco de dados (cuidado ao utilizar caso dados já estejam no banco de dados
DROP DATABASE nomedobanco;


/* 
   ----------------------
   - CRIAÇÃO DE TABELAS -
   ----------------------
*/

#Para criar uma tabela utiliza-se o CREATE TABLE
#Sintaxe:
#	Create table nometabela(
#		atributo  tipo chaveprimaria autoincrementa,
#		atributo2 tipo null ou not null ou unique,
#	);

#Criação da tabela usuários 
#Temos 4 tipos de restrições na criação desta tabela
#Restrições de:
#    - Chave Primária (linha 73)
#    - Não Nulo (Not null) (linhas 74 a 76)
#    - Unico (unique) (linha 75)
#    - Checagem com relação ao dado digitado para usu_senha (Check) (linha 77)
CREATE TABLE usuario(
	usu_codigo INT PRIMARY KEY AUTO_INCREMENT,
	usu_nome VARCHAR(255) NOT NULL,
	usu_email VARCHAR(255) NOT NULL UNIQUE,
	usu_senha CHAR(8) NOT NULL,
	CHECK (CHAR_LENGTH(usu_senha)>=8)		
);


#Criação da tabela de clientes
CREATE TABLE cliente(
	cli_codigo INT(10) PRIMARY KEY,
	cli_nome VARCHAR(255) NOT NULL,
	cli_telefone VARCHAR(255) NOT NULL,
	cli_email VARCHAR(255) NOT NULL UNIQUE,
	cli_obs VARCHAR(255) NULL
);


#Criação da tabela "equipamento"
#Pode-se Referenciar a Chave-Extrangeira logo na criação da Tabela e Após a Criação

#Exemplo 1: Para este exemplo já se cria a referência da chave extrangeira no proprio Create Table
CREATE TABLE equipamento(
	equipe_codigo INT(10) PRIMARY KEY,
	equipe_descricao VARCHAR(255) NOT NULL,
	equipe_detalhes VARCHAR(255) NOT NULL,
	equipe_obs VARCHAR(255) NULL,
	fk_cli_codigo INT NOT NULL,
	fk_marca INT NOT NULL,
	CONSTRAINT fk_equipamento FOREIGN KEY (fk_cli_codigo) REFERENCES cliente(cli_codigo)
	CONSTRAINT fk_equipmarca FOREIGN KEY (fk_marca) REFERENCES marca(marca_codigo)
);

#Exemplo 2: Cria a tabela equipamento com a chave estrangeira, e referencia a Chave Extrangeira 
#com Alter table após a criação da tabela
CREATE TABLE equipamento(
	equipe_codigo INT(10) PRIMARY KEY,
	equipe_descricao VARCHAR(255) NOT NULL,
	equipe_detalhes VARCHAR(255) NOT NULL,
	equipe_obs VARCHAR(255) NULL,
	fk_cli_codigo INT(10) NOT NULL,
);
ALTER TABLE equipamento
CONSTRAINT fk_cliente
ADD FOREIGN KEY (fk_cli_codigo) 
REFERENCES cliente(cli_codigo);


#Criação da tabela Marca
CREATE TABLE marca(
	marca_codigo INT(10) PRIMARY KEY,
	marca_nome VARCHAR(255) NOT NULL
);


#Criação da tabela tecnico
CREATE TABLE tecnico(
	tecnico_codigo INT(10) PRIMARY KEY,
	tecnico_nome VARCHAR(255) NOT NULL,
	tecnico_telefone VARCHAR(255) NOT NULL
);


#Criação da tabela Itens
CREATE TABLE itens(
	item_codigo INT(10) PRIMARY KEY AUTO_INCREMENT,
	item_descricao VARCHAR(255) NOT NULL,
	item_valor DECIMAL(5,2) NOT NULL
);


#Criação da tabela serviço
CREATE TABLE servico(
	ser_codigo INT(10) PRIMARY KEY,
	ser_descricao VARCHAR(255) NOT NULL,
	ser_horas INT(1) NOT NULL,
	ser_valor DECIMAL(5,2) NOT NULL
);


#Criação da tabela OS
CREATE TABLE os(
	os_codigo INT PRIMARY KEY AUTO_INCREMENT,
	os_dt_abertura DATE NOT NULL,
	os_dt_fechamento DATE NOT NULL,
	fk_os_tecnico_codigo INT NOT NULL,
	fk_os_equipe_codigo INT NOT NULL,
	fk_os_cliente_cpfcnpj INT NOT NULL
);
ALTER TABLE os CONSTRAINT fk_tecnico REFERENCES tecnico(tecnico_codigo);
ALTER TABLE os CONSTRAINT fk_equipamento REFERENCES equipamento(equip_codigo);
ALTER TABLE os CONSTRAINT fk_cliente REFERENCES cliente(cliente_codigo);


/* -------------------------------------------------------------------------------------------------
   - ALTER TABLE
   
   - ALTERAÇÕES EM ESTRUTURA DE TABELAS
   - Adiciona atributos
   - Modifica Atributos
   - Adiciona Chave Extrangeira
   - Remove Atributos
   -	
   - Parâmetos: Drop, Add Column, Modify, Change entre outros.
   -------------------------------------------------------------------------------------------------
*/


/* 
	ALTERA CARACTERISTICAS DE UM ATRIBUTO 
	- PARA ALTERAR O TIPO DO ATRIBUTO (DE VARCHAR PARA CHAR POR EXEMPLO, OU OUTRO TIPO)
	
	SINTAXE: ALTER TABLE tabela MODIFY atributo novas características do atributo
   
	Exemplo: Alterar o atributo cli_obs de VARCHAR(255) para VARCHAR(200)
	ALTER TABLE cliente MODIFY cli_obs VARCHAR(200) NOT NULL
*/

/* 
    MODIFY - Modificando a estrutura de um Atributo
    Tipo do atributo, restrições
*/

#Tipo de dado do Atributo cli_obs SENDO MOFIFICADO DE VARCHAR(255) PARA VARCHAR(200)
ALTER TABLE cliente 
MODIFY cli_obs VARCHAR(200) NOT NULL; 

  
#Tipo de dado do Atributo cli_email SENDO MOFIFICADO DE VARCHAR(255) PARA VARCHAR(200) */
ALTER TABLE cliente 
MODIFY cli_email VARCHAR(200) NULL;   


/* 
    CHANGE - Alterando o nome de um atributo
    #ALTER TABLE tabela CHANGE nome_antigo novo_nome características do atributo 
*/

#No exemplo abaixo estamos mudando o nome o nome do atributo cli_obs para cli_obs1    
ALTER TABLE cliente CHANGE cli_obs cli_obs1 VARCHAR(255) NULL;

/*
    ADD - Adiciona um novo atributo a tabela 
    No exemplo abaixo:
     - adiciona o atributo cli_profissão na tabela cliente com o tipo VARCHAR(255) e Podendo ser nulo
     - adiciona o atributo fk_marca_codigo na tabela equipamento com o tipo inteiro de 10 posiçoes e nao nulo
*/
ALTER TABLE cliente ADD cli_profissao VARCHAR(255) NULL;
ALTER TABLE equipamento ADD fk_marca_codigo INT(10) NOT NULL;


/* 
   DROP - Remove um atributo da tabela
   Sintaxe: ALTER TABLE tabela DROP COLUMN nomedoatributo 
*/

#No exemplo abaixo remove o atributo cli_profissao da tabela cliente
ALTER TABLE cliente DROP COLUMN cli_profissao;

/* 
   DROP INDEX - Apagar determinado indice de uma tabela
   Indice pode ser:
	- uma chave primária
	- uma chave extrangeira
	- um campo unico
*/ 

# 1º Mostrar o nome dos indices da tabela
SHOW INDEX FROM tabela;
# 2º Dropar o indice necessário
ALTER TABLE tabela DROP INDEX nomedoindice;

/* 
   ADD FOREIGN KEY - Modifica um atributo simples para que se torne chave extrangeira
   Deve-se utilizar com CONSTRAINT caso queira já indicar o nome do indice (restrição de chave)
   Sintaxe: 
   CONSTRAINT nomeindice
   ALTER TABLE nometabela 
   ADD FOREIGN KEY (NOME DO ATRIBUTO) REFERENCES tabela(chave primaria da tabela)   
*/
CONSTRAINT fk_equip_marca #Cria o nome para o indice
ALTER TABLE equipamento   #Inicia a alteração de tabela
ADD FOREIGN KEY (fk_marca_codigo) #Adicionar uma chave extrangeira
REFERENCES marca(marca_codigo); #Referencia a tabela auxiliar



/* 
 Constraints ou restrições
 Restrições criam consistência de dados e relacionamentos.
 Nelas são especificadas restrições como:
	- Chave Primária
	- Chave Extrangeira
	- Unico
	- Nulo
	- Não Nulo
	- Check
*/

#CHAVE PRIMÁRIA
atributo tipo PRIMARY KEY AUTO_INCREMENT;

#NÃO NULO
atributo tipo NOT NULL;

#NULO
atributo tipo NULL;

#UNICO
ATRIBUTO TIPO UNIQUE;

#CHECK
CHECK (ATRIBUTO=CONDIÇÃO); #IGUAL A 
CHECK (ATRIBUTO>=CONDIÇÃO); #MAIOR OU IGUAL A 
CHECK (ATRIBUTO>CONDIÇÃO); #MAIOR QUE 
CHECK (ATRIBUTO<=CONDIÇÃO); #MENOR OU IGUAL A
CHECK (ATRIBUTO<CONDIÇÃO); #MENOR OU IGUAL A 
CHECK (CHAR_LENGHT(ATRIBUTO)=CONDIÇÃO); #IGUAL A 

#PARA O EXEMPLO ABAIXO ESTAMOS CHECANDO SE O QUE ESTÁ SENDO INSERIDO NO ATRIBUTO USU_SENHA É IGUAL A 8
#OU SEJA, SE O TAMANHO TOTAL DE CARACTERES DESTE CAMPO É IGUAL A 8
#NÃO IRÁ ACEITAR TAMANHO MENOR DO QUE 8, NEM MAIOR
CREATE TABLE usuario(
	usu_codigo INT PRIMARY KEY AUTO_INCREMENT; /* cria restrição de Chave primária */
	usu_nome VARCHAR(255) NOT NULL, /* NOT NULL CRIA RESTRIÇAO DE NÃO NULO */
	usu_senha CHAR(8) NOT NULL,
        usu_email VARCHAR(255) NOT NULL UNIQUE, /* Cria restrição de não nulo e unico */
	usu_obs VARCHAR(255) NULL, /* NULL CRIA RESTRIÇÃO DE NULO */
	CHECK (CHAR_LENGTH(usu_senha)=8) /* conta todos os caracteres do campo senha, e testa para que este contenha 8 digitos */
);



/* 
	Restrições ON UPDATE e ON DELETE
	
	
*/
