USE portfolioobrasbi;
DROP VIEW IF EXISTS vw_avanco_fisico_servicos;

CREATE VIEW vw_avanco_fisico_servicos AS

WITH previsto AS (
    SELECT
        id_servico,
        MAX(avanco_previsto_acum_pct)
            AS avanco_previsto
    FROM fato_planejamento
    GROUP BY id_servico
),

realizado AS (
    SELECT
        id_servico,
        MAX(avanco_realizado_acum_pct)
            AS avanco_realizado
    FROM fato_execucao
    GROUP BY id_servico
)

SELECT
    s.id_servico,
    s.categoria,
    s.servico,
    s.peso_orcamentario,

    COALESCE(
        p.avanco_previsto,
        0
    ) AS avanco_previsto,

    COALESCE(
        r.avanco_realizado,
        0
    ) AS avanco_realizado,

    COALESCE(
        r.avanco_realizado,
        0
    )
    -
    COALESCE(
        p.avanco_previsto,
        0
    )
        AS desvio_avanco_pp

FROM dim_servico s

LEFT JOIN previsto p
    ON p.id_servico = s.id_servico

LEFT JOIN realizado r
    ON r.id_servico = s.id_servico;