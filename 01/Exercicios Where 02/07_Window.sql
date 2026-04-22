-- Qual dia da semana mais ativo de casa usuario?

WITH tb_cliente_semana AS (

SELECT idCliente,
       strftime('%w', substr(DtCriacao, 1,10)) AS DtDiaSemana,
       count(DISTINCT IdTransacao) AS QtTransacao

from transacoes

GROUP BY idCliente, DtDiaSemana
)

SELECT *,
        row_number() OVER (PARTITION BY idCliente ORDER BY QtTransacao DESC) AS rn

 FROM tb_cliente_semana