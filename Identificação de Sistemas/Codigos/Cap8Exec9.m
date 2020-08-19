clc
clear
%close all

%Entrada com ruído branco para excitar todo o sistema
u=randn(1,300); 

%Vetor de saida do ruído branco com erro
y_ARX=zeros(1,300); 
e=0.2*randn(1,300);
for k=3:300
    y_ARX(k)=0.7859*y_ARX(k-1)-0.3679*y_ARX(k-2)+0.1701*u(k-1)+0.1208*u(k-2)+e(k);
end

%Definindo a primeira covariancia do sistema
Pk=1000*eye(4);
%Criando o vetor de parametros
Parametros=zeros(4,1);

for k=3:300 %retirando os dois primeiros valores para carregar o sistema
    Regressores=[y_ARX(k-1) y_ARX(k-2) u(k-1) u(k-2)]';
    Kk =(Pk*Regressores)/(Regressores'*Pk*Regressores+1);
    Parametros = Parametros +Kk*(y_ARX(k)-Regressores'*Parametros);
    Pk=Pk-Kk*Regressores'*Pk;
end

%Criando o modelo a partir dos parametros
Modelo=zeros(1,300);
for k=3:300
    Modelo(k)=Parametros(1)*Modelo(k-1)+Parametros(2)*Modelo(k-2)+Parametros(3)*u(k-1)+Parametros(4)*u(k-2);
end
%Mostrar os valores dos parametros e o plot do modelo
Parametros
figure()
plot(y_ARX)
hold on
plot(Modelo,'r')
xlabel('Amostras')
legend('Dados Sistema','Modelo ARX')