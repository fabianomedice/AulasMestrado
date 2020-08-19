%% ------------------------------------------------------------------------
%Trabalhando com Simulação do 500Hz
%  ------------------------------------------------------------------------
clear
clc
close all

%Carregando os dados gerados pelo o artigo
load ('Simulacao500Hz.mat');
%Periodo de Amostragem
T = 0.002;

%Criando as Variaveis
Velocidade = sqrt(s(2,:).^2+s(4,:).^2); %Vetor Modulo da Velocidade em m/s
DeslocamentoY = s(3,:)/1000; %Deslocamento em km
DeslocamentoX = s(1,:)/1000; %Deslocamento em km

%% Trabalhando com a variável deslocamento Y - FAC

% %Usando a função de correlação cruzada para auto correlação
% figure()
% FAC=[DeslocamentoY' DeslocamentoY'];
% lag=length(DeslocamentoY);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC de Y')
% 
% %Conferindo autocorrelação não linear
% figure()
% FAC2=[DeslocamentoY.^2' DeslocamentoY.^2'];
% lag=length(DeslocamentoY);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC2,lag,1,1,'k');
% title('FAC^2 de Y')
% 
% figure()
% FAC3=[DeslocamentoY.^3' DeslocamentoY.^3'];
% lag=length(DeslocamentoY);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC3,lag,1,1,'k');
% title('FAC^3 de Y')

%% Trabalhando com a variável deslocamento X - FAC

% %Usando a função de correlação cruzada para auto correlação
% figure()
% FAC=[DeslocamentoX' DeslocamentoX'];
% lag=length(DeslocamentoX);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC de X')
% 
% %Conferindo autocorrelação não linear
% figure()
% FAC2=[DeslocamentoX.^2' DeslocamentoX.^2'];
% lag=length(DeslocamentoX);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC2,lag,1,1,'k');
% title('FAC^2 de X')
% 
% figure()
% FAC3=[DeslocamentoX.^3' DeslocamentoX.^3'];
% lag=length(DeslocamentoX);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC3,lag,1,1,'k');
% title('FAC^3 de X')

%% Trabalhando com a variável velocidade - FAC

% %Usando a função de correlação cruzada para auto correlação
% figure()
% FAC=[Velocidade' Velocidade'];
% lag=length(Velocidade);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC de Velocidade')
% 
% %Conferindo autocorrelação não linear
% figure()
% FAC2=[Velocidade.^2' Velocidade.^2'];
% lag=length(Velocidade);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC2,lag,1,1,'k');
% title('FAC^2 de Velocidade')
% 
% figure()
% FAC3=[Velocidade.^3' Velocidade.^3'];
% lag=length(Velocidade);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC3,lag,1,1,'k');
% title('FAC^3 de Velocidade')

%% Decimando as variáveis
%Fazendo novo sinal decimado
Decimador = 1080;
for i=1:(length(DeslocamentoY)/Decimador)
    DeslocamentoYD(i) = DeslocamentoY(i*Decimador);
    DeslocamentoXD(i) = DeslocamentoX(i*Decimador);
    VelocidadeD(i) = Velocidade(i*Decimador);
end

% figure()
% plot(T*Decimador*(0:(length(DeslocamentoYD)-1)),DeslocamentoYD)
% xlabel('Tempo [s]')
% ylabel('Deslocamento [km]')
% title('Deslocamento no eixo Y Decimado')
% 
% figure()
% plot(T*Decimador*(0:(length(DeslocamentoXD)-1)),DeslocamentoXD)
% xlabel('Tempo [s]')
% ylabel('Deslocamento [km]')
% title('Deslocamento no eixo X Decimado')
% 
% figure()
% plot(T*Decimador*(0:(length(VelocidadeD)-1)),VelocidadeD)
% xlabel('Tempo [s]')
% ylabel('Velocidade [m/s]')
% title('Velocidade do alvo por segundo Decimado')

%Usando a função de correlação cruzada para auto correlação
% figure()
% FAC=[DeslocamentoYD' DeslocamentoYD'];
% lag=length(DeslocamentoYD);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC de Y Decimado')
% 
% figure()
% FAC=[DeslocamentoXD' DeslocamentoXD'];
% lag=length(DeslocamentoXD);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC de X Decimado')
% 
% figure()
% FAC=[VelocidadeD' VelocidadeD'];
% lag=length(VelocidadeD);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC de Velocidade Decimada')

%% Fazendo as correlações cruzadas - FCC

% %Deslocamento Y - Velocidade
% figure()
% FCC=[DeslocamentoYD' VelocidadeD'];
% lag=length(DeslocamentoYD);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FCC,lag,1,1,'k');
% title('FCC de Y x Velocidade')
% 
% %Deslocamento X - Velocidade
% figure()
% FCC=[DeslocamentoXD' VelocidadeD'];
% lag=length(DeslocamentoXD);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FCC,lag,1,1,'k');
% title('FCC de X x Velocidade')
% 
% %Deslocamento Y - Deslocamento X
% figure()
% FCC=[DeslocamentoYD' DeslocamentoXD'];
% lag=length(DeslocamentoYD);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FCC,lag,1,1,'k');
% title('FCC de Y x X')

%% Modelo ARMA para correlação espúria

%Criando um modelo para Deslocamento Y para filtrar o Deslocamento X

%Considerando um modelo de segunda ordem -> Yest[k] = a1 Yest[k-1] + a2 Yest[k-2] + c1 (Y[k-1]-Yest[k-1]) + c2 (Y[k-2]-Yest[k-2])

%Criando o vetor de Y estimado
Yest = zeros(1,length(DeslocamentoYD));
Yest(1) = DeslocamentoYD(1);
Yest(2) = DeslocamentoYD(2);
%Criando o Vetor de residuos
ResiduoMQR1 = zeros(1,length(DeslocamentoYD));

%Definindo a primeira covariancia do sistema
Pk=1000*eye(4);
%Criando o vetor de parametros - [a1 a2 c1 c2]
Parametros=zeros(4,1);

