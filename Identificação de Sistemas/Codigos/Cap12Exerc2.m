clear all
clc

%Carregando os dados PRBSA02.dat
Data = load ('PRBSA02.DAT');

%Separando os Sinais
Tempo = Data(:,1);
SinalPRBS = Data(:,2);
SinalVazao = Data(:,3);

%--------------------------------------------------------------------------
% Para o Sinal PRBS
%--------------------------------------------------------------------------

figure
%Usando a função de autocorrelação cruzada de ry
rx=[SinalPRBS SinalPRBS];
lag=floor(length(SinalPRBS)/2);
[CorrelacaoX,CorrelacaoY] = MYCCF(rx,lag,1,1,'k');
title('rx')

figure
%Usando a função de autocorrelação cruzada de ry^2
rx2=[SinalPRBS.^2 SinalPRBS.^2];
lag=floor(length(SinalPRBS)/2);
[CorrelacaoX2,CorrelacaoY2] = MYCCF(rx2,lag,1,1,'k');
title('rx^2')
%Por ry^2, não há correlações não linearidades

%Procurando o menor valor para achar o atraso
MenorRx = min(CorrelacaoY);
for i=1:length(CorrelacaoY)
    if CorrelacaoY(i)== MenorRx
        Atraso = CorrelacaoX(i);
    end
end

%informando qual variavel está sendo trabalhada
disp('Sinal PRBS')

if Atraso > 20
    disp('Sinal superamostrado');
    DecimadorPRBS = round(Atraso/15)
else %<=20
    if Atraso < 10
        disp('Sinal subamostrado');
    else %>= 10
        disp('Sinal bem amostrado')
    end
end

%--------------------------------------------------------------------------
% Para o Sinal Vazão
%--------------------------------------------------------------------------

figure
%Usando a função de autocorrelação cruzada de ry
ry=[SinalVazao SinalVazao];
lag=floor(length(SinalVazao)/2);
[CorrelacaoX,CorrelacaoY] = MYCCF(ry,lag,1,1,'k');
title('ry')

figure
%Usando a função de autocorrelação cruzada de ry^2
ry2=[SinalVazao.^2 SinalVazao.^2];
lag=floor(length(SinalVazao)/2);
[CorrelacaoX2,CorrelacaoY2] = MYCCF(ry2,lag,1,1,'k');
title('ry^2')
%Por ry^2, não há correlações não linearidades

%Procurando o menor valor para achar o atraso
MenorRy = min(CorrelacaoY);
for i=1:length(CorrelacaoY)
    if CorrelacaoY(i)== MenorRy
        Atraso = CorrelacaoX(i);
    end
end

%informando qual variavel está sendo trabalhada
disp('Sinal Vazão')

if Atraso > 20
    disp('Sinal superamostrado');
    DecimadorVazao = round(Atraso/15)
else %<=20
    if Atraso < 10
        disp('Sinal subamostrado');
    else %>= 10
        disp('Sinal bem amostrado')
    end
end

%--------------------------------------------------------------------------
% Decimando os sinais
%--------------------------------------------------------------------------

%Fazendo a escolha do Decimador
if DecimadorVazao>DecimadorPRBS
    Decimador = DecimadorVazao
else
    Decimador = DecimadorPRBS
end


%Fazendo novo sinal PRBS
for i=1:(length(SinalPRBS)/Decimador)
    NovoSinalPRBS(i) = SinalPRBS(i*Decimador);
end

figure
%Usando a função de autocorrelação cruzada de ry
rx=[NovoSinalPRBS' NovoSinalPRBS'];
lag=floor(length(NovoSinalPRBS)/2);
[CorrelacaoX,CorrelacaoY] = MYCCF(rx,lag,1,1,'k');
title('rx')

%Procurando o menor valor para achar o atraso
MenorRx = min(CorrelacaoY);
for i=1:length(CorrelacaoY)
    if CorrelacaoY(i)== MenorRx
        Atraso = CorrelacaoX(i);
    end
end

%informando qual variavel está sendo trabalhada
disp('Sinal PRBS Decimado')

if Atraso > 20
    disp('Sinal superamostrado');
    DecimadorTeste = round(Atraso/15)
else %<=20
    if Atraso < 10
        disp('Sinal subamostrado');
    else %>= 10
        disp('Sinal bem amostrado')
    end
end

%Fazendo novo sinal Vazão
for i=1:(length(SinalVazao)/Decimador)
    NovoSinalVazao(i) = SinalVazao(i*Decimador);
