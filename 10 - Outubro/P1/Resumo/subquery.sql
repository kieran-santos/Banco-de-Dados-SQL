
#======================================#
###    Subqueries - select aninhados ###
#======================================#
#Regras para a construção de Subqueries:
#======================================#
/*Podem ser muito úteis quando é preciso selecionar 
dados de uma tabela com uma condição que dependa da 
própria tabela ou de outras.

Quando precisamos pegar um valor da tabela para ser
comparado é necessário utilizar a subquery

É possível utilizar uma subquery em várias 
cláusulas: SELECT, WHERE, HAVING e FROM.
Operadores pode ser de 2 tipos:	
	*Operadores de Uma Linha (=, >, >=, <, <=, <>).
	*Operadores de Múltiplas Linhas (IN). 
	
A subquery em um SELECT só pode devolver um campo, não tabela
	- Apenas UM valor, não pode ter mais de UM se não vira tabela
	
A condição IN pode voltar uma tabela
*/



/*SINTAXE*/
======================================================

SELECT campo1, campo2, (subquery), ....
FROM tabela1 INNER JOIN (subquery)
WHERE campox IN (subquery) AND campoy >= (subquery)
GROUP BY
HAVING campo < (subquery)

======================================================


/*Exemplos*/

/*Ex1-Quais funcionários tem o salário maior do que o 
salário do funcionário cujo codigo = 1.
Código     Nome      Salário  */

SELECT 	f.id_funcionario "Codigo",
		f.nome "Nome",
		f.salario "Salario"
FROM funcionarios f
WHERE f.salario > (					/*normalmente em um WHERE com subquery*/
	SELECT f.salario				/*sempre vamos ter o atributo no WHERE e no */
	FROM funcionarios f				/*SELECT da subquery iguais*/
	WHERE f.id_funcionario = 1);    /*Neste caso precisamos fazer 3 comparações (WHERE f.salario > (f.id_funcionario=1))
                                        - Porém, não podemos fazer assim, tem que ser uma subquery*/


/*Ex2-Quais funcionários tem o salário maior do que o 
salário do funcionário cujo codigo = 1 e que participam 
do projeto cujo codigo = 3.
Código       Nome        Salário*/ 

SELECT 	f.id_funcionario "Codigo",  /*Temos duas condições aqui*/
		f.nome "Nome",
		f.salario "Salario"
FROM funcionarios f					/*Eu poderia usar um INNER JOIN*/
WHERE f.salario > (					/*pra pegar a tabela funcionarios_projetos*/
	SELECT f.salario				/*mas como a query não precisa*/
	FROM funcionarios f				/*me dar nenhum valor dessa tabela*/
	WHERE f.id_funcionario = 1)		/*eu posso colocar essa query*/
AND id_funcionario IN (				/*em uma subquery, só pra achar esse valor*/
	SELECT id_funcionario           /*O INNER JOIN só é necessário se formos mostrar no SELECT algo da tabela*/
	FROM funcionarios_projetos		/*Lembrando que o AND vai fazer com que*/
	WHERE id_projeto = 3			/*as duas condições sejam obrigatórias*/
)

/*Ex3-Listar os funcionários cujo valor do salário é igual 
ao maior salário cadastrado na empresa.

Código    Nome      Sexo      Salário*/

SELECT 	id_funcionario "Codigo",
		nome "Nome",
		sexo "Sexo",
		salario "Salario"
FROM funcionarios
WHERE salario = (
	SELECT MAX(salario)      
	FROM funcionarios
)

/*Se fosse o menor salário*/

SELECT 	id_funcionario "Codigo",
		nome "Nome",
		sexo "Sexo",
		salario "Salario"
FROM funcionarios
WHERE salario = (
	SELECT MIN(salario)
	FROM funcionarios
)

/*Ex4-Listar todos os funcionários que possuem salários 
abaixo da média dos salários entre todos os funcionários 
da empresa 
	
Código     Nome     Salário       Departamento
                                   descritivo */


SELECT 	f.id_funcionario "Codigo",
		f.nome "Nome",
		f.salario "Salario",
		d.descritivo "Departamento"
FROM funcionarios f INNER JOIN departamentos d
ON (f.id_departamento = d.id_departamento)
WHERE salario < (
	SELECT AVG(salario)
	FROM funcionarios
)

/*Ex6-Criar uma query para reajustar em 10% o salario de 
todos os funcionarios com numero de dependentes maior 
do que 2.*/

/*Tentativa*/
SELECT	f.id_funcionario "Codigo",
		f.nome "Nome",
		f.salario "Salario",
		f.salario*1.1 "Salario_reajustado"
FROM funcionarios f INNER JOIN dependentes d
ON (f.id_funcionario = d.id_funcionario)
WHERE id_funcionario
IN (SELECT id_funcionario
	FROM dependentes
	GROUP BY id_funcionario
	HAVING COUNT(id_funcionario) > 2)


/*Correção professor*/

UPDATE funcionarios SET salario = salario*1.1   /*A palavra chave aqui é REAJUSTAR, não é só selecionar*/
WHERE id_funcionario IN (                       /*Aqui o id_funcionario deve estrar dentro desta condição*/
	SELECT id_funcionario                       /*Precisa pertencer à condição*/
	FROM dependentes
	GROUP BY id_funcionario
	HAVING COUNT(id_funcionario) > 2)

/*Textualizando:

Fazer um UPDATE na tabela funcionario, no campo salario
reajustar o salário para salario*1.1
ONDE id do funcionario esteja dentro da condição a seguir
(selecionamos o funcionario a partir da tabela dependentes
agrupamos por id_funcionario
ONDE a quantidade de ocorrências de id_funcionario for maior que 2)
pois neste caso significa que ele possui mais de 2 dependentes*/




/*Ex7-Liste todos os dependentes que possuem idade maior 
ou igual a idade média de todos os dependentes cadastrados 
na empresa.

Código     Nome     Sexo     Idade     Média_Idades*/

SELECT 	id_dependente "Codigo",
		nome "Nome",
		SEXO "Sexo",
		YEAR(CURRENT_DATE) - YEAR(DATAN) "Idade",
		AVG(YEAR(CURRENT_DATE) - YEAR(DATAN)) "Media_Idades"
FROM dependentes
WHERE YEAR(CURRENT_DATE) - YEAR(DATAN) >= (
	SELECT AVG(YEAR(CURRENT_DATE) - YEAR(DATAN))
	FROM dependentes
)



/*Ex8-Listar os departamentos que possuem 2 ou mais funcionários

Código		descritivo		*/

SELECT	id_departamento "Codigo",
		descritivo "Descritivo"
FROM departamentos
WHERE id_departamento IN(
	SELECT id_departamento
	FROM funcionarios
	GROUP BY id_departamento
	HAVING COUNT(id_departamento) >= 2
)