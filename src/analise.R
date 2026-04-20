# JoaoSantos_RM76332_fase2_cap9
# CaikeMinhano_rm569255_fase2_cap9
# JoaoPedro_rm570231_fase2_cap9
# JessicaPaula_rm572120_fase2_cap9
# RafaelBriani_rm573086_fase2_cap9
# RenanSeni_rm570862_fase2_cap9

# =============================================================================
# ANÁLISE EXPLORATÓRIA - BASE DE DADOS AGRONEGÓCIO BRASILEIRO
# Fonte: CONAB - 7º Levantamento Safra 2025/26 (abril/2026)
# =============================================================================

# ---- 1. PACOTES NECESSÁRIOS ----
# install.packages("readxl")
# install.packages("ggplot2")
# install.packages("dplyr")

library(readxl)
library(ggplot2)
library(dplyr)

# ---- 2. LEITURA DOS DADOS ----
# Ajuste o caminho do arquivo conforme a localização na sua máquina
caminho_arquivo <- "Base_Dados_Agronegocio_CONAB.xlsx"

# A aba "Dados Completos (164)" tem 3 linhas de cabeçalho/metadata antes dos dados
# Os nomes das colunas estão na linha 4, e os dados começam na linha 5
dados <- read_excel(
  caminho_arquivo,
  sheet = "Dados Completos (164)",
  skip = 3   # pula as 3 primeiras linhas (título, fonte, linha em branco)
)

# Renomear colunas para facilitar o uso no R (sem espaços e parênteses)
colnames(dados) <- c("ID", "UF", "Estado", "Produto",
                     "Ranking_Nacional", "Producao_mil_t", "Produtividade_kg_ha")

# Verificar a estrutura dos dados carregados
cat("=== ESTRUTURA DOS DADOS ===\n")
str(dados)
cat("\n=== PRIMEIRAS LINHAS ===\n")
print(head(dados, 10))
cat("\nTotal de observações:", nrow(dados), "\n\n")


# =============================================================================
# 3. ANÁLISE DE VARIÁVEL QUANTITATIVA
# Variável escolhida: Producao_mil_t (Produção em mil toneladas - Quantitativa Contínua)
# =============================================================================

cat("=============================================================\n")
cat("  ANÁLISE EXPLORATÓRIA - VARIÁVEL QUANTITATIVA: PRODUÇÃO   \n")
cat("  (em mil toneladas, safra 2025/26)                        \n")
cat("=============================================================\n\n")

producao <- dados$Producao_mil_t

# ---- 3.1 MEDIDAS DE TENDÊNCIA CENTRAL ----
cat(">>> MEDIDAS DE TENDÊNCIA CENTRAL <<<\n")

media      <- mean(producao)
mediana    <- median(producao)

cat(sprintf("Média..........: %10.2f mil t\n", media))
cat(sprintf("Mediana........: %10.2f mil t\n", mediana))

# ---- 3.2 MEDIDAS DE DISPERSÃO ----
cat(">>> MEDIDAS DE DISPERSÃO <<<\n")

valor_min    <- min(producao)
valor_max    <- max(producao)
amplitude    <- valor_max - valor_min
variancia    <- var(producao)
desvio_pad   <- sd(producao)
coef_var     <- (desvio_pad / media) * 100   # em %

cat(sprintf("Mínimo.........: %10.2f mil t\n", valor_min))
cat(sprintf("Máximo.........: %10.2f mil t\n", valor_max))
cat(sprintf("Amplitude......: %10.2f mil t\n", amplitude))
cat(sprintf("Variância......: %14.2f\n", variancia))
cat(sprintf("Desvio Padrão..: %10.2f mil t\n", desvio_pad))
cat(sprintf("Coef. Variação.: %10.2f %%\n\n", coef_var))

# Interpretação do CV
if (coef_var < 15) {
  interpretacao_cv <- "Baixa dispersão (dados homogêneos)"
} else if (coef_var < 30) {
  interpretacao_cv <- "Média dispersão"
} else {
  interpretacao_cv <- "Alta dispersão (dados heterogêneos)"
}
cat("Interpretação do CV:", interpretacao_cv, "\n\n")


