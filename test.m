clear
close all
[sig, Fs] = audioread('noise.wav');

c = 20;
db = zeros(1, c);
x = 1:c;
x = x ./ c;
for i = 1:c
    tmp = sig(:, 1) .* x(i);
    db(i) = 20 * log10(rms(sig(:, 1))/rms(tmp));
end
x(length(x)) = [];
db(length(db)) = [];