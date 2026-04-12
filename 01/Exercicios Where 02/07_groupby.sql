-- Qual o produto mais transicionado?

SELECT IdProduto, 
       count(*) as TransicaoProduto

FROM transacao_produto

GROUP BY IdProduto
ORDER BY count(*) DESC
