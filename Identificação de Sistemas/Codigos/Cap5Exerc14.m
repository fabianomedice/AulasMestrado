clear all
clc

%Carregando os dados PRBSA02.dat
Data = load ('PRBSA02.DAT');

%Separando os Sinais
Tempo = Data(:,1);
SinalEntrada = Data(:,2);
SinalSaida = Data(:,3);

% figure
% plot(SinalEntrada)
% title('Entrada PRBSA02')
% figure
% plot(SinalSaida)
% title('Saida PRBSA02')

%Número de regressores utilizados
Ny=8;
Nu=8;

if Ny>=Nu
    n=Ny+1;
else
    n=Nu+1;
end

for i=n:1:length(SinalEntrada)
    for j=1:1:Ny
        reg(i-n+1,j)=SinalSaida(i-j);
    end
    for j=1:1:Nu
        reg(i-n+1,j+Ny)=SinalEntrada(i-j);
    end
end

theta = inv(reg'*reg)*reg'*SinalSaida(n:end);

y1s=SinalSaida(1)*ones(Ny+Nu,1)';
for k=Ny+Nu+1:length(SinalEntrada)
    y1s(k)=0;
    for i=1:1:Ny
        y1s(k)=y1s(k)+theta(i)*y1s(k-i);
    end
    for j=Ny+1:Ny+Nu
        y1s(k)=y1s(k)+theta(j)*SinalEntrada(k-(Nu+(Ny-Nu)-1));
    end
end

figure()
plot(SinalSaida)
hold on
plot(y1s)
xlabel('Tempo')
legend('Dados Sistema','Modelo ARX')
