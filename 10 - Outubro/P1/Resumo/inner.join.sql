/*Vamos relembrar o UPDATE, INNER JOIN, DATA FORMAT*/

UPDATE exames SET valor = valor*2
WHERE valor < 200;

/*INNER JOIN*/
/*O INNER JOIN só pode ser feito entre tabelas que estejam relacionadas por atributos*/

/*Exemplos*/
SELECT * FROM tabela1 INNER JOIN tabela2
ON (tabela1.campo = tabela2.campo)

SELECT  m.id_medico "Código",
        m.nome "Nome",
        e.descritivo "Especialidade"
FROM medicos m INNER JOIN especialidades e
ON (m.id_especialidade=e.id_especialidade);


/*DATA FORMAT*/
DATE_FORMAT(campo datax, "%d/%m/%Y") /*isso é um layout - %Y mostra o ano completo, %y mostra apenas os dois últimos digitos do ano*/

/*Exemplos*/
SELECT  m.id_medico "Codigo", m.nome "Nome",   /*Tudo isso entre aspas é o alias*/
DATE_FORMAT(a.data_a,"%d/%m/Y") "Data_Consulta", a.horario_a "Horário_Consulta"
FROM medicos m INNER JOIN atendimentos a
ON (m.id_medico = a.id_medico);

/*Estamos pegando o campo (a.data_a) e definindo
no formato dia, mes e ano (apenas os dois ultimos números do ano)*/
