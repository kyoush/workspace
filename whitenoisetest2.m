clear

Fs = 44100;
T = 2;

x = wgn(Fs*T, 1, 1);
x = 0.5 * x ./ 0.4267;

sound(x, Fs)

x = wgn(Fs*T, 1, 1);
x = 0.5 * x ./ 4.267;
sound(x, Fs)