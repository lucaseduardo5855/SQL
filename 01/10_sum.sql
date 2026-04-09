SELECT Sum(QtdePontos), 

  Sum(CASE
      WHEN QtdePontos > 0 THEN QtdePontos
  END) AS QtdePontosPositivos,

  sum(CASE
    WHEN QtdePontos < 0 THEN QtdePontos
  END) AS QtdePontosNegativos

FROM transacoes 

WHERE DtCriacao >= '2025-07-01' AND DtCriacao < '2025-98-01'

ORDER BY QtdePontos





