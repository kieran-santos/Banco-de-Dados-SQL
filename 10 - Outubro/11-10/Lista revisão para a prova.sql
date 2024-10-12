###====== Revisão para a prova ========###

/*1.Listar todos os produtos com suas respectivas 
#categorias.Classificar a listagem pelo preço de
#do produto.
Codigo   Descritivo   Preço_Venda  Categoria
			          R$ 0.000,00   descritivo*/


SELECT	p.id_produto "Código",
		p.descritivo "Descritivo",
		CONCAT("R$ ", FORMAT(p.venda, 2, "de_DE")) "Preço_Venda",  /*o de_DE serve pra trocar o ponto pela vírgula*/
		c.descritivo "Categoria"
FROM produtos p INNER JOIN categorias c
ON (p.id_categoria = c.id_categoria)		/*sempre CHAVE PRIMÁRIA e CHAVE ESTRANGEIRA*/
ORDER BY p.venda


/*2.Listar todos os produtos que ainda não tiveram nenhuma venda.
Código   Descritivo   Categoria*/

SELECT	p.id_produto "Código",
		p.descritivo "Descritivo",
		c.descritivo "Categoria"
FROM  categorias c INNER JOIN produtos p 
ON (p.id_categoria = c.id_categoria)
LEFT JOIN itens_nfv i
ON (p.id_produto = i.id_produto)
WHERE i.id_produto IS NULL
GROUP BY p.id_produto


/*3.Listar todos os produtos cujo estoque esteja 
#abaixo de 100 unidades e preço de venda entre 
#200.00 e 300.00.Classificar a listagem pelo 
#descritivo do produto.
Código  Descritivo  PreçoVenda   Estoque  Categoria
					R$ 0.000,00           descritivo*/


SELECT	p.id_produto "Código",
		p.descritivo "Descritivo",
		CONCAT("R$ ", FORMAT(p.venda, 2, "de_DE")) "PreçoVenda",
		p.estoque "Estoque",
		c.descritivo "Categoria"
FROM produtos p INNER JOIN categorias c
ON (p.id_categoria = c.id_categoria)
WHERE p.estoque < 100
AND p.venda BETWEEN 200 AND 300

/*3.1 Tranformar a query do exercicio 2 em uma visão.*/

CREATE OR REPLACE VIEW vw_produto_sem_venda AS
SELECT	p.id_produto "Código",
		p.descritivo "Descritivo",
		c.descritivo "Categoria"
FROM  categorias c INNER JOIN produtos p 
ON (p.id_categoria = c.id_categoria)
LEFT JOIN itens_nfv i
ON (p.id_produto = i.id_produto)
WHERE i.id_produto IS NULL
GROUP BY p.id_produto



/*4.Listar todas as notas fiscais de venda de acordo 
#com o layout abaixo.Classificar a listagem pela 
#data de emissaõ da NF.
 NroNF   Emissão     Valor        Vendedor  Cliente                 
       dd/mm/AAAA   R$ 0.000,00     nome     nome*/

SELECT	nf.id_nfv "NroNF",
		DATE_FORMAT(nf.emissao, "%d/%m/%Y") "Emissão",
		nf.valor "Valor",
		v.nome "Vendedor",
		c.nome "Cliente"
FROM vendedores v INNER JOIN nf_vendas nf
ON (nf.id_vendedor = v.id_vendedor)
INNER JOIN clientes c
ON (nf.id_cliente = c.id_cliente)
ORDER BY nf.emissao

/*4.1 Tranformar a query do exercicio 3 em uma visão.*/

CREATE OR REPLACE VIEW vw_estoque_preco AS
SELECT	p.id_produto "Código",
		p.descritivo "Descritivo",
		CONCAT("R$ ", FORMAT(p.venda, 2, "de_DE")) "PreçoVenda",
		p.estoque "Estoque",
		c.descritivo "Categoria"
FROM produtos p INNER JOIN categorias c
ON (p.id_categoria = c.id_categoria)
WHERE p.estoque < 100
AND p.venda BETWEEN 200 AND 300


