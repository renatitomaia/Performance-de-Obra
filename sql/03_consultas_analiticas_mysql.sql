USE PortfolioObrasBI;

-- 1. Resumo financeiro por categoria
SELECT
    s.categoria,
    ROUND(SUM(s.orcamento_servico), 2) AS orcamento_categoria,
    ROUND(SUM(e.custo_realizado_mes), 2) AS custo_realizado,
    ROUND(SUM(e.custo_realizado_mes) - SUM(s.orcamento_servico), 2) AS desvio_financeiro
FROM dim_servico s
LEFT JOIN fato_execucao e
    ON e.id_servico = s.id_servico
GROUP BY s.categoria
ORDER BY desvio_financeiro DESC;


-- 2. Previsto x realizado por mês
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
    c.ano_mes,
    ROUND(COALESCE(p.valor_previsto, 0), 2) AS valor_previsto,
    ROUND(COALESCE(r.valor_realizado, 0), 2) AS valor_realizado,
    ROUND(
        COALESCE(r.valor_realizado, 0) - COALESCE(p.valor_previsto, 0),
        2
    ) AS desvio_mes
FROM dim_calendario c
LEFT JOIN previsto p
    ON p.data = c.data
LEFT JOIN realizado r
    ON r.data = c.data
ORDER BY c.data;


-- 3. Top 10 serviços com maior estouro de custo
SELECT
    s.categoria,
    s.servico,
    ROUND(s.orcamento_servico, 2) AS orcamento_servico,
    ROUND(SUM(e.custo_realizado_mes), 2) AS custo_realizado,
    ROUND(SUM(e.custo_realizado_mes) - s.orcamento_servico, 2) AS desvio_valor,
    ROUND(
        (
            SUM(e.custo_realizado_mes) /
            NULLIF(s.orcamento_servico, 0)
            - 1
        ) * 100,
        2
    ) AS desvio_pct
FROM dim_servico s
JOIN fato_execucao e
    ON e.id_servico = s.id_servico
GROUP BY
    s.id_servico,
    s.categoria,
    s.servico,
    s.orcamento_servico
ORDER BY desvio_valor DESC
LIMIT 10;


-- 4. Avanço final previsto x realizado por serviço
WITH plan_max AS (
    SELECT
        id_servico,
        MAX(avanco_previsto_acum_pct) AS avanco_previsto
    FROM fato_planejamento
    GROUP BY id_servico
),
exec_max AS (
    SELECT
        id_servico,
        MAX(avanco_realizado_acum_pct) AS avanco_realizado
    FROM fato_execucao
    GROUP BY id_servico
)
SELECT
    s.categoria,
    s.servico,
    p.avanco_previsto,
    e.avanco_realizado,
    ROUND(
        e.avanco_realizado - p.avanco_previsto,
        2
    ) AS desvio_avanco_pp
FROM dim_servico s
LEFT JOIN plan_max p
    ON p.id_servico = s.id_servico
LEFT JOIN exec_max e
    ON e.id_servico = s.id_servico
ORDER BY desvio_avanco_pp;


-- 5. Base integrada para exploração e Power BI
SELECT
    c.data,
    c.ano_mes,
    s.categoria,
    s.servico,
    p.valor_previsto_mes,
    p.avanco_previsto_acum_pct,
    e.custo_realizado_mes,
    e.avanco_realizado_acum_pct,
    e.status_execucao
FROM dim_calendario c
CROSS JOIN dim_servico s
LEFT JOIN fato_planejamento p
    ON p.data = c.data
    AND p.id_servico = s.id_servico
LEFT JOIN fato_execucao e
    ON e.data = c.data
    AND e.id_servico = s.id_servico
ORDER BY
    c.data,
    s.categoria,
    s.servico;


-- 6. Resumo executivo geral
SELECT
    o.nome_obra,
    o.orcamento_total,
    ROUND(SUM(e.custo_realizado_mes), 2) AS custo_realizado,
    ROUND(
        SUM(e.custo_realizado_mes) - o.orcamento_total,
        2
    ) AS desvio_financeiro,
    ROUND(
        SUM(e.custo_realizado_mes) / o.orcamento_total * 100,
        2
    ) AS percentual_orcamento_consumido
FROM dim_obra o
JOIN fato_execucao e
    ON e.id_obra = o.id_obra
GROUP BY
    o.id_obra,
    o.nome_obra,
    o.orcamento_total;
