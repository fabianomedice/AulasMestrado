clear all
clc

%Carregando os dados ensaio6mw.dat
Data = load ('PRBSA02.DAT');

%Separando os Sinais
SinalPRBS = Data(:,2);
SinalVazao = Data(:,3);

%Usando a função de correlação cruzada para auto correlação
%Criando as duas colunas do mesmo sinal
FAC=[SinalPRBS SinalPRBS];
lag=300;
[AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
title('FAC')

figure
%Usando a função de correlação cruzada
FCC=[SinalPRBS SinalVazao];
lag=300;
[CorrelacaoX,CorrelacaoY] = MYCCF(FCC,lag,1,1,'k');
title('FCC')

%Montando a matriz de autocorrelação
Ru= zeros(lag/2+1);

%Achando o meio do FAC, ou seja, o Ru(0)
IndiceFAC=lag/2+1;
while IndiceFAC>0
    for i=0:lag/2            
        Ru(i+1,lag/2+2-IndiceFAC)= AutoCorrelacaoY(IndiceFAC+i);        
    end
    IndiceFAC=IndiceFAC-1;
end

%Montando o vetor da correlação
Ruy= zeros(lag/2+1,1);

%Achando o meio do FCC, ou seja, o Ruy(0)
IndiceFCC=lag/2+1;

for i=0:lag/2
    Ruy(i+1)=CorrelacaoY(i+IndiceFCC);
end

H=Ru^(-1)*Ruy;

figure()
plot(H)
title('h(k)')