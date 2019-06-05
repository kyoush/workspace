clear
close all

Fs = 44100;
T = 2;
tau = -20;

noise = GenNoiseWave(Fs*T, 1);
sig = zeros(Fs*T + abs(tau), 2);


if tau > 0
    sig(:, 1) = [noise zeros(1, tau)];
    sig(:, 1) = sig(:, 1);
    sig(tau+1:end, 2) = noise .* 1.5;
else
    sig(abs(tau)+1:end, 1) = noise;
    sig(:, 2) = [noise zeros(1, abs(tau))];
    sig(:, 2) = sig(:, 2) .* 1.2;
end
sound(sig, Fs)
pause(T)