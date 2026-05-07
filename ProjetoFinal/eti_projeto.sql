/* - Quantidade de transações Históricas (vida, d7, d14, d28, d56) 
   - Dias desde a ultima transação
   - Idade na Base
   - Saldo de pontos atual
   - Pontos acumulados Positivos (vida, d7, d14, d28, d56)
   - Pontos acumulados Negativos (vida, d7, d14, d28, d56)
   - Dias da semana mais ativos (d28)
   - Produtos mais usados (vida, d7, d14, d28, d56)
   - Dia da semana mais ativo (d28)
   - Periodo mais ativo 
   - Engajamento em D28 versus Vida
*/ 

WITH tb_transacoes AS (

SELECT IdTransacao, 
       idCliente, 
       QtdePontos,
       datetime(substr(DtCriacao,1,19)) AS dtCriacao,
       julianday('now') - julianday(substr(DtCriacao,1,10)) AS diffDate,
       CAST(strftime('%H', DtCriacao) AS INT) AS DtHora

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

tb_transacao_produto AS (

SELECT t1.*,
       t3.DescNomeProduto,
       t3.DescCategoriaProduto

FROM tb_transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto 

),


tb_cliente_produto AS (

SELECT idCliente,
       DescNomeProduto, 
       count(*) AS QtdeVida,
       count( CASE WHEN diffDate <= 56 THEN IdTransacao END) AS QtdeVida56,
       count( CASE WHEN diffDate <= 28 THEN IdTransacao END) AS QtdeVida28,
       count( CASE WHEN diffDate <= 14 THEN IdTransacao END) AS QtdeVida14,
       count( CASE WHEN diffDate <= 7 THEN IdTransacao END) AS QtdeVida7

FROM tb_transacao_produto

GROUP BY idCliente, DescNomeProduto

),

tb_cliente_produto_rn AS (

SELECT *,
        row_number( ) OVER (PARTITION BY idCliente ORDER BY QtdeVida DESC) AS rnVida,
        row_number( ) OVER (PARTITION BY idCliente ORDER BY QtdeVida56 DESC) AS rnVida56,
        row_number( ) OVER (PARTITION BY idCliente ORDER BY QtdeVida28 DESC) AS rnVida28,
        row_number( ) OVER (PARTITION BY idCliente ORDER BY QtdeVida14 DESC) AS rnVida14,
        row_number( ) OVER (PARTITION BY idCliente ORDER BY QtdeVida7 DESC) AS rnVida7


FROM tb_cliente_produto

),

tb_cliente_dia AS (

SELECT idCliente, 
       strftime('%w', DtCriacao) AS DtDia,
       count(*) AS qtdTransacao
 
FROM tb_transacoes

WHERE diffDate <= 300
GROUP BY idCliente, DtDia

),

tb_cliente_dia_rn AS ( 

SELECT *,
        row_number () OVER (PARTITION BY idCliente ORDER BY qtdTransacao) AS rnDia

FROM tb_cliente_dia

),

tb_cliente_periodo AS (

SELECT 
       idCliente,
       CASE 
         WHEN DtHora BETWEEN 7 and 12 THEN 'MANHA'
         WHEN DtHora BETWEEN 13 and 18 THEN 'TARDE'
         WHEN DtHora BETWEEN 19 and 23 THEN 'NOITE'
         ELSE 'MADRUGADA'
         END AS Periodo,
         count(*) AS qtdeTransacao

from tb_transacoes

GROUP BY 1,2

),


tb_cliente_periodo_rn AS (

SELECT *,
       row_number() OVER (PARTITION BY idCliente ORDER BY qtdeTransacao DESC) AS rnPeriodo

FROM tb_cliente_periodo 

),

tb_join AS (

SELECT t1.*,
       t2.IdadeBase,
       t3.DescNomeProduto AS ProdutoVida,
       t4.DescNomeProduto AS Produto56,
       t5.DescNomeProduto AS Produto28,
       t6.DescNomeProduto AS Produto14,
       t7.DescNomeProduto AS Produto7,
       COALESCE(t8.DtDia, -1) AS DtDia,
       t9.Periodo

from tb_sumario_transacoes AS t1

LEFT JOIN tb_cliente AS t2
on t1.idCliente = t2.idCliente

LEFT JOIN tb_cliente_produto_rn AS t3
ON t1.idCliente = t3.idCliente
AND t3.rnVida = 1

LEFT JOIN tb_cliente_produto_rn AS t4
ON t1.idCliente = t4.idCliente
AND t4.rnVida56 = 1

LEFT JOIN tb_cliente_produto_rn AS t5
ON t1.idCliente = t5.idCliente
AND t5.rnVida28 = 1

LEFT JOIN tb_cliente_produto_rn AS t6
ON t1.idCliente = t6.idCliente
AND t6.rnVida14 = 1

LEFT JOIN tb_cliente_produto_rn AS t7
ON t1.idCliente = t7.idCliente
AND t7.rnVida7 = 1

LEFT JOIN tb_cliente_dia_rn AS t8
on t1.idCliente = t8.idCliente
AND t8.rnDia = 1

LEFT JOIN tb_cliente_periodo_rn AS t9
ON t1.idCliente = t9.idCliente
AND t9.rnPeriodo = 1

)

SELECT *,
        1. * QtTransacaoVida28D / QtTransacaoVida AS engajamento28Vida

FROM tb_join