end

figure
%Usando a função de autocorrelação cruzada de ry
ry=[NovoSinalVazao' NovoSinalVazao'];
lag=floor(length(NovoSinalVazao)/2);
[CorrelacaoX,CorrelacaoY] = MYCCF(ry,lag,1,1,'k');
title('ry')

%Procurando o menor valor para achar o atraso
MenorRy = min(CorrelacaoY);
for i=1:length(CorrelacaoY)
    if CorrelacaoY(i)== MenorRy
        Atraso = CorrelacaoX(i);
    end
end

%informando qual variavel está sendo trabalhada
disp('Sinal Vazão Decimado')

if Atraso > 20
    disp('Sinal superamostrado');
    DecimadorTeste = round(Atraso/15)
else %<=20
    if Atraso < 10
        disp('Sinal subamostrado');
    else %>= 10
        disp('Sinal bem amostrado')
    end
end

%--------------------------------------------------------------------------
% Contando intervalos do PRBS
%--------------------------------------------------------------------------

MediaPRBS = mean(SinalPRBS)
MediaNovoPRBS = mean(NovoSinalPRBS)

%Definindo os vetores dos intervalos
IntSupPRBS = zeros(length(SinalPRBS),1);
IntInfPRBS = zeros(length(SinalPRBS),1);
IntSupNovoPRBS = zeros(length(NovoSinalPRBS),1);
IntInfNovoPRBS = zeros(length(NovoSinalPRBS),1);

%---------------------------------------------
%Para o PRBS
%---------------------------------------------
%Iniciando os contadores
AtrasoSup = 0;
AtrasoInf = 0;
ContadorSup = 0;
ContadorInf = 0;

for i=1:length(SinalPRBS)-1 %Retira o ultimo valor do vetor
    if SinalPRBS(i)< MediaPRBS
        %Abaixo da media - Intervalo Inferior
        AtrasoSup = 0; %Zera o atraso do outro intervalo
        AtrasoInf = AtrasoInf+1; %Avança o contador de atraso
        if SinalPRBS(i+1)>MediaPRBS %O proximo mudou de intervalo
            ContadorInf = ContadorInf+1; %Muda o indice do vetor
            IntInfPRBS(ContadorInf)=AtrasoInf; %Adiciona o numero de amostras daquele intervalo
        end
    else
        %Acima da media - Intervalo Superior
        AtrasoInf = 0; %Zera o atraso do outro intervalo
        AtrasoSup = AtrasoSup+1; %Avança o contador de atraso
        if SinalPRBS(i+1)<MediaPRBS %O proximo mudou de intervalo
            ContadorSup = ContadorSup+1; %Muda o indice do vetor
            IntSupPRBS(ContadorSup)=AtrasoSup; %Adiciona o numero de amostras daquele intervalo
        end
    end
end
%Fazendo o ultimo valor do Sinal
%Se o intervalo se manteve o mesmo, não tenho o ultimo valor do intervalo

if SinalPRBS(i)<MediaPRBS
    %Abaixo da media - Intervalo Inferior
    if SinalPRBS(i+1)<MediaPRBS
        %Abaixo da media - Intervalo Inferior
        %Ambos são do patamar inferior. Então não tenho o ultimo intervalor inferior no vetor
        AtrasoInf = AtrasoInf+1;%Avança o contador de atraso
        ContadorInf = ContadorInf+1; %Muda o indice do vetor
        IntInfPRBS(ContadorInf)=AtrasoInf; %Adiciona o numero de amostras daquele intervalo
    else %O ultimo ponto não é o mesmo patamar, então só não tenho o ultimo ponto do outro intervalo
        %Acima da media - Intervalo Superior
        AtrasoSup = AtrasoSup+1; %Avança o contador de atraso
        ContadorSup = ContadorSup+1; %Muda o indice do vetor
        IntSupPRBS(ContadorSup)=AtrasoSup; %Adiciona o numero de amostras daquele intervalo
    end
