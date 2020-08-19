clear all
clc

%Carregando os dados BFG33.dat
Data = load ('BFG33.DAT');

%Separando os Sinais
Tempo33 = Data(:,1);
SinalEntrada33 = Data(:,2);
SinalSaida33 = Data(:,3);

% figure
% plot(SinalEntrada33)
% title('Entrada BFG33')
% figure
% plot(SinalSaida33)
% title('Saida BFG33')

%Carregando os dados BFG44.dat
Data = load ('BFG44.DAT');

%Separando os Sinais
Tempo44 = Data(:,1);
SinalEntrada44 = Data(:,2);
SinalSaida44 = Data(:,3);

% figure
% plot(SinalEntrada44)
% title('Entrada BFG44')
% figure
% plot(SinalSaida44)
% title('Saida BFG44')

%Para BFG33
%Número de regressores utilizados
Ny1=20;
Nu1=20;

if Ny1>=Nu1
    n=Ny1+1;
else
    n=Nu1+1;
end

for i=n:1:length(SinalEntrada33)
    for j=1:1:Ny1
        reg(i-n+1,j)=SinalSaida33(i-j);
    end
    for j=1:1:Nu1
        reg(i-n+1,j+Ny1)=SinalEntrada33(i-j);
    end
end

theta33 = inv(reg'*reg)*reg'*SinalSaida33(n:end);

y1s=SinalSaida33(1)*ones(Ny1+Nu1,1)';
for k=Ny1+Nu1+1:length(SinalEntrada33)
    y1s(k)=0;
    for i=1:1:Ny1
        y1s(k)=y1s(k)+theta33(i)*y1s(k-i);
    end
    for j=Ny1+1:Ny1+Nu1
        y1s(k)=y1s(k)+theta33(j)*SinalEntrada33(k-(Nu1+(Ny1-Nu1)-1));
    end
end
% Simulacao H1
s=tf('s');
H1 = (1.338*exp(-1.9*s))/((3.406*s+1)*(1.053*s+1));
yh1=lsim(H1,SinalEntrada33,Tempo33);

figure()
plot(y1s)
hold on
plot(SinalSaida33)
xlabel('Tempo')
ylabel('Volts')
legend('Modelo ARX','Dados Sistema')

%Para BFG44
%Número de regressores utilizados
Ny2=40;
Nu2=40;

if Ny2>=Nu2
    n=Ny2+1;
else
    n=Nu2+1;
end

for i=n:1:length(SinalEntrada44)
    for j=1:1:Ny2
        reg(i-n+1,j)=SinalSaida44(i-j);
    end
    for j=1:1:Nu2
        reg(i-n+1,j+Ny2)=SinalEntrada44(i-j);
    end
end

theta44 = inv(reg'*reg)*reg'*SinalSaida44(n:end);

y2s=SinalSaida44(1)*ones(Ny2+Nu2,1)';
for k=Ny2+Nu2+1:length(SinalEntrada44)
    y2s(k)=0;
    for i=1:1:Ny2
        y2s(k)=y2s(k)+theta44(i)*y2s(k-i);
    end
    for j=Ny2+1:Ny2+Nu2
        y2s(k)=y2s(k)+theta44(j)*SinalEntrada44(k-(Nu2+(Ny2-Nu2)-1));
    end
end

figure()
plot(y2s)
hold on
plot(SinalSaida44)
xlabel('Tempo')
ylabel('Volts')
legend('Modelo ARX','Dados Sistema')
