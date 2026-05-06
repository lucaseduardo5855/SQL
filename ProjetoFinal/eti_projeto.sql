/* Quantidade de transações Históricas (vida, d7, d14, d28, d56) 
   Dias desde a ultima transação
*/ 

WITH tb_transacoes AS (

SELECT IdTransacao, 
       idCliente, 
       QtdePontos,
       datetime(substr(DtCriacao,1,19)) AS dtCriacao,
       julianday('now') - julianday(substr(DtCriacao,1,10)) AS diffDate

  from transacoes
)

SELECT idCliente,
       count(DISTINCT IdTransacao) AS QtTransacaoVida,
       count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS QtTransacaoVida56D,
       count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS QtTransacaoVida28D,
       count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS QtTransacaoVida14D,
       count(CASE WHEN diffDate <= 7 THEN IdTransacao END) AS QtTransacaoVida7D,
       min(diffDate) AS DiasUltimaInteração

FROM tb_transacoes

GROUP BY idCliente