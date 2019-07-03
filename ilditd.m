function aDW = ilditd(db, delta, ildlabel, itdlabel)
frame_length = 4096;
[noise, Fs] = audioread('noise2.wav');
aDW = audioDeviceWriter;

for i = 1:length(noise)/frame_length - 1
    sig = zeros(frame_length, 2);
    tau = round(abs(delta.Value) * Fs * 0.000001);
    %% ITD
    tmp = frame_length*i:frame_length*i + 4095;
%     disp(delta.Value)
%     disp(db.Value)
    if delta.Value > 0
        sig(:, 1) = noise(tmp + tau);
        sig(:, 2) = noise(tmp);
    else
        sig(:, 1) = noise(tmp);
        sig(:, 2) = noise(tmp + tau);
    end
    %% ILD
    const = 10^(abs(db.Value)/20);
    if db.Value > 0
        sig(:, 2) = sig(:, 2) ./ const;
    else
        sig(:, 1) = sig(:, 1) ./ const;
    end
    
    %% dB calc
    l_pow = rms(sig(:, 1));
    r_pow = rms(sig(:, 2));
    a = 20 * log10(l_pow/r_pow);
    
    ildlabel.Text = [num2str(round(a)) ' [dB]'];
    
    a = sign(delta.Value) * (tau/Fs)*10^6;
    
    itdlabel.Text = [num2str(round(a)) ' [É s]'];
    
    aDW(sig);
    pause(frame_length/Fs);
end
disp('ok')
release(aDW);
end