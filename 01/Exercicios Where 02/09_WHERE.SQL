/* Lista todas as transações adiconando uma coluna nova sinalizando "alto", "médio" e "baixo" para valor dos pontos <10; <500; >= 500 */

SELECT IdTransacao, 
       QtdePontos,
       CASE 
          WHEN QtdePontos < 10 THEN 'BAIXO'
          WHEN QtdePontos < 500 THEN 'MEDIO'
          ELSE 'ALTO'
       END AS FlQtdePontos

FROM transacoes

ORDER BY QtdePontos DESC 