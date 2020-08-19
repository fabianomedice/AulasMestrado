% Dados de calibração medidos no LECI/UFMG
%

% Copyright (c) 1998 por Luis Antonio Aguirre, todos os direitos reservados

% Dados de potenciômetros
% Potenciômetro de 100 ohms
% Posição angular em graus
pos100=(0:0.05:1)*288;

% Relação tensão de saída por volt de alimentação
k100=[0 0.009 0.018 0.029 0.038 0.049 0.058 0.068 0.079 0.089];
k100=[k100 0.098 0.109 0.119 0.129 0.139 0.149 0.160 0.170 0.180];
k100=[k100 0.189 0.2];

% regressão linear usando apenas duas amostras com ruido
%k100e=k100+0.01*randn(size(k100));
k100e=[   0.0116
    0.0176
    0.0077
    0.0271
    0.0250
    0.0521
    0.0677
    0.0605
    0.0510
    0.0960
    0.1301
    0.1144
    0.1220
    0.1318
    0.1486
    0.1699
    0.1752
    0.1680
    0.1802
    0.1915
    0.1915];


% regressão linear usando todas as amostras com ruído
pol2=polyfit(pos100,k100e',1);

y=polyval(pol2,pos100);
figure(2);
plot(pos100,y,'k-',pos100,k100e,'kx');
xlabel('graus angulares');
ylabel('tensão de saída por volt de alimentação (V/V)');
axis([-10 305 -0.05 0.25]);
pause;

% método de MQP
w=0.1*ones(21,1);
w(9:11)=[10;10;10];
W=diag(w);
X=[ones(21,1) pos100'];
teta=inv(X'*W*X)*X'*W*k100e;
y=polyval([teta(2) teta(1)],pos100);
w(9:11)=[100;100;100];
W=diag(w);
X=[ones(21,1) pos100'];
teta=inv(X'*W*X)*X'*W*k100e;
y2=polyval([teta(2) teta(1)],pos100);
figure(2);
plot(pos100,y,'k-',pos100,y2,'k-.',pos100,k100e,'kx',pos100(9:11),k100e(9:11),'ko');
xlabel('graus angulares');
ylabel('tensão de saída por volt de alimentação (V/V)');
axis([-10 305 -0.05 0.25]);

