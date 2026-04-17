-- Quais cliente assinaram lista de presença 25/08/25

SELECT 
t1.idCliente,
count(*)

FROM transacoes AS t1

LEFT JOIN transacao_produto as T2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE substr(t1.DtCriacao, 1,10) = '2025-08-25'
AND t3.DescNomeProduto = 'Lista de presença'

GROUP BY t1.idCliente