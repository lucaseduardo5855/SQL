/* - Quantidade de transações Históricas (vida, d7, d14, d28, d56) 
   - Dias desde a ultima transação
   - Idade na Base
   - Saldo de pontos atual
   - Pontos acumulados Positivos (vida, d7, d14, d28, d56)
   - Pontos acumulados Negativos (vida, d7, d14, d28, d56)
   - Dias da semana mais ativos (d28)
*/ 

WITH tb_transacoes AS (

SELECT IdTransacao, 
       idCliente, 
       QtdePontos,
       datetime(substr(DtCriacao,1,19)) AS dtCriacao,
       julianday('now') - julianday(substr(DtCriacao,1,10)) AS diffDate

  from transacoes
),


tb_cliente AS (
  
  SELECT idCliente,
         datetime(substr(DtCriacao,1,19)) AS dtCriacao,
         julianday('now') - julianday(substr(DtCriacao,1,10)) AS IdadeBase

  From clientes
),

tb_sumario_transacoes AS (

SELECT idCliente,
       count(DISTINCT IdTransacao) AS QtTransacaoVida,
       count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS QtTransacaoVida56D,
       count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS QtTransacaoVida28D,
       count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS QtTransacaoVida14D,
       count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS QtTransacaoVida7D,

       min(diffDate) AS DiasUltimaInteração,

       sum(QtdePontos) AS saldoPontos,

       sum(CASE WHEN QtdePontos > 0 THEN qtdePontos ELSE 0 END) AS QtPontosPositivosVida,
       sum(CASE WHEN QtdePontos > 0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) AS QtPontosPos56,
       sum(CASE WHEN QtdePontos > 0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) AS QtPontosPos28,
       sum(CASE WHEN QtdePontos > 0 AND diffDate <= 14 THEN qtdePontos ELSE 0 END) AS QtPontosPos14,
       sum(CASE WHEN QtdePontos > 0 AND diffDate <= 7 THEN qtdePontos ELSE 0 END) AS QtPontosPos7,

       sum(CASE WHEN QtdePontos > 0 THEN qtdePontos ELSE 0 END) AS QtPontosNegVida,
       sum(CASE WHEN QtdePontos < 0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) AS QtPontosNeg56,
       sum(CASE WHEN QtdePontos < 0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) AS QtPontosNeg28,
       sum(CASE WHEN QtdePontos < 0 AND diffDate <= 14 THEN qtdePontos ELSE 0 END) AS QtPontosNeg14,
       sum(CASE WHEN QtdePontos < 0 AND diffDate <= 7 THEN qtdePontos ELSE 0 END) AS QtPontosNeg7

  FROM tb_transacoes
  GROUP BY idCliente
),

tb_join AS (

SELECT t1.*,
       t2.IdadeBase

from tb_sumario_transacoes AS t1
LEFT JOIN tb_cliente AS t2
on t1.idCliente = t2.idCliente

),

tb_transacao_produto AS (

SELECT t1.*,
       t3.DescNomeProduto,
       t3.DescCategoriaProduto

FROM tb_transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto 

)

SELECT idCliente,
       DescNomeProduto, 
       count(*) AS QtdeVida,
       count( CASE WHEN diffDate <= 56 THEN IdTransacao END) AS QtdeVida56

FROM tb_transacao_produto

GROUP BY idCliente, DescNomeProduto
