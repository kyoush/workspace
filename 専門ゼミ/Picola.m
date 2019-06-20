function outsig = Picola(rate, insig, Fs)

% [insig, Fs] = audioread('./sound/SoundE2.wav');
% rate = 1.5;

PITCH_MAX_Hz = 250;
PITCH_MIN_Hz = 60;

minTp = fix(Fs/PITCH_MAX_Hz);
maxTp = fix(Fs/PITCH_MIN_Hz);

insig_VectorSize = size(insig);

if insig_VectorSize(2) == 2
    insig = (insig(:,1) + insig(:,2))/2;
end

if ~iscolumn(insig)
    insig = insig';
end

A = 1;

tmpbuf = insig(A:A + maxTp*3 - 1);

Tp = AMDF_for_Picola(minTp, maxTp, tmpbuf, Fs);

L = ceil(Tp/(rate-1));

bufOLA = zeros(Tp, 1);
bufL = insig(A:A + L - 1);

outsig = [bufOLA; bufL];

A = A + L;

while A + maxTp*3 - 1 <= length(insig)

    tmpbuf = insig(A:A + maxTp*3 - 1);
    Tp = AMDF_for_Picola(minTp, maxTp, tmpbuf, Fs);
    L = ceil(Tp/(rate-1));

    if A + L <= length(insig)
        Pre_A = insig(A - (Tp - 1):A);
        Post_A  = insig(A:A + Tp - 1);

        bufOLA = OverLap_and_Add(Tp, Pre_A, Post_A);

        bufL = insig(A + 1:A + L);
        outbuf = [bufOLA(1:end);bufL];
        outsig = [outsig(1:end);outbuf];

        A = A + L + 1;
    end
end
end