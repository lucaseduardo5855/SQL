-- Qual o dia da semana mais ativo de cada usuario?

-- idCliente
-- DtCriacao

-- IdTransacao


SELECT 
      t1.idCliente, 
      count(t1.IdTransacao),
      CASE strftime('%w', substr(t1.DtCriacao, 1,10)) 
        WHEN '0' THEN 'Domingo'
        WHEN '1' THEN 'Segunda'
        WHEN '2' THEN 'Terça'
        WHEN '3' THEN 'Quarta'
        WHEN '4' THEN 'Quinta'
        WHEN '5' THEN 'Sexta'
        WHEN '6' THEN 'Sábado'
        END AS DiaSemana

FROM transacoes AS t1

GROUP BY t1.idCliente, DiaSemana