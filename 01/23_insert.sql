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

INSERT INTO relatorio_diario

SELECT * 
FROM tb_acum;

SELECT * from relatorio_diario;