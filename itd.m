function itd(delta)
Fs = 44100;
T = 2;

tau = round(abs(delta) * Fs * 0.000001);
noise = GenNoiseWave(Fs*T, 1);
sig = zeros(Fs*T + tau, 2);


if delta > 0
    sig(1:Fs*T, 1) = noise;
    sig(tau+1:end, 2) = noise;
else
    sig(tau+1:end, 1) = noise;
    sig(1:Fs*T, 2) = noise;
end

sound(sig, Fs)
end