-- Qual o produto mais transicionado?

SELECT IdProduto,
       count(*)

 FROM transacao_produto

 GROUP BY IdProduto
 ORDER BY count(*) DESC

