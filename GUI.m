%---------------------------------------------
%
% GUI Program
%
% by K.Kamura  06/02/2019
% 
%---------------------------------------------
clear
close all force

X_MIN = 200;
Y_MIN = 200;
WIDTH = 600;
HEIGHT = 500;
Figure_position = [X_MIN Y_MIN WIDTH HEIGHT];

%% figureの作成
H0 = uifigure('Position', Figure_position,...
    'NumberTitle','off',...
    'Name','ITD & ILD',...
    'MenuBar', 'none',...
    'Color', [0.6 0.7 1],...
    'Units','pixels',...
    'Visible','on');
v = get(0, 'MonitorPosition');

%% ラベル
label1 = uilabel(H0,...
    'Position', [WIDTH/2-10 HEIGHT-80 500 100],...
    'Text', 'ILD');
label1.FontSize = 20;
label2 = uilabel(H0,...
    'Position', [WIDTH/2-10 HEIGHT-185 500 100],...
    'Text', 'ITD');
label2.FontSize = 20;
label3 = uilabel(H0,...
    'Position', [WIDTH-40 HEIGHT-140 100 100],...
    'Text', '[dB]');
label4 = uilabel(H0,...
    'Position', [WIDTH-40 HEIGHT-220 100 100],...
    'Text', '[μs]');

%% グラフ
ax = uiaxes(H0,...
    'Position', [30 HEIGHT-470 550 250],...
    'ylim', [-1 1]);

%% スライダ
sld = uislider(H0,...
    'Position', [WIDTH/2-250 HEIGHT-70 500 3]);
sld.Limits = [-20 20];
sld_itd = uislider(H0,...
    'Position', [WIDTH/2-250 HEIGHT-170 500 3],...
    'ValueChangedFcn',@(sld_itd, event) ilditd(sld.Value, sld_itd.Value, ax));
sld.ValueChangedFcn = (@(sld, event) ilditd(sld.Value, sld_itd.Value, ax));
sld_itd.Limits = [-1000 1000];

%% リセットボタン
button_ild = uibutton(H0,...
    'Position', [WIDTH-150 HEIGHT-50 80 30],...
    'Text', 'Clear ILD',...
    'ButtonPushedFcn',@(button_ild, event) reset_value(sld));

button_itd = uibutton(H0,...
    'Position', [WIDTH-150 HEIGHT-150 80 30],...
    'Text', 'Clear ITD',...
    'ButtonPushedFcn',@(button_itd, event) reset_value(sld_itd));

%% play
button_play = uibutton(H0,...
    'Position', [WIDTH-580 HEIGHT-50 80 30],...
    'Text', 'Play',...
    'ButtonPushedFcn',@(button_play, event) ilditd(sld.Value, sld_itd.Value, ax));

function reset_value(obj)
obj.Value = 0;
end
function sig = ilditd(db, delta, ax)
[noise, Fs] = audioread('noise.wav');
T = 1;
tau = round(abs(delta) * Fs * 0.000001);
sig = zeros(Fs*T + tau, 2);
%% ITD
if delta > 0
    sig(1:Fs*T, 1) = noise;
    sig(tau+1:end, 2) = noise;
else
    sig(tau+1:end, 1) = noise; 
    sig(1:Fs*T, 2) = noise;
end

%% ILD
down = power2const(abs(db));
if db > 0
    sig(:, 2) = sig(:, 2) .* down;
else
    sig(:, 1) = sig(:, 1) .* down;
end
sound(sig, Fs)

%% dB calc
l_pow = bandpower(sig(:, 1));
r_pow = bandpower(sig(:, 2));
a = 20 * log10(l_pow/r_pow);

%% plot
i = 3000:3500;
i = i';

h1 = plot(ax, i, sig(i, 1), 'b');
hold(ax, 'on')
h2 = plot(ax, i, sig(i, 2), 'r');
legend(ax, [h1, h2], 'L-channel', 'R-channel', 'location', 'southwest')

if db < 0
    h = get(ax, 'children');
    hg = findobj(ax, 'type', 'line', 'color', 'b');
    ind = (h == hg);
    newh = [h(ind), h(~ind)];
    set(ax, 'children', newh);
else
    h = get(ax, 'children');
    hg = findobj(ax, 'type', 'line', 'color', 'r');
    ind = (h == hg);
    newh = [h(ind), h(~ind)];
    set(ax, 'children', newh);
end

str = num2str(a);
str = ['ILD : ' str ' [dB]'];
text(ax, 3350, 0.75, str, 'Color', 'k', 'fontsize', 16);

str2 = num2str(sign(delta) * (tau/Fs) * 1000000);
str2 = ['ITD : ' str2 ' [μs]'];
text(ax, 3350, -0.75, str2, 'Color', 'k', 'fontsize', 16);

hold(ax, 'off')
save('temp.mat');

    function const = power2const(x)
        const = exp(-0.05756*x);
    end

end