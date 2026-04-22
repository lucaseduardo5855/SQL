-- Saldo de pontos acumulado de cada usuario

WITH tb_cliente_dia AS (

SELECT idCliente,
       substr(DtCriacao, 1,10) AS DtDia,
       sum(QtdePontos) AS TotalPontos

from transacoes

GROUP BY idCliente, DtDia

)

SELECT *,
        sum(TotalPontos) OVER (PARTITION BY idCliente ORDER BY DtDia) AS SaldoPontos

FROM tb_cliente_dia