-- De quanto em quanto tempo o pessoal volta para ver o Curso SQL?

WITH tb_dia_cliente AS (

SELECT 
      IdCliente,
      substr(DtCriacao, 1, 10) AS DtDia,
      COUNT(DISTINCT idTransacao) AS QtTransacoes

 from transacoes

WHERE DtCriacao >= '2025-08-25' 
AND DtCriacao < '2025-08-30' 

GROUP BY idCliente, DtDia

),

tb_lag AS (

  SELECT *,
          sum(QtTransacoes) OVER (PARTITION BY idCliente ORDER BY DtDia) AS AcumuladorTran,
          lag(QtTransacoes) OVER (PARTITION BY idCliente ORDER BY DtDia) AS LagTransac

from tb_dia_cliente

)

SELECT *, 
        1.* QtTransacoes / LagTransac
FROM tb_lag