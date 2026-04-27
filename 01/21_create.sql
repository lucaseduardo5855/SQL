-- Quantidade de transacoes acumuladas ao longo do tempo (diario)?


DROP TABLE IF EXISTS relatorio_diario;

CREATE TABLE IF NOT EXISTS relatorio_diario AS

  WITH tb_diario AS (

  SELECT substr(DtCriacao, 1, 10) AS DtDia,
        count(DISTINCT IdTransacao) QtTransacao

  FROM transacoes 

  GROUP BY DtDia
  ORDER BY DtDia 

),

tb_acum AS (
  SELECT *,
          sum(QtTransacao) OVER (ORDER BY DtDia) AS QtTransacaoAcum

  from tb_diario
)

SELECT * 
FROM tb_acum;

SELECT * FROM relatorio_diario;