function drawwavespec (x, Fs, H_waveplot, H_specplot)
    time_axis = [0: length(x)-1]/Fs;
    
    subplot(H_waveplot) %�����ꏊ���w��
    plot(time_axis, x, 'k')
    sig = x;
    axis([time_axis(1) time_axis(end) -1 1]);
    grid on
    ylabel('Amplitude')

    subplot(H_specplot)
    %�X�y�N�g���O����
    x = x'; % ���x�N�g���ɕϊ�

    frame_length = 40/1000; % �t���[����40[ms]
    P_frame = round(frame_length * Fs); % �t���[�����̃f�[�^��(�����l�֎l�̌ܓ�)

    frame_shift = 10/1000; % �t���[���V�t�g��10[ms]
    P_shift = round(frame_shift * Fs); % �t���[���V�t�g�̃f�[�^��(�����l�֎l�̌ܓ�)

    N_frame = ceil(length(x)/P_shift); % ���t���[����(�����l�֐؂�グ)

    P_inputdata = (N_frame - 1)*P_shift + P_frame;  % ���t���[��������Z�o�����A�K�v�ȓ��̓f�[�^�����i�����l�j

    xx = [x zeros(1, P_inputdata - length(x))];  % ���͐M���ɂO��t�����āA�K�v�ȓ��̓f�[�^�����ɂ���

    NFFT = 2048; % FFT �|�C���g���ݒ� NFFT >= P_frame
    F = [0 : NFFT/2]*Fs/NFFT/1000; % ���g����0�`Fs/2 [kHz]

    W = hanning(P_frame)'; % ���͑��֐��̐ݒ�

    for frame = 1 : N_frame % �e�t���[�����ƂɃX�y�N�g������

        start_point = (frame -1) * P_shift +1;
        end_point = start_point + P_frame -1;

        wxx = xx(start_point:end_point).* W;

        X = fft(wxx, NFFT);
        SPC(frame,:) = X(1:NFFT/2+1)'; % �X�y�N�g����SPC �Ɋi�[
    end
    T = [0:N_frame-1]*frame_shift; % �e�t���[���̐擪�̎����n��
    F = [0 : NFFT/2]*Fs/NFFT/1000; % ���g����0�`Fs/2 [kHz]

    imagesc(T,F,20*log10((abs(SPC(:,:)'))), [-80 30])
    axis xy
    colormap('jet')

    xlabel ('Time [s]')
    ylabel ('Frequency [kHz]')
end
