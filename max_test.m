clear

Fs = 44100;
frame_length = 4096;
N = 10000;

Max = zeros(N, 1);
Mean = zeros(100, 1);

for j = 1:10
    for i = 1:N
        noise = wgn(frame_length, 1, 1);
        Max(i) = max(abs(noise));
    end
    Mean(j) = mean(Max);
end

histogram(Mean)