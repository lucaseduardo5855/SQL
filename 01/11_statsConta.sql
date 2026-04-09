SELECT 
        round(avg(QtdePontos),2) AS MediaCarteira, 
        sum(QtdePontos) / count(idCliente) AS MediaCarteiraRoots,

        min(QtdePontos) AS minCarteira,
        max(QtdePontos) AS maxCarteira
        FROM clientes