clear
close all

Fs = 44100;
T = 0.5;
loop = 15;
delay = 0.001;
delta = round((delay - ((2 * delay) / loop)) * Fs) + 100;
noise = GenNoiseWave(Fs*T, 1)';

for i = 1 : 3000
    noise(i) = noise(i) * i / 3000;
    noise(Fs * T - i + 1) = noise(Fs * T - i + 1) .* (i / 3000);
end

h1 = animatedline('Marker', 'o');
grid on
ylim([-1000 1000])
ylabel('ITD [É s]')
xlim([1 loop])

sig = zeros(Fs * T + 1000, 2);
start = delta;
sig(delta:delta + Fs * T - 1, 2) = noise;
sig(start:start + Fs * T - 1, 1) = noise;

for i = 1:loop
    tau = round((delay - ((2 * delay) / loop) * i) * Fs);
    start = delta + tau;
    sig(start:start + Fs * T - 1, 1) = noise;
    sound(sig, Fs)
    pause(T)
    
    addpoints(h1, i, tau/Fs*1000000)
    drawnow
end

figure(2)
plot(noise)
grid on
xlim([1 Fs*T])