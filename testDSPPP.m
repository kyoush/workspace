%% Create objects for audio input/output
frameLength = 1024;

fileReader = dsp.AudioFileReader( ...
    'Counting-16-44p1-mono-15secs.wav', ...
    'SamplesPerFrame',frameLength);
deviceWriter = audioDeviceWriter( ...
    'SampleRate',fileReader.SampleRate);

%% Create object for visualization
scope = dsp.TimeScope( ...
    'SampleRate',fileReader.SampleRate, ...
    'TimeSpan',16, ...
    'BufferLength',1.9e6, ...
    'YLimits',[-1,1]);

%% Create object for audio processing
reverb = reverberator( ...
    'SampleRate',fileReader.SampleRate, ...
    'PreDelay',0.5, ...
    'WetDryMix',0.4);

%% Audio stream loop
while ~isDone(fileReader)
    signal = fileReader();
    reverbSignal = reverb(signal);
    deviceWriter(reverbSignal);
    scope([signal, mean(reverbSignal, 2)])
end

release(fileReader)
release(deviceWriter)
release(reverb)
release(scope)