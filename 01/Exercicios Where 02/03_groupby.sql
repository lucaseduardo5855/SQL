-- Qual cliente fez mais transacoes no ano de 2024

-- WHERE strftime('%Y', substr(DtCriacao, 1, 19)) = '2024'

SELECT IdCliente,
       count(DISTINCT IdTransacao)
    
FROM transacoes

WHERE DtCriacao >= '2024-01-01' AND DtCriacao < '2025-01-01'

GROUP BY idCliente

ORDER BY count(DISTINCT IdTransacao) DESC

LIMIT 1