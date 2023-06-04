----------------------------------------------------------------------------------------
-- Script para criação da camada Clean 
----------------------------------------------------------------------------------------
USE MASTER
IF db_id('neoway_clean') IS NOT NULL
    DROP DATABASE neoway_clean
GO
CREATE DATABASE neoway_clean
GO
USE neoway_clean
GO

-- Criação da tabela tb_empresa_simples
CREATE TABLE dbo.tb_empresas_simples
(
	cnpj VARCHAR(14) NOT NULL,
	optante_simples VARCHAR(10) NOT NULL,
	optante_simei VARCHAR(10) NOT NULL,
	dt_carga DATETIME NOT NULL,
	CONSTRAINT PK_tb_empresas_simples PRIMARY KEY (cnpj)
) ON [PRIMARY]
GO

-- Insert dos dados a partir da camada raw (neoway_raw) realizando a higienização dos dados, substituição de valores null por NI (não informado) e padronizar os registros e nome dos campos
INSERT INTO neoway_clean.dbo.tb_empresas_simples (cnpj, optante_simples, optante_simei, dt_carga)
SELECT cnpj, LTRIM(RTRIM(ISNULL(optante_simples, 'NI'))), LTRIM(RTRIM(ISNULL(optante_simei, 'NI'))), GETDATE() AS dt_carga -- etapa para substituição de valores null por NI (não informado) e remoção de espaços caso haja
FROM neoway_raw.dbo.empresas_simples
GO

-- Criação da tabela tb_empresas_saude_tributaria
CREATE TABLE dbo.tb_empresas_saude_tributaria
(
	cnpj VARCHAR(14) NOT NULL,
	dsc_saude_tributaria NVARCHAR(10) NOT NULL,
	dt_carga DATETIME NOT NULL,
	CONSTRAINT PK_empresas_saude_tributaria PRIMARY KEY (cnpj)
) ON [PRIMARY]
GO

-- Insert dos dados a partir da camada raw (neoway_raw) realizando a higienização dos dados, substituição de valores null por NI (não informado) e padronizar os registros e nome dos campos
INSERT INTO dbo.tb_empresas_saude_tributaria (cnpj, dsc_saude_tributaria, dt_carga)
SELECT cnpj, 
       UPPER(SUBSTRING(LOWER(ISNULL(saude_tributaria, 'NI')), 1, 1)) + 
       SUBSTRING(LOWER(ISNULL(saude_tributaria, 'NI')), 2, LEN(ISNULL(saude_tributaria, 'NI'))), GETDATE() AS dt_carga
FROM neoway_raw.dbo.empresas_saude_tributaria
GO

-- Criação da tabela tb_empresas_porte
CREATE TABLE dbo.tb_empresas_porte
(
	cnpj VARCHAR(14) NOT NULL,
	dsc_porte NVARCHAR(10) NOT NULL,
	dt_carga DATETIME NOT NULL,
	CONSTRAINT PK_tb_empresas_porte PRIMARY KEY (cnpj)
) ON [PRIMARY]
GO

-- Insert dos dados a partir da camada raw (neoway_raw) realizando a higienização dos dados, substituição de valores null por NI (não informado) e padronizar os registros e nome dos campos
INSERT INTO dbo.tb_empresas_porte (cnpj, dsc_porte, dt_carga)
SELECT cnpj, UPPER(SUBSTRING(LOWER(ISNULL(empresa_porte, 'NI')), 1, 1)) + SUBSTRING(LOWER(ISNULL(empresa_porte, 'NI')), 2, LEN(ISNULL(empresa_porte, 'NI'))), GETDATE() AS dt_carga 
FROM neoway_raw.dbo.empresas_porte
GO

-- Criação da tabela tb_empresas_nivel_atividade
CREATE TABLE dbo.tb_empresas_nivel_atividade
(
    cnpj VARCHAR(14) NOT NULL,
    dsc_nivel_atividade NVARCHAR(20) NOT NULL,
	dt_carga DATETIME NOT NULL,
    CONSTRAINT PK_tb_empresas_nivel_atividade PRIMARY KEY (cnpj)
) ON [PRIMARY]
GO

