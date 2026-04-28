SELECT * from relatorio_diario;

update relatorio_diario
SET QtTransacao = 10000
WHERE DtDia >= '2025-08-25';

SELECT * from relatorio_diario;