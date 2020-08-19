clear all
clc

%Usando a função PRBS conforme a figura 4.10 do Livro
%Sequencia m com n=6
n=6;
%Sequencia m com nível lógico 0 e 1
m=1;
Sinal=PRBS(190,n,m);

plot(Sinal)
xlabel('amostras');
axis([0 190 -0.5 1.5])

%Usando a função de correlação cruzada para auto correlação
%Criando as duas colunas do mesmo sinal
c=[Sinal' Sinal'];
lag=190;
AutoCorrelacao = MYCCF(c,lag,1,1,'k');