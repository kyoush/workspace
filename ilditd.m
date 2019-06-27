function sig = ilditd(db, delta, ax)
[noise, Fs] = audioread('noise.wav');
T = 1;
tau = round(abs(delta) * Fs * 0.000001);
sig = zeros(Fs*T + tau, 2);
%% ITD
if delta > 0
    sig(1:Fs*T, 1) = noise;
    sig(tau+1:end, 2) = noise;
else
    sig(tau+1:end, 1) = noise; 
    sig(1:Fs*T, 2) = noise;
end

%% ILD
down = power2const(abs(db));
if db > 0
    sig(:, 2) = sig(:, 2) .* down;
else
    sig(:, 1) = sig(:, 1) .* down;
end
sound(sig, Fs)

%% dB calc
% l_pow = bandpower(sig(:, 1));
% r_pow = bandpower(sig(:, 2));
% a = 20 * log10(l_pow/r_pow);

a1=rms(sig(:,1));
a2=rms(sig(:,2));
a=20*log10(a1/a2);


%% plot
i = 3000:3500;
i = i';

h1 = plot(ax, i, sig(i, 1), 'b');
hold(ax, 'on')
h2 = plot(ax, i, sig(i, 2), 'r');
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

    % ƒpƒ[[dB]‚©‚ç’è”
    function const = power2const(x)
        const = exp(-0.1151*x);
    end
end