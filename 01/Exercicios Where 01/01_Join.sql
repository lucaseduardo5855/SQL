-- Qual categoria de produtos mais vendidos

SELECT t2.DescCategoriaProduto,
       count(DISTINCT t1.IdTransacao) AS qtDeTrasancao

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

group by t2.DescCategoriaProduto
order by count(DISTINCT t1.IdTransacao) DESC