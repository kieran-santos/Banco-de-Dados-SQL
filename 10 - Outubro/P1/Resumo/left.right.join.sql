/*LEFT/RIGHT JOIN e FORMAT*/
/*O LEFT JOIN traz os que não tem associação também*/
/*A tabela que está controlando no LEFT fica ao lado esquerdo, no RIGHT é na direita*/
/*É boa prática colocar a tabela de controle do lado esquerdo*/
/*É possível fazer LEFT e INNER juntos, ele vai fazer a primeira junção e vai juntar essa tabela resultando com a próxima*/
/*É bom pra ser usado o LEFT JOIN quando procuramos um campo que não possua valor
    - O INNER JOIN só traz o que tem em comum, é intersecção
    - O LEFT JOIN é união*/

/*Exercício 5: Quais os exames que nunca foram relizados.  /*O INNER JOIN não vai trazer os exames não realziados, para isso usamos o LEFT JOIN*/
Código	Descritivo	Valor*/

SELECT e.id_exame "Código", e.descritivo,
FORMAT(e.valor, 2, "de_DE") "Valor"
FROM exames e LEFT JOIN realiza_exames re
ON (e.id_exame = re.id_exame)
WHERE re.id_exame IS NULL;

/*O FORMAT da um formato para um número*/

/*Exercício 6: Quais os médicos que nunca realizaram nenhuma consulta.
Classificar a listagem em ordem crescente de data de nascimento (do mais velho para o mais novo ASC).
Código	Nome	Data_Nascimento(dd/mm/aaaa)		Especialidade (descritivo)*/
SELECT 	m.id_medico "Código",
		m.nome "Nome",
		DATE_FORMAT(m.data_nasc, "%d/%m/%Y") "Data_Nascimento",
		e.descritivo "Descritivo",
		a.id_atendimento "Atendimento"
FROM medicos m LEFT JOIN atendimentos a
ON (m.id_medico = a.id_medico)
INNER JOIN especialidades e
ON (m.id_especialidade = e.id_especialidade)
WHERE a.id_atendimento IS NULL
ORDER BY m.data_nasc;

/*Exercício 7: Quais os pacientes do sexo masculino que nunca realizaram exames
Código	 Nome	Sexo*/

SELECT p.id_paciente "Código", p.nome "Nome", p.sexo "Sexo", re.id_realizae "Exame"
FROM pacientes p LEFT JOIN realiza_exames re
ON (p.id_paciente = re.id_paciente)
WHERE p.sexo = "M" AND re.id_realizae IS NULL;



