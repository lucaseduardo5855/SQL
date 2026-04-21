-- De quanto em quanto tempo o pessoal volta para ver o Curso SQL?

WITH cliente_dia AS ( 

  SELECT 
        DISTINCT idCliente, 
        substr(DtCriacao, 1,10) AS dtDia

  FROM transacoes
  WHERE substr(DtCriacao, 1,4) = '2025'
  ORDER BY IdCliente, dtDia

),

tb_lag AS (

SELECT *,
        lag(dtDia) OVER (PARTITION BY idCliente ORDER BY dtDia) AS lagDia
FROM cliente_dia

),

tb_diff_dt AS (

SELECT *,
        julianday(lagDia)- julianday(dtDia) AS DtDif
from tb_lag

)

SELECT idCliente, avg(DtDif)

from tb_diff_dt
GROUP BY idCliente