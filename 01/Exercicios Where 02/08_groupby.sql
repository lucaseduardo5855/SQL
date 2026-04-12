-- Qual produto com mais pontos transicionados?

SELECT IdProduto, 
       sum(vlProduto) AS TotalPontosProduto

FROM transacao_produto

GROUP BY IdProduto
ORDER BY sum(vlProduto) DESC