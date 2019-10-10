[x, Fs] = audioread('wn4.wav');
[y, Fs] = audioread('wn3.wav');
T = 2;
noise = wgn(Fs*T, 1, 1);
noise = 0.5 * noise ./ max(abs(noise));
% sound(noise, Fs)
sound(x(1:Fs*T), Fs);
pause(3)
sound(y(1:Fs*T), Fs);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
filter = dsp.FIRFilter();
filter.Numerator = [1 zeros(1, 49)];
filter(x);
plot(x)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             