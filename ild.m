clear
close all

Fs = 44100;
T = 2;

noise = GenNoiseWave(Fs*T, 1);

sig = zeros(Fs*T, 2);
sig(:, 1) = noise(:);

sig(:, 2) = noise .* 0.3;
sound(sig, Fs)