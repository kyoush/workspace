clear
close all
Fs = 44100;
T = 2;
org = GenNoiseWave(Fs*T, 1);
sig = zeros(Fs*T, 2);
sig(:, 1) = org;

figure(1);
grid on
xlim([1 10])
ylim([0 17])

l = 50;
power = zeros(l, 1);
for i = 1:l
    power(i) = bandpower(org .* (1/i));
end
disp(power)
plot(power)