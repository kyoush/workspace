function sig = ilditd(db, delta)

frame_length = 4096;
[noise, Fs] = audioread('noise2.wav');
aDW = audioDeviceWriter;

for i = 1:length(noise)/frame_length
    sig = zeros(frame_length, 2);
    tau = round(abs(delta.Value) * Fs * 0.000001);
    %% ITD
    tmp = frame_length*i - 4095 + tau:frame_length*i + tau;
    disp(delta.Value)
    disp(db.Value)
    if delta.Value > 0
        sig(:, 1) = noise(frame_length*i - 4095 : frame_length*i);
        sig(:, 2) = noise(tmp);
    else
        sig(:, 1) = noise(tmp);
        sig(:, 2) = noise(frame_length*i - 4095 :frame_length*i);
    end

    %% ILD
    const = 10^(abs(db.Value)/20);
    if db.Value > 0
        disp('aa')
        sig(:, 2) = sig(:, 2) ./ const;
    else
        sig(:, 1) = sig(:, 1) ./ const;
    end
    pause(frame_length/Fs);
    aDW(sig);
end
disp('ok')
release(aDW);

%% dB calc
a1 = rms(sig(:,1));
a2 = rms(sig(:,2));
a = 20*log10(a1/a2);
disp(a)

%% plot
% i = 3000:3500;
% i = i';
% 
% h1 = plot(ax, i, sig(i, 1), 'b');
% hold(ax, 'on')
% h2 = plot(ax, i, sig(i, 2), 'r');
% legend(ax, [h1, h2], 'L-channel', 'R-channel', 'location', 'southwest')
% 
% if db < 0
%     h = get(ax, 'children');
%     hg = findobj(ax, 'type', 'line', 'color', 'b');
%     ind = (h == hg);
%     newh = [h(ind), h(~ind)];
%     set(ax, 'children', newh);
% else
%     h = get(ax, 'children');
%     hg = findobj(ax, 'type', 'line', 'color', 'r');
%     ind = (h == hg);
%     newh = [h(ind), h(~ind)];
%     set(ax, 'children', newh);
% end 
% 
% str = num2str(a);
% str = ['ILD : ' str ' [dB]'];
% text(ax, 3350, 0.75, str, 'Color', 'k', 'fontsize', 16);
% 
% str2 = num2str(sign(delta) * (tau/Fs) * 1000000);
% str2 = ['ITD : ' str2 ' [ƒÊs]'];
% text(ax, 3350, -0.75, str2, 'Color', 'k', 'fontsize', 16);
% 
% hold(ax, 'off')
% save('temp.mat');
end