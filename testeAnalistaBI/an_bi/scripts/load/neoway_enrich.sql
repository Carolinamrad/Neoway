----------------------------------------------------------------------------------------
-- Script para criação da camada ENRICH 
----------------------------------------------------------------------------------------
USE MASTER
IF db_id('neoway_enrich') IS NOT NULL
    DROP DATABASE neoway_enrich
GO
CREATE DATABASE neoway_enrich
GO
USE neoway_enrich
GO
-- Criação da tabela DIM_nivel_atividade
CREATE TABLE DIM_nivel_atividade (
    SK1_nivel_atividade INT IDENTITY(-1, 1) NOT NULL,
    dsc_nivel_atividade NVARCHAR(50) NOT NULL,
	dt_carga DATETIME NOT NULL,
    CONSTRAINT PK_DIM_nivel_atividade PRIMARY KEY (SK1_nivel_atividade),
    CONSTRAINT UQ_DIM_nivel_atividade_dsc_nivel_atividade UNIQUE (dsc_nivel_atividade)
)
GO

-- Insert dados da dimensão DIM_nivel_atividade
INSERT INTO DIM_nivel_atividade (dsc_nivel_atividade, dt_carga)
SELECT dsc_nivel_atividade, dt_carga
FROM	(
			SELECT	dsc_nivel_atividade,
					ROW_NUMBER() OVER (ORDER BY dsc_nivel_atividade ASC) AS rn,
					GETDATE() AS dt_carga
			FROM	neoway_clean.dbo.tb_empresas_nivel_atividade
			GROUP BY dsc_nivel_atividade
		) AS subconsulta
ORDER BY CASE WHEN dsc_nivel_atividade = 'NI' THEN -1 ELSE rn END
GO

-- Criação da tabela DIM_porte
CREATE TABLE DIM_porte 
(
    SK1_porte INT IDENTITY(-1, 1) NOT NULL,
    dsc_porte NVARCHAR(10) NOT NULL,
	dt_carga DATETIME NOT NULL,
    CONSTRAINT PK_DIM_porte PRIMARY KEY (SK1_porte),
    CONSTRAINT UQ_DIM_porte_dsc_porte UNIQUE (dsc_porte)
)
GO

-- Insert dados da dimensão DIM_porte
INSERT INTO DIM_porte (dsc_porte, dt_carga)
VALUES ('NI', GETDATE())
GO

-- Insert dados da dimensão DIM_porte
INSERT INTO DIM_porte (dsc_porte, dt_carga)
SELECT dsc_porte, dt_carga
FROM	(
			SELECT	dsc_porte,
					ROW_NUMBER() OVER (ORDER BY dsc_porte ASC) AS rn,
					GETDATE() AS dt_carga
			FROM	neoway_clean.dbo.tb_empresas_porte
			GROUP BY dsc_porte
		) AS subconsulta
ORDER BY CASE WHEN dsc_porte = 'NI' THEN -1 ELSE rn END
GO

-- Criação da tabela DIM_saude_tributaria
CREATE TABLE DIM_saude_tributaria
(
    SK1_saude_tributaria INT IDENTITY(-1, 1) NOT NULL,
    dsc_saude_tributaria NVARCHAR(10) NOT NULL,
    dt_carga DATETIME NOT NULL,
    CONSTRAINT PK_DIM_saude_tributaria PRIMARY KEY (SK1_saude_tributaria),
    CONSTRAINT UQ_DIM_saude_tributaria_dsc_saude_tributaria UNIQUE (dsc_saude_tributaria)
)
GO

-- Insert dados da dimensão DIM_saude_tributaria
INSERT INTO DIM_saude_tributaria (dsc_saude_tributaria, dt_carga)
SELECT dsc_saude_tributaria, dt_carga
FROM	(	SELECT	dsc_saude_tributaria,
					ROW_NUMBER() OVER (ORDER BY dsc_saude_tributaria ASC) AS rn,
					GETDATE() AS dt_carga
			FROM	neoway_clean.dbo.tb_empresas_saude_tributaria
			GROUP BY dsc_saude_tributaria
		) AS subconsulta
ORDER BY CASE WHEN dsc_saude_tributaria = 'NI' THEN -1 ELSE rn END
GO

