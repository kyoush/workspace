clear
close all

Fs = 44100;
T = 2;
loop = 10;

% h1 = animatedline;
% xlim([0 loop])
% ylim([0 1])

tau = 36;
noise = GenNoiseWave(Fs*T, 1);
sig = zeros(Fs*T + tau, 2);
sig(1:Fs*T, 1) = noise;
sig(tau+1:end, 2) = noise;
sound(sig, Fs)