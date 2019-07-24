function itdild3(db, delta, ildlabel, itdlabel, stop, waveform)
global store
global h
global plt
% clf plt
frame_length = 2048;
Fs = 48000;
AP = dsp.AudioPlayer('OutputNumUnderrunSamples', true);
aDW = audioDeviceWriter;
flag = 1;
tmp.sig = [];
tmp.tau = 0;
t_pause = 0.085;
t_pause = 4096/Fs;
bufferLatency = frame_length / Fs;
j = 1;
pos = h.Center;
save = [];
if waveform == 1
    while(stop.Value == 0)
        if h.Selected == 1
            pos_old = pos;
            pos = h.Center;
            if pos_old == pos
                save = [save; pos];
                disp(pos)
                h.Selected = 0;
            end
        end
        noise = wgn(frame_length + 441, 1, 1);
        noise = 0.5 * noise ./ 0.4267;
        tau = round(abs(delta.Value) * Fs * 0.000001);
        if flag == 1
            for i = 1:1000
                noise(i) = noise(i) * (i/1000);
            end
            flag = 0;
        end
        
        %% ITD
        if delta.Value > 0
            sig(:, 1) = noise(tau + 1:frame_length+tau);
            sig(:, 2) = noise(1:frame_length);
            tmp.LR = 1;
        else
            sig(:, 1) = noise(1:frame_length);
            sig(:, 2) = noise(tau + 1:frame_length+tau);
            tmp.LR = 2;
        end
        
        %% ILD
        const = 10^(abs(db.Value)/20);
        if db.Value > 0
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
        %% tmp
        if tmp.LR == 1 && tmp.tau > 0
            sig(1:tmp.tau+1, 2) = tmp.sig';
        elseif tmp.LR == 2 && tmp.tau > 0
            sig(1:tmp.tau+1, 1) = tmp.sig';
        end
        
        tmp.sig = noise(frame_length:frame_length+tau) ./ const;
        tmp.tau = tau;
        j = j + 1;
        a = AP(sig);
%         a = aDW(sig);
%         if a > 0
%             disp('delay')
%         end
        pause(bufferLatency)
%         pause(0.0000000001)
    end
else
    freq = 416;
%     freq = sld.Value;
    taper = 3000;
    w = hann(taper);
    tmp = zeros(taper/2, 2);
    while(stop.Value == 0)
        freq = sld.Value;
        x = 1:frame_length + 1441;
        x = 0.5 * sin((2*pi)/(Fs/freq) * x)';
        tau = round(abs(delta.Value) * Fs * 0.000001);
        
        %% ITD
        if delta.Value > 0
            sig(:, 1) = x(tau + 1:frame_length+tau);
            sig(:, 2) = x(1:frame_length);
%             tmp.LR = 1;
        else
            sig(:, 1) = x(1:frame_length);
            sig(:, 2) = x(tau + 1:frame_length+tau);
%             tmp.LR = 2;
        end
        
        %% ILD
        const = 10^(abs(db.Value)/20);
        if db.Value > 0
            sig(:, 2) = sig(:, 2) ./ const;
        else
            sig(:, 1) = sig(:, 1) ./ const;
        end
        
        sig(1:taper/2, :) = sig(1:taper/2, :) .* w(1:taper/2);
        temp = sig(1:taper/2, :) + tmp;
        sig2 = [temp; sig(taper/2+1:end, :)];
        
        tmp = sig(end-taper/2+1:end, :) .* w(end-taper/2+1:end);
        
        AP(sig2);
        pause(bufferLatency)
    end
end

stop.Value = 0;
release(aDW);
% release(AP)
a = size(save);
for i = 1:a(1)
    plt(i) = plot(save(i, 1), save(i, 2), 'b.', 'MarkerSize', 100)
end