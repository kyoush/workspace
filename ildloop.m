clear
close all

Fs = 44100;
T = 10;
L = 5*Fs;

noise = GenNoiseWave(Fs*T, 1);

sig = zeros(Fs*T, 2);
sig(:, 1) = noise(:);

w = 2 * triang(L)';

for i = 1:(Fs*T)/L
    sig(i*L-L+1:i*L, 2) = noise(i*L-L+1:i*L) .* w;
    tmp(i,:) = [i*L-L+1:i*L];
end
sound(sig, Fs)