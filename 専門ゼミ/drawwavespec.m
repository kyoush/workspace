function drawwavespec (x, Fs, H_waveplot, H_specplot)
    time_axis = [0: length(x)-1]/Fs;
    
    subplot(H_waveplot) %書く場所を指定
    plot(time_axis, x, 'k')
    sig = x;
    axis([time_axis(1) time_axis(end) -1 1]);
    grid on
    ylabel('Amplitude')

    subplot(H_specplot)
    %スペクトログラム
    x = x'; % 横ベクトルに変換

    frame_length = 40/1000; % フレーム長40[ms]
    P_frame = round(frame_length * Fs); % フレーム長のデータ数(整数値へ四捨五入)

    frame_shift = 10/1000; % フレームシフト幅10[ms]
    P_shift = round(frame_shift * Fs); % フレームシフトのデータ数(整数値へ四捨五入)

    N_frame = ceil(length(x)/P_shift); % 総フレーム数(整数値へ切り上げ)

    P_inputdata = (N_frame - 1)*P_shift + P_frame;  % 総フレーム数から算出される、必要な入力データ総数（整数値）

    xx = [x zeros(1, P_inputdata - length(x))];  % 入力信号に０を付加して、必要な入力データ総数にする

    NFFT = 2048; % FFT ポイント数設定 NFFT >= P_frame
    F = [0 : NFFT/2]*Fs/NFFT/1000; % 周波数軸0～Fs/2 [kHz]

    W = hanning(P_frame)'; % 分析窓関数の設定

    for frame = 1 : N_frame % 各フレームごとにスペクトル分析

        start_point = (frame -1) * P_shift +1;
        end_point = start_point + P_frame -1;

        wxx = xx(start_point:end_point).* W;

        X = fft(wxx, NFFT);
        SPC(frame,:) = X(1:NFFT/2+1)'; % スペクトルをSPC に格納
    end
    T = [0:N_frame-1]*frame_shift; % 各フレームの先頭の時刻系列
    F = [0 : NFFT/2]*Fs/NFFT/1000; % 周波数軸0～Fs/2 [kHz]

    imagesc(T,F,20*log10((abs(SPC(:,:)'))), [-80 30])
    axis xy
    colormap('jet')

    xlabel ('Time [s]')
    ylabel ('Frequency [kHz]')
end