-- Criação da tabela DIM_cnae_principal
CREATE TABLE DIM_cnae_principal 
(
    SK1_cnae_principal INT IDENTITY(-1, 1) NOT NULL,
    cod_cnae_principal INT NOT NULL,
    dsc_cnae_principal VARCHAR(MAX) NOT NULL,
    dt_carga DATETIME NOT NULL,
    CONSTRAINT PK_DIM_cnae_principal PRIMARY KEY (SK1_cnae_principal),
    )
GO

-- Insert dados da dimensão DIM_cnae_principal
INSERT INTO DIM_cnae_principal (cod_cnae_principal, dsc_cnae_principal, dt_carga)
SELECT cod_cnae_principal, dsc_cnae_principal, dt_carga
FROM	(	SELECT	cod_cnae_principal,
					dsc_cnae_principal,
					ROW_NUMBER() OVER (ORDER BY dsc_cnae_principal ASC) AS rn,
					GETDATE() AS dt_carga
			FROM	neoway_clean.dbo.tb_df_empresas
			GROUP BY cod_cnae_principal, dsc_cnae_principal
		) AS subconsulta
ORDER BY CASE WHEN cod_cnae_principal = 0 THEN -1 ELSE rn END
GO

-- Criação da tabela DIM_ramo_atividade
CREATE TABLE DIM_ramo_atividade 
(
    SK1_ramo_atividade INT IDENTITY(-1, 1) NOT NULL,
    dsc_ramo_atividade NVARCHAR(50) NOT NULL,
	dt_carga DATETIME NOT NULL,
    CONSTRAINT PK_DIM_ramo_atividade PRIMARY KEY (SK1_ramo_atividade),
    CONSTRAINT UQ_DIM_ramo_atividade_dsc_ramo_atividade UNIQUE (dsc_ramo_atividade)
)
GO

-- Insert dados da dimensão DIM_ramo_atividade
INSERT INTO DIM_ramo_atividade (dsc_ramo_atividade, dt_carga)
SELECT dsc_ramo_atividade, dt_carga
FROM	(	SELECT	dsc_ramo_atividade,
					ROW_NUMBER() OVER (ORDER BY dsc_ramo_atividade ASC) AS rn,
					GETDATE() AS dt_carga
			FROM	neoway_clean.dbo.tb_df_empresas
			GROUP BY dsc_ramo_atividade
		) AS subconsulta
ORDER BY CASE WHEN dsc_ramo_atividade = 'NI' THEN -1 ELSE rn END
GO

-- Criação da tabela DIM_ramo_atividade
CREATE TABLE DIM_setor 
(
    SK1_setor INT IDENTITY(-1, 1) NOT NULL,
    dsc_setor NVARCHAR(25) NOT NULL,
	dt_carga DATETIME NOT NULL,
    CONSTRAINT PK_DIM_setor PRIMARY KEY (SK1_setor),
    CONSTRAINT UQ_DIM_setor_dsc_setor UNIQUE (dsc_setor)
)
GO

-- Insert dados da dimensão DIM_setor
INSERT INTO DIM_setor (dsc_setor, dt_carga)
SELECT dsc_setor, dt_carga
FROM	(	SELECT	dsc_setor,
					ROW_NUMBER() OVER (ORDER BY dsc_setor ASC) AS rn,
					GETDATE() AS dt_carga
			FROM	neoway_clean.dbo.tb_df_empresas
			GROUP BY dsc_setor
		) AS subconsulta
ORDER BY CASE WHEN dsc_setor = 'NI' THEN -1 ELSE rn END
GO

-- Criação da tabela DIM_empresa
CREATE TABLE DIM_empresa 
(
    cnpj VARCHAR(14) NOT NULL,
	razao_social NVARCHAR(100) NOT NULL,
	cod_acao_reduzido VARCHAR(4) NOT NULL, 
	cod_acao NVARCHAR(100) NOT NULL, 
	dt_abertura DATE NOT NULL, 
	matriz_empresa NVARCHAR(10) NOT NULL, 
	endereco_municipio NVARCHAR(50) NOT NULL, 
	endereco_uf NVARCHAR(2) NOT NULL,
	endereco_regiao NVARCHAR(20) NOT NULL,
	situacao_cadastral NVARCHAR(10) NOT NULL,
	optante_simples VARCHAR(10) NOT NULL,
	optante_simei VARCHAR(10) NOT NULL,
	dt_carga DATETIME NOT NULL,
	CONSTRAINT PK_DIM_empresa PRIMARY KEY (cnpj)
)
GO

