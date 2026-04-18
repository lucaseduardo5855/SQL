-- Quantidade de usuarios cadastrados (absoluto e acumulado) ao longo do tempo?

SELECT 
       substr(DtCriacao, 1,10) AS DataCriacao,
       count(idCliente) AcumIdCliente,
       sum(count(IdCliente)) OVER (ORDER BY substr(DtCriacao, 1,10)) AS CadastroAcum

FROM Clientes
GROUP BY DataCriacao