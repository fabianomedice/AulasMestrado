function y = filtro(x,fc,fa)
% x  -> sinal 
% fc -> frequência central
% fa -> frequencia de amostagem
% Banda de 5 Hz

fmin = fc - 5;
fmax = fc + 5;
f = [fmin fmax];
wn = 2*f/fa;

[b,a] = butter(2,wn);
y = filter(b,a,x);

