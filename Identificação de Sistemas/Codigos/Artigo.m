clear
clc
close all

%% Modelo do Movimento do Alvo - Modelo N�o Linear
%Per�odo de Amostragem
T = 2;
% % % %N�mero de Amostras
% % % N = 60000;

%------------------------------
%Para o PRBS
%------------------------------
b = 6; %N�mero de bits
N = 2^b-1; %N�mero de Amostras
m = 4; %Minimo de bits de repeti��o
% A = 1; %Amplitude do sinal
% A = 5; %Amplitude do sinal
A = 10; %Amplitude do sinal
% A= 50; %Amplitude do sinal
% A= 100; %Amplitude do sinal
%------------------------------


%Criando o Vetor de estados
%s[1] = Posi��o em X em m
%s[2] = Velocidade em X em m/s
%s[3] = Posi��o em Y em m
%s[4] = Velocidade em Y em m/s
s = zeros(4,N);

%Parametros Iniciais
% % % g = 9.81; %Acelera��o da Gravidade
% % % Beta = 40000e4; %Coeficiente de Balistica
% % % q = 1; %Parametro da intensidade do ru�do
% % % X0 = 232; %x(0) em km
% % % Y0 = 88; %y(0) em km
% % % Gama0 = 190; %Angulo entre os eixo X e Y em graus
% % % Ni0 = 2290; %Modulo da velocidade em m/s

% % % %Calculo dos Parametros Iniciais
% % % s(1,1) = X0*1000; %x(0) em m
% % % s(2,1) = Ni0*cos(deg2rad(Gama0)); %Vx(0) em m/s
% % % s(3,1) = Y0*1000; %y(0) em m
% % % s(4,1) = Ni0*sin(deg2rad(Gama0)); %Vy(0) em m/s

%------------------------------
%Para o PRBS
%------------------------------
g = 9.81; %Acelera��o da Gravidade
Beta = 40000e4; %Coeficiente de Balistica
q = 1; %Parametro da intensidade do ru�do

%Calculo dos Parametros
s(1,:) = A*PRBS(N,b,m);
s(3,:) = A*PRBS(N,b,m);
%------------------------------


%Defini��o de Constantes
Fi = [1 T 0 0;0 1 0 0;0 0 1 T;0 0 0 1]; %Equa��o 4
G = [T^2/2 0; T 0; 0 T^2/2; 0 T]; %Equa��o 5
Q = q*[T^3/3 T^2/2 0 0; T^2/2 T 0 0; 0 0 T^3/3 T^2/2; 0 0 T^2/2 T]; %Equa��o 9 - Matriz de covariancia Q do ru�do branco

% % % %Cria��o do Modelo
% % % for k=1:N
% % %     
% % %     %Calculando a Condi��o da equa��o 6
% % %     if s(3,k)<9144 %y < 9144m
% % %         C1 = 1.227;
% % %         C2 = 1.09310e-4;       
% % %     else %y >= 9144m
% % %         C1 = 1.754;
% % %         C2 = 1.4910e-4;        
% % %     end
% % %     Ro = C1 * exp (-C2 * s(3,k)); %Densidade do Ar
% % %     Fk = -0.5*g/Beta * Ro * s(3,k)* sqrt(s(2,k)^2+s(4,k)^2) * [s(2,k);s(4,k)]; %Equa��o 8 - For�a de Arrasto
% % %     Psi = Fi*s(:,k) + G*Fk; %Equa��o 3 - Regressores
% % %     wk = Q*randn(4,1); %Ru�do Branco    
% % %     s(:,k+1) = Psi + G*[0;-g] + wk; %Equa��o 1 - Modelo N�o Linear
% % %     
% % % end

%------------------------------
%Para o PRBS
%------------------------------
%Cria��o do Modelo
for k=1:N
    
    %Calculando a Condi��o da equa��o 6
    if s(3,k)<9144 %y < 9144m
        C1 = 1.227;
        C2 = 1.09310e-4;       
    else %y >= 9144m
        C1 = 1.754;
        C2 = 1.4910e-4;        
    end
    Ro = C1 * exp (-C2 * s(3,k)); %Densidade do Ar
    Fk = -0.5*g/Beta * Ro * s(3,k)* sqrt(s(2,k)^2+s(4,k)^2) * [s(2,k);s(4,k)]; %Equa��o 8 - For�a de Arrasto
    Psi = Fi*s(:,k) + G*Fk; %Equa��o 3 - Regressores
    wk = Q*randn(4,1); %Ru�do Branco 
    Mudanca = Psi + G*[0;-g] + wk; %Equa��o 1 - Modelo N�o Linear
    %Atualiza��o da Velocidade
    s(2,k+1) = Mudanca(2);
    s(4,k+1) = Mudanca(4);
    
end
%------------------------------


% % % figure()
% % % plot(s(1,:)/1000,s(3,:)/1000)
% % % % axis([0 250 0 90])
% % % xlabel('x[km]')
% % % ylabel('y[km]')
% % % title('Trajet�ria no plano XY')

%% Vari�vel Velocidade
Ni = sqrt(s(2,:).^2+s(4,:).^2); %Vetor Modulo da Velocidade em m/s
figure()
plot(T*(0:(N)),Ni)
xlabel('Tempo [s]')
ylabel('Velocidade do alvo [m/s]')
title('Velocidade do alvo por segundo')

%% Vari�vel Deslocamento

% % % DeslocamentoX = s(1,:)/1000; %Deslocamento em km
% % % figure()
% % % plot(T*(0:(N)),DeslocamentoX)
% % % xlabel('Tempo [s]')
% % % ylabel('Deslocamento [km]')
% % % title('Deslocamento no eixo X')
% % % 
% % % DeslocamentoY = s(3,:)/1000; %Deslocamento em km
% % % figure()
% % % plot(T*(0:(N)),DeslocamentoY)
% % % xlabel('Tempo [s]')
% % % ylabel('Deslocamento [km]')
% % % title('Deslocamento no eixo Y')

%------------------------------
%Para o PRBS
%------------------------------
DeslocamentoX = s(1,:); %Deslocamento em m
figure()
plot(T*(0:(N)),DeslocamentoX)
xlabel('Tempo [s]')
ylabel('Deslocamento [m]')
title('Deslocamento no eixo X')
% ylim([-0.5 1.5])
% ylim([-1 6])
ylim([-1 11])
% ylim([-5 55])
% ylim([-10 110])

DeslocamentoY = s(3,:); %Deslocamento em m
figure()
plot(T*(0:(N)),DeslocamentoY)
xlabel('Tempo [s]')
ylabel('Deslocamento [m]')
title('Deslocamento no eixo Y')
% ylim([-0.5 1.5])
% ylim([-1 6])
ylim([-1 11])
% ylim([-5 55])
% ylim([-10 110])
%------------------------------
