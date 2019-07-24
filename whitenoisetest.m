clear
close all

Fs = 44100;
T = 5;
frame_length = 4096;
NN = 30;
n = 4096 * NN;
N = 2^17;

%% ノイズの作成と窓かけ
win = hann(2048);
% noise = wgn(n, 1, -20);
noise = randn(n, 1) * 0.1;

noise = 0.5 * noise./max(abs(noise));

figure(2)
subplot(2, 1, 1)
histogram(noise)

noise(1:1024) = noise(1:1024) .* win(1:1024);
noise(end-1023:end) = noise(end-1023:end) .* win(end-1023:end);

x = noise;
sig = kasan(noise, N);

sig2 = [];
for i = 1:NN
    noise2 = wgn(frame_length, 1, 1);
%     noise2 = randn(frame_length, 1) * 0.1;
    disp(max(abs(noise2)))
    noise2 = 0.5 * (noise2 ./ max(noise2));
    sig2 = [sig2; noise2];
end

figure(2)
subplot(2, 1, 2)
histogram(sig2)

sig2(1:1024) = sig2(1:1024) .* win(1:1024);
sig2(end-1023:end) = sig2(end-1023:end) .* win(end-1023:end);
% sig2 = [sig2; zeros(N-length(sig2), 1)];

time = 0:n-1;
time = time ./ Fs;

fos = 14;

figure(1)
subplot(2, 2, 1)
plot(time, x)
ylim([-1 1])
grid on
title('409600点のホワイトノイズを作成した場合')
xlabel('time [s]')
ylabel('Amplitude')
set(gca, 'fontsize', fos)

subplot(2, 2, 3)
plot(time, sig2)
ylim([-1 1])
grid on
title('4096点のホワイトノイズを100回作成してつなげた場合')
xlabel('time [s]')
ylabel('Amplitude')
X2 = kasan(sig2, N);
set(gca, 'fontsize', fos)

k = 0:length(X2)-1;
freq = k * Fs / length(X2) / 1000;
freq = freq';

subplot(2, 2, 2)
db1 = 20 * log10(sig);
semilogx(freq, db1);
xlim([0.02 20])
grid on
ylim([6 13])
ylabel('Power [dB]')
xlabel('frequency [Hz]')
set(gca, 'fontsize', fos)

subplot(2, 2, 4)
db2 = 20 * log10(X2);
semilogx(freq, db2)
grid on
xlim([0.02 20])
ylim([6 13])
xlabel('frequency [Hz]')
ylabel('Power [dB]')
set(gca, 'fontsize', fos)

sound(x, Fs)
pause(3)
sound(sig2, Fs)

function out = kasan(x, N)
n = length(x);
SUMSig = 0;
Frame_length = 2048;
Frame_shift = Frame_length/2;
TotalFrameNum = n - Frame_length;
for frame = 1 : Frame_shift :TotalFrameNum
    SIG = x(frame:frame+Frame_length-1) .* hann(Frame_length);
    sig = abs(fft(SIG));
    SUMSig = SUMSig + sig;
end
out = SUMSig/(n/Frame_shift-2);
end