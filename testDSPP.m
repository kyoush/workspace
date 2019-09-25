frameLength = 256;
fileReader = dsp.AudioFileReader( ...
    'whitenoise.wav', ...
    'SamplesPerFrame',frameLength);
deviceWriter = audioDeviceWriter( ...
    'SampleRate',fileReader.SampleRate);

scope = dsp.TimeScope( ...
    'SampleRate',fileReader.SampleRate, ...
    'TimeSpan',16, ...
    'BufferLength',1.9e6, ...
    'YLimits',[-1,1]);

reverb = reverberator( ...
    'SampleRate',fileReader.SampleRate, ...
    'PreDelay',0.5, ...
    'WetDryMix',0.4);

while ~isDone(fileReader)
    signal = fileReader();
    delay = dsp.Delay(70);
    sig = [signal delay(signal)];
    deviceWriter(sig);
%     scope([sig,signal])
end

release(fileReader)
release(deviceWriter)
release(reverb)
release(scope)