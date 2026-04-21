-- Qual o dia com maior engajamento de cada aluno que iniciou o curso do dia 01

-- ENTROU DIA 1
-- QUAL DIA MAIS ELA TRANSITOU
-- 25 a dia 29 do 8

WITH tb_id_diaUm AS (

  SELECT DISTINCT idCliente
  FROM transacoes
  WHERE substr(DtCriacao, 1,10) = '2025-08-25' 

),

tb_engajamento AS (

  SELECT idCliente,
         substr(DtCriacao, 1,10) AS Dia,
         count(DISTINCT IdTransacao) AS QtEngajamento
  FROM transacoes
  WHERE substr(DtCriacao, 1,10) >= '2025-08-25' AND substr(DtCriacao, 1,10) <= '2025-08-29' 

GROUP BY idCliente, Dia

)

SELECT * from tb_id_diaUm AS t1 INNER JOIN tb_engajamento AS t2
ON t1.idCliente = t2.idCliente