-- Insert dos dados a partir da camada raw (neoway_raw) realizando a higienização dos dados, substituição de valores null por NI (não informado) e padronizar os registros e nome dos campos
INSERT INTO neoway_clean.dbo.tb_empresas_nivel_atividade (cnpj, dsc_nivel_atividade, dt_carga)
SELECT cnpj, 
    ISNULL(UPPER(LEFT(nivel_atividade, 1)) + LOWER(SUBSTRING(nivel_atividade, 2, LEN(nivel_atividade))), 'NI') AS dsc_nivel_atividade,
    GETDATE() AS dt_carga
FROM neoway_raw.dbo.empresas_nivel_atividade
GO

-- Criação da tabela df_empresas
CREATE TABLE dbo.tb_df_empresas
(
    cnpj VARCHAR(14) NOT NULL,
    dt_abertura DATE NOT NULL,
    matriz_empresa NVARCHAR(10) NOT NULL,
    cod_cnae_principal INT NOT NULL,
    dsc_cnae_principal VARCHAR(MAX) NOT NULL,
    dsc_ramo_atividade NVARCHAR(50) NOT NULL,
    dsc_setor NVARCHAR(50) NOT NULL,
    end_cep INT NOT NULL,
    end_municipio NVARCHAR(50) NOT NULL,
    end_uf NVARCHAR(2) NOT NULL,
    end_regiao NVARCHAR(20) NOT NULL,
    end_mesorregiao NVARCHAR(100) NOT NULL,
    situacao_cadastral NVARCHAR(10) NOT NULL,
	dt_carga DATETIME NOT NULL,
    CONSTRAINT PK_tb_df_empresas PRIMARY KEY (cnpj)
) ON [PRIMARY]
GO

-- Insert dos dados a partir da camada raw (neoway_raw) realizando a higienização dos dados, substituição de valores null por NI (não informado) e padronizar os registros e nome dos campos
INSERT INTO dbo.tb_df_empresas (cnpj, dt_abertura, matriz_empresa, cod_cnae_principal, dsc_cnae_principal, dsc_ramo_atividade, dsc_setor, end_cep, end_municipio, end_uf, end_regiao, end_mesorregiao, situacao_cadastral, dt_carga)
SELECT cnpj, dt_abertura, ISNULL(matriz_empresa, 'NI'), 
       ISNULL(cd_cnae_principal, 0), de_cnae_principal, ISNULL(de_ramo_atividade, 'NI'), ISNULL(de_setor, 'NI'), 
       CASE WHEN LEN(endereco_cep) < 8 THEN '99999999' ELSE endereco_cep END, 
       endereco_municipio, endereco_uf, endereco_regiao, endereco_mesorregiao, situacao_cadastral, GETDATE() AS dt_carga
FROM [neoway_raw].[dbo].[df_empresas]
GO

-- Criação da tabela tb_empresas_bolsa
CREATE TABLE dbo.tb_empresas_bolsa
(
    cod_acao_rdz VARCHAR(4) NOT NULL,
    cod_acao NVARCHAR(100) NOT NULL,
    razao_social NVARCHAR(100) NOT NULL,
    dsc_setor_economico NVARCHAR(100) NOT NULL,
    dsc_subsetor NVARCHAR(100) NOT NULL,
    dsc_segmento NVARCHAR(100) NOT NULL,
    segmento_b3 NVARCHAR(5) NOT NULL,
    cnpj NVARCHAR(14) NOT NULL,
	dt_carga DATETIME NOT NULL,
    CONSTRAINT PK_tb_empresas_bolsa PRIMARY KEY (cod_acao_rdz)
) ON [PRIMARY]
GO

-- Insert dos dados a partir da camada raw (neoway_raw) realizando a higienização dos dados, substituição de valores null por NI (não informado) e padronizar os registros e nome dos campos
INSERT INTO dbo.tb_empresas_bolsa (cod_acao_rdz, cod_acao, razao_social, dsc_setor_economico, dsc_subsetor, dsc_segmento, segmento_b3, cnpj, dt_carga)
SELECT 
    cd_acao_rd,
    ISNULL(cd_acao, 'NI'),
    ISNULL(nm_empresa, 'NI'),
    ISNULL(setor_economico, 'NI'),
    ISNULL(subsetor, 'NI'),
    ISNULL(segmento, 'NI'),
    ISNULL(segmento_b3, 'NI'),
    RIGHT('00000000000000' + REPLACE(REPLACE(ISNULL(vl_cnpj, '99999999999999'), '.', ''), '/', ''), 14),
	GETDATE() AS dt_carga
