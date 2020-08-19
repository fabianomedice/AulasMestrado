clear all
clc

%Carregando os dados PRBSA02.dat
Data = load ('PRBSA02.DAT');

%Separando os Sinais
Tempo = Data(:,1);
SinalPRBS = Data(:,2);
SinalVazao = Data(:,3);

%Usando a função de correlação cruzada para auto correlação
%Criando as duas colunas do mesmo sinal
FAC=[SinalPRBS SinalPRBS];
lag=300;
[AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
title('FAC')

%Fazendo a função de correlação de um sinal aleatório
x = randn(length(SinalPRBS),1);
rx = [x x];
lag=300;
figure
[AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(rx,lag,1,1,'k');
title('FAC')

Decimador = 14;

%Fazendo novo sinal PRBS
for i=1:(length(SinalPRBS)/Decimador)
    NovoSinalPRBS(i) = SinalPRBS(i*Decimador);
end

figure
%Usando a função de autocorrelação cruzada de ry
rx=[NovoSinalPRBS' NovoSinalPRBS'];
lag=floor(length(NovoSinalPRBS)/2);
[CorrelacaoX,CorrelacaoY] = MYCCF(rx,lag,1,1,'k');
title('FAC')