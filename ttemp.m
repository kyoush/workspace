frameLength = 256;
fileReader = dsp.AudioFileReader( ...
    'Counting-16-44p1-mono-15secs.wav', ...
    'SamplesPerFrame',frameLength);
deviceWriter = audioDeviceWriter( ...
    'SampleRate',fileReader.SampleRate);

scope = dsp.TimeScope( ...
    'SampleRate',fileReader.SampleRate, ...
    'TimeSpan',16, ...
    'BufferLength',1.5e6, ...
    'YLimits',[-1,1]);

reverb = reverberator( ...
    'SampleRate',fileReader.SampleRate, ... 
    'PreDelay',0.5, ...
    'WetDryMix',0.4);

while ~isDone(fileReader)
    signal = fileReader();
    reverbSignal = reverb(signal);
    deviceWriter(reverbSignal);
%     scope(signal)
end

release(fileReader) 
release(deviceWriter)
release(reverb)
release(scope)