function aDW = ilditd2(db, delta, ildlabel, itdlabel, stop)
frame_length = 4096;
Fs = 44100;
aDW = audioDeviceWriter;
flag = 1;

while(stop.Value == 0)
    noise = GenNoiseWave(frame_length + 441, 1);
    tau = round(abs(delta.Value) * Fs * 0.000001);
    
    if flag == 1
        for i = 1:3000
            noise(i) = noise(i) * (i/3000);
        end
        flag = 0;
    end
    
    %% ITD
    if delta.Value > 0
        sig(:, 1) = noise(tau + 1:frame_length+tau);
        sig(:, 2) = noise(1:frame_length);
    else
        sig(:, 1) = noise(1:frame_length);
        sig(:, 2) = noise(tau + 1:frame_length+tau);
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
    
    itdlabel.Text = [num2str(round(a)) ' [É s]'];
    
    aDW(sig);
%     pause(frame_length/Fs)
    pause(0.091)
end
stop.Value = 0;
release(aDW);
end