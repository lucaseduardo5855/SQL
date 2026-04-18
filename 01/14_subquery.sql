-- Lista de transacoes com produto "Chapéu do Ladino"


SELECT * 

FROM transacao_produto AS t1

Where t1.IdProduto IN (
  SELECT IdProduto  
  From produtos
  WHERE DescNomeProduto = 'Chapéu do Ladino'
)