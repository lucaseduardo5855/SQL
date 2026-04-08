/*Lista todas as transações adicionando uma coluna nova sinalizando "alto", "médio" e "baixo" para o valor dos pontos < 10; < 500; >= 500 */

SELECT *, 
CASE 
WHEN QtdePontos <= 10 THEN 'Baixo'
WHEN QtdePontos <= 500 THEN 'Médio'
WHEN QtdePontos >= 500 THEN 'Alto'
END AS Categorias 
FROM transacoes 
ORDER BY QtdePontos DESC