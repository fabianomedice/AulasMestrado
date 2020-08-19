function y = filtro_notch(x,fc,fa,q)
% filtro_notch(x,fc,fa,q)
% x  -> sinal 
% fc -> frequ�ncia de corte
% fa -> frequencia de amostagem
% q  -> fator de qualidade do filtro

%filtro iirnotch (w0,bw)

%w0 � o �ngulo de corte. Ele � calculado por % do sinal.
%w0 = angulo de corte / frequencia de amostragem
% Como frequencia de amostragem � espelhada, � fa/2
w0 = fc/(fa/2);

%bw � o fator de qualidade (q) do filtro relacionada a largura de banda dele
%q = w0 / bw
bw = w0/q;

[b,a] = iirnotch(w0,bw);

%Chama um filtro de distor��o de fase zero
y = filtfilt(b,a,x);
