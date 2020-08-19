% Exemplos secoes 3.5 e 3.6
% (c) Luis Antonio Aguirre

% O sistema
%u=[1 zeros(1,39)];
u=PRBS(40,8,2);
u=u-0.5;
lu=length(u);
y=dlsim([1 0.5],[1 -1.5 0.7],u);
e=randn(40,1);
e=0.003*(e-mean(e));
yi=dimpulse([1 0.5],[1 -1.5 0.7],lu);

subplot(211)
plot(1:40,u,'w-',1:40,u,'wo');
axis([0 40 -0.7 0.7]);
title('(a)');
subplot(212)
plot(1:40,y,'w-',1:40,y,'wo');
title('(b)');
xlabel('amostras')
axis([0 40 -6 6]);

pause

U=u';
for i=1:39
U=[U [zeros(i,1); u(1:lu-i)']];
end;

h=inv(U)*(y);
hr=inv(U)*(y+e);

subplot(211)
plot(1:40,yi,'w-',1:40,yi,'wo',1:40,h,'w+');
title('(a)');
subplot(212)
plot(1:40,yi,'w-',1:40,yi,'wo',1:40,hr,'w+');
title('(b)');
axis([0 40 -1 3]);
xlabel('amostras');
pause

%%%% Dominio da frequencia %%%%%

u=PRBS(128,8,2);
u=u-0.5;
lu=length(u);
y=dlsim([1 0.5],[1 -1.5 0.7],u);
e=randn(128,1);
e=0.003*(e-mean(e));
Y=fft(y+e);
U=fft(u');
H=Y./U;

freq=1/(length(y))*(0:length(y)/2); 
semilogx(freq,20*log10(abs(H(1:length(freq))))); 

w=logspace(-1.4,0.4,100);
mw=max(w);
I=find(2*pi*freq<=mw);
freq=freq(I);
[mag,pha]=dbode([1 0.5],[1 -1.5 0.7],1,w);
subplot(211)
semilogx(w,20*log10(mag),'w-',2*pi*freq,20*log10(abs(H(1:length(freq)))),'w--');
title('(a)');
ylabel('|H(jw)| (dB)');
axis([0.04 2.5 -20 30]);
subplot(212)
semilogx(w,pha,'w-',2*pi*freq,angle(H(1:length(freq)))*90/pi,'w--');
title('(b)');
ylabel('fase de H(jw) (graus)');
xlabel('freqüência (rad/s)')
axis([0.04 2.5 -200 50]);

pause



