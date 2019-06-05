%---------------------------------------------
%
% GUI Program
%
% by K.Kamura  06/02/2019
%Å@ 
%---------------------------------------------
clear
close all

set(0, 'Units', 'pixels');
v = get(0, 'MonitorPosition');

Fs = 44100;

X_MIN = 100;
Y_MIN = 100;
WIDTH = 700;
HEIGHT = 500;

rate = 1.7;

Figure_position = [X_MIN Y_MIN WIDTH HEIGHT];


H0 = uifigure('Position', Figure_position,...
    'NumberTitle','off',...
    'Name','GUI',...
    'MenuBar', 'none',...
    'Color','w',...
    'Units','pixels',...
    'Visible','on');
v = get(0, 'MonitorPosition');

sld = uislider(H0);
sld.Limits = [0 1.5];
