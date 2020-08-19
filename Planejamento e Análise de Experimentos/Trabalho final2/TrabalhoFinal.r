rm(list=ls(all=TRUE)) # limpar todas as variáveis do R

#------------------------------------------------------------------------------------------------------------------
# Leitura dos Dados
#------------------------------------------------------------------------------------------------------------------
#Leitura das amostras obtidas
TabelaResumo <- as.data.frame(read.table("Tabelas dos Campeonatos.TXT",header = TRUE, sep="\t"))
#TabelaResumo$Pontuação <- TabelaResumo$Pontuação*38

# ===== Boxplot das amostras =====
library(ggplot2)
ggplot(TabelaResumo,aes(x = Campeonato,y = Pontuação,fill = Campeonato)) + geom_boxplot() + geom_point()

# ===== Aplicação do teste ANOVA =====

my.model <- aov(Pontuação ~ Campeonato,data = TabelaResumo)
summary.aov(my.model)

# ===== teste de normalidade =====

shapiro.test(my.model$residuals)
# install.packages("car")
library(car)
qqPlot(my.model$residuals,
         pch = 16,
         lwd = 3,
         cex = 2,
         las = 1)

# ===== teste de homocedasticidade =====
fligner.test(Pontuação ~ Campeonato, data = TabelaResumo)
plot(x = my.model$fitted.values,y = my.model$residuals)

# ===== teste todos contra todos (TUKEY) =====

# install.packages("multcomp")
library(multcomp)
mc1 <- glht(my.model, linfct = mcp(Campeonato = "Tukey"))
mc1_CI <- confint(mc1, level = 0.95)
plot(mc1_CI)

# ===== teste um contra todos (DUNNETT) =====
TabelaResumo$Campeonato <- relevel(TabelaResumo$Campeonato, ref = "Brasileiro")
model2 <- aov(Pontuação ~ Campeonato, data = TabelaResumo)
mc2 <- glht(model2, linfct = mcp(Campeonato = "Dunnett"))
mc2_CI <- confint(mc2, level = 0.95)
plot(mc2_CI)
