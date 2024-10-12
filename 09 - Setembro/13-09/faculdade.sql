/*Exercício 1 - Calcular o número de alunos do sexo feminino em cada
curso. Classificar a listagem em ordem alfabética*/

SELECT  c.id_curso "Código",
        c.descritivo "Curso", 
        COUNT(a.id_curso) "Número_de_alunas"        /* É pra contar o que queremos ver, o número de alunos*/
FROM alunos a INNER JOIN cursos c
ON (c.id_curso = a.id_curso)
WHERE a.sexo = "F"
GROUP BY c.id_curso         /*O group by serve pra separar por curso nesse caso, então ele vai contar os alunos e separar por curso*/
ORDER BY c.descritivo;            /*Sem o group by aqui ele vai contar todos os alunos*/



/*Exercício 2 - Calcular os cursos que tem 6 ou mais alunas
Usamos um comando para filtrar resultados, depois que já agrupamos e fizemos uma query
O WHERE só funciona para detalhes da tabela*/

SELECT  c.id_curso "Código",
        c.descritivo "Curso", 
        COUNT(a.id_curso) "Numero_de_alunas"    /*Pra usar esse alias como variável no HAVING tem que seguir as regras pra nomear variável*/      
FROM alunos a INNER JOIN cursos c
ON (c.id_curso = a.id_curso)                    /*É preciso seguir essa ordem dos comandos*/
WHERE a.sexo = "F"
GROUP BY c.id_curso
HAVING Numero_de_alunas >= 6                                  /*O HAVING precisa vir depois do GROUP BY*/
ORDER BY c.descritivo;                             /*Também podemos usar o COUNT(a.id_curso) no HAVING*/


/*Exercício 3 - Calcular o número de disciplinas ministradas por cada professor. Classificar
a listagem em ordem alfabética pelo nome do professor*/ /*tabelas: profs, cursos e disciplinas*/

SELECT  p.id_professor "Codigo",
        p.nome "Nome",
        c.descritivo "Curso",
        COUNT(d.id_disciplina) "Nro_disciplinas"
FROM disciplinas d INNER JOIN professores p
ON (d.id_professor = p.id_professor)
INNER JOIN cursos c
ON (p.id_curso = c.id_curso)
GROUP BY p.id_professor
HAVING Nro_disciplinas >= 5
ORDER BY p.nome;

SELECT  p.id_professor "Código",                    /*O foco dessa query é o professor, entao temos que fazer os INNER JOIN baseado nele*/
        p.nome "Nome",
        c.descritivo "Curso",
        COUNT(d.id_disciplina) "Nro_disciplinas"
FROM professores p INNER JOIN cursos c
ON (p.id_curso = c.id_curso)
INNER JOIN disciplinas d
ON (d.id_professor = p.id_professor)
GROUP BY p.id_professor
ORDER BY p.nome;


/*Exercício 4 - Calcular o número de alunos matriculados em cada disciplina. Classificar a 
listagem pelo id de disciplina*/

SELECT  d.id_disciplina "Código",
        d.descritivo "Disciplina",
        c.descritivo "Curso",
        COUNT(m.id_disciplina) "Nro_alunos"
FROM disciplinas d INNER JOIN matriculas m
ON (d.id_disciplina = m.id_disciplina)
INNER JOIN cursos c
ON (c.id_curso = d.id_curso)
/*INNER JOIN alunos a               Não precisa da tabela de alunos pois o id_alunos já
ON (a.id_aluno = m.id_aluno)        está em matriculas, e não estamos chamando no select*/
GROUP BY d.id_disciplina
ORDER BY d.id_disciplina;


/*Exercício 5 - Calcular a mensalidade que cada aluno paga pelas disciplinas cursadas. 
Classificar a listagem pelo nome do aluno*/

SELECT  a.id_aluno "Código",
        a.nome "Nome",
        c.descritivo "Curso",
        SUM(d.valor)        /*Eu preciso somar os valores das mensalidades*/
FROM disciplinas d INNER JOIN matriculas m
ON (m.id_disciplina = d.id_disciplina)
INNER JOIN cursos c
ON (c.id_curso = d.id_curso)
INNER JOIN alunos a 
ON (a.id_aluno = m.id_aluno)
GROUP BY a.id_aluno         /*De acordo com cada aluno*/
ORDER BY a.nome;
