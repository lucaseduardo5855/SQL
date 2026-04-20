-- 11 - Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?

WITH tb_primeiro_dia AS (
  
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_dias_curso AS (
 
  SELECT DISTINCT 
        idCliente, 
        substr(DtCriacao, 1,10) AS PresenteDia
  FROM transacoes
  WHERE DtCriacao >= '2025-08-25'
  AND DtCriacao < '2025=08-30'

  ORDER BY idCliente, PresenteDia
),

tb_cliente_dias AS (

SELECT t1.idCliente,
       count(DISTINCT t2.PresenteDia) AS QtDeDias

FROM tb_primeiro_dia AS t1

LEFT JOIN tb_dias_curso AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t1.idCliente

)

SELECT avg(QtDeDias) FROM tb_cliente_dias