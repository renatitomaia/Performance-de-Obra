-- Projeto 01 - Análise de Performance de Obras
-- Banco alvo: MySQL 8+
-- Dados fictícios para portfólio

CREATE DATABASE IF NOT EXISTS PortfolioObrasBI
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE PortfolioObrasBI;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS fato_execucao;
DROP TABLE IF EXISTS fato_planejamento;
DROP TABLE IF EXISTS dim_calendario;
DROP TABLE IF EXISTS dim_servico;
DROP TABLE IF EXISTS dim_obra;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE dim_obra (
    id_obra INT PRIMARY KEY,
    nome_obra VARCHAR(120) NOT NULL,
    cliente VARCHAR(120),
    cidade VARCHAR(80),
    uf CHAR(2),
    data_inicio DATE,
    data_fim_prevista DATE,
    orcamento_total DECIMAL(18,2),
    status VARCHAR(30)
);

CREATE TABLE dim_servico (
    id_servico INT PRIMARY KEY,
    categoria VARCHAR(80) NOT NULL,
    servico VARCHAR(120) NOT NULL,
    unidade VARCHAR(20),
    peso_orcamentario DECIMAL(10,6),
    mes_inicio_previsto INT,
    mes_fim_previsto INT,
    orcamento_servico DECIMAL(18,2)
);

CREATE TABLE dim_calendario (
    data DATE PRIMARY KEY,
    ano INT,
    mes INT,
    mes_nome VARCHAR(20),
    trimestre VARCHAR(5),
    ano_mes CHAR(7)
);

CREATE TABLE fato_planejamento (
    id_planejamento INT PRIMARY KEY,
    id_obra INT NOT NULL,
    id_servico INT NOT NULL,
    data DATE NOT NULL,
    valor_previsto_mes DECIMAL(18,2),
    avanco_previsto_acum_pct DECIMAL(8,2),

    CONSTRAINT fk_plan_obra
        FOREIGN KEY (id_obra) REFERENCES dim_obra(id_obra),

    CONSTRAINT fk_plan_servico
        FOREIGN KEY (id_servico) REFERENCES dim_servico(id_servico),

    CONSTRAINT fk_plan_data
        FOREIGN KEY (data) REFERENCES dim_calendario(data)
);

CREATE TABLE fato_execucao (
    id_execucao INT PRIMARY KEY,
    id_obra INT NOT NULL,
    id_servico INT NOT NULL,
    data DATE NOT NULL,
    custo_realizado_mes DECIMAL(18,2),
    avanco_realizado_acum_pct DECIMAL(8,2),
    status_execucao VARCHAR(20),

    CONSTRAINT fk_exec_obra
        FOREIGN KEY (id_obra) REFERENCES dim_obra(id_obra),

    CONSTRAINT fk_exec_servico
        FOREIGN KEY (id_servico) REFERENCES dim_servico(id_servico),

    CONSTRAINT fk_exec_data
        FOREIGN KEY (data) REFERENCES dim_calendario(data)
);

SHOW TABLES;
