-- DROP TABLE IF EXISTS clientes_d28;

CREATE TABLE IF NOT EXISTS clientes_d28 (
    IdCliente varchar(250) PRIMARY KEY,
    Qtdetransacoes INTEGER
);

DELETE FROM clientes_d28;

-- Aqui entra a mágica: O comando INSERT jogando o resultado do SELECT para dentro da tabela
INSERT INTO clientes_d28
SELECT IdCliente,
       count(DISTINCT IdTransacao) AS Qtdetransacoes
FROM transacoes

-- Trocamos o 'now' pela data limite exata que você encontrou!
WHERE julianday('2026-03-31') - julianday(substr(DtCriacao, 1, 10)) <= 28
GROUP BY IdCliente;

SELECT * FROM clientes_d28;