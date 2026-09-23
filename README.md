# Projeto 01 | Análise de Performance de Obras

## Visão geral

Este projeto apresenta um dashboard desenvolvido em **Power BI** para acompanhamento da performance física e financeira de uma obra, com foco na identificação de desvios de custo, avanço físico e cronograma.

O projeto foi construído com **dados sintéticos**, simulando o cenário de uma obra residencial, com o objetivo de demonstrar a aplicação prática de conceitos de **Business Intelligence, SQL, modelagem de dados, Power Query e DAX**.

## Problema de negócio

**Como acompanhar a saúde física e financeira de uma obra e identificar rapidamente desvios de custo e prazo?**

A proposta foi transformar dados de orçamento, planejamento e execução em informações que permitam:

* acompanhar o avanço físico planejado e realizado;
* comparar custos previstos e realizados;
* identificar desvios financeiros;
* identificar serviços com atraso;
* localizar categorias e serviços críticos;
* apoiar a análise e tomada de decisão.

## Tecnologias utilizadas

* **MySQL**
* **SQL**
* **Power Query**
* **Power BI**
* **DAX**
* **Modelagem dimensional**

## Arquitetura do projeto

O fluxo de tratamento e análise foi estruturado da seguinte forma:

**MySQL → SQL → Power Query → Modelo de Dados → DAX → Power BI**

O modelo utiliza uma estrutura em estrela, composta por dimensões e tabelas fato.

### Modelo de dados

**Dimensões**

* `dim_obra`
* `dim_servico`
* `dim_calendario`

**Tabelas fato**

* `fato_planejamento`
* `fato_execucao`

A granularidade principal do modelo é **serviço x mês**.

## Cenário analisado

Projeto fictício:

**Residencial Atlântico**
**Localização:** Fortaleza/CE
**Período:** Janeiro a Dezembro de 2026
**Orçamento:** R$ 10,5 milhões

Base sintética composta por registros de planejamento e execução de serviços da obra.

## Dashboard

O dashboard foi dividido em quatro páginas:

### 01. Visão Executiva

Apresenta uma visão consolidada da situação da obra, com indicadores de:

* orçamento;
* custo realizado;
* desvio financeiro;
* avanço físico;
* desvio de avanço;
* status financeiro e físico.

Também apresenta análises por categoria e os serviços com maiores desvios.

### 02. Análise Financeira

Foco no acompanhamento financeiro da obra.

Principais análises:

* previsto x realizado por mês;
* desvio financeiro mensal;
* orçamento e custo realizado;
* desvio acumulado até a data;
* custo por categoria;
* detalhamento financeiro por serviço.

### 03. Cronograma e Avanço Físico

Foco na evolução física da obra em relação ao planejamento.

Principais análises:

* Curva S;
* avanço previsto x realizado;
* desvio de avanço;
* avanço por categoria;
* serviços com maior atraso;
* última atualização da execução.

### 04. Análise de Desvios

Página voltada à investigação dos principais pontos críticos.

Principais análises:

* maiores desvios financeiros;
* maiores atrasos físicos;
* matriz de serviços críticos;
* comparação entre desempenho financeiro e físico.

## Principais medidas DAX

Entre as métricas desenvolvidas estão:

* Orçamento Total
* Custo Realizado
* Desvio Financeiro
* Desvio Financeiro %
* Orçamento Consumido %
* Valor Previsto
* Previsto Acumulado
* Realizado Acumulado
* Avanço Previsto Ponderado
* Avanço Realizado Ponderado
* Desvio Físico
* Desvio Financeiro por Serviço
* Desvio Físico por Serviço
* Indicadores de status

As medidas foram estruturadas para separar corretamente análises **mensais, acumuladas e até a data de corte**, evitando interpretações inconsistentes dos indicadores.

## O que este projeto demonstra

Este projeto demonstra conhecimentos práticos em:

**SQL**

* consultas;
* filtros;
* `JOIN`;
* criação e manipulação de tabelas;
* organização dos dados para análise.

**Power BI**

* modelagem de dados;
* Power Query;
* criação de indicadores;
* construção de dashboards;
* filtros e interações;
* formatação condicional;
* análise de desempenho.

**DAX**

* medidas;
* indicadores percentuais;
* acumulados;
* cálculos ponderados;
* análise por período;
* desvios financeiros e físicos.

## Resultado

O dashboard transforma dados operacionais de obra em uma visão analítica capaz de responder rapidamente:

**Quanto foi planejado?**
**Quanto foi realizado?**
**Qual é o desvio?**
**Estamos atrasados?**
**Quais categorias apresentam maior impacto?**
**Quais serviços precisam de atenção?**

## Observação

Todos os dados utilizados neste projeto são **fictícios e sintéticos**, desenvolvidos exclusivamente para fins de estudo e portfólio.

## Autor

**Renato Maia**

Projeto desenvolvido como parte do processo de construção de portfólio em **Dados e Business Intelligence**.
