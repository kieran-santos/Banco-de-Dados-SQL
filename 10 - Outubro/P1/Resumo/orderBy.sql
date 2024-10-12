/*ORDER BY*/
ORDER BY id_medico;

/*O ORDER BY vai ordenar a tabela segundo o campo especificado
    - Sempre de menor para maior, para mudar isso precisamos dar um parâmetro*/

/*Exemplos*/
/*Exercício 1: Listar todas as consultar realizadas pelos médicos*/

SELECT  m.id_medico "Codigo", m.nome "Nome",   /*Tudo isso entre aspas é o alias*/
DATE_FORMAT(a.data_a,"%d/%m/Y") "Data_Consulta", a.horario_a "Horário_Consulta"
FROM medicos m INNER JOIN atendimentos a
ON (m.id_medico = a.id_medico);

/*Exercício 2: Listar todos as consultas realizadas pelos pacientes femininos*/
SELECT	p.id_paciente "Código",
	p.nome "Nome",
	p.sexo "Sexo",
	DATE_FORMAT(a.data_a, "%d/%m/%Y") "Data_Consulta",
	a.horario_a "Horário_Consulta"
FROM pacientes p INNER JOIN atendimentos a
ON (p.id_paciente = a.id_paciente)
WHERE p.sexo = "F"
ORDER BY p.nome, a.data_a, a.horario_a;

/*Exercício 3: listar todas as consultas realizadas pelos médicos do sexo feminino.
Classificar a listagem em ordem alfabética*/

SELECT a.id_atendimento "Código", m.nome "Nome", e.descritivo, DATE_FORMAT(a.data_a, "%d/%m/%Y") "Data", a.horario_a "Horário", p.nome "Pacientes"
FROM atendimentos a INNER JOIN medicos m INNER JOIN especialidades e INNER JOIN pacientes p
ON(a.id_medico = m.id_medico)		/*O primeiro inner join não pode ser entre tabelas que não tem ligação*/
WHERE m.sexo = "F"
ORDER BY m.nome;

/*Exercício 4: listar todos os exames realizados. Classificar a listagem pelo descritivo do
exame em ordem DESC. FORMAT (valor, 2, "de_DE")*/

SELECT e.id_exame "ID", e.descritivo "Especialidade" 
FROM exames e 
ORDER BY e.descritivo DESC;
/*O DESC vai fazer ele ordenar de forma decrescente*/