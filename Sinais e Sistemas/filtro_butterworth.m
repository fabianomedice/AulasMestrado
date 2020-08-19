function y = filtro_butterworth (x,fc,fa)
% filtro_butterworth (x,fc,fa)
% x  -> sinal 
% fc -> frequência central
% fa -> frequencia de amostagem

%Filtro Butterworth de 2 ordem, passa alta
%n = ordem do filtro
n = 2;

%Wn = frequencia de corte normalizada
%Wn = frequencia de corte / frequencia de amostragem
Wn = fc/fa;

%Tipo do filtro - Passa Alta - 'high'

[b,a] = butter(n,Wn,'high');

%Chama um filtro de distorção de fase zero
y = filtfilt(b,a,x);
