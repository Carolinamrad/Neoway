----------------------------------------------------------------------------------------
-- Script para criação da camada RAW 
----------------------------------------------------------------------------------------
USE MASTER
IF db_id('neoway_raw') IS NOT NULL
    DROP DATABASE neoway_raw
GO
CREATE DATABASE neoway_raw
GO
USE neoway_raw
GO

-- Criação das tabelas
CREATE TABLE [dbo].[empresas_simples]
(
    cnpj VARCHAR(14) NOT NULL,
    optante_simples VARCHAR(10) NULL,
    optante_simei VARCHAR(10) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[empresas_porte]
(
    cnpj VARCHAR(14) NOT NULL,
    empresa_porte NVARCHAR(50) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[empresas_saude_tributaria](
    cnpj VARCHAR(14) NOT NULL,
    saude_tributaria NVARCHAR(50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[empresas_nivel_atividade]
(
    cnpj VARCHAR(14) NOT NULL,
    nivel_atividade NVARCHAR(50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[df_empresas]
(
    cnpj VARCHAR(14) NULL,
    dt_abertura DATE NULL,
    matriz_empresa NVARCHAR(10) NULL,
    cd_cnae_principal INT NULL,
    de_cnae_principal VARCHAR(max) NULL,
    de_ramo_atividade NVARCHAR(50) NULL,
    de_setor NVARCHAR(50) NULL,
    endereco_cep INT NULL,
    endereco_municipio NVARCHAR(50) NULL,
    endereco_uf NVARCHAR(50) NULL,
    endereco_regiao NVARCHAR(50) NULL,
    endereco_mesorregiao NVARCHAR(50) NULL,
    situacao_cadastral NVARCHAR(50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[empresas_bolsa]
(
    id smallint NOT NULL,
    cd_acao_rd NVARCHAR(50) NOT NULL,
    nm_empresa NVARCHAR(50) NOT NULL,
    setor_economico NVARCHAR(50) NOT NULL,
    subsetor NVARCHAR(100) NOT NULL,
    segmento NVARCHAR(100) NOT NULL,
    segmento_b3 NVARCHAR(50) NULL,
    nm_segmento_b3 NVARCHAR(1) NULL,
    cd_acao NVARCHAR(50) NULL,
    tx_cnpj NVARCHAR(50) NULL,
    vl_cnpj VARCHAR(14) NULL,
    created_at NVARCHAR(50) NOT NULL,
    updated_at NVARCHAR(50) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[cotacoes_bolsa]
(
    id INT NULL,
    tp_reg TINYINT NULL,
    dt_pregao DATE NULL,
    cd_bdi TINYINT NULL,
    cd_acao NVARCHAR(50) NULL,
    tp_merc TINYINT NULL,
    nm_empresa_rdz NVARCHAR(50) NULL,
    especi NVARCHAR(50) NULL,
    prazot TINYINT NULL,
    moeda_ref NVARCHAR(50) NULL,
    vl_abertura FLOAT NULL,
    vl_maximo FLOAT NULL,
    vl_minimo FLOAT NULL,
    vl_medio FLOAT NULL,
    vl_fechamento FLOAT NULL,
    vl_mlh_oft_compra FLOAT NULL,
    vl_mlh_oft_venda FLOAT NULL,
    vl_ttl_neg FLOAT NULL,
    qt_tit_neg INT NULL,
	  vl_volume FLOAT NULL,
    vl_exec_opc FLOAT NULL,
    in_opc TINYINT NULL,
    dt_vnct_opc DATE NULL,
    ft_cotacao NVARCHAR(50) NULL,
    vl_exec_moeda_corrente TINYINT NULL,
    cd_isin NVARCHAR(50) NULL,
    cd_acao_rdz NVARCHAR(50) NULL,
    created_at NVARCHAR(50) NULL,
    updated_at NVARCHAR(50) NULL,
    index_level_0 SMALLINT NULL
) ON [PRIMARY]
GO

-- Extração dos dados dos arquivos CSV
BULK INSERT dbo.empresas_simples
FROM 'C:\Neoway\testeAnalistaBI\an_bi\spreadsheets\empresas_simples.csv'
WITH 
(
   FORMAT = 'CSV',
   FIELDTERMINATOR = ';',
   CODEPAGE = '65001',
   ROWTERMINATOR = '0x0a',
   FIRSTROW = 2
)
GO

BULK INSERT dbo.empresas_porte
FROM 'C:\Neoway\testeAnalistaBI\an_bi\spreadsheets\empresas_porte.csv'
WITH 
(
   FORMAT = 'CSV',
   FIELDTERMINATOR = ';',
   CODEPAGE = '65001',
   ROWTERMINATOR = '0x0a',
   FIRSTROW = 2
)
GO

BULK INSERT dbo.empresas_saude_tributaria
FROM 'C:\Neoway\testeAnalistaBI\an_bi\spreadsheets\empresas_saude_tributaria.csv'
WITH 
(
   FORMAT = 'CSV',
   FIELDTERMINATOR = ';',
   CODEPAGE = '65001',
   ROWTERMINATOR = '0x0a',
   FIRSTROW = 2
)
GO

BULK INSERT dbo.empresas_nivel_atividade
FROM 'C:\Neoway\testeAnalistaBI\an_bi\spreadsheets\empresas_nivel_atividade.csv'
WITH 
(
   FORMAT = 'CSV',
   FIELDTERMINATOR = ';',
   CODEPAGE = '65001',
   ROWTERMINATOR = '0x0a',
   FIRSTROW = 2
)
GO

BULK INSERT dbo.df_empresas
FROM 'C:\Neoway\testeAnalistaBI\an_bi\spreadsheets\df_empresas.csv'
WITH 
(
   FORMAT = 'CSV',
   FIELDTERMINATOR = ';',
   CODEPAGE = '65001',
   ROWTERMINATOR = '0x0a',
   FIRSTROW = 2
)
GO

BULK INSERT dbo.empresas_bolsa
FROM 'C:\Neoway\testeAnalistaBI\an_bi\spreadsheets\empresas_bolsa.csv'
WITH 
(
   FORMAT = 'CSV',
   FIELDTERMINATOR = ';',
   CODEPAGE = '65001',
   ROWTERMINATOR = '0x0a',
   FIRSTROW = 2
)
GO

BULK INSERT dbo.cotacoes_bolsa
FROM 'C:\Neoway\testeAnalistaBI\an_bi\spreadsheets\cotacoes_bolsa.csv'
WITH 
(
   FORMAT = 'CSV',
   FIELDTERMINATOR = ';',
   CODEPAGE = '65001',
   ROWTERMINATOR = '0x0a',
   FIRSTROW = 2
)
GO