Fs = 44100;

RecordingTime = 5;
frame_length = 4096;

NFFT = frame_length;
dF = Fs/NFFT;

aDR = audioDeviceReader('Device', 'Default', ...
    'SampleRate', Fs, ...
    'SamplesPerFrame', frame_length);

fileWriter = dsp.AudioFileWriter(...
    'tmp.wav',...
    'FileFormat', 'WAV');

figure(1)
H1 = subplot(3,1,1);
    set(H1, 'ylim', [-1 1]);
    set(H1, 'xlim', [0 RecordingTime]);
    box on
    
    h1 = animatedline('color', 'k');
    
H2 = subplot(3,1,[2, 3]);
 freq_vector = (1:frame_length/2+1)*dF/1000;
 h2 = semilogx(H2, NaN, NaN, 'r-');
    
    set(H2, 'ylim', [-40 60]);
    set(H2, 'xlim', [20/1000 freq_vector(end)]);
    
    set(H2, 'XTick', [0.02 0.1 1 10 20]);
    set(H2, 'XTickLabel', {'20', '100', '1k', '10k', '20k'})
    
    xlabel('Frequency in Hz');
    ylabel('Power in dB');
    grid on
    drawnow;
    
maxt = 0;
frame_num = 0;

while maxt <= RecordingTime
    x = aDR();
    
    X = fft(x.*hanning(NFFT));
    XdB = 20*log10(abs(X(1:NFFT/2+1)));
    
    frame_num = frame_num + 1;
    Start_Time = (frame_num-1)*frame_length;
    
    t = (Start_Time : Start_Time + frame_length-1)';
    time_vector = t/Fs;
    
    maxt = max(time_vector);
    
    addpoints(h1, time_vector, x);
    drawnow
    
    set(h2, 'XData', freq_vector(2:end),'YData', XdB(2:end));
    
    fileWriter(x);
end
release(aDR);

release(fileWriter);
y = audioread('tmp.wav');