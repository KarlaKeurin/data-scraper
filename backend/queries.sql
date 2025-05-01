-- Consultas para obter os 10 maiores valores de despesa por operadora no último trimestre 
WITH ultimo_trimestre AS (
    SELECT 
        MAX(data) AS ultima_data
    FROM demonstracoes_contabeis
)
SELECT 
    reg_ans AS operadora,
    SUM(vl_saldo_final) AS total_despesa
FROM demonstracoes_contabeis
JOIN ultimo_trimestre ON 
    data >= DATE_SUB(ultima_data, INTERVAL 3 MONTH) 
    AND data <= ultima_data
WHERE descricao LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
GROUP BY reg_ans
ORDER BY total_despesa DESC
LIMIT 10;

-- Consultas para obter os 10 maiores valores de despesa por operadora no último ano
WITH ultimo_ano AS (
    SELECT 
        MAX(data) AS ultima_data
    FROM demonstracoes_contabeis
)
SELECT 
    reg_ans AS operadora,
    SUM(vl_saldo_final) AS total_despesa
FROM demonstracoes_contabeis
JOIN ultimo_ano ON 
    data >= DATE_SUB(ultima_data, INTERVAL 1 YEAR) 
    AND data <= ultima_data
WHERE descricao LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
GROUP BY reg_ans
ORDER BY total_despesa DESC
LIMIT 10;