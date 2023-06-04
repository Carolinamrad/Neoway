# Neoway
 
# Teste de aptidão para a vaga de Analista de BI

﻿Gostaria de compartilhar com vocês a abordagem realizada e os resultados do teste técnico de criação de dashboard no Power BI. Foram utilizados os dados da B3 e bases de uma amostra de empresas do Brasil para criar o dashboard com análises relevantes.

Todo o processo de ETL foi realizado no Microsoft SQL Server conforme o desenho abaixo:

![](Aspose.Words.1e324c59-bf0e-4c35-a252-b576eac86d2a.001.png)

Iniciei pelo processo de extração e exploração dos dados disponibilizados para maior compreensão do conjunto de dados, identificação de dados ausentes, investigação de outliers e insights iniciais. Para isso utilizei de sumarização, aplicação de filtros e análise descritivas para melhor entendimento do contexto e ligação entre os dados. Os arquivos .CSV foram extraídos para a camada RAW do projeto chamada de neoway\_raw.

![](Aspose.Words.1e324c59-bf0e-4c35-a252-b576eac86d2a.002.png)

Na sequência, iniciei a etapa de modelagem dos dados com a normalização e integração dos dados para mantê-los organizados e consistentes evitando duplicidade, implementação de processos de higienização e transformação para garantir confiabilidade, padronização de nomes e tipos de dados e tratamento de valores ausentes e nulos. Adicionei nas tabelas um campo de data para monitoramento de carga dos dados. Após as transformações os dados foram estruturados na camada CLEAN (neoway\_clean).

![](Aspose.Words.1e324c59-bf0e-4c35-a252-b576eac86d2a.003.png)

A etapa seguinte de modelagem dimensional, identifiquei todos os fatos relativos ao negócio e as dimensões necessárias para a contextualização deles. Projetei as tabelas fato com as métricas mais relevantes e as dimensões com os devidos atributos e as chaves de ligação para o correto relacionamento e consistência. Realizei também a normalização dos dados para reduzir a redundância e apliquei técnicas de transformação e enriquecimento dos dados. O modelo dimensional foi estruturado na camada ENRICH (neoway\_enrich).

![](Aspose.Words.1e324c59-bf0e-4c35-a252-b576eac86d2a.004.png)

No dashboard, apresentei uma variedade de indicadores e análises que fornecem insights relevantes para tomadas de decisão. Esses indicadores foram selecionados com base em sua relevância para o contexto do teste e possíveis necessidades do negócio. 

Na primeira página do dashboard, optei por oferecer uma visão abrangente sobre a composição das empresas por porte, saúde tributária, nível de atividade, ramo de atividade, setor e CNAE. Utilizei gráficos e cartões para apresentar os indicadores consolidados, como a quantidade de empresas e a distribuição percentual dessas empresas de acordo com CNAE e setor. Essa abordagem permite identificar rapidamente as principais áreas de atuação das empresas e compreender sua distribuição em diferentes categorias. Essas informações são essenciais para compreender o panorama geral e podem auxiliar na identificação de oportunidades e tendências específicas em determinados setores. 

A segunda página do dashboard foi desenvolvida para fornecer uma visão abrangente e detalhada dos indicadores de ações relacionados ao histórico dos pregões. Os indicadores selecionados incluem medidas como volatilidade, volume médio, títulos negociados por porte e variação percentual média de valores ao longo do período analisado.

Nesta página, você tem a flexibilidade de analisar os indicadores de forma geral, considerando todas as empresas, ou de forma individual, selecionando uma ação específica para análise detalhada. Essa funcionalidade permite que você obtenha insights tanto do panorama geral do mercado quanto do desempenho específico de uma empresa em particular.

A volatilidade é uma medida que reflete a variação dos preços das ações ao longo do tempo, indicando a oscilação dos valores de mercado. Ela pode ser útil para identificar as flutuações e o risco associado a um determinado setor.

O volume médio representa a quantidade média de ações negociadas em um período, este indicador é importante para avaliação de liquidez de um título. 

A análise dos títulos negociados por porte traz informações sobre a distribuição em diferentes categorias de empresas, como pequenas, médias e grandes. Isso permite identificar possíveis padrões de comportamento e tendências específicas de cada segmento.

A variação percentual média de valores é um indicador que mede a taxa de mudança dos preços das ações ao longo do período analisado. Essa medida auxilia na compreensão das tendências de valorização ou desvalorização dos ativos, proporcionando insights sobre o desempenho histórico.

Esses indicadores foram selecionados com o objetivo de fornecer uma análise abrangente do histórico dos pregões, permitindo que os usuários do dashboard compreendam melhor o comportamento e a volatilidade das ações ao longo do tempo. Eles oferecem uma visão quantitativa e significativa para auxiliar na tomada de decisões relacionadas a investimentos e estratégias no mercado financeiro.
