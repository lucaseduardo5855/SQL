-- Saldo de pontos acumulados de cada user

-- IdCliente
-- QtdePontos

-- transacao_produto
-- vlProduto

SELECT 
      t1.idCliente, 
      sum(t2.vlProduto) AS SomProduto

from transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.idTransacao = t2.idTransacao

GROUP BY t1.idCliente