-- Insert dados da dimensão DIM_empresa
INSERT INTO DIM_empresa (cnpj, razao_social, cod_acao_reduzido, cod_acao, dt_abertura, matriz_empresa, endereco_municipio, endereco_uf, endereco_regiao,
	situacao_cadastral, optante_simples, optante_simei, dt_carga)
SELECT	tb_df_empresas.cnpj,
		ISNULL(tb_eb.razao_social,'NI') AS razao_social, 
		ISNULL(tb_eb.cod_acao_rdz,'NI') AS cod_acao_rdz,				   					 
		ISNULL(tb_eb.cod_acao,'NI') AS cod_acao,	
		tb_df_empresas.dt_abertura,
		tb_df_empresas.matriz_empresa,
		tb_df_empresas.end_municipio,
		tb_df_empresas.end_uf,
		tb_df_empresas.end_regiao,
		tb_df_empresas.situacao_cadastral,
		ISNULL(tb_es.optante_simples,'NI') AS optante_simples,
		ISNULL(tb_es.optante_simei,'NI') AS optante_simei,
		GETDATE() AS dt_carga
FROM	neoway_clean.dbo.tb_df_empresas
		LEFT JOIN neoway_clean.dbo.tb_empresas_bolsa tb_eb ON tb_eb.cnpj = tb_df_empresas.cnpj
		LEFT JOIN neoway_clean.dbo.tb_empresas_simples tb_es ON tb_es.cnpj = tb_df_empresas.cnpj
GO

-- Criação da tabela FT_cotacoes_bolsa
CREATE TABLE FT_cotacoes_bolsa 
(
		cnpj VARCHAR(14) NOT NULL,
		cod_acao_rdz VARCHAR(4) NOT NULL, 
		cod_acao NVARCHAR(100) NOT NULL, 
		dt_pregao DATE NOT NULL,
		vlr_abertura FLOAT NOT NULL,
		vlr_maximo FLOAT NOT NULL,
		vlr_minimo FLOAT NOT NULL,
		vlr_medio FLOAT NOT NULL,
		vlr_fechamento FLOAT NOT NULL,
		vlr_mlh_oft_compra FLOAT NOT NULL, 
		vlr_mlh_oft_venda FLOAT NOT NULL,
		vlr_volume FLOAT NOT NULL, 
		vlr_exec_opc FLOAT NOT NULL,
		qtde_tit_neg INT NOT NULL,
		variacao_percentual FLOAT NOT NULL,
		volatilidade_media FLOAT NOT NULL,
		oferta_compra_relacao_preco_fechamento FLOAT NOT NULL,
		volume_medio_neg FLOAT NOT NULL,
		SK1_cnae_principal INT NOT NULL,
		SK1_nivel_atividade INT NOT NULL, 
		SK1_porte INT NOT NULL,
		SK1_saude_tributaria INT NOT NULL,
		SK1_ramo_atividade INT NOT NULL,
		SK1_setor INT NOT NULL,
		dt_carga DATETIME NOT NULL
)
GO

-- Insert dados da fato FT_cotacoes_bolsa
INSERT INTO FT_cotacoes_bolsa (cnpj, cod_acao_rdz, cod_acao, dt_pregao, vlr_abertura, vlr_maximo, vlr_minimo, vlr_medio, vlr_fechamento, vlr_mlh_oft_compra, vlr_mlh_oft_venda, vlr_volume, vlr_exec_opc,
		qtde_tit_neg, variacao_percentual, volatilidade_media, volume_medio_neg, oferta_compra_relacao_preco_fechamento, SK1_cnae_principal, SK1_nivel_atividade, SK1_porte, SK1_saude_tributaria, SK1_ramo_atividade, SK1_setor, dt_carga)