# ---- 3.3 MEDIDAS SEPARATRIZES ----
cat(">>> MEDIDAS SEPARATRIZES <<<\n")

# Quartis
quartis <- quantile(producao, probs = c(0.25, 0.50, 0.75))
cat("Quartis:\n")
cat(sprintf("  Q1 (25%%)....: %10.2f mil t\n", quartis[1]))
cat(sprintf("  Q2 (50%%)....: %10.2f mil t\n", quartis[2]))
cat(sprintf("  Q3 (75%%)....: %10.2f mil t\n", quartis[3]))

# Intervalo Interquartílico
iqr <- IQR(producao)
cat(sprintf("  IQR (Q3-Q1).: %10.2f mil t\n\n", iqr))

# Decis
decis <- quantile(producao, probs = seq(0.1, 0.9, by = 0.1))
cat("Decis:\n")
for (i in seq_along(decis)) {
  cat(sprintf("  D%d (%d%%)....: %10.2f mil t\n", i, i*10, decis[i]))
}
cat("\n")

# Percentis selecionados
percentis <- quantile(producao, probs = c(0.05, 0.95, 0.99))
cat("Percentis selecionados:\n")
cat(sprintf("  P5..........: %10.2f mil t\n", percentis[1]))
cat(sprintf("  P95.........: %10.2f mil t\n", percentis[2]))
cat(sprintf("  P99.........: %10.2f mil t\n\n", percentis[3]))

# Resumo completo via summary()
cat(">>> RESUMO (summary) <<<\n")
print(summary(producao))
cat("\n")


# ---- 3.4 ANÁLISE GRÁFICA DA VARIÁVEL QUANTITATIVA ----

# Divide a janela gráfica em 2x2 para mostrar 4 gráficos ao mesmo tempo
par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))

# Gráfico 1: Histograma
hist(producao,
     breaks = 20,
     col    = "#2E8B2E",
     border = "white",
     main   = "Histograma - Produção (mil t)",
     xlab   = "Produção (mil t)",
     ylab   = "Frequência")
abline(v = media,   col = "red",  lwd = 2, lty = 2)
abline(v = mediana, col = "blue", lwd = 2, lty = 3)
legend("topright",
       legend = c("Média", "Mediana"),
       col    = c("red", "blue"),
       lty    = c(2, 3),
       lwd    = 2,
       cex    = 0.8)

# Gráfico 2: Boxplot
boxplot(producao,
        col    = "#6AA84F",
        main   = "Boxplot - Produção (mil t)",
        ylab   = "Produção (mil t)",
        horizontal = FALSE)

# Gráfico 3: Densidade
plot(density(producao),
     col  = "#1F6E1F",
     lwd  = 2,
     main = "Densidade - Produção (mil t)",
     xlab = "Produção (mil t)",
     ylab = "Densidade")
polygon(density(producao), col = adjustcolor("#6AA84F", alpha.f = 0.4))

# Gráfico 4: Boxplot por Produto (visão segmentada)
boxplot(Producao_mil_t ~ Produto,
        data = dados,
        col  = "#D9EAD3",
        main = "Produção por Produto",
        xlab = "",
        ylab = "Produção (mil t)",
        las  = 2,       # labels verticais no eixo X
        cex.axis = 0.7)

# Restaura a área gráfica
par(mfrow = c(1, 1))

# Salva também uma versão em PNG (opcional)
png("analise_quantitativa.png", width = 1000, height = 800, res = 100)
par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))
hist(producao, breaks = 20, col = "#2E8B2E", border = "white",
     main = "Histograma - Produção (mil t)", xlab = "Produção (mil t)", ylab = "Frequência")
abline(v = media, col = "red", lwd = 2, lty = 2)
abline(v = mediana, col = "blue", lwd = 2, lty = 3)
legend("topright", legend = c("Média", "Mediana"),
       col = c("red", "blue"), lty = c(2, 3), lwd = 2, cex = 0.8)
