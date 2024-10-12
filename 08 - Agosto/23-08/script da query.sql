/* COMANDOS DML */

UPDATE exames SET valor = valor*1.10
WHERE valor < 200;

UPDATE pacientes SET cidade = "Rio de Janeiro", bairro = "Ipanema"
WHERE id_paciente =1;

/* INNER JOIN = junção */

/* Só traz relacionamentos que existem*/

SELECT * FROM tabela1 INNER JOIN tabela2
ON (tabela1.campo = tabela2.campo) /*isso é onde eles se ligam - tem o mesmo valor*/


SELECT * FROM medicos m INNER JOIN especialidades e
ON (m.id_especialidade = e.id_especialidade);  /*precisa ser uma PK com uma FK*/

SELECT m.id_medico "Código", m.nome "Nome", e.descritivo "Especialidade"
FROM medicos m INNER JOIN especialidades e
ON (m.id_especialidade=e.id_especialidade);     /*o 'm' e o 'e' são alias - a partir do momento que criamos alias não podemos usar mais o nome da tabela*/

/*Exercício 1: Listar todas as consultar realizadas pelos médicos*/
DATE_FORMAT(campo datax, "%d/%m/%Y")  /*isso é um layout - %Y mostra o ano completo, %y mostra apenas os dois últimos digitos do ano*/
Código Nome Sexo Data_Consulta Horário_Consulta 

SELECT * FROM atendimentos a INNER JOIN medicos m
ON (a.id_medico = m.id_medico);

/*Resposta exercício 1*/
SELECT  m.id_medico "Codigo", m.nome "Nome",   /*Tudo isso entre aspas é o alias*/
DATE_FORMAT(a.data_a,"%d/%m/Y") "Data_Consulta", a.horario_a "Horário_Consulta"
FROM medicos m INNER JOIN atendimentos a
ON (m.id_medico = a.id_medico);

/*ordenar a tabela pelo campo*/
ORDER BY id_medico;  /*ele entende automaticamente que é do menor pro maior*/

SELECT  m.id_medico "Codigo", m.nome "Nome", 
DATE_FORMAT(a.data_a,"%d/%m/%y") "Data_Consulta", a.horario_a "Horário_Consulta"
FROM medicos m INNER JOIN atendimentos a
ON (m.id_medico = a.id_medico)
ORDER BY m.id_medico, a.data_a, a.horario_a;

/*Exercício 2: Listar todos as consultas realizadas pelos pacientes femininos*/

SELECT p.id_paciente "Código", p.nome "Nome", p.sexo "Sexo",
DATE_FORMAT(a.data_a, "%d/%m/%y") "Data_Consulta", a.horario_a "Horário_Consulta"
FROM pacientes p INNER JOIN atendimentos a
ON (p.id_paciente = a.id_paciente)
WHERE p.sexo = "F"
ORDER BY p.id_paciente, a.data_a, a.horario_a;

/*Organizado*/
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

/*LEFT/RIGHT JOIN*/
/*O LEFT JOIN traz os que não tem associação também*/
/*A tabela que está controlando no LEFT fica ao lado esquerdo, no RIGHT é na direita*/
/*É boa prática colocar a tabela de controle do lado esquerdo*/
/*É possível fazer LEFT e INNER juntos, ele vai fazer a primeira junção e vai juntar essa tabela resultando com a próxima*/

/*Exercício 5: Quais os exames que nunca foram relizados.  /*O INNER JOIN não vai trazer os exames não realziados, para isso usamos o LEFT JOIN*/
Código	Descritivo	Valor*/

SELECT e.id_exame "Código", e.descritivo,
FORMAT(e.valor, 2, "de_DE") "Valor"
FROM exames e LEFT JOIN realiza_exames re
ON (e.id_exame = re.id_exame)
WHERE re.id_exame IS NULL;

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


