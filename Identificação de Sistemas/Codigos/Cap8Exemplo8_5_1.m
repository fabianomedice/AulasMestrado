clear all
clc

%Carregando os dados F0707.dat
Data = load ('F0707.DAT');

%Separando os Sinais
SinalEntrada = Data(:,1);
SinalSaida = Data(:,2);

u = SinalEntrada - 3.3554; %subtração referente ao inicio do exemplo
y = SinalSaida - 29.6; %subtração referente ao inicio do exemplo

%Retirada dos primeiros 9 dados do regime transiente
u = u([10:end]);
y = y([10:end]);

figure
subplot(2,1,1)
plot(u)
title('Entrada u(k)')
axis([-inf inf 0 12])

subplot(2,1,2)
plot(y)
title('Saida y(k)')

%------------------------------------------------------------------------------------
%a) Implementando mínimos quadrados recursivo com estimativa inicial
%------------------------------------------------------------------------------------

%Definindo a primeira covariancia do sistema
Pk_a=1000*eye(2);
%Criando o vetor de parametros
Parametros_a=zeros(2,1);

for k=2:length(y) %retirando primeiro valor para carregar o sistema
    Regressores=[y(k-1) u(k-1)]';
    Kk =(Pk_a*Regressores)/(Regressores'*Pk_a*Regressores+1);
    Parametros_a = Parametros_a +Kk*(y(k)-Regressores'*Parametros_a);
    Pk_a=Pk_a-Kk*Regressores'*Pk_a;
end

%Criando o modelo a partir dos parametros
Modelo_a=zeros(1,length(y));
for k=2:length(y)
    Modelo_a(k)=Parametros_a(1)*Modelo_a(k-1)+Parametros_a(2)*u(k-1);
end
%Mostrar os valores dos parametros e o plot do modelo
Parametros_a
%Desvio das covariancias
Desvio_a = 3*eig(Pk_a)
figure()
plot(y)
hold on
plot(Modelo_a,'r')
xlabel('Amostras')
legend('Saída do Sistema','Saída do Modelo da Letra a)')

%------------------------------------------------------------------------------------
%b) Implementando mínimos quadrados recursivo com estimativa inicial e fator de esquecimento
%------------------------------------------------------------------------------------

%Definindo a primeira covariancia do sistema
Pk_b=1000*eye(2);
%Criando o vetor de parametros
Parametros_b=zeros(2,1);

%Definindo o Fator de Esquecimento
% % %Fazendo o degrau para analizar o tau
% % %Inicio do degrau x=21
% % %Termino do degrau x=120
% % %Ganho k=25
% % degrau=zeros(length(y),1);
% % for i=1:length(y)
% %     if i>=21
% %         if i<= 120
% %             degrau(i)=25;
% %         end
% %     end
% % end
% % %Y tau
% % tau = 25*0.632*ones(length(y),1);
% % 
% % figure()
% % plot(y)
% % hold
% % plot(degrau)
% % plot(tau)
% % title('Saida y(k)')
Fator_Esquecimento = 0.98;

for k=2:length(y) %retirando primeiro valor para carregar o sistema
    Regressores=[y(k-1) u(k-1)]';
    Kk =(Pk_b*Regressores)/(Regressores'*Pk_b*Regressores+Fator_Esquecimento);
    Parametros_b = Parametros_b +Kk*(y(k)-Regressores'*Parametros_b);
    Pk_b=1/Fator_Esquecimento*(Pk_b-(Pk_b*Regressores*Regressores'*Pk_b)/(Regressores'*Pk_b*Regressores+Fator_Esquecimento));
end

%Criando o modelo a partir dos parametros
Modelo_b=zeros(1,length(y));
for k=2:length(y)
    Modelo_b(k)=Parametros_b(1)*Modelo_b(k-1)+Parametros_b(2)*u(k-1);
end
%Mostrar os valores dos parametros e o plot do modelo
Parametros_b
%Desvio das covariancias
Desvio_b = 3*eig(Pk_b)
figure()
plot(y)
hold on
plot(Modelo_b,'r')
xlabel('Amostras')
legend('Saída do Sistema','Saída do Modelo da Letra b)')

%------------------------------------------------------------------------------------
%c) Implementando mínimos quadrados recursivo com regulação variável
%------------------------------------------------------------------------------------

%Definindo a primeira covariancia do sistema
Pk_c=1000*eye(2);
%Definindo o primeiro Rk, ou seja, o R0
Rk_menos1 = zeros(length(Regressores));
%Criando o vetor de parametros
Parametros_c=zeros(2,1);
%Definindo o primeiro Alfa k, ou seja Alfa0
Alfak_menos1 = Parametros_c;

for k=2:length(y) %retirando primeiro valor para carregar o sistema
    
    Regressores=[y(k-1) u(k-1)]';
    
    %Definindo Rk    
%     Rk = Rk_menos1; %Testando para R constante
%     [Fi,S]=Decomposicao_VR(Rk,Rk_menos1);
 
    Rk = ones(length(Regressores)); %Testando para Rk-Rk-1 constante
    Rk_menos1 = zeros(length(Regressores));
    [Fi,S]=Decomposicao_VR(Rk,Rk_menos1);

%     Rk = inv(Pk_c); %Testando com R variando o código todo
%     [Fi,S]=Decomposicao_VR(Rk,Rk_menos1);
     
%     if k<3 %atualiza
%         Rk = inv(Pk_c); %Testando com R variando apenas dentro do rank de A
%         [Fi,S]=Decomposicao_VR(Rk,Rk_menos1);
%     end %se não, não atualiza
    
    %Definindo a variavel alfa k do sistema
    %Usando Recursividade
    Alfak = Parametros_c; %Mudando o Alfak para os parametros passados (1 tempo de atraso)
%     Alfak = zeros(2,1); %Alfak se mantendo a estimativa inicial
    
    I=eye(length(Regressores));
    
    Qk = Pk_c*(I-Fi/(S+Fi'*Pk_c*Fi)*Fi'*Pk_c);
    Pk_c = Qk*(I-Regressores/(1+Regressores'*Qk*Regressores)*Regressores'*Qk);    
    Ak = Regressores*Regressores';
    bk = -2*Regressores*y(k);
    Parametros_c = Parametros_c-Pk_c*(Ak*Parametros_c+(Rk-Rk_menos1)*Parametros_c+Rk_menos1*Alfak_menos1-Rk*Alfak+1/2*bk);
        
    Rk_menos1 = Rk; %Mudando o Rk passado após terminar o cálculo (1 tempo de atraso)
    Alfak_menos1 = Alfak; %Mudando o Alfak após terminar o cáculo (2 tempos de atraso)
end

%Criando o modelo a partir dos parametros
Modelo_c=zeros(1,length(y));
for k=2:length(y)
    Modelo_c(k)=Parametros_c(1)*Modelo_c(k-1)+Parametros_c(2)*u(k-1);
end
%Mostrar os valores dos parametros e o plot do modelo
Parametros_c
%Desvio das covariancias
Desvio_c = 3*eig(Pk_c)
figure()
plot(y)
hold on
plot(Modelo_c,'r')
xlabel('Amostras')
legend('Saída do Sistema','Saída do Modelo da Letra c)')

%------------------------------------------------------------------------------------
%d) Implementando mínimos quadrados recursivo com regulação variável e fator de esquecimento
%------------------------------------------------------------------------------------

%Definindo a primeira covariancia do sistema
Pk_d=1000*eye(2);
%Definindo o primeiro Rk, ou seja, o R0
Rk_menos1 = zeros(length(Regressores));
%Criando o vetor de parametros
Parametros_d=zeros(2,1);
%Definindo o primeiro Alfa k, ou seja Alfa0
Alfak_menos1 = Parametros_d;

for k=2:length(y) %retirando primeiro valor para carregar o sistema
    
    Regressores=[y(k-1) u(k-1)]';
    
    %Definindo Rk    
%     Rk = Rk_menos1; %Testando para R constante
%     [Fi,S]=Decomposicao_VR(Rk,Rk_menos1);
    
    Rk = ones(length(Regressores)); %Testando para Rk-Rk-1 constante
    Rk_menos1 = zeros(length(Regressores));
    [Fi,S]=Decomposicao_VR(Rk,Rk_menos1);

%     Rk = inv(Pk_d); %Testando com R variando o código todo
%     [Fi,S]=Decomposicao_VR(Rk,Rk_menos1);

%     %Testando com R variando o código todo
%     if k==2 %primeiro Rk calculado
%         Rk = inv(Pk_d); 
%     else %Rk calculado sem o Fator_Esquecimento
%         Pk_d_SemFator_Esquecimento = Qk*(I-Regressores/(1+Regressores'*Qk*Regressores)*Regressores'*Qk);
%         Rk = inv(Pk_d_SemFator_Esquecimento);
%     end
%     [Fi,S]=Decomposicao_VR(Rk,Rk_menos1);
    
    %Definindo a variavel alfa k do sistema
    %Usando Recursividade
    Alfak = Parametros_d; %Mudando o Alfak para os parametros passados (1 tempo de atraso)
%     Alfak = zeros(2,1); %Alfak se mantendo a estimativa inicial
    
    I=eye(length(Regressores));
    
    Qk = Pk_d*(I-Fi/(S+Fi'*Pk_d*Fi)*Fi'*Pk_d);
    Pk_d = 1/Fator_Esquecimento*Qk*(I-Regressores/(Fator_Esquecimento+Regressores'*Qk*Regressores)*Regressores'*Qk);    
    Ak = Regressores*Regressores';
    bk = -2*Regressores*y(k);
    Parametros_d = Parametros_d-Pk_d*(Ak*Parametros_d+(Rk-Rk_menos1)*Parametros_d+Rk_menos1*Alfak_menos1-Rk*Alfak+1/2*bk);
        
    Rk_menos1 = Rk; %Mudando o Rk passado após terminar o cálculo (1 tempo de atraso)
    Alfak_menos1 = Alfak; %Mudando o Alfak após terminar o cáculo (2 tempos de atraso)
end

%Criando o modelo a partir dos parametros
Modelo_d=zeros(1,length(y));
for k=2:length(y)
    Modelo_d(k)=Parametros_d(1)*Modelo_d(k-1)+Parametros_d(2)*u(k-1);
end
%Mostrar os valores dos parametros e o plot do modelo
Parametros_d
%Desvio das covariancias
Desvio_d = 3*eig(Pk_d)
figure()
plot(y)
hold on
plot(Modelo_d,'r')
xlabel('Amostras')
legend('Saída do Sistema','Saída do Modelo da Letra d)')

%------------------------------------------------------------------------------------
%Comparando os modelos
%------------------------------------------------------------------------------------
figure()
plot(y)
hold on
plot(Modelo_a)
plot(Modelo_b)
plot(Modelo_c)
plot(Modelo_d)
xlabel('Amostras')
legend('Saída do Sistema','Saída do Modelo da Letra a)','Saída do Modelo da Letra b)','Saída do Modelo da Letra c)','Saída do Modelo da Letra d)')

%------------------------------------------------------------------------------------
%Testando modelo bilinear
%------------------------------------------------------------------------------------
%Criando o modelo a partir dos parametros B e D
Modelo_bilinear=zeros(1,length(y));
for k=2:length(y)
    if u(k)==0 %Entrada desligada, modelo de esfriamento
        Modelo_bilinear(k)=Parametros_d(1)*Modelo_bilinear(k-1)+Parametros_d(2)*u(k-1);
    else %Entrada ligada, modelo de aquecimento
        Modelo_bilinear(k)=Parametros_a(1)*Modelo_bilinear(k-1)+Parametros_a(2)*u(k-1);
    end    
end
figure()
plot(y)
hold on
plot(Modelo_bilinear,'r')
xlabel('Amostras')
legend('Saída do Sistema','Saída do Modelo Bilinear')

figure()
plot(y)
hold on
plot(Modelo_a)
plot(Modelo_b)
plot(Modelo_c)
plot(Modelo_d)
plot(Modelo_bilinear)
xlabel('Amostras')
legend('Saída do Sistema','Saída do Modelo da Letra a)','Saída do Modelo da Letra b)','Saída do Modelo da Letra c)','Saída do Modelo da Letra d)','Saída do Modelo Bilinear')
