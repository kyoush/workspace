fileReader = dsp.AudioFileReader('speech_dft.mp3');
fileInfo = audioinfo('speech_dft.mp3');

deviceWriter = audioDeviceWriter( ...
    'SampleRate',fileReader.SampleRate);
setup(deviceWriter, ...
    zeros(fileReader.SamplesPerFrame,fileInfo.NumChannels));

totalUnderrun = 0;
while ~isDone(fileReader)
    input = fileReader();
    numUnderrun = deviceWriter(input);
    totalUnderrun = totalUnderrun + numUnderrun;
end
fprintf('Total samples underrun: %d.\n', ...
    totalUnderrun);
fprintf('Total seconds underrun: %d.\n', ...
    double(totalUnderrun)/double(deviceWriter.SampleRate));

release(fileReader);
release(deviceWriter);
totalUnderrun = 0;

while ~isDone(fileReader)
    input = fileReader();
    numUnderrun = deviceWriter(input);
    totalUnderrun = totalUnderrun + numUnderrun;
    pause(0.075)
end
fprintf('Total samples underrun: %d.\n', ...
    totalUnderrun);
fprintf('Total seconds underrun: %d.\n', ...
    double(totalUnderrun)/double(deviceWriter.SampleRate));

release(fileReader);
release(deviceWriter);
totalUnderrun = 0;