boxplot(producao, col = "#6AA84F", main = "Boxplot - Produção (mil t)", ylab = "Produção (mil t)")
plot(density(producao), col = "#1F6E1F", lwd = 2,
     main = "Densidade - Produção (mil t)", xlab = "Produção (mil t)", ylab = "Densidade")
polygon(density(producao), col = adjustcolor("#6AA84F", alpha.f = 0.4))
boxplot(Producao_mil_t ~ Produto, data = dados, col = "#D9EAD3",
        main = "Produção por Produto", xlab = "", ylab = "Produção (mil t)",
        las = 2, cex.axis = 0.7)
dev.off()
par(mfrow = c(1, 1))


# =============================================================================
# 4. ANÁLISE DE VARIÁVEL QUALITATIVA
# Variável escolhida: Produto (Qualitativa Nominal)
# =============================================================================

cat("=============================================================\n")
cat("  ANÁLISE GRÁFICA - VARIÁVEL QUALITATIVA: PRODUTO            \n")
cat("=============================================================\n\n")

# ---- 4.1 TABELA DE FREQUÊNCIAS ----
freq_abs <- table(dados$Produto)                       # frequência absoluta
freq_rel <- prop.table(freq_abs) * 100                 # frequência relativa (%)

tabela_freq <- data.frame(
  Produto       = names(freq_abs),
  Freq_Absoluta = as.integer(freq_abs),
  Freq_Relativa = round(as.numeric(freq_rel), 2)
)
tabela_freq <- tabela_freq[order(-tabela_freq$Freq_Absoluta), ]

cat(">>> TABELA DE FREQUÊNCIAS <<<\n")
print(tabela_freq, row.names = FALSE)
cat("\n")
cat("Total de observações:", sum(tabela_freq$Freq_Absoluta), "\n\n")


# ---- 4.2 ANÁLISE GRÁFICA DA VARIÁVEL QUALITATIVA ----
par(mfrow = c(1, 2), mar = c(8, 4, 3, 1))

# Gráfico 1: Gráfico de barras (frequência absoluta)
barplot(sort(freq_abs, decreasing = TRUE),
        col    = "#2E8B2E",
        main   = "Freq. de UFs produtoras por Produto",
        ylab   = "Nº de UFs produtoras",
        las    = 2,
        cex.names = 0.8,
        border = "white")

# Gráfico 2: Gráfico de pizza (frequência relativa)
par(mar = c(2, 2, 3, 2))
pie(freq_abs,
    labels = paste0(names(freq_abs), "\n(", round(freq_rel, 1), "%)"),
    col    = c("#1F6E1F", "#2E8B2E", "#4F7F4F", "#6AA84F", "#8FBC8F",
               "#9ACD32", "#A9D18E", "#C5E0B4", "#D9EAD3", "#E2EFDA"),
    main   = "Distribuição % dos Produtos na Base",
    cex    = 0.8)

par(mfrow = c(1, 1))

# Salva também em PNG
png("analise_qualitativa.png", width = 1200, height = 600, res = 100)
par(mfrow = c(1, 2), mar = c(8, 4, 3, 1))
barplot(sort(freq_abs, decreasing = TRUE), col = "#2E8B2E",
        main = "Freq. de UFs produtoras por Produto",
        ylab = "Nº de UFs produtoras", las = 2, cex.names = 0.8, border = "white")
par(mar = c(2, 2, 3, 2))
pie(freq_abs, labels = paste0(names(freq_abs), "\n(", round(freq_rel, 1), "%)"),
    col  = c("#1F6E1F", "#2E8B2E", "#4F7F4F", "#6AA84F", "#8FBC8F",
             "#9ACD32", "#A9D18E", "#C5E0B4", "#D9EAD3", "#E2EFDA"),
    main = "Distribuição % dos Produtos na Base", cex = 0.8)
dev.off()
par(mfrow = c(1, 1))


# =============================================================================
# FIM DO SCRIPT
# =============================================================================

cat("\n=== ANÁLISE CONCLUÍDA ===\n")
cat("Arquivos gerados: analise_quantitativa.png, analise_qualitativa.png\n")
