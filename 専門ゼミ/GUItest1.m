%---------------------------------------------
%
% GUI Program
%
% by K.Kamura  12/20/2018 
%�@ 
%---------------------------------------------

set(0, 'Units', 'pixels');
v = get(0, 'MonitorPosition');

Fs = 44100;

X_MIN = 100;
Y_MIN = 100;
WIDTH = 700;
HEIGHT = 500;

rate = 1.7;

Figure_position = [X_MIN Y_MIN WIDTH HEIGHT];

H0 = figure('Position', Figure_position,...
    'NumberTitle','off',...
    'Name','MATLAB GUI for 2018���[�~',...
    'MenuBar', 'none',...
    'Color','w',...
    'Units','pixels',...
    'Visible','on');
v = get(0, 'MonitorPosition');

H_A1 = axes('Box', 'on',...
    'Units', 'normalized',...
    'Position', [60/WIDTH 320/HEIGHT 520/WIDTH 110/HEIGHT]);

H_A2 = axes('Box', 'on',...
    'Units', 'normalized',...
    'Position', [60/WIDTH 40/HEIGHT 520/WIDTH 240/HEIGHT]);

H_PB_1 = uicontrol(H0,...
    'Style', 'pushbutton',...
    'Units', 'normalized',...
    'Position', [610/WIDTH 450/HEIGHT 60/WIDTH 40/HEIGHT],...
    'String', 'Read',...
    'BackgroundColor', [0.9 0.9 0.2],...
    'CallBack', '[sig, Fs] = Load_Data_and_Plot(H_A1, H_A2);');

H_PB_rec = uicontrol(H0,...
    'Style', 'pushbutton',...
    'Units', 'normalized',...
    'Position', [610/WIDTH 380/HEIGHT 60/WIDTH 40/HEIGHT],...
    'String', 'Rec',...
    'BackgroundColor', [0.9 0.4 0.4],...
    'CallBack', 'sig = record_GUI(Fs, H_A1, H_A2);');

H_PB_RTrec = uicontrol(H0,...
    'Style', 'pushbutton',...
    'Units', 'normalized',...
    'Position', [610/WIDTH 310/HEIGHT 60/WIDTH 40/HEIGHT],...
    'String', 'RT Rec',...
    'BackgroundColor', [0.9 0.9 0.6],...
    'CallBack', 'sig = RT_record(Fs, H_A1, H_A2);');

H_PB_save = uicontrol(H0,...
    'Style', 'pushbutton',...
    'Units', 'normalized',...
    'Position', [610/WIDTH 230/HEIGHT 60/WIDTH 40/HEIGHT],...
    'String', 'Save',...
    'BackgroundColor', [0.6 0.7 0.9],...
    'CallBack', 'save_GUI(sig, Fs);');

H_PB_picola = uicontrol(H0,...
    'Style', 'pushbutton',...
    'Units', 'normalized',...
    'Position', [590/WIDTH 50/HEIGHT 100/WIDTH 40/HEIGHT],...
    'String', 'Picola SlowDown',...
    'BackgroundColor', [1.0 0.6 1.0],...
    'CallBack', 'sound(Picola(rate, sig, Fs), Fs);');

H_PB2 = uicontrol(H0,...
    'Style', 'pushbutton',...
    'Units', 'normalized',...
    'Position', [100/WIDTH 450/HEIGHT 60/WIDTH 30/HEIGHT],...
    'String', 'Play',...
    'BackgroundColor', [0.0 1.0 0.0],...
    'CallBack', 'sound(sig, Fs);');

H_PB3 = uicontrol(H0,...
    'Style', 'pushbutton',...
    'Units', 'normalized',...
    'Position', [180/WIDTH 450/HEIGHT 60/WIDTH 30/HEIGHT],...
    'String', 'Rev. Play',...
    'BackgroundColor', [0.0 1.0 0.0],...
    'CallBack', 'sound(flipud(sig), Fs);');

HM.UIM3 = uimenu (H0, 'label', 'Preference');
    HM.UIM3_01 = uimenu( HM.UIM3, 'label', 'Fs (Default: 44.1 kHz');
        uimenu(HM.UIM3_01, 'label', ' 8000', 'CallBack', 'Fs =  8000;');
        uimenu(HM.UIM3_01, 'label', '16000', 'CallBack', 'Fs = 16000;');
        uimenu(HM.UIM3_01, 'label', '22050', 'CallBack', 'Fs = 22050;');
        uimenu(HM.UIM3_01, 'label', '44100', 'CallBack', 'Fs = 44100;');
        uimenu(HM.UIM3_01, 'label', '48000', 'CallBack', 'Fs = 48000;');