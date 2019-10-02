clear
close all force

Pos = [100 200 600 400];

H0 = uifigure(...
    'Position', Pos);

sld = uislider(H0,...
    'Limits', [-1000 1000],...
    'ValueChangingFcn', @(sld, event) update_sld(sld, event));

button = uibutton(H0,...
    'Position', [250 200 80 50],...
    'Text', 'Play',...
    'ButtonPushedFcn', @(button, event) play(sld));

function play(sld)
frame_length = 1024;
fileReader = dsp.AudioFileReader(...
    'whitenoise.wav',...
    'SamplesPerFrame', frame_length);
Fs = fileReader.SampleRate;
aDW = audioDeviceWriter(...
    'SampleRate', Fs);
filter = dsp.FIRFilter();

while ~isDone(fileReader)
    noise = fileReader();
    tau = round(abs(sld.Value) * Fs * 0.000001);
    filter.Numerator = [zeros(1, tau) 1 zeros(1, 50-tau-1)];
    drawnow limitrate
    disp(sld.Value)
    if sld.Value > 0
        sig = [noise filter(noise)];
    else
        sig = [filter(noise) noise];
    end
    aDW(sig);
end
release(fileReader)
release(aDW)
end

function update_sld(sld, event)
sld.Value = event.Value;
end