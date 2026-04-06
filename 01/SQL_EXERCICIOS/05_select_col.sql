SELECT idCliente, 
        -- qtdePontos,
        -- QtdePontos + 10 AS QtdePontosPlus10, 
        -- qtdePontos * 2 AS QtdePontosDouble,
        DtCriacao,

        datetime(substr(DtCriacao, 1, 19)) AS dtCriacaoNova,
        datetime(substr(DtCriacao, 1, 19), '+1 year') AS MaisUmAno,
        strftime('%d', datetime(substr(DtCriacao, 1, 19))) AS diaSemana

FROM clientes


