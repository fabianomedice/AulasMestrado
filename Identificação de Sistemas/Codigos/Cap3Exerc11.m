clear all
clc

%Carregando os dados ensaio6mw.dat
Data = load ('PULSO30.DAT');

%Separando os Sinais
SinalVazao = Data(:,2);
SinalEntrada = Data(:,3);

FFTSinalVazao = fft(SinalVazao);
FFTSinalEntrada = fft(SinalEntrada);

H=FFTSinalVazao./FFTSinalEntrada;

f= -length(SinalVazao)/2:1:length(SinalVazao)/2-1;

figure, plot(f,abs(H)), title('Amplitude plot')
figure, plot(f,angle(H)), title('Phase plot')
