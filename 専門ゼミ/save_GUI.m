function save_GUI(sig, Fs)
    [filename, pathname] = uiputfile('*.wav', 'Save sound data');
    audiowrite([pathname, filename], sig, Fs);
end