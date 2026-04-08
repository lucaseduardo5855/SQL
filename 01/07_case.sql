-- intervalos 
-- De 0 A 500 -> ponei 
-- De 501 a 1000 -> ponei Premium
-- de 1001 a 5000 -> mago aprendiz
-- de 5001 a 10000 -> mago mestre
-- +10001 -> mago supremo

SELECT qtdePontos, idCliente, CASE 
  WHEN qtdePontos <= 500 THEN 'Ponei' 
  WHEN QtdePontos <= 1001 THEN 'Ponei Premium' 
  WHEN QtdePontos <= 5000 THEN 'Mago aprendiz'
  WHEN QtdePontos <= 10000 THEN 'Mago Mestre'
  ELSE 'Mago Supremo'
END AS GRUPO,

CASE 
WHEN QtdePontos <= 1000 THEN 1
  ELSE 0
END AS flPonei,

CASE
  WHEN QtdePontos > 1001 THEN 1
  ELSE 0
END AS flMago

FROM clientes ORDER BY QtdePontos DESC

