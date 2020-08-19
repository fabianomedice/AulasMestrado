clear all
clc

%Carregando os dados ensaio6mw.dat
Data = load ('ensaio6mw.dat');

%Separando o Sinal
Sinal = Data(:,2);

%Usando Média Móvel Para achar o ponto de inicio do Degrau
for i=2:length(Sinal)
    
    SinalFiltrado(i)=(Sinal(i)+Sinal(i-1))/length(Sinal);
    
end

plot(SinalFiltrado)

%Criando o vetor degrau
%Criando a média do y(0)
soma=0;
for i=1:112
    
    soma = soma+Sinal(i);
    
end
y0 = soma/112

%Criando a média do y(infinito)
soma=0;
for i=151:length(Sinal)
    
    soma = soma+Sinal(i);
    
end
yinf = soma/(length(Sinal)-150)

%Criando a entrada degrau no grafico
Degrau = zeros(length(Sinal),1);
for i=1:length(Sinal)
    
    if i<112        
        Degrau(i)=y0;
    else
        Degrau(i)=yinf;
    end
end

%Ganho com um degrau unitário
A=1;
K=(yinf-y0)/A

ytau = 0.632*(yinf-y0)+y0
%Linha de encontro do tau com o sistema
linhaytau = ytau*ones(length(Sinal),1);

figure()
plot(Sinal,'b');
hold on;
plot(Degrau,'k','linewidth',2);
plot(linhaytau,'--');
hold off;

%Fazendo a função de transferencia do sistema
s = tf('s');  
tau=18;
H = K/(tau*s+1)

%Achando os parametros de tempo
%o t=0 do sinal é o t=111 do sistema como o t=111 entra, tiramos 110 pontos
Tamanho_t = length(Sinal)-110;
t=0:1:Tamanho_t;
%Fazendo o Degrau Unitário
Y=step(H,t);
%Fazendo o vetor resposta
Resposta = y0*ones(length(Sinal),1);
j=1;
for i=1:length(Sinal)
    if(i>110)
        Resposta(i)=Resposta(i)+Y(j);
        j=j+1;
    end
end
figure()
plot(Sinal,'b');
hold on;
plot(Degrau,'k','linewidth',2);
plot(Resposta,'--r','linewidth',2);
hold off;