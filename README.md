# Projeto 01 — Análise de Performance de Obras | SQL + Power BI

## Objetivo
Construir uma solução de Business Intelligence para acompanhar a performance física e financeira de uma obra fictícia, comparando planejamento e execução.

## Pergunta de negócio
**Como acompanhar a saúde física e financeira de uma obra e identificar rapidamente desvios de custo e prazo?**

## Cenário
- Obra fictícia: **Residencial Atlântico**
- Local: Fortaleza/CE
- Orçamento: **R$ 10,5 milhões**
- Período: **jan/2026 a dez/2026**
- 30 serviços distribuídos em macroetapas
- Dados 100% sintéticos, criados exclusivamente para portfólio

## Tecnologias
- SQL Server / T-SQL
- Power BI
- Power Query
- DAX

## Modelo
Dimensões:
- `dim_obra`
- `dim_servico`
- `dim_calendario`

Fatos:
- `fato_planejamento`
- `fato_execucao`

Granularidade: serviço x mês.

## Passos
1. Executar `01_criar_banco_mysql`.
2. Ajustar o caminho em `02_popular_dados_mysql`.
3. Executar a importação dos CSVs.
4. Executar `03_consultas_analiticas_mysql`.
5. Conectar o Power BI ao banco `PortfolioObrasBI`.
6. Modelar os relacionamentos.
7. Criar medidas DAX.
8. Montar as páginas do dashboard.
9. Documentar insights e publicar no GitHub.

## Páginas previstas
- Visão Executiva
- Financeiro
- Cronograma e Avanço Físico
- Análise de Desvios

> Nenhum dado real de clientes ou empregadores foi utilizado.
