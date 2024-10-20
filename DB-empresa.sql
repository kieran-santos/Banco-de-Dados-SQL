/*1. Criar uma query para listar as vendas realizadas de todos os
produtos das categorias (1, 2 e 3) de acordo com o layout abaixo.
Classificar a listagem em ordem decrescente da data de emissão.
O produto pode constar em várias notas, portanto, ele poderá ser listado várias vezes. (2.0)

Código  Descritivo  Categoria    NroNF    Emissão       Vendedor    Cliente  
                    descritivo           dd/mm/AAAA      nome        nome
*/

SELECT  p.id_produto "Codigo",
        p.descritivo "Descritivo",
        c.descritivo "Categoria",
        nf.id_nfv "NroNF",
        DATE_FORMAT(nf.emissao, "%d/%m/%Y") "Emissão",
        v.nome "Vendedor",
        cl.nome "Cliente"        
FROM vendedores v INNER JOIN nf_vendas nf
ON (v.id_vendedor = nf.id_vendedor)
INNER JOIN clientes cl
ON (cl.id_cliente = nf.id_cliente)
INNER JOIN itens_nfv i
ON (nf.id_nfv = i.id_nfv)
INNER JOIN produtos p 
ON (p.id_produto = i.id_produto)
INNER JOIN categorias c
ON (p.id_categoria = c.id_categoria)
WHERE c.id_categoria < 4
ORDER BY nf.emissao DESC


/*2. Criar uma query para listar a quantidade total de produtos cadastrados em cada categoria.
Somente devem ser listadas as categorias que tiverem uma quantidade de produtos acima de 3.(2.0)

Código    		 Descritivo      	 Quantidade_Produtos*/

SELECT  p.id_produto "Código",
        c.descritivo "Descritivo",
        COUNT(p.id_produto) "Quantidade_Produtos"
FROM produtos p INNER JOIN categorias c
ON (p.id_categoria = c.id_categoria)
GROUP BY c.id_categoria
HAVING Quantidade_Produtos > 3


/*3.Criar uma query para listar todos os vendedores do sexo feminino que ainda não realizaram
nenhuma venda na loja. A listagem deverá vir classificada em ordem alfabética. (2.0)

Código   	     Nome   	          	 Comissão  	  	       Salario_Fixo
                                            XX%                         R$ 0.000,00 */             

/*Para alterar a tabela*/
ALTER TABLE vendedores
ADD sexo VARCHAR(1);
 
UPDATE vendedores
SET sexo = "F"
WHERE id_vendedor = 1 OR id_vendedor = 4;
 
UPDATE vendedores
SET sexo = "M"
WHERE id_vendedor = 2 OR id_vendedor = 3 OR id_vendedor = 5 OR id_vendedor = 6 OR id_vendedor = 7

/*select*/
SELECT  v.id_vendedor "Codigo",
        v.nome "Nome",
        CONCAT(v.comissao, "%") "Comissao",
        v.salario_fixo "Salario_Fixo"
FROM vendedores v LEFT JOIN nf_vendas nf
ON (v.id_vendedor = nf.id_vendedor)
WHERE nf.id_nfv IS NULL AND v.sexo = "F"
ORDER BY v.nome


/*4.Criar uma VIEW que liste os totais vendidos por todos os vendedores do sexo masculino.
A listagem deverá indicar o percentual vendido pelo vendedor em relação ao valor total geral
vendido pela loja. (2.0)
%vendido do total = (total vendido pelo vendedor/ total geral vendido) *100
	
Código 	   Nome             ValorTotalVendido            %Vendido_do_Total
	                        R$ 0.000,00                         XX%*/

CREATE OR REPLACE VIEW vw_total_vendas_masc AS
SELECT  v.id_vendedor "Codigo",
        v.nome "Nome",
        CONCAT("R$ ", FORMAT(SUM(nf.valor), 2, "de_DE")) "ValorTotalVendido",
        CONCAT(FORMAT(SUM(nf.valor) / (SELECT SUM(valor) FROM nf_vendas) * 100, 2, "de_DE"), "%") "%Vendido_do_Total"
FROM vendedores v LEFT JOIN nf_vendas nf
ON (v.id_vendedor = nf.id_vendedor)
WHERE v.sexo = "M"
GROUP BY v.id_vendedor


/*5.Aumentar em 2% a comissão de todos os vendedores que bateram a meta de venda de R$ 7.000,0.
Aumentar em 2% é somar 2 no campo comissão do vendedor, por exemplo, se o vendedor bateu a meta
de vendas e ganha 10% de comissão, ele passará a ganhar 12%. (2.0)*/

UPDATE vendedores
SET comissao = comissao+2
WHERE id_vendedor IN ( SELECT v.id_vendedor
	FROM vendedores v INNER JOIN nf_vendas nf
	ON (v.id_vendedor = nf.id_vendedor)
	GROUP BY nf.id_vendedor
	HAVING SUM(nf.valor) >= 7000)