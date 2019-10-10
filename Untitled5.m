Fs = 44100;
T = 2;
% 
% noise = GenNoiseWave(Fs*T, 0.5);
% sound(noise, Fs)
% pause(T+1)

[x, Fs] = audioread('whitenoise.wav');
sound(x(1:Fs*T), Fs)