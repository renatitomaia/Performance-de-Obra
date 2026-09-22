USE portfolioobrasbi;
DROP VIEW IF EXISTS vw_desvio_servicos;

CREATE VIEW vw_desvio_servicos AS

SELECT
    s.id_servico,
    s.categoria,
    s.servico,
    s.orcamento_servico,

    COALESCE(
        SUM(e.custo_realizado_mes),
        0
    ) AS custo_realizado,

    COALESCE(
        SUM(e.custo_realizado_mes),
        0
    ) - s.orcamento_servico
        AS desvio_valor,

    (
        COALESCE(
            SUM(e.custo_realizado_mes),
            0
        )
        / NULLIF(s.orcamento_servico, 0)
        - 1
    ) * 100
        AS desvio_pct

FROM dim_servico s

LEFT JOIN fato_execucao e
    ON e.id_servico = s.id_servico

GROUP BY
    s.id_servico,
    s.categoria,
    s.servico,
    s.orcamento_servico;