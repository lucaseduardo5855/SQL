-- Durante o curso Quantidade de acumulado por Cliente

WITH tb_cliente_dia AS (

SELECT idCliente, 
       substr(DtCriacao, 1,10) AS DtDia,
       count(DISTINCT IdTransacao) AS qtTransacao

FROM transacoes

WHERE DtCriacao >= '2025-08-25' 
AND DtCriacao < '2025-08-30' 

GROUP BY idCliente, DtDia
)

SELECT *,
        sum(qtTransacao) OVER (PARTITION BY idCliente ORDER BY DtDia) AS AcumuladoTra
 
FROM tb_cliente_dia