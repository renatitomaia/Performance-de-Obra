USE portfolioobrasbi;
DROP VIEW IF EXISTS vw_previsto_realizado_mensal;

CREATE VIEW vw_previsto_realizado_mensal AS

WITH previsto AS (
    SELECT
        data,
        SUM(valor_previsto_mes) AS valor_previsto
    FROM fato_planejamento
    GROUP BY data
),

realizado AS (
    SELECT
        data,
        SUM(custo_realizado_mes) AS valor_realizado
    FROM fato_execucao
    GROUP BY data
)

SELECT
    c.data,
    c.ano,
    c.mes,
    c.mes_nome,
    c.ano_mes,

    COALESCE(p.valor_previsto, 0)
        AS valor_previsto,

    COALESCE(r.valor_realizado, 0)
        AS valor_realizado,

    COALESCE(r.valor_realizado, 0)
        - COALESCE(p.valor_previsto, 0)
        AS desvio_mes

FROM dim_calendario c

LEFT JOIN previsto p
    ON p.data = c.data

LEFT JOIN realizado r
    ON r.data = c.data;