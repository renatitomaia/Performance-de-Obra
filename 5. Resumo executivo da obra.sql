USE portfolioobrasbi;
DROP VIEW IF EXISTS vw_resumo_executivo;

CREATE VIEW vw_resumo_executivo AS

SELECT
    o.id_obra,
    o.nome_obra,
    o.cliente,
    o.cidade,
    o.uf,
    o.data_inicio,
    o.data_fim_prevista,
    o.status,

    o.orcamento_total,

    SUM(e.custo_realizado_mes)
        AS custo_realizado,

    SUM(e.custo_realizado_mes)
        - o.orcamento_total
        AS desvio_financeiro,

    (
        SUM(e.custo_realizado_mes)
        / NULLIF(o.orcamento_total, 0)
    ) * 100
        AS percentual_orcamento_consumido

FROM dim_obra o

LEFT JOIN fato_execucao e
    ON e.id_obra = o.id_obra

GROUP BY
    o.id_obra,
    o.nome_obra,
    o.cliente,
    o.cidade,
    o.uf,
    o.data_inicio,
    o.data_fim_prevista,
    o.status,
    o.orcamento_total;