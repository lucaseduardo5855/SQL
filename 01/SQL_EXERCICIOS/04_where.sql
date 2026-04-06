--selecione produtos q tem 'churn' no nome

SELECT * from produtos WHERE DescNomeProduto IN('Botas de Força', 'Botas de Lava', 'Botas de Veludo')

--WHERE DescNomeProduto = 'Botas de Força'OR DescNomeProduto = 'Botas de Lava' OR DescNomeProduto = 'Botas de Veludo'