SELECT	tb_eb.cnpj,
		tb_cotacoes_bolsa.cod_acao_rdz AS cod_acao_rdz,				   					 
		tb_cotacoes_bolsa.cod_acao AS cod_acao,	
		tb_cotacoes_bolsa.dt_pregao,
		tb_cotacoes_bolsa.vlr_abertura,
		tb_cotacoes_bolsa.vlr_maximo,
		tb_cotacoes_bolsa.vlr_minimo,
		tb_cotacoes_bolsa.vlr_medio,
		tb_cotacoes_bolsa.vlr_fechamento,
		tb_cotacoes_bolsa.vlr_mlh_oft_compra,
		tb_cotacoes_bolsa.vlr_mlh_oft_venda,
		tb_cotacoes_bolsa.vlr_volume,
		tb_cotacoes_bolsa.vlr_exec_opc,
		tb_cotacoes_bolsa.qtde_tit_neg,
		ROUND(((tb_cotacoes_bolsa.vlr_fechamento - tb_cotacoes_bolsa.vlr_abertura)/ tb_cotacoes_bolsa.vlr_abertura),2) AS variacao_percentual,
		ROUND((tb_cotacoes_bolsa.vlr_maximo - tb_cotacoes_bolsa.vlr_minimo) / tb_cotacoes_bolsa.vlr_abertura,2) AS volatilidade_media,
		ROUND(tb_cotacoes_bolsa.vlr_volume / tb_cotacoes_bolsa.qtde_tit_neg,0) AS volume_medio_neg,
		ROUND((tb_cotacoes_bolsa.vlr_mlh_oft_compra - tb_cotacoes_bolsa.vlr_fechamento) / tb_cotacoes_bolsa.vlr_fechamento, 2) AS oferta_compra_relacao_preco_fechamento,
		ISNULL(DIM_cnae_principal.SK1_cnae_principal,-1) AS SK1_cnae_principal,
		ISNULL(DIM_nivel_atividade.SK1_nivel_atividade, -1) AS SK1_nivel_atividade,
		ISNULL(DIM_porte.SK1_porte, -1) AS SK1_porte,
		ISNULL(DIM_saude_tributaria.SK1_saude_tributaria, -1) AS SK1_saude_tributaria,
		ISNULL(DIM_ramo_atividade.SK1_ramo_atividade, -1) AS SK1_saude_tributaria,
		ISNULL(DIM_setor.SK1_setor, -1) AS SK1_setor,
		GETDATE() AS dt_carga
FROM	neoway_clean.dbo.tb_cotacoes_bolsa
		LEFT JOIN neoway_clean.dbo.tb_empresas_bolsa tb_eb ON tb_eb.cod_acao_rdz = tb_cotacoes_bolsa.cod_acao_rdz
		LEFT JOIN neoway_clean.dbo.tb_df_empresas ON tb_df_empresas.cnpj = tb_eb.cnpj
		LEFT JOIN neoway_clean.dbo.tb_empresas_nivel_atividade tb_ena ON tb_ena.cnpj = tb_df_empresas.cnpj 
		LEFT JOIN neoway_enrich.dbo.DIM_nivel_atividade ON DIM_nivel_atividade.dsc_nivel_atividade = tb_ena.dsc_nivel_atividade
		LEFT JOIN neoway_clean.dbo.tb_empresas_porte tb_ep ON tb_ep.cnpj = tb_df_empresas.cnpj 
		LEFT JOIN neoway_enrich.dbo.DIM_porte ON DIM_porte.dsc_porte = tb_ep.dsc_porte
		LEFT JOIN neoway_clean.dbo.tb_empresas_saude_tributaria tb_est ON tb_est.cnpj = tb_df_empresas.cnpj 
		LEFT JOIN neoway_enrich.dbo.DIM_saude_tributaria ON DIM_saude_tributaria.dsc_saude_tributaria = tb_est.dsc_saude_tributaria
		LEFT JOIN neoway_enrich.dbo.DIM_ramo_atividade ON DIM_ramo_atividade.dsc_ramo_atividade = tb_df_empresas.dsc_ramo_atividade
		LEFT JOIN neoway_enrich.dbo.DIM_cnae_principal ON DIM_cnae_principal.cod_cnae_principal = tb_df_empresas.cod_cnae_principal AND DIM_cnae_principal.dsc_cnae_principal = tb_df_empresas.dsc_cnae_principal
		LEFT JOIN neoway_enrich.dbo.DIM_setor ON DIM_setor.dsc_setor = tb_df_empresas.dsc_setor
GO