FROM neoway_raw.dbo.empresas_bolsa
GO

-- Criação da tabela tb_cotacoes_bolsa
CREATE TABLE dbo.tb_cotacoes_bolsa
(
    cod_acao_rdz NVARCHAR(4) NOT NULL,
    cod_acao NVARCHAR(100) NOT NULL,
    dt_pregao DATE NOT NULL,
    cod_bdi TINYINT NOT NULL,
    tp_mercado TINYINT NOT NULL,
    nome_empresa_rdz NVARCHAR(50) NOT NULL,
    especie NVARCHAR(50) NOT NULL,
    moeda_ref NVARCHAR(50) NOT NULL,
    vlr_abertura FLOAT NOT NULL,
    vlr_maximo FLOAT NOT NULL,
    vlr_minimo FLOAT NOT NULL,
    vlr_medio FLOAT NOT NULL,
    vlr_fechamento FLOAT NOT NULL,
    vlr_mlh_oft_compra FLOAT NOT NULL,
    vlr_mlh_oft_venda FLOAT NOT NULL,
    vlr_ttl_neg FLOAT NOT NULL,
    qtde_tit_neg INT NOT NULL,
    vlr_volume FLOAT NOT NULL,
    vlr_exec_opc FLOAT NOT NULL,
    dt_vnct_opc DATE NOT NULL,
    ft_cotacao NVARCHAR(50) NOT NULL,
    vlr_exec_moeda_corrente TINYINT NOT NULL,
    cod_isin NVARCHAR(50) NOT NULL,
	dt_carga DATETIME NOT NULL,
    CONSTRAINT PK_cotacoes_bolsa PRIMARY KEY (cod_acao, dt_pregao)
) ON [PRIMARY]
GO

-- Insert dos dados a partir da camada raw (neoway_raw) realizando a higienização dos dados, substituição de valores null por NI (não informado) e padronizar os registros e nome dos campos
INSERT INTO dbo.tb_cotacoes_bolsa (cod_acao_rdz, cod_acao, dt_pregao, cod_bdi, tp_mercado, nome_empresa_rdz, especie, moeda_ref, vlr_abertura, vlr_maximo, vlr_minimo, vlr_medio, vlr_fechamento, vlr_mlh_oft_compra, vlr_mlh_oft_venda, vlr_ttl_neg, qtde_tit_neg, 
		vlr_volume, vlr_exec_opc, dt_vnct_opc, ft_cotacao, vlr_exec_moeda_corrente, cod_isin, dt_carga)
SELECT 
    ISNULL(cd_acao_rdz, 'NI'),
    ISNULL(cd_acao, 'NI'),
    dt_pregao,
    ISNULL(cd_bdi, 0),
    ISNULL(tp_merc, 0),
    ISNULL(nm_empresa_rdz, 'NI'),
    ISNULL(especi, 'NI'),
    ISNULL(moeda_ref, 'NI'),
    ISNULL(vl_abertura, 0),
    ISNULL(vl_maximo, 0),
    ISNULL(vl_minimo, 0),
    ISNULL(vl_medio, 0),
    ISNULL(vl_fechamento, 0),
    ISNULL(vl_mlh_oft_compra, 0),
    ISNULL(vl_mlh_oft_venda, 0),
    ISNULL(vl_ttl_neg, 0),
    ISNULL(qt_tit_neg, 0),
    ISNULL(vl_volume, 0),
    ISNULL(vl_exec_opc, 0),
    dt_vnct_opc,
    ISNULL(ft_cotacao, 'NI'),
    ISNULL(vl_exec_moeda_corrente, 0),
    ISNULL(cd_isin, 'NI'),
	GETDATE() AS dt_carga
FROM [neoway_raw].[dbo].[cotacoes_bolsa];
GO
