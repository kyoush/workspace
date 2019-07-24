clear
close all

aDW = audioDeviceWriter('SupportVariableSizeInput', true);
frame_length = 2048;
Fs = aDW.SampleRate;
T = 2;
n = T*Fs/frame_length;

for j = 1:4
    pow = 9 + j;
    frame_length = 2^pow;
    n = T*Fs/frame_length;
    for i = 1:n
        cn = dsp.ColoredNoise('Color', 'white', 'SamplesPerFrame', frame_length);
        x = cn();
        aDW(x);
    end
    pause(0.5)
end

release(aDW)