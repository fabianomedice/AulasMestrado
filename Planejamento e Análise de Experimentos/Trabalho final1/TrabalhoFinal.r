rm(list=ls(all=TRUE)) # limpar todas as vari√°veis do R

#------------------------------------------------------------------------------------------------------------------
# Leitura dos Dados
#------------------------------------------------------------------------------------------------------------------
#Leitura das amostras obtidas
TabelaResumo <- as.data.frame(read.table("Tabelas dos Campeonatos.TXT",header = TRUE, sep="\t"))
library(ggplot2)
# boxplot(TabelaResumo)
ggplot(TabelaResumo,aes(x = Campeonato,y = PontuaÁ„o,fill = Campeonato)) + geom_boxplot() + geom_point()

my.model <- aov(PontuaÁ„o ~ Campeonato,data = TabelaResumo)
summary.aov(my.model)

shapiro.test(my.model$residuals)
# install.packages("car")
library(car)
qqPlot(my.model$residuals,
         pch = 16,
         lwd = 3,
         cex = 2,
         las = 1)
# install.packages("multcomp")
library(multcomp)
mc1 <- glht(my.model, linfct = mcp(Campeonato = "Tukey"))
mc1_CI <- confint(mc1, level = 0.95)
plot(mc1_CI)