-- Quantidade de usuarios cadastrador (absoluto acumulado) ao longo do tempo 

WITH tb_dia_cliente AS (

  SELECT substr(DtCriacao, 1, 10) AS DtDia,
        count(DISTINCT idCliente) AS QtdeCliente

  from clientes

  GROUP BY DtDia
)

SELECT *,
        sum(QtdeCliente) OVER (ORDER BY DtDia) AS SomAcumuladaCliente

from tb_dia_cliente