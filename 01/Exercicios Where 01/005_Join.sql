-- Clientes mais antigos tem mais frequencia de transacao?

SELECT idCliente, 
       CAST(julianday('now') - julianday(substr(DtCriacao, 1, 19)) AS INT) AS DataBase

FROM clientes