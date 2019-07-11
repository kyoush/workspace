clear

Fs = 44100;
T = 5;
N = 2^18;
win = hann(2048);
noise = wgn(Fs*T, 1, 1);
noise(1:1024) = noise(1:1024) .* win(1:1024);
noise(end-1023:end) = noise(end-1023:end) .* win(end-1023:end);

x = zeros(N, 1);
x(1:Fs*T) = noise;
X = fft(x);
k = 0:N-1;
freq = k * Fs / N / 1000;
freq = freq';
plot(freq, abs(X))
xlim([0 freq(N/2-1)])

sig = kasan(x);

function sig = kasan(x)
n = length(x);
cnt = 0;
SUMSig = 0;
Frame_shift = 1024;
Frame_length = 8192;
TotalFrameNum = n - Frame_length;
 for frame = 1 : Frame_shift : TotalFrameNum
     SIG = x(frame:frame+Frame_length-1) .* hanning(Frame_length);
     sig = abs(fft(SIG,Frame_length*2));
     SUMSig = SUMSig + sig;
     cnt = cnt + 1;
 end

sig = SUMSig/cnt;
end