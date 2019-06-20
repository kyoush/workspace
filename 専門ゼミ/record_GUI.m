function sig = record_GUI (Fs, H_waveplot, H_specplot)
Nbit = 16;
Nch = 1; % 1 for モノ、2 for ステレオ
RecTime = 3; % 録音秒数
r = audiorecorder(Fs, Nbit, Nch); % 録音オブジェクトr を設定
disp('........ Start speaking.');
recordblocking(r, RecTime); % 録音オブジェクトr の実行
x = getaudiodata(r, 'double'); % 録音データをsig に代入

sig = x;

drawwavespec(x, Fs, H_waveplot, H_specplot);
end
