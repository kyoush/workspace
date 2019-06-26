function sig2 = ilditd(db, delta, ax)
[noise, Fs] = audioread('noise.wav');
T = 1;

%% ild
sig = zeros(Fs*T, 2);
% powersig = bandpower(noise) ./ (10^(abs(db)/20));
% down = power2const(powersig);
down = power2const(abs(db));

if db > 0
    sig(:, 1) = noise;
    sig(:, 2) = noise .* down;
else
    sig(:, 1) = noise .* down;
    sig(:, 2) = noise;
end
%% itd
tau = round(abs(delta) * Fs * 0.000001);
sig2 = zeros(Fs*T + tau, 2);

if delta > 0
    sig2(1:Fs*T, 1) = sig(:, 1);
    sig2(tau+1:end, 2) = sig(:, 2);
else
    sig2(tau+1:end, 1) = sig(:, 1);
    sig2(1:Fs*T, 2) = sig(:, 2);
end
sig = sig2;
sound(sig, Fs)

%% dB calc
% l_pow = rms(sig(:, 1));
% r_pow = rms(sig(:, 2));

l_pow = bandpower(sig(:, 1));
r_pow = bandpower(sig(:, 2));

a = 20 * log10(l_pow/r_pow);

%% plot
i = 3000:3500;
i = i';

h1 = plot(ax, i, sig2(i, 1), 'b');
hold(ax, 'on')
h2 = plot(ax, i, sig2(i, 2), 'r');
legend(ax, [h1, h2], 'L-channel', 'R-channel', 'location', 'southwest')

if db < 0
    h = get(ax, 'children');
    hg = findobj(ax, 'type', 'line', 'color', 'b');
    ind = (h == hg);
    newh = [h(ind), h(~ind)];
    set(ax, 'children', newh);
else
    h = get(ax, 'children');
    hg = findobj(ax, 'type', 'line', 'color', 'r');
    ind = (h == hg);
    newh = [h(ind), h(~ind)];
    set(ax, 'children', newh);
end 

str = num2str(a);
str = ['ILD : ' str ' [dB]'];
text(ax, 3350, 0.75, str, 'Color', 'k', 'fontsize', 16);

str2 = num2str(sign(delta) * (tau/Fs) * 1000000);
str2 = ['ITD : ' str2 ' [ƒÊs]'];
text(ax, 3350, -0.75, str2, 'Color', 'k', 'fontsize', 16);

hold(ax, 'off')
save('temp.mat');

end