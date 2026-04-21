-- Dentre os clientes de janeiro quantos assistiram o curso de SQL?

WITH tb_clientes_jan AS (

SELECT DISTINCT idCliente
FROM transacoes
WHERE DtCriacao >= '2025-01-01' 
AND DtCriacao <= '2025-01-31'

),

tb_curso_sql AS (

  SELECT DISTINCT 
    IdCliente,
    substr(DtCriacao, 1, 10) DiasCurso
  FROM transacoes
  WHERE DtCriacao >= '2025-08-25' 
  AND DtCriacao < '2025-08-30'

)

SELECT count(DISTINCT t1.idCliente) as QtdAlunosSql
from tb_clientes_jan AS t1
INNER JOIN tb_curso_sql AS t2
ON t1.idCliente = t2.idCliente


