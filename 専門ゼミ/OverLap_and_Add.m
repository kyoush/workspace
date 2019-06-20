function out = OverLap_and_Add(Tp, buffer1, buffer2)
% Usage :: out = OverLap_and_Add(Tp, buffer1, buffer2)
%
% Overlap and Add function for picola
% Tp: pitch period length (points)
% buffer1 : speech data multiplied with an ascending linear-taper function
% buffer2 : speech data multiplied with a descending linear-taper function

Taper = (0:Tp-1)'/(Tp-1); %ベクトルの向きに注意！
out = buffer1.*Taper + buffer2.* flipud(Taper);

end
