function [sig, Fs] = Load_Data_and_Plot (H_waveplot, H_specplot)

[filename, pathname] = uigetfile('*.wav', 'Load Sound Data');

[x, Fs] = audioread([pathname filename]);

sig = x;

drawwavespec(x, Fs, H_waveplot, H_specplot);
end
