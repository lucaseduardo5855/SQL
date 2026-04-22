-- Qual dia da semana mais ativo de casa usuario?

WITH tb_cliente_semana AS (

SELECT idCliente,
       strftime('%w', substr(DtCriacao, 1,10)) AS DtDiaSemana,
       count(DISTINCT IdTransacao) AS QtTransacao

from transacoes

GROUP BY IdCliente, DtDiaSemana

),

tb_rn AS (

SELECT *, 
        CASE 
            WHEN DtDiaSemana = '1' THEN 'SEGUNDA'
            WHEN DtDiaSemana = '2' THEN 'TERÇA'
            WHEN DtDiaSemana = '3' THEN 'QUARTA'
            WHEN DtDiaSemana = '4' THEN 'QUINTA'
            WHEN DtDiaSemana = '5' THEN 'SEXTA'
            WHEN DtDiaSemana = '6' THEN 'SABADO'
            ELSE 'DOMINGO'
            END AS descDiaSemana,

        row_number() OVER (PARTITION BY idCliente ORDER BY QtTransacao) AS DiaMaisAtivo

FROM tb_cliente_semana

)

SELECT * FROM tb_rn
WHERE DiaMaisAtivo = 1