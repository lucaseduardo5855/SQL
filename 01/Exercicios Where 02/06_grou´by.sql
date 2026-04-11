-- Qual dia da semana que mais teve pedido em 2025

SELECT 
       strftime('%w',substr(DtCriacao, 1,10)) AS DiaSemana,
       count(DISTINCT IdTransacao) AS QtTransacao

FROM transacoes

WHERE substr(DtCriacao, 1, 4) = '2025'

GROUP BY 1
