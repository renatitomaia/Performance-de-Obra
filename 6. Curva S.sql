USE portfolioobrasbi;
DROP VIEW IF EXISTS vw_curva_s_fisica;

CREATE VIEW vw_curva_s_fisica AS

WITH calendario_servico AS (

    SELECT
        c.data,
        s.id_servico,
        s.peso_orcamentario
    FROM dim_calendario c
    CROSS JOIN dim_servico s

),

avanco_previsto AS (

    SELECT
        cs.data,
        cs.id_servico,
        cs.peso_orcamentario,

        COALESCE(
            (
                SELECT MAX(p.avanco_previsto_acum_pct)
                FROM fato_planejamento p
                WHERE p.id_servico = cs.id_servico
                  AND p.data <= cs.data
            ),
            0
        ) AS avanco_previsto

    FROM calendario_servico cs

),

avanco_realizado AS (

    SELECT
        cs.data,
        cs.id_servico,
        cs.peso_orcamentario,

        COALESCE(
            (
                SELECT MAX(e.avanco_realizado_acum_pct)
                FROM fato_execucao e
                WHERE e.id_servico = cs.id_servico
                  AND e.data <= cs.data
            ),
            0
        ) AS avanco_realizado

    FROM calendario_servico cs

),

previsto_mensal AS (

    SELECT
        data,

        SUM(
            peso_orcamentario *
            avanco_previsto
        ) / NULLIF(SUM(peso_orcamentario), 0)
            AS avanco_previsto_ponderado

    FROM avanco_previsto

    GROUP BY data

),

realizado_mensal AS (

    SELECT
        data,

        SUM(
            peso_orcamentario *
            avanco_realizado
        ) / NULLIF(SUM(peso_orcamentario), 0)
            AS avanco_realizado_ponderado

    FROM avanco_realizado

    GROUP BY data

)

SELECT
    c.data,
    c.ano,
    c.mes,
    c.mes_nome,
    c.ano_mes,

    ROUND(
        COALESCE(
            p.avanco_previsto_ponderado,
            0
        ),
        2
    ) AS avanco_previsto_ponderado,

    ROUND(
        COALESCE(
            r.avanco_realizado_ponderado,
            0
        ),
        2
    ) AS avanco_realizado_ponderado,

    ROUND(
        COALESCE(
            r.avanco_realizado_ponderado,
            0
        )
        -
        COALESCE(
            p.avanco_previsto_ponderado,
            0
        ),
        2
    ) AS desvio_avanco_pp

FROM dim_calendario c

LEFT JOIN previsto_mensal p
    ON p.data = c.data

LEFT JOIN realizado_mensal r
    ON r.data = c.data

ORDER BY c.data;