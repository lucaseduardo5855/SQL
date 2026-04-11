-- quantos produtos sao rpg?

SELECT count(*)
FROM produtos
WHERE DescCategoriaProduto = 'rpg';


SELECT DescCategoriaProduto,
count(*)
From produtos
GROUP BY DescCategoriaProduto;