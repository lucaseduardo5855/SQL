-- qual valor medio dos pontos positivos por dia?

SELECT sum(QtdePontos) AS TotalPontos,
       count(substr(DtCriacao, 1, 10)) AS DataCriacao,

       count(DISTINCT substr(DtCriacao, 1, 10)) AS DataCriacaoUnica,

       sum(QtdePontos) / count(DISTINCT substr(DtCriacao, 1, 10)) AS MediaPontosPositivos

from transacoes

WHERE QtdePontos > 0