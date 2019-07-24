clear

[x, Fs] = audioread('wn.wav');
X = fft(x);

figure(1)
subplot(2, 2, 1)
db = 20*log10(abs(X));
k = 0:length(X)-1;
freq = k * Fs / length(X) / 1000;
freq = freq';
semilogx(freq, db)
xlim([0.02 20])
grid on
sound(x, Fs)

subplot(2, 2, 2)
histogram(x)
xlim([-0.8 0.8])
grid on

T = 0.4;

clear x
x = wgn(Fs*T, 1, 1);
% x = randn(Fs*T, 1);
x = 0.5 * x ./ max(abs(x));
X = fft(x);

subplot(2, 2, 3)
db = 20*log10(abs(X));
k = 0:length(X)-1;
freq = k * Fs / length(X) / 1000;
freq = freq';
semilogx(freq, db)
xlim([0.02 20])
ylim([-100 50])
grid on
sound(x, Fs)
subplot(2, 2, 4)
histogram(x)
xlim([-0.8 0.8])
ylim([0 2500])
grid on