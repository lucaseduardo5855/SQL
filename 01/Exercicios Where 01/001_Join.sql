-- Quais clientes mais perderam pontos por lovers?

SELECT 
       t1.IdCliente, 
       sum(t1.QtdePontos) AS TotalPontosLovers

from transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE DescCategoriaProduto = 'lovers'

GROUP BY t1.IdCliente
ORDER BY TotalPontosLovers ASC