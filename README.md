# FIAP - Faculdade de Informática e Administração Paulista

<p align="center">
<a href= "https://www.fiap.com.br/"><img src="assets/logo-fiap.png" alt="FIAP - Faculdade de Informática e Admnistração Paulista" border="0" width=40% height=40%></a>
</p>

<br>

# DECOLANDO COM CIÊNCIAS DE DADOS

## Capitulo 2 - Fase 7

## 👨‍🎓 Integrantes: 
- João Pedro Zavanela Andreu - RM570231
- Jéssica Paula Miranda Gomes - RM572120
- Caike Minhano - RM569255
- Rafael Briani Rodrigues da Costa - RM573086
- Renan Lucas Seni de Souza - RM570862

## 👩‍🏫 Professores:
### Tutor(a) 
- Sabrina Otoni

### Coordenador(a)
- André Godoi

## 📜 Descrição

Este projeto realiza uma análise exploratória da produção agrícola brasileira na safra 2025/26 a partir de dados oficiais da CONAB (7º Levantamento, abril/2026), complementados por referências do IBGE, MAPA, EMBRAPA, INPE e CNA Brasil. Foi construída uma base estruturada com 149 combinações de UF × Produto, contemplando variáveis qualitativas (nominal e ordinal) e quantitativas (discreta e contínua). Em linguagem R, aplicam-se medidas de tendência central, dispersão e separatrizes sobre a variável Produção (mil toneladas), além de análise gráfica da distribuição dos produtos agrícolas pelas unidades da federação. Os resultados evidenciam a forte concentração produtiva do agronegócio brasileiro, com coeficiente de variação superior a 300% e liderança absoluta de Mato Grosso na produção de milho e soja.

## 📁 Estrutura de pastas

Dentre os arquivos e pastas presentes na raiz do projeto, definem-se:

- <b>.github</b>: Nesta pasta ficarão os arquivos de configuração específicos do GitHub que ajudam a gerenciar e automatizar processos no repositório.

- <b>assets</b>: aqui estão os arquivos relacionados a elementos não-estruturados deste repositório, como imagens.

- <b>config</b>: Posicione aqui arquivos de configuração que são usados para definir parâmetros e ajustes do projeto.

- <b>document</b>: aqui estão todos os documentos do projeto que as atividades poderão pedir. Na subpasta "other", adicione documentos complementares e menos importantes.

- <b>scripts</b>: Posicione aqui scripts auxiliares para tarefas específicas do seu projeto. Exemplo: deploy, migrações de banco de dados, backups.

- <b>src</b>: Todo o código fonte criado para o desenvolvimento do projeto ao longo das fases.

- <b>README.md</b>: arquivo que serve como guia e explicação geral sobre o projeto (o mesmo que você está lendo agora).

## 🔧 Como executar o código

### Pré-requisitos
- **R** (versão 4.0 ou superior) — download em https://cran.r-project.org/
- Arquivo `Base_Dados_Agronegocio_CONAB.xlsx` na mesma pasta do script

### Instalação dos pacotes
No console do R, execute uma única vez:
```r
install.packages(c("readxl", "ggplot2", "dplyr"))
```

### Execução
Via terminal, na pasta do projeto:
```bash
Rscript analise_agronegocio.R
```

Ou no console interativo do R:
```r
setwd("caminho/para/a/pasta")
source("analise_agronegocio.R")
```

### Saída
O script imprime as estatísticas no console e gera dois arquivos na pasta atual: `analise_quantitativa.png` e `analise_qualitativa.png`.

## 🗃 Histórico de lançamentos

* 1.0.0 - 15/04/2026

## 📋 Licença

<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"><p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://github.com/agodoi/template">MODELO GIT FIAP</a> por <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://fiap.com.br">Fiap</a> está licenciado sobre <a href="http://creativecommons.org/licenses/by/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">Attribution 4.0 International</a>.</p>
