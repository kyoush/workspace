clear
close all

[sig, Fs] = audioread('noise.wav');

ILD = 16;
const = 10^(ILD/20);

tmp(:, 1) = sig;
tmp(:, 2) = sig;

tmp(:, 1) = sig ./ const;

sound(tmp, Fs)