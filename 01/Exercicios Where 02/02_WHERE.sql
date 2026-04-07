/* Lista de pedidos realizados no fim de semana*/
SELECT  IdTransacao, DtCriacao,

    strftime('%w', datetime(substr(DtCriacao, 1, 19))) AS DiasSemana

FROM transacoes

    WHERE DiasSemana IN ('6', '0')
