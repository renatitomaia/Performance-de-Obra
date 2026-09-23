# Projeto 01 - Scripts MySQL

Este pacote converte o Projeto 01 para MySQL 8+.

## Ordem de execução

1. Abra `01_criar_banco_mysql.sql`
2. Execute o script completo
3. Confirme que as 5 tabelas foram criadas
4. Importe os CSVs
5. Execute `03_consultas_analiticas_mysql.sql`

## Importação dos CSVs

Você tem duas opções.

### Opção A - Table Data Import Wizard
Mais simples para começar no MySQL Workbench.

Para cada tabela:

- botão direito na tabela
- Table Data Import Wizard
- selecione o CSV correspondente
- confirme `;` como delimitador
- confira o mapeamento das colunas

Importe nesta ordem:

1. dim_obra
2. dim_servico
3. dim_calendario
4. fato_planejamento
5. fato_execucao

A ordem importa por causa das foreign keys.

### Opção B - SQL

Use `02_importar_csvs_mysql.sql`.

Troque:

`C:/CAMINHO/Projeto_01_Performance_Obras/`

pelo caminho real da pasta dos CSVs.

Se `LOAD DATA LOCAL INFILE` estiver bloqueado, use o Wizard acima.

## Resultado esperado

- 1 obra
- 30 serviços
- 12 registros de calendário
- 101 registros de planejamento
- 96 registros de execução
- orçamento total dos serviços: 10.500.000
- custo realizado total: aproximadamente 10.839.347,82