/*5. Listar o total vendido por cada vendedor da
loja Fatecvan.
Código    Nome     Total_Vendido
					R$ 0.000,00*/

SELECT	v.id_vendedor "Código",
		v.nome "Nome",
		CONCAT("R$ ", FORMAT(SUM(nf.valor), 2, "de_DE")) "Total vendido"
FROM vendedores v INNER JOIN nf_vendas nf
ON (v.id_vendedor = nf.id_vendedor)
GROUP BY v.id_vendedor

/*5.1 Listar todos os produtos vendidos. Ordenar
#pelo descritivo do produto.
Código   Descritivo    Quantidade  Preço_Venda*/

SELECT	p.id_produto "Código",
		p.descritivo "Descritivo",
		i.quantidade "Quantidade",
		CONCAT("R$ ", FORMAT(i.venda, 2, "de_DE")) "Preço_Venda"
FROM produtos p INNER JOIN itens_nfv i
ON (p.id_produto = i.id_produto)
ORDER BY p.descritivo


/*6.Criar uma listar com a quantidade total vendida 
#de cada produto. Filtrar somente os produtos que
#somaram mais do que 2 unidades vendidas.
Código   Descritivo   Quantidade_total*/

SELECT p.id_produto "Código",
	   p.descritivo "Descritivo",
	   SUM(i.quantidade) "Quantidade_total"
FROM produtos p INNER JOIN itens_nfv i
ON (p.id_produto = i.id_produto)
GROUP BY p.id_produto
HAVING Quantidade_total > 2


/*7.Calcular o valor a ser recebido por cada
#vendedor com relação ao total vendido.
#Valor_a_Receber = salario_fixo + (comissão/100*total vendido)
Código  Nome  Total_Vendido  Comissão  Valor_a_Receber*/

SELECT v.id_vendedor "Código",
	   v.nome "Nome",
	   SUM(nf.valor) "Total_Vendido",
	   CONCAT(v.comissao, "%") "Comissão",
	   CONCAT("R$", FORMAT(v.salario_fixo+(v.comissao/100*SUM(nf.valor)), 2, "de_DE")) "Valor_a_Receber"
FROM vendedores v INNER JOIN nf_vendas nf
ON (v.id_vendedor = nf.id_vendedor)
GROUP BY v.id_vendedor


/*8.Listar todos os vendedores que tiveram a media
#de vendas maior do que a media geral de vendas 
#de toda a loja.
Código      Nome       Media_Vendas
					   R$ 0.000,00*/


SELECT v.id_vendedor "Código",
	   v.nome "Nome",
	   CONCAT("R$ ", FORMAT(AVG(nf.valor), 2, "de_DE")) "Media_Vendas"
FROM vendedores v INNER JOIN nf_vendas nf
ON(v.id_vendedor = nf.id_vendedor)
GROUP BY v.id_vendedor
HAVING AVG(nf.valor) > (
	SELECT AVG(valor)
	FROM nf_vendas)

	/*A conta para média seria SUM(valor) / numero_de_vendedores
	Mas o AVG é uma função nativa que faz isso */


/*9.Listar todos os produtos cujo preço de venda
#é maior do que a media entre todos os preços 
#de venda dos produtos da loja.  
Código    Descritivo   Preço_Venda   Categoria
                       R$ 0.000,00   descritivo*/   

SELECT p.id_produto "Código",
	   p.descritivo "Descritivo",
	   p.venda "Preco_Venda",
	   c.descritivo "Categoria"
FROM produtos p INNER JOIN categorias c
ON (p.id_categoria = c.id_categoria)
WHERE p.venda > (
	SELECT AVG(venda)
	FROM produtos)



/*10.Atualizar o preço de venda de todos os produtos
#que nunca foram vendidos. Dar um desconto de 20% 
#no preço de venda.*/

SELECT *
FROM produtos

UPDATE produtos SET venda = venda*0.8
WHERE id_produto IN (
	SELECT p.id_produto
	FROM produtos p LEFT JOIN itens_nfv i
	ON (p.id_produto = i.id_produto)
	WHERE i.id_produto IS NULL)

