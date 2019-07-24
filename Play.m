function Play(H, bt_stop, filename, pathname)
    AFR = dsp.AudioFileReader([pathname filename]);
    AP = dsp.AudioPlayer('SampleRate', AFR.SampleRate);
    set(gca, 'XScale', 'log',...
        'XLim', [0.2 20],...
        'YLim', [-70 60]);
    grid on
    AFR.SamplesPerFrame = 2048;
    i = 1;
    while ~isDone(AFR) && bt_stop.Value == 0
%         disp(i)
        i = i + 1;
        audio = AFR();
%         nUnderrun = AP(audio);
        AP(audio)
%         pause(AFR.SamplesPerFrame/AP.SampleRate);
        clearpoints(H)
        x = audio(:, 1) + audio(:, 2);
        X = kasan(x);
        X = 20*log10(abs(X));
        N = length(X);
        k = 0:N-1;
        freq = k * 44100 / N / 1000;
        freq = freq';
        addpoints(H, freq, X);
% %         if nUnderrun > 0
%             fprintf('Audio player queue underrun by %d samples.\n'...
%                 ,nUnderrun);
%         end
        drawnow limitrate
    end
    bt_stop.Value = 0;
    release(AFR);
    release(AP);
end

function out = kasan(x)
n = length(x);
SUMSig = 0;
Frame_length = 1024;
Frame_shift = Frame_length/2;
TotalFrameNum = n - Frame_length;
for frame = 1 : Frame_shift :TotalFrameNum
    SIG = x(frame:frame+Frame_length-1) .* hann(Frame_length);
    sig = abs(fft(SIG));
    SUMSig = SUMSig + sig;
end
out = SUMSig/(n/Frame_shift-2);
end