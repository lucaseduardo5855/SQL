-- Dos clientes que iniciaram o curso de SQL no priomeiro dia, quantos chegaram ao 5 dia?

SELECT count(DISTINCT idCliente) AS Clientes5dia

FROM transacoes AS t1

WHERE t1.idCliente IN (
  SELECT DISTINCT IdCliente
  FROM transacoes
  WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
)

AND substr(t1.DtCriacao, 1, 10) = '2025-08-29'
;

SELECT count(DISTINCT idCliente)
FROM transacoes
WHERE substr(DtCriacao, 1,10) = '2025-08-25';