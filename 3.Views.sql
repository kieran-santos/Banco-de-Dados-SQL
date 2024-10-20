#=============================#
##	 Conceito de VIEW 		 ##
#=============================#

/*Criação de uma Visão (view)
 * tabela virtual(visão) - é criada baseada em uma consulta, fruto do resultado de um select
 * não existe "fisicamente"
 * não pode sofrer atualizações > salvo quando 
   é formada por uma unica tabela.
 * é mais seguro de se trabalhar do que com a tabela física
 * garante que você não precise ficar fazendo a mesma query várias vezes
 * Pode ser apenas CREATE VIEW - o problema é que se a view já existir tem
 que fazer CREATE OR REPLACE VIEW
 * A aplicação acessa a view e não a tabela de origem
 * Primeiro criamos a query, conferimos se está correta e depois cria a visão
 * Dar o nome da visão começando com vw_nome
 * A view fica salva em outra pasta no banco de dados, não na mesma das tabelas
 * É basicamente o resultado de uma query que fica salva
 * Quando formos reutilizar a view em outra query é importante criar os alias
 como variável, pois agora o alias será o nome do atributo utilizado na query
*/
    
## Sintaxe ##

CREATE OR REPLACE VIEW nome_da_visao AS
    SELECT
    FROM 
    WHERE ...
    
/*Pra ver a visão: */
/*Criando uma view para ver os dados dos funcionários*/

CREATE OR REPLACE VIEW vw_imagem_funcionarios AS
SELECT  f.id_funcionario "Codigo",
        f.nome "Nome",
        e.descritivo "Unidade",
        d.descritivo "Departamento",
        c.descritivo "Cargo"
FROM funcionarios f INNER JOIN empresas e
ON (f.id_empresa=e.id_empresa)
INNER JOIN departamentos d
ON (f.id_departamento=d.id_departamento)
INNER JOIN cargos c
ON (f.id_cargo=c.id_cargo)
ORDER BY f.nome


/*Utilizando a view com INNER JOIN com a tabela funcionários para ver o salário também*/
SELECT  vw.codigo "Código",
        vw.nome "Nome",
        vw.cargo "Cargo",
        f.salario "Salário"
FROM vw_imagem_funcionarios vw INNER JOIN funcionarios f
ON (vw.codigo = f.id_funcionario)

/*Vamos refazer os exercícios do banco Faculdade*/

/*Exercício 1 - Calcular o número de alunos do sexo feminino em cada
curso. Classificar a listagem em ordem alfabética*/

SELECT  p.id_professor "Código",                   
        p.nome "Nome",
        c.descritivo "Curso",
        COUNT(d.id_disciplina) "Nro_disciplinas"
FROM professores p INNER JOIN cursos c
ON (p.id_curso = c.id_curso)
INNER JOIN disciplinas d
ON (d.id_professor = p.id_professor)
GROUP BY p.id_professor
ORDER BY p.nome;

/*Exercício 3 - Calcular o número de disciplinas ministradas por cada professor. Classificar
a listagem em ordem alfabética pelo nome do professor*/ /*tabelas: profs, cursos e disciplinas*/
CREATE OR REPLACE VIEW vw_professores_disciplina AS
SELECT  p.id_professor "Codigo",
        p.nome "Nome",
        c.descritivo "Curso",
        COUNT(d.id_disciplina) "Nro_disciplinas"
FROM disciplinas d INNER JOIN professores p
ON (d.id_professor = p.id_professor)
INNER JOIN cursos c
ON (p.id_curso = c.id_curso)
GROUP BY p.id_professor
ORDER BY p.nome;


/*Exercício 4 - Calcular o número de alunos matriculados em cada disciplina. Classificar a 
listagem pelo id de disciplina*/



/*Exercício 5 - Calcular a mensalidade que cada aluno paga pelas disciplinas cursadas. 
Classificar a listagem pelo nome do aluno*/