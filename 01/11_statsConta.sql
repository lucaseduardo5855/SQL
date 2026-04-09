SELECT 
        round(avg(QtdePontos),2) AS MediaCarteira, 
        sum(QtdePontos) / count(idCliente) AS MediaCarteiraRoots,

        min(QtdePontos) AS minCarteira,
        max(QtdePontos) AS maxCarteira,

        sum(flTwitch) AS QtPtwitch,
        sum(flEmail) AS QtPEmail
        
        FROM clientes