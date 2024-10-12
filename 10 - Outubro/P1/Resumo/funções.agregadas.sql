/* Funções agregadas - Agregamento */
/*  SUM(parametro) - numérico - soma valores 
    AVG(parametro) - numérico - média aritmética
    COUNT(parametro) - id - contador de registros
    MAX(parametro) - maior elemento de um grupo
    MIN(parametro) - menor elemento de um grupo
    CURRENT_DATE() - pega a data atual
    CONCAT() - concatenar, junta string e numeros
 
    DAY() - função que extrai dia de um campo DATE
    MONTH() - função que extrai mês de um campo DATE
    YEAR() - função que extrai ano de um campo DATE
    */

/*Exemplo 1 - Calcular quantos médicos a clínica tem cadastrasdos*/

SELECT COUNT(*)
FROM medicos
WHERE sexo = "F" AND YEAR(data_nasc) > 1990;

/*Exemplo 2 - Contar quantos atendimentos forma relizados na clínica*/

/*ele vai contar tudo ONDE data_a estiver ENTRE data1 E data2*/
SELECT COUNT(*) "Número de atendimentos"
FROM atendimentos
WHERE data_a BETWEEN "2021-08-01" AND "2024-08-10";

/*Exemplo 3 - Calcular a média das idades entre todos os médicos*/
/*CURRENT_DATE()*/

/*Aqui nós estamos extraindo o ANO da DATA ATUAL menos o ANO da DATA DE NASCIMENTO dos médicos
ao mesmo tempo que fazemos uma média e formatamos o númeo
    - não precisa fazer um de cada vez*/

SELECT FORMAT(AVG(YEAR(CURRENT_DATE()) - YEAR(data_nasc)))
FROM medicos;

/*Exemplo 4 - Calcular a média dos valores de exames cadastrados*/

SELECT CONCAT(FORMAT(AVG(valor), 2, "de_DE")) "Média dos valores de exames"
FROM exames;

/*Exemplo 5 - Calcular o faturamento total de atendimentos da clínica*/

SELECT CONCAT(FORMAT(COUNT(*)*250, 2, "de_DE")) "Número de atendimentos"
FROM atendimentos;