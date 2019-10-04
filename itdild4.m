function itdild4(db, delta, ildlabel, itdlabel, stop, waveform)
global h
global plt
frame_length = 2048;
Fs = 44100;
fileReader = dsp.AudioFileReader(...
    'wn2.wav',...
    'SamplesPerFrame', frame_length);
aDW = audioDeviceWriter(...
    'SampleRate', fileReader.SampleRate);
flag = 1;
pos = h.Center;
save = [];
filter = dsp.FIRFilter();
length_coeff = 50;
if waveform == 1
    while(isDone(fileReader) == 0 && stop.Value == 0)
        if h.Selected == 1
            pos_old = pos;
            pos = h.Center;
            if pos_old == pos
                save = [save; pos];
                disp(pos)
                h.Selected = 0;
            end
        end
        noise = fileReader();
        drawnow limitrate
        tau = round(abs(delta.Value) * Fs * 0.000001);
        filter.Numerator = [zeros(1, tau) 1 zeros(1, length_coeff-tau-1)];
        
        if flag == 1
            for i = 1:1000
                noise(i) = noise(i) * (i/1000);
            end
            flag = 0;
        end

        %% ITD
        if delta.Value > 0
            sig = [filter(noise) noise];
        else
            sig = [noise filter(noise)];
        end
        
        %% ILD
        const = 10^(abs(db.Value)/20);
        if db.Value < 0
            sig(:, 2) = sig(:, 2) ./ const;
        else
            sig(:, 1) = sig(:, 1) ./ const;
        end
        
        %% update label
        l_pow = rms(sig(:, 1));
        r_pow = rms(sig(:, 2));
        a = 20 * log10(l_pow/r_pow);

        ildlabel.Text = [num2str(round(a)) ' [dB]'];

        a = sign(delta.Value) * (tau/Fs)*10^6;

        itdlabel.Text = [num2str(round(a)) ' [ƒÊs]'];

        
        
        aDW(sig);
    end
else
    filter = dsp.FIRFilter();
    sine = dsp.SineWave(...
        'Amplitude', 0.5,...
        'Frequency', 300,...
        'SampleRate', Fs,...
        'SamplesPerFrame', frame_length);
    while(stop.Value == 0)
        drawnow limitrate
%         x = 1:frame_length;
%         x = 0.5 * sin((2*pi)/(Fs/freq) * x)';
        x = sine();
        tau = round(abs(delta.Value) * Fs * 0.000001);
        filter.Numerator = [zeros(1, tau) 1 zeros(1, 50-tau-1)];
        
        %% ITD
        if delta.Value > 0
            sig = [filter(x) x];
        else
            sig = [x filter(x)];
        end
        
        %% ILD
        const = 10^(abs(db.Value)/20);
        if db.Value < 0
            sig(:, 2) = sig(:, 2) ./ const;
        else
            sig(:, 1) = sig(:, 1) ./ const;
        end
        
        %% update label
        l_pow = rms(sig(:, 1));
        r_pow = rms(sig(:, 2));
        a = 20 * log10(l_pow/r_pow);

        ildlabel.Text = [num2str(round(a)) ' [dB]'];

        a = sign(delta.Value) * (tau/Fs)*10^6;

        itdlabel.Text = [num2str(round(a)) ' [ƒÊs]'];
        
        aDW(sig);
    end
end
stop.Value = 0;
release(aDW);
release(fileReader)
a = size(save);
for i = 1:a(1)
    plt(i) = plot(save(i, 1), save(i, 2), 'b.', 'MarkerSize', 100);
end