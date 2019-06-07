clear
close all

Fs = 44100;
T = 0.5;
loop = 15;

noise = GenNoiseWave(Fs*T, 1);
for i = 1 : 3000
    noise(i) = noise(i) * i / 3000;
    noise(Fs * T - i + 1) = noise(Fs * T - i + 1) .* (i / 3000);
end

h1 = animatedline('Marker', 'o');
movegui(h1,'northwest')
grid on
ylim([-50 50])
xlim([1 loop])
ylabel("ILD [dB]")

for i = 1:loop
    sig(:, 1) = noise * (i / loop);
    sig(:, 2) = noise * (1 - i / loop);
    sound(sig, Fs)
    pause(T)
    
    if i == 10
        f3 = figure(3);
        movegui(f3, 'center')
        plot(sig(:, 1))
        hold on
        plot(sig(:, 2))
        xlim([1 Fs*T])
    end
    
    ild = bandpower(sig(:, 1)) / bandpower(sig(:, 2));
    ild = 20 * log10(ild);
    addpoints(h1, i, ild)
    drawnow
end

figure(2)
plot(noise)
grid on
xlim([1 Fs*T])