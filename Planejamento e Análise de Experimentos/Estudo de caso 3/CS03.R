#install.packages("ExpDE") #Rodar apenas uma vez
#install.packages("smoof") #Rodar apenas uma vez

rm(list=ls(all=TRUE)) # limpar todas as variáveis do R

#------------------------------------------------------------------------------------------------------------------
#Aquisição dos Dados
#------------------------------------------------------------------------------------------------------------------

#Geração dos "dim" utilizados para comparação

n_observacao = 10 #Primeiro teste
dims = sample(2:150, n_observacao, replace = FALSE, prob = NULL) #pegando os valores de dim aleatórios

Dados = matrix( rep( 0, len=4*n_observacao), nrow = 4) #cria uma matriz de 4 linhas com n_observacao colunas

for(i in 1:n_observacao){
  dim = dims[i] #Pega a primeira dim para rodar o código do professor

#-----------------------------------------------------------------------------------
#Início do Código do Professor
#-----------------------------------------------------------------------------------
  #Gerador da função de Rosenbrock de uma dada dimensão "dim"
  suppressPackageStartupMessages(library(smoof))
  # FOR INSTANCE: set dim = 10
  #dim <- 10
  fn <- function(X){
    if(!is.matrix(X)) X <- matrix(X, nrow = 1) # <- if a single vector is passed as X
    Y <- apply(X, MARGIN = 1,
               FUN = smoof::makeRosenbrockFunction(dimensions = dim))
    return(Y)
  }

  #Parâmetros para o problema de dimensão "dim"
  selpars <- list(name = "selection_standard")
  stopcrit <- list(names = "stop_maxeval", maxevals = 5000 * dim, maxiter = 100 * dim)
  probpars <- list(name = "fn", xmin = rep(-5, dim), xmax = rep(10, dim))
  popsize = 5 * dim
  
  #Código do Grupo H
  ## Config 1
  recpars1 <- list(name = "recombination_eigen",othername = "recombination_bin", cr = 0.9)
  mutpars1 <- list(name = "mutation_best", f = 2.8)
  ## Config 2
  recpars2 <- list(name = "recombination_sbx", eta = 90)
  mutpars2 <- list(name = "mutation_best", f = 4.5)

  #Uma observação do desempenho para o problema de dimensão "dim" na config 1
  suppressPackageStartupMessages(library(ExpDE))
  # Run algorithm on problem:
  out1 <- ExpDE(mutpars = mutpars1,
               recpars = recpars1,
               popsize = popsize,
               selpars = selpars,
               stopcrit = stopcrit,
               probpars = probpars,
               showpars = list(show.iters = "dots", showevery = 20))
  # Extract observation:
  #out1$Fbest
  
  #Uma observação do desempenho para o problema de dimensão "dim" na config 2
  suppressPackageStartupMessages(library(ExpDE))
  # Run algorithm on problem:
  out2 <- ExpDE(mutpars = mutpars2,
                recpars = recpars2,
                popsize = popsize,
                selpars = selpars,
                stopcrit = stopcrit,
                probpars = probpars,
                showpars = list(show.iters = "dots", showevery = 20))
  # Extract observation:
  #out2$Fbest
#-----------------------------------------------------------------------------------
#Fim do Código do Professor
#-----------------------------------------------------------------------------------
  
  # Inserindo os dados na matriz Dados
  Dados[1,i] = dim #dim escolhido
  Dados[2,i] = out1$Fbest #valor extraido da config 1
  Dados[3,i] = out2$Fbest #valor extraido da config 2
  Dados[4,i] = (out1$Fbest-out2$Fbest) #Valor observador sem o efeito da "dim" escolhida
}

write.csv(Dados, "Dados.csv", row.names = FALSE)

#Conferindo o nº de observações
n_observacao_da_potencia = power.t.test(n = NULL, 
                                        delta = 0.5, 
                                        sd = sd(Dados[4,]), 
                                        sig.level = 0.05,
                                        power = 0.8, 
                                        type = "paired",
                                        alternative = "two.sided")
show(n_observacao_da_potencia)

power.t.test(n = NULL, 
             delta = 0.5*sd(Dados[4,]), 
             sd = sd(Dados[4,]), 
             sig.level = 0.05,
             power = 0.8, 
             type = "paired",
             alternative = "two.sided")
