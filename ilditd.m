function ilditd(db, delta)
[noise, Fs] = audioread('noise.wav');
T = 2;

%% ild
sig = zeros(Fs*T, 2);
disp(bandpower(noise))
powersig = bandpower(noise) / (10^(abs(db)/20));
down = power2const(powersig);
disp(powersig)
disp(down)
if db > 0
    sig(:, 1) = noise;
    sig(:, 2) = noise .* down;
else
    sig(:, 1) = noise .* down;
    sig(:, 2) = noise;
end

%% itd
tau = round(abs(delta) * Fs * 0.000001);
sig2 = zeros(Fs*T + tau, 2);

if delta > 0
    sig2(1:Fs*T, 1) = noise;
    sig2(tau+1:end, 2) = noise;
else
    sig2(tau+1:end, 1) = noise;
    sig2(1:Fs*T, 2) = noise;
end

sound(sig2, Fs)

end