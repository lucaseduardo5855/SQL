-- 2025-08-25 a 2025-08-29 quantos clientes assinaram a lista de presença

SELECT count(DISTINCT t1.idCliente),
       t3.DescNomeProduto

FROM transacoes AS t1
  
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-29'
AND t3.DescNomeProduto = 'Lista de presença'

