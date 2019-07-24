aDW = audioDeviceWriter;
for i = 1:10
    out = dsp.Sinewave();
    aDW(out)
end
release(aDW)