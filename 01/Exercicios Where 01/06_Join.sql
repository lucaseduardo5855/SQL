-- Quantidade de transacoes Acumuladas ao longo do tempo

SELECT count(DISTINCT t1.IdTransacao) AS TransaoAcumulada,
       substr(DtCriacao, 1,10) AS DataCriacao

 FROM transacoes AS t1

GROUP BY DataCriacao