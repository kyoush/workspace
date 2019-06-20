function Tp = AMDF_for_Picola(minTp, maxTp, x, Fs)

% Usage :: pitch = AMDF_for_Picola(minTp, maxTp, x, Fs)
% 
% Periodicity estimation using the Averaged Mean Difference(AMDF) for picola
%  
%  Tp:    pitch period length[points], pitch frequency[Hz] is Fs/Tp
%  minTp: minimum pitch period length for search(corresponds to the max pitch frequency)
%  maxTp: maximum pitch period length for search(corresponds to the max pitch frequency)
%  x:
%  Fs:

N = length(x) - maxTp;
amdf = zeros(1, maxTp);

for m = 1: maxTp
          tmp = 0;
          
          for n = 1: N
                    tmp = tmp + abs(x(n) - x(n + m));
          end
          
          amdf(m) = tmp/N;
end

invamdf = mean(amdf) - amdf;


[~, peakIndex] = findpeaks(invamdf, 'SortStr', 'descend');


Tp_candidate_index = find(peakIndex >= minTp & peakIndex <= maxTp);



if isempty(Tp_candidate_index)
          Tp = maxTp;
else
          Tp = peakIndex(Tp_candidate_index(1));
end



end