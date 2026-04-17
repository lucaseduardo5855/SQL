-- Clientes mais antigos tem mais frequencia de transacao?

SELECT t1.idCliente, 
       julianday('now') - julianday(substr(t1.DtCriacao, 1, 19)) AS IdadeBase,
       count(t2.IdTransacao) AS QtdeTransacoes

FROM clientes AS t1

LEFT JOIN transacoes AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t1.idCliente, IdadeBase