-- Qual produto com mais pontos transicionados?

SELECT IdProduto, 
       sum(vlProduto * QtdeProduto) AS TotalPontosProduto,
       sum(QtdeProduto) AS QtDeVendas

FROM transacao_produto

GROUP BY IdProduto
ORDER BY sum(vlProduto) DESC