else
    %Acima da media - Intervalo Superior
    if SinalPRBS(i+1)>MediaPRBS
        %Acima da media - Intervalo Superior
        %Ambos são do patamar Superior. Então não tenho o ultimo intervalor superior no vetor
        AtrasoSup = AtrasoSup+1; %Avança o contador de atraso
        ContadorSup = ContadorSup+1; %Muda o indice do vetor
        IntSupPRBS(ContadorSup)=AtrasoSup; %Adiciona o numero de amostras daquele intervalo
    else %O ultimo ponto não é o mesmo patamar, então só não tenho o ultimo ponto do outro intervalo
        %Abaixo da media - Intervalo Inferior
        AtrasoInf = AtrasoInf+1; %Avança o contador de atraso
        ContadorInf = ContadorInf+1; %Muda o indice do vetor
        IntInfPRBS(ContadorInf)=AtrasoInf; %Adiciona o numero de amostras daquele intervalo
    end    
end

%---------------------------------------------
%Para o Novo PRBS
%---------------------------------------------
%Iniciando os contadores
AtrasoSup = 0;
AtrasoInf = 0;
ContadorSup = 0;
ContadorInf = 0;

for i=1:length(NovoSinalPRBS)-1 %Retira o ultimo valor do vetor
    if NovoSinalPRBS(i)< MediaNovoPRBS
        %Abaixo da media - Intervalo Inferior
        AtrasoSup = 0; %Zera o atraso do outro intervalo
        AtrasoInf = AtrasoInf+1; %Avança o contador de atraso
        if NovoSinalPRBS(i+1)>MediaNovoPRBS %O proximo mudou de intervalo
            ContadorInf = ContadorInf+1; %Muda o indice do vetor
            IntInfNovoPRBS(ContadorInf)=AtrasoInf; %Adiciona o numero de amostras daquele intervalo
        end
    else
        %Acima da media - Intervalo Superior
        AtrasoInf = 0; %Zera o atraso do outro intervalo
        AtrasoSup = AtrasoSup+1; %Avança o contador de atraso
        if NovoSinalPRBS(i+1)<MediaNovoPRBS %O proximo mudou de intervalo
            ContadorSup = ContadorSup+1; %Muda o indice do vetor
            IntSupNovoPRBS(ContadorSup)=AtrasoSup; %Adiciona o numero de amostras daquele intervalo
        end
    end
end
%Fazendo o ultimo valor do Sinal
%Se o intervalo se manteve o mesmo, não tenho o ultimo valor do intervalo

if NovoSinalPRBS(i)<MediaNovoPRBS
    %Abaixo da media - Intervalo Inferior
    if NovoSinalPRBS(i+1)<MediaNovoPRBS
        %Abaixo da media - Intervalo Inferior
        %Ambos são do patamar inferior. Então não tenho o ultimo intervalor inferior no vetor
        AtrasoInf = AtrasoInf+1;%Avança o contador de atraso
        ContadorInf = ContadorInf+1; %Muda o indice do vetor
        IntInfNovoPRBS(ContadorInf)=AtrasoInf; %Adiciona o numero de amostras daquele intervalo
    else %O ultimo ponto não é o mesmo patamar, então só não tenho o ultimo ponto do outro intervalo
        %Acima da media - Intervalo Superior
        AtrasoSup = AtrasoSup+1; %Avança o contador de atraso
        ContadorSup = ContadorSup+1; %Muda o indice do vetor
        IntSupNovoPRBS(ContadorSup)=AtrasoSup; %Adiciona o numero de amostras daquele intervalo
    end
else
    %Acima da media - Intervalo Superior
    if NovoSinalPRBS(i+1)>MediaNovoPRBS
        %Acima da media - Intervalo Superior
        %Ambos são do patamar Superior. Então não tenho o ultimo intervalor superior no vetor
        AtrasoSup = AtrasoSup+1; %Avança o contador de atraso
        ContadorSup = ContadorSup+1; %Muda o indice do vetor
        IntSupNovoPRBS(ContadorSup)=AtrasoSup; %Adiciona o numero de amostras daquele intervalo
    else %O ultimo ponto não é o mesmo patamar, então só não tenho o ultimo ponto do outro intervalo
        %Abaixo da media - Intervalo Inferior
        AtrasoInf = AtrasoInf+1; %Avança o contador de atraso
        ContadorInf = ContadorInf+1; %Muda o indice do vetor
        IntInfNovoPRBS(ContadorInf)=AtrasoInf; %Adiciona o numero de amostras daquele intervalo
    end    
end


%Obtendo apenas o vetor com os valores dos intervalos
IntSupPRBS = nonzeros(IntSupPRBS);
IntInfPRBS = nonzeros(IntInfPRBS);
IntSupNovoPRBS = nonzeros(IntSupNovoPRBS);
IntInfNovoPRBS = nonzeros(IntInfNovoPRBS);
