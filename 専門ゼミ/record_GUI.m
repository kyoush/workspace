function sig = record_GUI (Fs, H_waveplot, H_specplot)
Nbit = 16;
Nch = 1; % 1 for ���m�A2 for �X�e���I
RecTime = 3; % �^���b��
r = audiorecorder(Fs, Nbit, Nch); % �^���I�u�W�F�N�gr ��ݒ�
disp('........ Start speaking.');
recordblocking(r, RecTime); % �^���I�u�W�F�N�gr �̎��s
x = getaudiodata(r, 'double'); % �^���f�[�^��sig �ɑ��

sig = x;

drawwavespec(x, Fs, H_waveplot, H_specplot);
end
