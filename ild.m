function ild(db)
[noise, Fs] = audioread('noise.wav');
T = 2;

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

sound(sig, Fs)
end