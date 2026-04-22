-- Quantidade de usuarios cadastrador (absoluto acumulado) ao longo do tempo 
-- Quando que chegamos em 3mil clientes?

WITH tb_dia_cliente AS (

  SELECT substr(DtCriacao, 1, 10) AS DtDia,
        count(DISTINCT idCliente) AS QtdeCliente

  from clientes

  GROUP BY DtDia
),

tb_soma_cliente AS (

  SELECT *,
          sum(QtdeCliente) OVER (ORDER BY DtDia) AS SomAcumuladaCliente

  from tb_dia_cliente
)

SELECT * FROM tb_soma_cliente
WHERE SomAcumuladaCliente > 3000
ORDER BY DtDia
LIMIT 1
