clear
close all

Fs = 44100;
frame_length = 8192;
win_len = 4096;
x = 1:frame_length;
freq = 1000;
win = hann(win_len);
win = win';
tau = 40;

sig = sin((2*pi)/(Fs/freq) * x);
sig2 = sin((2*pi)/(Fs/freq) * (x - tau));
tmp = [sig sig2];
sound(tmp, 44100)
a = [sig sig2];

sig(end-win_len/2+1:end) = sig(end-(win_len)/2+1:end) .* win(win_len/2+1:end);
sig2(1:win_len/2) = sig2(1:win_len/2) .* win(1:win_len/2);
tmp = sig(end-win_len/2+1:end);
tmp2 = sig2(1:win_len/2);
tmp3 = tmp + tmp2;

figure(1)
subplot(3, 1, 1)
plot(tmp)
subplot(3, 1, 2)
plot(tmp2)
subplot(3, 1, 3)
plot(tmp3)

sig3 = [sig(1:end-win_len/2) tmp3 sig2(win_len/2+1:end)];
figure(2)
subplot(2, 1, 1)
plot(a)
xlim([0 17000])
subplot(2, 1, 2)
plot(sig3)
xlim([0 17000])

pause(2)
sound(sig3, Fs)