%Usando Minimos Quadrados Recursivo Estendido com Simulação 1 passo a frente
for k=3:length(DeslocamentoYD) %retirando os dois primeiros valores para carregar o sistema
    
    Regressores=[DeslocamentoYD(k-1) DeslocamentoYD(k-2) ResiduoMQR1(k-1) ResiduoMQR1(k-2)]';
    Kk =(Pk*Regressores)/(Regressores'*Pk*Regressores+1);
    Parametros = Parametros +Kk*(DeslocamentoYD(k)-Regressores'*Parametros);
    Pk=Pk-Kk*Regressores'*Pk;
    
    %Atualizando o Residuo
    Yest(k) = Regressores'*Parametros;
    ResiduoMQR1(k) = DeslocamentoYD(k) - Yest(k);
    
end

%Usando os mesmos parametros, cria-se Xest
%Criando o vetor de Y estimado
Xest = zeros(1,length(DeslocamentoXD));
Xest(1) = DeslocamentoXD(1);
Xest(2) = DeslocamentoXD(2);
%Criando o Vetor de residuos
ResiduoX = zeros(1,length(DeslocamentoXD));

%Criando o vetor Xest
for k=3:length(DeslocamentoYD) %retirando os dois primeiros valores para carregar o sistema
    
    Regressores=[DeslocamentoXD(k-1) DeslocamentoXD(k-2) ResiduoX(k-1) ResiduoX(k-2)]';
    %Atualizando o Residuo
    Xest(k) = Regressores'*Parametros;
    ResiduoX(k) = DeslocamentoXD(k) - Xest(k);
    
end

%Conferindo se existe correlação entre DeslocamentoX e DeslocamentoY
% figure()
% FCC=[ResiduoY' ResiduoX'];
% lag=length(ResiduoY);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FCC,lag,1,1,'k');
% title('FCC do ResiduoY x ResiduoX')

%% ------------------------------------------------------------------------
%Trabalhando com Simulação do PRBS
%  ------------------------------------------------------------------------
clear
clc
close all

%Carregando os dados gerados pelo o artigo
load ('SimulacaoPRBS1.mat');
%Periodo de Amostragem
T = 2;

%Criando as Variaveis
Velocidade = sqrt(s(2,:).^2+s(4,:).^2); %Vetor Modulo da Velocidade em m/s
DeslocamentoY = s(3,:); %Deslocamento em m
DeslocamentoX = s(1,:); %Deslocamento em m

%% Minimos Quadrados - MQ
%Modelo 1 passo a frente de 1 ordem
%VelocidadeEst [k] = a Velocidade [k-1] + b DeslocamentoY [k-1] + c DeslocamentoX [k-1]
%Criando o vetor de Velocidade estimado
VMQ1 = zeros(1,length(Velocidade));

%Criando a matriz de regressores
Regressores = zeros(length(VMQ1),3);

for k=1:length(VMQ1) 
    
    Regressores(k,:)=[Velocidade(k) DeslocamentoY(k) DeslocamentoX(k)]';
    
end
%Criando o vetor de parametros - [a b c]
Parametros1=zeros(3,1);

Parametros1 = (Regressores'*Regressores)^(-1)*Regressores'*Velocidade';

%Criando o modelo
VMQ1(1) = Velocidade(1);

for k=2:length(VMQ1) 
    
    VMQ1(k) = Regressores(k,:)*Parametros1;
    
end
%Criando o Vetor de residuos
ResiduoMQ1 = zeros(1,length(Velocidade));
for k=1:length(VMQ1) 

    ResiduoMQ1(k) = Velocidade(k) - VMQ1(k);
    
end

% figure()
% FAC=[ResiduoMQ1' ResiduoMQ1'];
% lag=length(ResiduoMQ1);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do MQ 1 grau')

%Modelo 1 passo a frente de 2 ordem
%VelocidadeEst [k] = a1 Velocidade [k-1] + a2 Velocidade [k-2] +b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]
%Criando o vetor de Velocidade estimado
VMQ2 = zeros(1,length(Velocidade));

%Criando a matriz de regressores
Regressores = zeros(length(VMQ2),6);

for k=2:length(VMQ2) 
    
    Regressores(k,:)=[Velocidade(k) Velocidade(k-1) DeslocamentoY(k) DeslocamentoY(k-1) DeslocamentoX(k) DeslocamentoX(k-1)]';
    
end
%Criando o vetor de parametros - [a1 a2 b1 b2 c1 c2]
Parametros2=zeros(6,1);

Parametros2 = (Regressores'*Regressores)^(-1)*Regressores'*Velocidade';

%Criando o modelo
VMQ2(1) = Velocidade(1);
VMQ2(2) = Velocidade(2);

for k=3:length(VMQ2) 
    
    VMQ2(k) = Regressores(k,:)*Parametros2;
    
end
%Criando o Vetor de residuos
ResiduoMQ2 = zeros(1,length(Velocidade));
for k=1:length(VMQ2) 

    ResiduoMQ2(k) = Velocidade(k) - VMQ2(k);
    
end

% figure()
% FAC=[ResiduoMQ2' ResiduoMQ2'];
% lag=length(ResiduoMQ2);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do MQ 2 grau')

%Modelo 1 passo a frente de 3 ordem
%VelocidadeEst [k] = a1 Velocidade [k-1]+a2 Velocidade [k-2]+a3 Velocidade [k-3]+ b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ b3 DeslocamentoY [k-3]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]+ c3 DeslocamentoX [k-3]
%Criando o vetor de Velocidade estimado
VMQ3 = zeros(1,length(Velocidade));

%Criando a matriz de regressores
Regressores = zeros(length(VMQ3),9);

for k=3:length(VMQ3) 
    
    Regressores(k,:)=[Velocidade(k) Velocidade(k-1) Velocidade(k-2) DeslocamentoY(k) DeslocamentoY(k-1) DeslocamentoY(k-2) DeslocamentoX(k) DeslocamentoX(k-1) DeslocamentoX(k-2)]';
    
end
%Criando o vetor de parametros - [a1 a2 a3 b1 b2 b3 c1 c2 c3]
Parametros3=zeros(9,1);

Parametros3 = (Regressores'*Regressores)^(-1)*Regressores'*Velocidade';

%Criando o modelo
VMQ3(1) = Velocidade(1);
VMQ3(2) = Velocidade(2);
VMQ3(3) = Velocidade(3);

for k=4:length(VMQ3) 
    
    VMQ3(k) = Regressores(k,:)*Parametros3;
    
end
%Criando o Vetor de residuos
ResiduoMQ3 = zeros(1,length(Velocidade));
for k=1:length(VMQ3) 

    ResiduoMQ3(k) = Velocidade(k) - VMQ3(k);
    
end

% figure()
% FAC=[ResiduoMQ3' ResiduoMQ3'];
% lag=length(ResiduoMQ3);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do MQ 3 grau')

%% Minimos Quadrados Estendido - MQE
% % % % %Modelo 1 passo a frente de 1 ordem
% % % % %VelocidadeEst [k] = a Velocidade [k-1] + b DeslocamentoY [k-1] + c DeslocamentoX [k-1] + d ResiduoMQ [k-1]
% % % % %Criando o vetor de Velocidade estimado
% % % % VMQE1 = zeros(1,length(Velocidade));
% % % % 
% % % % %Criando a matriz de regressores
% % % % Regressores = zeros(length(VMQE1),4);
% % % % 
% % % % for k=1:length(VMQE1) 
% % % %     
% % % %     Regressores(k,:)=[Velocidade(k) DeslocamentoY(k) DeslocamentoX(k) ResiduoMQ1(k)]';
% % % %     
% % % % end
% % % % %Criando o vetor de parametros - [a b c d]
% % % % Parametros1=zeros(4,1);
% % % % 
% % % % Parametros1 = (Regressores'*Regressores)^(-1)*Regressores'*Velocidade';
% % % % 
% % % % %Criando o modelo
% % % % VMQE1(1) = Velocidade(1);
% % % % 
% % % % for k=2:length(VMQE1) 
% % % %     
% % % %     VMQE1(k) = Regressores(k,:)*Parametros1;
% % % %     
% % % % end
% % % % %Criando o Vetor de residuos
% % % % ResiduoMQE1 = zeros(1,length(Velocidade));
% % % % for k=1:length(VMQE1) 
% % % % 
% % % %     ResiduoMQ1(k) = Velocidade(k) - VMQE1(k);
% % % %     
% % % % end
% % % % 
% % % % figure()
% % % % FAC=[ResiduoMQE1' ResiduoMQE1'];
% % % % lag=length(ResiduoMQE1);
% % % % [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% % % % title('FAC do Residuo do MQE 1 grau')
% % % % 
% % % % %Modelo 1 passo a frente de 2 ordem
% % % % %VelocidadeEst [k] = a1 Velocidade [k-1] + a2 Velocidade [k-2] +b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2] + d1 ResiduoMQ [k-1] + d2 ResiduoMQ [k-2]
% % % % %Criando o vetor de Velocidade estimado
% % % % VMQE2 = zeros(1,length(Velocidade));
% % % % 
% % % % %Criando a matriz de regressores
% % % % Regressores = zeros(length(VMQE2),8);
% % % % 
% % % % for k=2:length(VMQE2) 
% % % %     
% % % %     Regressores(k,:)=[Velocidade(k) Velocidade(k-1) DeslocamentoY(k) DeslocamentoY(k-1) DeslocamentoX(k) DeslocamentoX(k-1) ResiduoMQ2(k) ResiduoMQ2(k-1)]';
% % % %     
% % % % end
% % % % %Criando o vetor de parametros - [a1 a2 b1 b2 c1 c2 d1 d2]
% % % % Parametros2=zeros(8,1);
% % % % 
% % % % Parametros2 = (Regressores'*Regressores)^(-1)*Regressores'*Velocidade';
% % % % 
% % % % %Criando o modelo
% % % % VMQE2(1) = Velocidade(1);
% % % % VMQE2(2) = Velocidade(2);
% % % % 
% % % % for k=3:length(VMQE2) 
% % % %     
% % % %     VMQE2(k) = Regressores(k,:)*Parametros2;
% % % %     
% % % % end
% % % % %Criando o Vetor de residuos
% % % % ResiduoMQE2 = zeros(1,length(Velocidade));
% % % % for k=1:length(VMQE2) 
% % % % 
% % % %     ResiduoMQE2(k) = Velocidade(k) - VMQE2(k);
% % % %     
% % % % end
% % % % 
% % % % figure()
% % % % FAC=[ResiduoMQE2' ResiduoMQE2'];
% % % % lag=length(ResiduoMQE2);
% % % % [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% % % % title('FAC do Residuo do MQE 2 grau')
% % % % 
% % % % %Modelo 1 passo a frente de 3 ordem
% % % % %VelocidadeEst [k] = a1 Velocidade [k-1]+a2 Velocidade [k-2]+a3 Velocidade [k-3]+ b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ b3 DeslocamentoY [k-3]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]+ c3 DeslocamentoX [k-3]+ d1 ResiduoMQ [k-1] + d2 ResiduoMQ [k-2]+ d3 ResiduoMQ [k-3]
% % % % %Criando o vetor de Velocidade estimado
% % % % VMQE3 = zeros(1,length(Velocidade));
% % % % 
% % % % %Criando a matriz de regressores
% % % % Regressores = zeros(length(VMQE3),12);
% % % % 
% % % % for k=3:length(VMQE3) 
% % % %     
% % % %     Regressores(k,:)=[Velocidade(k) Velocidade(k-1) Velocidade(k-2) DeslocamentoY(k) DeslocamentoY(k-1) DeslocamentoY(k-2) DeslocamentoX(k) DeslocamentoX(k-1) DeslocamentoX(k-2) ResiduoMQ3(k) ResiduoMQ3(k-1) ResiduoMQ3(k-2)]';
% % % %     
% % % % end
% % % % %Criando o vetor de parametros - [a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3]
% % % % Parametros3=zeros(12,1);
% % % % 
% % % % Parametros3 = (Regressores'*Regressores)^(-1)*Regressores'*Velocidade';
% % % % 
% % % % %Criando o modelo
% % % % VMQE3(1) = Velocidade(1);
% % % % VMQE3(2) = Velocidade(2);
% % % % VMQE3(3) = Velocidade(3);
% % % % 
% % % % for k=4:length(VMQE3) 
% % % %     
% % % %     VMQE3(k) = Regressores(k,:)*Parametros3;
% % % %     
% % % % end
% % % % %Criando o Vetor de residuos
% % % % ResiduoMQE3 = zeros(1,length(Velocidade));
% % % % for k=1:length(VMQE3) 
% % % % 
% % % %     ResiduoMQE3(k) = Velocidade(k) - VMQE3(k);
% % % %     
% % % % end
% % % % 
% % % % figure()
% % % % FAC=[ResiduoMQE3' ResiduoMQE3'];
% % % % lag=length(ResiduoMQE3);
% % % % [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% % % % title('FAC do Residuo do MQE 3 grau')


%% Minimos Quadrados Recursivo - MQR
%Modelo 1 passo a frente de 1 ordem
%VelocidadeEst [k] = a Velocidade [k-1] + b DeslocamentoY [k-1] + c DeslocamentoX [k-1]
%Criando o vetor de Velocidade estimado
VMQR1 = zeros(1,length(Velocidade));
VMQR1(1) = Velocidade(1);

%Criando o Vetor de residuos
ResiduoMQR1 = zeros(1,length(Velocidade));

%Definindo a primeira covariancia do sistema
Pk=1000*eye(3);
%Criando o vetor de parametros - [a b c]
Parametros1=zeros(3,1);

%Usando Minimos Quadrados Recursivo Estendido com Simulação 1 passo a frente
for k=2:length(VMQR1) %retirando o primeiro valor para carregar o sistema
    
    Regressores=[Velocidade(k-1) DeslocamentoY(k-1) DeslocamentoX(k-1)]';
    Kk =(Pk*Regressores)/(Regressores'*Pk*Regressores+1);
    Parametros1 = Parametros1 +Kk*(Velocidade(k)-Regressores'*Parametros1);
    Pk=Pk-Kk*Regressores'*Pk;
    
    %Atualizando o Residuo
    VMQR1(k) = Regressores'*Parametros1;
    ResiduoMQR1(k) = Velocidade(k) - VMQR1(k);
    
end

% figure()
% FAC=[ResiduoMQR1' ResiduoMQR1'];
% lag=length(ResiduoMQR1);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do MQR 1 grau')

%Modelo 1 passo a frente de 2 ordem
%VelocidadeEst [k] = a1 Velocidade [k-1] + a2 Velocidade [k-2] +b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]
%Criando o vetor de Velocidade estimado
VMQR2 = zeros(1,length(Velocidade));
VMQR2(1) = Velocidade(1);
VMQR2(2) = Velocidade(2);

%Criando o Vetor de residuos
ResiduoMQR2 = zeros(1,length(Velocidade));

%Definindo a primeira covariancia do sistema
Pk=1000*eye(6);
%Criando o vetor de parametros - [a1 a2 b1 b2 c1 c2]
Parametros=zeros(6,1);

%Usando Minimos Quadrados Recursivo com Simulação 1 passo a frente
for k=3:length(VMQR2) %retirando os dois primeiros valores para carregar o sistema
    
    Regressores=[Velocidade(k-1) Velocidade(k-2) DeslocamentoY(k-1) DeslocamentoY(k-2) DeslocamentoX(k-1) DeslocamentoX(k-2)]';
    Kk =(Pk*Regressores)/(Regressores'*Pk*Regressores+1);
    Parametros = Parametros +Kk*(Velocidade(k)-Regressores'*Parametros);
    Pk=Pk-Kk*Regressores'*Pk;
    
    %Atualizando o Residuo
    VMQR2(k) = Regressores'*Parametros;
    ResiduoMQR2(k) = Velocidade(k) - VMQR2(k);
    
end

% figure()
% FAC=[ResiduoMQR2' ResiduoMQR2'];
% lag=length(ResiduoMQR2);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do MQR 2 grau')

%Modelo 1 passo a frente de 3 ordem
%VelocidadeEst [k] = a1 Velocidade [k-1]+a2 Velocidade [k-2]+a3 Velocidade [k-3]+ b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ b3 DeslocamentoY [k-3]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]+ c3 DeslocamentoX [k-3]
%Criando o vetor de Velocidade estimado
VMQR3 = zeros(1,length(Velocidade));
VMQR3(1) = Velocidade(1);
VMQR3(2) = Velocidade(2);
VMQR3(3) = Velocidade(3);

%Criando o Vetor de residuos
ResiduoMQR3 = zeros(1,length(Velocidade));

%Definindo a primeira covariancia do sistema
Pk=1000*eye(9);
%Criando o vetor de parametros - [a1 a2 a3 b1 b2 b3 c1 c2 c3]
Parametros=zeros(9,1);

%Usando Minimos Quadrados Recursivo com Simulação 1 passo a frente
for k=4:length(VMQR3) %retirando o primeiro valor para carregar o sistema
    
    Regressores=[Velocidade(k-1) Velocidade(k-2) Velocidade(k-3) DeslocamentoY(k-1) DeslocamentoY(k-2) DeslocamentoY(k-3) DeslocamentoX(k-1) DeslocamentoX(k-2) DeslocamentoX(k-3)]';
    Kk =(Pk*Regressores)/(Regressores'*Pk*Regressores+1);
    Parametros = Parametros +Kk*(Velocidade(k)-Regressores'*Parametros);
    Pk=Pk-Kk*Regressores'*Pk;
    
    %Atualizando o Residuo
    VMQR3(k) = Regressores'*Parametros;
    ResiduoMQR3(k) = Velocidade(k) - VMQR3(k);
    
end

% figure()
% FAC=[ResiduoMQR3' ResiduoMQR3'];
% lag=length(ResiduoMQR3);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do MQR 3 grau')

%% Minimos Quadrados Recursivo Estendido - MQRE

%Modelo 1 passo a frente de 1 ordem
%VelocidadeEst [k] = a Velocidade [k-1] + b DeslocamentoY [k-1] + c DeslocamentoX [k-1] + d(Velocidade [k-1] - VelocidadeEst[k-1])
%Criando o vetor de Velocidade estimado
VMQRE1 = zeros(1,length(Velocidade));
VMQRE1(1) = Velocidade(1);

%Criando o Vetor de residuos
ResiduoMQRE1 = zeros(1,length(Velocidade));

%Definindo a primeira covariancia do sistema
Pk=1000*eye(4);
%Criando o vetor de parametros - [a b c d]
Parametros1=zeros(4,1);

%Usando Minimos Quadrados Recursivo Estendido com Simulação 1 passo a frente
for k=2:length(VMQRE1) %retirando o primeiro valor para carregar o sistema
    
    Regressores=[Velocidade(k-1) DeslocamentoY(k-1) DeslocamentoX(k-1) ResiduoMQRE1(k-1)]';
    Kk =(Pk*Regressores)/(Regressores'*Pk*Regressores+1);
    Parametros1 = Parametros1 +Kk*(Velocidade(k)-Regressores'*Parametros1);
    Pk=Pk-Kk*Regressores'*Pk;
    
    %Atualizando o Residuo
    VMQRE1(k) = Regressores'*Parametros1;
    ResiduoMQRE1(k) = Velocidade(k) - VMQRE1(k);
    
end

% figure()
% FAC=[ResiduoMQRE1' ResiduoMQRE1'];
% lag=length(ResiduoMQRE1);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do MQRE 1 grau')

%Modelo 1 passo a frente de 2 ordem
%VelocidadeEst [k] = a1 Velocidade [k-1] + a2 Velocidade [k-2] +b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2] + d1(Velocidade [k-1] - VelocidadeEst[k-1])+ d2(Velocidade [k-2] - VelocidadeEst[k-2])
%Criando o vetor de Velocidade estimado
VMQRE2 = zeros(1,length(Velocidade));
VMQRE2(1) = Velocidade(1);
VMQRE2(2) = Velocidade(2);

%Criando o Vetor de residuos
ResiduoMQRE2 = zeros(1,length(Velocidade));

%Definindo a primeira covariancia do sistema
Pk=1000*eye(8);
%Criando o vetor de parametros - [a1 a2 b1 b2 c1 c2 d1 d2]
Parametros=zeros(8,1);

%Usando Minimos Quadrados Recursivo Estendido com Simulação 1 passo a frente
for k=3:length(VMQRE2) %retirando os dois primeiros valores para carregar o sistema
    
    Regressores=[Velocidade(k-1) Velocidade(k-2) DeslocamentoY(k-1) DeslocamentoY(k-2) DeslocamentoX(k-1) DeslocamentoX(k-2) ResiduoMQRE2(k-1) ResiduoMQRE2(k-2)]';
    Kk =(Pk*Regressores)/(Regressores'*Pk*Regressores+1);
    Parametros = Parametros +Kk*(Velocidade(k)-Regressores'*Parametros);
    Pk=Pk-Kk*Regressores'*Pk;
    
    %Atualizando o Residuo
    VMQRE2(k) = Regressores'*Parametros;
    ResiduoMQRE2(k) = Velocidade(k) - VMQRE2(k);
    
end

% figure()
% FAC=[ResiduoMQRE2' ResiduoMQRE2'];
% lag=length(ResiduoMQRE2);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do MQRE 2 grau')

%Modelo 1 passo a frente de 3 ordem
%VelocidadeEst [k] = a1 Velocidade [k-1]+a2 Velocidade [k-2]+a3 Velocidade [k-3]+ b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ b3 DeslocamentoY [k-3]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]+ c3 DeslocamentoX [k-3] + d1(Velocidade [k-1] - VelocidadeEst[k-1)+ d2(Velocidade [k-2] - VelocidadeEst[k-2]) + d3(Velocidade [k-3] - VelocidadeEst[k-3])
%Criando o vetor de Velocidade estimado
VMQRE3 = zeros(1,length(Velocidade));
VMQRE3(1) = Velocidade(1);
VMQRE3(2) = Velocidade(2);
VMQRE3(3) = Velocidade(3);

%Criando o Vetor de residuos
ResiduoMQRE3 = zeros(1,length(Velocidade));

%Definindo a primeira covariancia do sistema
Pk=1000*eye(12);
%Criando o vetor de parametros - [a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3]
Parametros=zeros(12,1);

%Usando Minimos Quadrados Recursivo Estendido com Simulação 1 passo a frente
for k=4:length(VMQRE3) %retirando o primeiro valor para carregar o sistema
    
    Regressores=[Velocidade(k-1) Velocidade(k-2) Velocidade(k-3) DeslocamentoY(k-1) DeslocamentoY(k-2) DeslocamentoY(k-3) DeslocamentoX(k-1) DeslocamentoX(k-2) DeslocamentoX(k-3) ResiduoMQRE3(k-1) ResiduoMQRE3(k-2) ResiduoMQRE3(k-3)]';
    Kk =(Pk*Regressores)/(Regressores'*Pk*Regressores+1);
    Parametros = Parametros +Kk*(Velocidade(k)-Regressores'*Parametros);
    Pk=Pk-Kk*Regressores'*Pk;
    
    %Atualizando o Residuo
    VMQRE3(k) = Regressores'*Parametros;
    ResiduoMQRE3(k) = Velocidade(k) - VMQRE3(k);
    
end

% figure()
% FAC=[ResiduoMQRE3' ResiduoMQRE3'];
% lag=length(ResiduoMQRE3);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do MQRE 3 grau')

%% Plotando os modelos

%MQ
% figure()
% plot(T*(0:(length(Velocidade)-1)),Velocidade)
% hold on
% plot(T*(0:(length(VMQ1)-1)),VMQ1)
% plot(T*(0:(length(VMQ2)-1)),VMQ2)
% plot(T*(0:(length(VMQ3)-1)),VMQ3)
% hold off
% legend('Velocidade','Modelo MQ de 1 ordem','Modelo MQ de 2 ordem','Modelo MQ de 3 ordem')

%MQE
% % % % figure()
% % % % plot(T*(0:(length(Velocidade)-1)),Velocidade)
% % % % hold on
% % % % plot(T*(0:(length(VMQE1)-1)),VMQE1)
% % % % plot(T*(0:(length(VMQE2)-1)),VMQE2)
% % % % plot(T*(0:(length(VMQE3)-1)),VMQE3)
% % % % hold off
% % % % legend('Velocidade','Modelo MQE de 1 ordem','Modelo MQE de 2 ordem','Modelo MQE de 3 ordem')

%MQR
% figure()
% plot(T*(0:(length(Velocidade)-1)),Velocidade)
% hold on
% plot(T*(0:(length(VMQR1)-1)),VMQR1)
% plot(T*(0:(length(VMQR2)-1)),VMQR2)
% plot(T*(0:(length(VMQR3)-1)),VMQR3)
% hold off
% legend('Velocidade','Modelo MQR de 1 ordem','Modelo MQR de 2 ordem','Modelo MQR de 3 ordem')

%MQRE
% figure()
% plot(T*(0:(length(Velocidade)-1)),Velocidade)
% hold on
% plot(T*(0:(length(VMQRE1)-1)),VMQRE1)
% plot(T*(0:(length(VMQRE2)-1)),VMQRE2)
% plot(T*(0:(length(VMQRE3)-1)),VMQRE3)
% hold off
% legend('Velocidade','Modelo MQRE de 1 ordem','Modelo MQRE de 2 ordem','Modelo MQRE de 3 ordem')

%% Critério de Informação de Akaike

% AIC_MQ1 = length(VMQ1)*log(var(ResiduoMQ1))+2*3
% AIC_MQ2 = length(VMQ2)*log(var(ResiduoMQ2))+2*6
% AIC_MQ3 = length(VMQ3)*log(var(ResiduoMQ3))+2*9
% AIC_MQR1 = length(VMQR1)*log(var(ResiduoMQR1))+2*3
% AIC_MQR2 = length(VMQR2)*log(var(ResiduoMQR2))+2*6
% AIC_MQR3 = length(VMQR3)*log(var(ResiduoMQR3))+2*9
% AIC_MQRE1 = length(VMQRE1)*log(var(ResiduoMQRE1))+2*4
% AIC_MQRE2 = length(VMQRE2)*log(var(ResiduoMQRE2))+2*8
% AIC_MQRE3 = length(VMQRE3)*log(var(ResiduoMQRE3))+2*12

%% ------------------------------------------------------------------------
%Validando
%  ------------------------------------------------------------------------
clear
clc
close all

%Carregando os dados gerados pelo o artigo
load ('SimulacaoPRBS5.mat');
%Periodo de Amostragem
T = 2;

%Criando as Variaveis
Velocidade5 = sqrt(s(2,:).^2+s(4,:).^2); %Vetor Modulo da Velocidade em m/s
DeslocamentoY5 = s(3,:); %Deslocamento em m
DeslocamentoX5 = s(1,:); %Deslocamento em m

%Carregando os dados gerados pelo o artigo
load ('SimulacaoPRBS10.mat');
%Periodo de Amostragem

%Criando as Variaveis
Velocidade10 = sqrt(s(2,:).^2+s(4,:).^2); %Vetor Modulo da Velocidade em m/s
DeslocamentoY10 = s(3,:); %Deslocamento em m
DeslocamentoX10 = s(1,:); %Deslocamento em m

%Carregando os dados gerados pelo o artigo
load ('SimulacaoPRBS50.mat');
%Periodo de Amostragem

%Criando as Variaveis
Velocidade50 = sqrt(s(2,:).^2+s(4,:).^2); %Vetor Modulo da Velocidade em m/s
DeslocamentoY50 = s(3,:); %Deslocamento em m
DeslocamentoX50 = s(1,:); %Deslocamento em m

%Carregando os dados gerados pelo o artigo
load ('SimulacaoPRBS100.mat');
%Periodo de Amostragem

%Criando as Variaveis
Velocidade100 = sqrt(s(2,:).^2+s(4,:).^2); %Vetor Modulo da Velocidade em m/s
DeslocamentoY100 = s(3,:); %Deslocamento em m
DeslocamentoX100 = s(1,:); %Deslocamento em m

%% Modelo 1 passo a frente de 3 ordem
%VelocidadeEst [k] = a1 Velocidade [k-1]+a2 Velocidade [k-2]+a3 Velocidade [k-3]+ b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ b3 DeslocamentoY [k-3]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]+ c3 DeslocamentoX [k-3] + d1(Velocidade [k-1] - VelocidadeEst[k-1)+ d2(Velocidade [k-2] - VelocidadeEst[k-2]) + d3(Velocidade [k-3] - VelocidadeEst[k-3])
%Criando o vetor de Velocidade estimado
V5estPF = zeros(1,length(Velocidade5));
V5estPF(1) = Velocidade5(1);
V5estPF(2) = Velocidade5(2);
V5estPF(3) = Velocidade5(3);

V10estPF = zeros(1,length(Velocidade10));
V10estPF(1) = Velocidade10(1);
V10estPF(2) = Velocidade10(2);
V10estPF(3) = Velocidade10(3);

V50estPF = zeros(1,length(Velocidade50));
V50estPF(1) = Velocidade50(1);
V50estPF(2) = Velocidade50(2);
V50estPF(3) = Velocidade50(3);

V100estPF = zeros(1,length(Velocidade100));
V100estPF(1) = Velocidade100(1);
V100estPF(2) = Velocidade100(2);
V100estPF(3) = Velocidade100(3);

%Criando o Vetor de residuos
Residuo5PF = zeros(1,length(Velocidade5));
Residuo10PF = zeros(1,length(Velocidade10));
Residuo50PF = zeros(1,length(Velocidade50));
Residuo100PF = zeros(1,length(Velocidade100));

%Criando o vetor de parametros - [a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3]
Parametros= [1.2278 0.4602 -0.6874 -0.3940 0.0774 1.4177 0.6450 1.6413 -1.0939 -0.1704 -0.6552 0.3732]';

for k=4:length(V50estPF) %retirando o primeiro valor para carregar o sistema
    
    %Modelo 1 passo a frente de 3 ordem
    Regressores5=[Velocidade5(k-1) Velocidade5(k-2) Velocidade5(k-3) DeslocamentoY5(k-1) DeslocamentoY5(k-2) DeslocamentoY5(k-3) DeslocamentoX5(k-1) DeslocamentoX5(k-2) DeslocamentoX5(k-3) Residuo5PF(k-1) Residuo5PF(k-2) Residuo5PF(k-3)]';
    V5estPF(k) = Regressores5'*Parametros;
    
    Regressores10=[Velocidade10(k-1) Velocidade10(k-2) Velocidade10(k-3) DeslocamentoY10(k-1) DeslocamentoY10(k-2) DeslocamentoY10(k-3) DeslocamentoX10(k-1) DeslocamentoX10(k-2) DeslocamentoX10(k-3) Residuo10PF(k-1) Residuo10PF(k-2) Residuo10PF(k-3)]';
    V10estPF(k) = Regressores10'*Parametros;
    
    Regressores50=[Velocidade50(k-1) Velocidade50(k-2) Velocidade50(k-3) DeslocamentoY50(k-1) DeslocamentoY50(k-2) DeslocamentoY50(k-3) DeslocamentoX50(k-1) DeslocamentoX50(k-2) DeslocamentoX50(k-3) Residuo50PF(k-1) Residuo50PF(k-2) Residuo50PF(k-3)]';
    V50estPF(k) = Regressores50'*Parametros;
    
    Regressores100=[Velocidade100(k-1) Velocidade100(k-2) Velocidade100(k-3) DeslocamentoY100(k-1) DeslocamentoY100(k-2) DeslocamentoY100(k-3) DeslocamentoX100(k-1) DeslocamentoX100(k-2) DeslocamentoX100(k-3) Residuo100PF(k-1) Residuo100PF(k-2) Residuo100PF(k-3)]';
    V100estPF(k) = Regressores100'*Parametros;
    
    %Atualizando o Residuo
    
    Residuo5PF(k) = Velocidade5(k) - V5estPF(k);
    Residuo10PF(k) = Velocidade10(k) - V10estPF(k);
    Residuo50PF(k) = Velocidade50(k) - V50estPF(k);
    Residuo100PF(k) = Velocidade100(k) - V100estPF(k);
    
end

% figure()
% FAC=[Residuo5PF' Residuo5PF'];
% lag=length(Residuo5PF);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do PRBS 5 para 1 Passo a Frente')
% 
% figure()
% FAC=[Residuo10PF' Residuo10PF'];
% lag=length(Residuo10PF);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do PRBS 10 para 1 Passo a Frente')
%
% figure()
% FAC=[Residuo50PF' Residuo50PF'];
% lag=length(Residuo50PF);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do PRBS 50 para 1 Passo a Frente')
% 
% figure()
% FAC=[Residuo100PF' Residuo100PF'];
% lag=length(Residuo100PF);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do PRBS 100 para 1 Passo a Frente')

%% Modelo simulação livre de 3 ordem
%VelocidadeEst [k] = a1 VelocidadeEst [k-1]+a2 VelocidadeEst [k-2]+a3 VelocidadeEst [k-3]+ b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ b3 DeslocamentoY [k-3]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]+ c3 DeslocamentoX [k-3] + d1(Velocidade [k-1] - VelocidadeEst[k-1)+ d2(Velocidade [k-2] - VelocidadeEst[k-2]) + d3(Velocidade [k-3] - VelocidadeEst[k-3])
%Criando o vetor de Velocidade estimado
V5estL = zeros(1,length(Velocidade5));
V5estL(1) = Velocidade5(1);
V5estL(2) = Velocidade5(2);
V5estL(3) = Velocidade5(3);

V10estL = zeros(1,length(Velocidade10));
V10estL(1) = Velocidade10(1);
V10estL(2) = Velocidade10(2);
V10estL(3) = Velocidade10(3);

V50estL = zeros(1,length(Velocidade50));
V50estL(1) = Velocidade50(1);
V50estL(2) = Velocidade50(2);
V50estL(3) = Velocidade50(3);

V100estL = zeros(1,length(Velocidade100));
V100estL(1) = Velocidade100(1);
V100estL(2) = Velocidade100(2);
V100estL(3) = Velocidade100(3);

%Criando o Vetor de residuos
Residuo5L = zeros(1,length(Velocidade5));
Residuo10L = zeros(1,length(Velocidade10));
Residuo50L = zeros(1,length(Velocidade50));
Residuo100L = zeros(1,length(Velocidade100));

%Criando o vetor de parametros - [a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3]
Parametros= [1.2278 0.4602 -0.6874 -0.3940 0.0774 1.4177 0.6450 1.6413 -1.0939 -0.1704 -0.6552 0.3732]';

for k=4:length(V50estL) %retirando o primeiro valor para carregar o sistema
    
    %Modelo 1 passo a frente de 3 ordem
    Regressores5=[V5estL(k-1) V5estL(k-2) V5estL(k-3) DeslocamentoY5(k-1) DeslocamentoY5(k-2) DeslocamentoY5(k-3) DeslocamentoX5(k-1) DeslocamentoX5(k-2) DeslocamentoX5(k-3) Residuo5L(k-1) Residuo5L(k-2) Residuo5L(k-3)]';
    V5estL(k) = Regressores5'*Parametros;
    
    Regressores10=[V10estL(k-1) V10estL(k-2) V10estL(k-3) DeslocamentoY10(k-1) DeslocamentoY10(k-2) DeslocamentoY10(k-3) DeslocamentoX10(k-1) DeslocamentoX10(k-2) DeslocamentoX10(k-3) Residuo10L(k-1) Residuo10L(k-2) Residuo10L(k-3)]';
    V10estL(k) = Regressores10'*Parametros;
    
    Regressores50=[V50estL(k-1) V50estL(k-2) V50estL(k-3) DeslocamentoY50(k-1) DeslocamentoY50(k-2) DeslocamentoY50(k-3) DeslocamentoX50(k-1) DeslocamentoX50(k-2) DeslocamentoX50(k-3) Residuo50L(k-1) Residuo50L(k-2) Residuo50L(k-3)]';
    V50estL(k) = Regressores50'*Parametros;
    
    Regressores100=[V100estL(k-1) V100estL(k-2) V100estL(k-3) DeslocamentoY100(k-1) DeslocamentoY100(k-2) DeslocamentoY100(k-3) DeslocamentoX100(k-1) DeslocamentoX100(k-2) DeslocamentoX100(k-3) Residuo100L(k-1) Residuo100L(k-2) Residuo100L(k-3)]';
    V100estL(k) = Regressores100'*Parametros;
    
    %Atualizando o Residuo
    
    Residuo5L(k) = Velocidade5(k) - V5estL(k);
    Residuo10L(k) = Velocidade10(k) - V10estL(k);
    Residuo50L(k) = Velocidade50(k) - V50estL(k);
    Residuo100L(k) = Velocidade100(k) - V100estL(k);
    
end

% figure()
% FAC=[Residuo5L' Residuo5L'];
% lag=length(Residuo5L);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do PRBS 5 para Simulacao Livre')
% 
% figure()
% FAC=[Residuo10L' Residuo10L'];
% lag=length(Residuo10L);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do PRBS 10 para Simulacao Livre')
%
% figure()
% FAC=[Residuo50L' Residuo50L'];
% lag=length(Residuo50L);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do PRBS 50 para Simulacao Livre')
% 
% figure()
% FAC=[Residuo100L' Residuo100L'];
% lag=length(Residuo100L);
% [AutoCorrelacaoX,AutoCorrelacaoY] = MYCCF(FAC,lag,1,1,'k');
% title('FAC do Residuo do PRBS 100 para Simulacao Livre')

%% Plotando os resultados
% figure()
% plot(T*(0:(length(Velocidade5)-1)),Velocidade5)
% hold on
% plot(T*(0:(length(V5estL)-1)),V5estL)
% hold off
% legend('Velocidade','Modelo Simulacao Livre')
% 
% figure()
% plot(T*(0:(length(Velocidade5)-1)),Velocidade5)
% hold on
% plot(T*(0:(length(V5estPF)-1)),V5estPF)
% hold off
% legend('Velocidade','Modelo 1 Passo a Frente')
% 
% figure()
% plot(T*(0:(length(Velocidade10)-1)),Velocidade10)
% hold on
% plot(T*(0:(length(V10estL)-1)),V10estL)
% hold off
% legend('Velocidade','Modelo Simulacao Livre')
% 
% figure()
% plot(T*(0:(length(Velocidade10)-1)),Velocidade10)
% hold on
% plot(T*(0:(length(V10estPF)-1)),V10estPF)
% hold off
% legend('Velocidade','Modelo 1 Passo a Frente')
% 
% figure()
% plot(T*(0:(length(Velocidade50)-1)),Velocidade50)
% hold on
% plot(T*(0:(length(V50estL)-1)),V50estL)
% hold off
% legend('Velocidade','Modelo Simulacao Livre')
% 
% figure()
% plot(T*(0:(length(Velocidade50)-1)),Velocidade50)
% hold on
% plot(T*(0:(length(V50estPF)-1)),V50estPF)
% hold off
% legend('Velocidade','Modelo 1 Passo a Frente')
% 
% figure()
% plot(T*(0:(length(Velocidade100)-1)),Velocidade100)
% hold on
% plot(T*(0:(length(V100estL)-1)),V100estL)
% hold off
% legend('Velocidade','Modelo Simulacao Livre')
% 
% figure()
% plot(T*(0:(length(Velocidade100)-1)),Velocidade100)
% hold on
% plot(T*(0:(length(V100estPF)-1)),V100estPF)
% hold off
% legend('Velocidade','Modelo 1 Passo a Frente')

%% Inserindo Ruído na saída

%Criando as Variaveis
Velocidade5B = Velocidade5 + 5*0.2*randn(size(Velocidade5)); %Ruído Baixo
Velocidade5M = Velocidade5 + 5*0.5*randn(size(Velocidade5)); %Ruído Médio
Velocidade5A = Velocidade5 + 5*0.8*randn(size(Velocidade5)); %Ruído Alto

%Criando as Variaveis
Velocidade10B = Velocidade10 + 10*0.2*randn(size(Velocidade10)); %Ruído Baixo
Velocidade10M = Velocidade10 + 10*0.5*randn(size(Velocidade10)); %Ruído Baixo
Velocidade10A = Velocidade10 + 10*0.8*randn(size(Velocidade10)); %Ruído Baixo

%% Modelo 1 passo a frente de 3 ordem com Ruido Baixo
%VelocidadeEst [k] = a1 Velocidade [k-1]+a2 Velocidade [k-2]+a3 Velocidade [k-3]+ b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ b3 DeslocamentoY [k-3]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]+ c3 DeslocamentoX [k-3] + d1(Velocidade [k-1] - VelocidadeEst[k-1)+ d2(Velocidade [k-2] - VelocidadeEst[k-2]) + d3(Velocidade [k-3] - VelocidadeEst[k-3])
%Criando o vetor de Velocidade estimado
V5estPF = zeros(1,length(Velocidade5B));
V5estPF(1) = Velocidade5B(1);
V5estPF(2) = Velocidade5B(2);
V5estPF(3) = Velocidade5B(3);

V10estPF = zeros(1,length(Velocidade10B));
V10estPF(1) = Velocidade10B(1);
V10estPF(2) = Velocidade10B(2);
V10estPF(3) = Velocidade10B(3);

%Criando o Vetor de residuos
Residuo5PF = zeros(1,length(Velocidade5B));
Residuo10PF = zeros(1,length(Velocidade10B));

%Criando o vetor de parametros - [a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3]
Parametros= [1.2278 0.4602 -0.6874 -0.3940 0.0774 1.4177 0.6450 1.6413 -1.0939 -0.1704 -0.6552 0.3732]';

for k=4:length(V50estPF) %retirando o primeiro valor para carregar o sistema
    
    %Modelo 1 passo a frente de 3 ordem
    Regressores5=[Velocidade5B(k-1) Velocidade5B(k-2) Velocidade5B(k-3) DeslocamentoY5(k-1) DeslocamentoY5(k-2) DeslocamentoY5(k-3) DeslocamentoX5(k-1) DeslocamentoX5(k-2) DeslocamentoX5(k-3) Residuo5PF(k-1) Residuo5PF(k-2) Residuo5PF(k-3)]';
    V5estPF(k) = Regressores5'*Parametros;
    
    Regressores10=[Velocidade10B(k-1) Velocidade10B(k-2) Velocidade10B(k-3) DeslocamentoY10(k-1) DeslocamentoY10(k-2) DeslocamentoY10(k-3) DeslocamentoX10(k-1) DeslocamentoX10(k-2) DeslocamentoX10(k-3) Residuo10PF(k-1) Residuo10PF(k-2) Residuo10PF(k-3)]';
    V10estPF(k) = Regressores10'*Parametros;
    
    
    %Atualizando o Residuo
    
    Residuo5PF(k) = Velocidade5B(k) - V5estPF(k);
    Residuo10PF(k) = Velocidade10B(k) - V10estPF(k);
    
end

figure()
plot(T*(0:(length(Velocidade5B)-1)),Velocidade5B)
hold on
plot(T*(0:(length(V5estPF)-1)),V5estPF)
hold off
legend('Velocidade com ruído baixo','Modelo 1 Passo a Frente')

figure()
plot(T*(0:(length(Velocidade10B)-1)),Velocidade10B)
hold on
plot(T*(0:(length(V10estPF)-1)),V10estPF)
hold off
legend('Velocidade com ruído baixo','Modelo 1 Passo a Frente')

%Cálculando o RMSE
Numerador = 0;
Denominador =0;
for i=1:length(Velocidade5B)
    
    Numerador = Residuo5PF(i)^2;
    Denominador = (Velocidade5B(i)-mean(Velocidade5B))^2;
    
end
disp('RMSE de Amplitude 5 e Baixo ruido')
RMSE = sqrt(Numerador)/sqrt(Denominador)

Numerador = 0;
Denominador =0;
for i=1:length(Velocidade10B)
    
    Numerador = Residuo10PF(i)^2;
    Denominador = (Velocidade10B(i)-mean(Velocidade10B))^2;
    
end
disp('RMSE de Amplitude 10 e Baixo ruido')
RMSE = sqrt(Numerador)/sqrt(Denominador)

%% Modelo 1 passo a frente de 3 ordem com Ruido Médio
%VelocidadeEst [k] = a1 Velocidade [k-1]+a2 Velocidade [k-2]+a3 Velocidade [k-3]+ b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ b3 DeslocamentoY [k-3]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]+ c3 DeslocamentoX [k-3] + d1(Velocidade [k-1] - VelocidadeEst[k-1)+ d2(Velocidade [k-2] - VelocidadeEst[k-2]) + d3(Velocidade [k-3] - VelocidadeEst[k-3])
%Criando o vetor de Velocidade estimado
V5estPF = zeros(1,length(Velocidade5M));
V5estPF(1) = Velocidade5M(1);
V5estPF(2) = Velocidade5M(2);
V5estPF(3) = Velocidade5M(3);

V10estPF = zeros(1,length(Velocidade10M));
V10estPF(1) = Velocidade10M(1);
V10estPF(2) = Velocidade10M(2);
V10estPF(3) = Velocidade10M(3);

%Criando o Vetor de residuos
Residuo5PF = zeros(1,length(Velocidade5M));
Residuo10PF = zeros(1,length(Velocidade10M));

%Criando o vetor de parametros - [a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3]
Parametros= [1.2278 0.4602 -0.6874 -0.3940 0.0774 1.4177 0.6450 1.6413 -1.0939 -0.1704 -0.6552 0.3732]';

for k=4:length(V50estPF) %retirando o primeiro valor para carregar o sistema
    
    %Modelo 1 passo a frente de 3 ordem
    Regressores5=[Velocidade5M(k-1) Velocidade5M(k-2) Velocidade5M(k-3) DeslocamentoY5(k-1) DeslocamentoY5(k-2) DeslocamentoY5(k-3) DeslocamentoX5(k-1) DeslocamentoX5(k-2) DeslocamentoX5(k-3) Residuo5PF(k-1) Residuo5PF(k-2) Residuo5PF(k-3)]';
    V5estPF(k) = Regressores5'*Parametros;
    
    Regressores10=[Velocidade10M(k-1) Velocidade10M(k-2) Velocidade10M(k-3) DeslocamentoY10(k-1) DeslocamentoY10(k-2) DeslocamentoY10(k-3) DeslocamentoX10(k-1) DeslocamentoX10(k-2) DeslocamentoX10(k-3) Residuo10PF(k-1) Residuo10PF(k-2) Residuo10PF(k-3)]';
    V10estPF(k) = Regressores10'*Parametros;
    
    
    %Atualizando o Residuo
    
    Residuo5PF(k) = Velocidade5M(k) - V5estPF(k);
    Residuo10PF(k) = Velocidade10M(k) - V10estPF(k);
    
end

figure()
plot(T*(0:(length(Velocidade5M)-1)),Velocidade5M)
hold on
plot(T*(0:(length(V5estPF)-1)),V5estPF)
hold off
legend('Velocidade com ruído médio','Modelo 1 Passo a Frente')

figure()
plot(T*(0:(length(Velocidade10M)-1)),Velocidade10M)
hold on
plot(T*(0:(length(V10estPF)-1)),V10estPF)
hold off
legend('Velocidade com ruído médio','Modelo 1 Passo a Frente')

%Cálculando o RMSE
Numerador = 0;
Denominador =0;
for i=1:length(Velocidade5M)
    
    Numerador = Residuo5PF(i)^2;
    Denominador = (Velocidade5M(i)-mean(Velocidade5M))^2;
    
end
disp('RMSE de Amplitude 5 e Médio ruido')
RMSE = sqrt(Numerador)/sqrt(Denominador)

Numerador = 0;
Denominador =0;
for i=1:length(Velocidade10M)
    
    Numerador = Residuo10PF(i)^2;
    Denominador = (Velocidade10M(i)-mean(Velocidade10M))^2;
    
end
disp('RMSE de Amplitude 10 e Médio ruido')
RMSE = sqrt(Numerador)/sqrt(Denominador)

%% Modelo 1 passo a frente de 3 ordem com Ruido Alto
%VelocidadeEst [k] = a1 Velocidade [k-1]+a2 Velocidade [k-2]+a3 Velocidade [k-3]+ b1 DeslocamentoY [k-1] + b2 DeslocamentoY [k-2]+ b3 DeslocamentoY [k-3]+ c1 DeslocamentoX [k-1]+ c2 DeslocamentoX [k-2]+ c3 DeslocamentoX [k-3] + d1(Velocidade [k-1] - VelocidadeEst[k-1)+ d2(Velocidade [k-2] - VelocidadeEst[k-2]) + d3(Velocidade [k-3] - VelocidadeEst[k-3])
%Criando o vetor de Velocidade estimado
V5estPF = zeros(1,length(Velocidade5A));
V5estPF(1) = Velocidade5A(1);
V5estPF(2) = Velocidade5A(2);
V5estPF(3) = Velocidade5A(3);

V10estPF = zeros(1,length(Velocidade10A));
V10estPF(1) = Velocidade10A(1);
V10estPF(2) = Velocidade10A(2);
V10estPF(3) = Velocidade10A(3);

%Criando o Vetor de residuos
Residuo5PF = zeros(1,length(Velocidade5A));
Residuo10PF = zeros(1,length(Velocidade10A));

%Criando o vetor de parametros - [a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3]
Parametros= [1.2278 0.4602 -0.6874 -0.3940 0.0774 1.4177 0.6450 1.6413 -1.0939 -0.1704 -0.6552 0.3732]';

for k=4:length(V50estPF) %retirando o primeiro valor para carregar o sistema
    
    %Modelo 1 passo a frente de 3 ordem
    Regressores5=[Velocidade5A(k-1) Velocidade5A(k-2) Velocidade5A(k-3) DeslocamentoY5(k-1) DeslocamentoY5(k-2) DeslocamentoY5(k-3) DeslocamentoX5(k-1) DeslocamentoX5(k-2) DeslocamentoX5(k-3) Residuo5PF(k-1) Residuo5PF(k-2) Residuo5PF(k-3)]';
    V5estPF(k) = Regressores5'*Parametros;
    
    Regressores10=[Velocidade10A(k-1) Velocidade10A(k-2) Velocidade10A(k-3) DeslocamentoY10(k-1) DeslocamentoY10(k-2) DeslocamentoY10(k-3) DeslocamentoX10(k-1) DeslocamentoX10(k-2) DeslocamentoX10(k-3) Residuo10PF(k-1) Residuo10PF(k-2) Residuo10PF(k-3)]';
    V10estPF(k) = Regressores10'*Parametros;
    
    
    %Atualizando o Residuo
    
    Residuo5PF(k) = Velocidade5A(k) - V5estPF(k);
    Residuo10PF(k) = Velocidade10A(k) - V10estPF(k);
    
end

figure()
plot(T*(0:(length(Velocidade5A)-1)),Velocidade5A)
hold on
plot(T*(0:(length(V5estPF)-1)),V5estPF)
hold off
legend('Velocidade com ruído alto','Modelo 1 Passo a Frente')

figure()
plot(T*(0:(length(Velocidade10A)-1)),Velocidade10A)
hold on
plot(T*(0:(length(V10estPF)-1)),V10estPF)
hold off
legend('Velocidade com ruído alto','Modelo 1 Passo a Frente')

%Cálculando o RMSE
Numerador = 0;
Denominador =0;
for i=1:length(Velocidade5A)
    
    Numerador = Residuo5PF(i)^2;
    Denominador = (Velocidade5A(i)-mean(Velocidade5A))^2;
    
end
disp('RMSE de Amplitude 5 e Alto ruido')
RMSE = sqrt(Numerador)/sqrt(Denominador)

Numerador = 0;
Denominador =0;
for i=1:length(Velocidade10A)
    
    Numerador = Residuo10PF(i)^2;
    Denominador = (Velocidade10A(i)-mean(Velocidade10A))^2;
    
end
disp('RMSE de Amplitude 10 e Alto ruido')
RMSE = sqrt(Numerador)/sqrt(Denominador)