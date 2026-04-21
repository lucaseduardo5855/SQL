-- Durante o curso Quantidade de acumulado por Cliente

WITH tb_cliente_dia AS (

SELECT idCliente, 
       substr(DtCriacao, 1,10) AS DtDia,
       count(DISTINCT IdTransacao) AS qtTransacao

FROM transacoes

WHERE DtCriacao >= '2025-08-25' 
AND DtCriacao < '2025-08-30' 

GROUP BY idCliente, DtDia
),

tb_lag AS (

SELECT *,
        sum(qtTransacao) OVER (PARTITION BY idCliente ORDER BY DtDia) AS AcumuladoTra,
        lag(qtTransacao) OVER (PARTITION BY IdCliente ORDER BY DtDia) AS LagTransacao
 
FROM tb_cliente_dia

)

SELECT *,
        1.* qtTransacao / LagTransacao

FROM tb_lag