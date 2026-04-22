-- Quantidade de transacoes acumuladas ao longo do tempo (diario)?
-- Quando que chegamos a 100mil transações? 

WITH tb_diario AS (

SELECT substr(DtCriacao, 1, 10) AS DtDia,
       count(DISTINCT IdTransacao) QtTransacao

FROM transacoes 

GROUP BY DtDia
ORDER BY DtDia 

),

tb_acum AS (

SELECT *,
        sum(QtTransacao) OVER (ORDER BY DtDia) AS QtTransacaoAcum

from tb_diario
)

SELECT * 
FROM tb_acum
WHERE QtTransacaoAcum > 100000
ORDER BY QtTransacaoAcum
limit 1