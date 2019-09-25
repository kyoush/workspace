%% Specify Signal Source
Sine1 = dsp.SineWave('Amplitude', 1, 'Frequency', 1e3, 'SampleRate', 44.1e3);
Sine2 = dsp.SineWave('Amplitude', 1, 'Frequency', 10e3, 'SampleRate', 44.1e3);

%% Create Lowpass Filter
FIRLowPass = dsp.LowpassFilter('PassbandFrequency', 5000,...
    'StopbandFrequency', 8000);

%% Create Spectrum Analyzer
SpecAna = dsp.SpectrumAnalyzer('PlotAsTwoSidedSpectrum', false,...
    'SampleRate', Sine1.SampleRate,...
    'NumInputPorts', 2,...
    'ShowLegend', true,...
    'YLimits', [-145 45]);
SpecAna.ChannelNames = {'Original noisy signal', 'Low pass filtered signal'};

%% Specify Samples per Frame
Sine1.SamplesPerFrame = 4000;
Sine2.SamplesPerFrame = 4000;

%% Filter the Noisy Sine Wave Signal
for i = 1:1000
    x = Sine1() + Sine2() + 0.1 .* randn(Sine1.SamplesPerFrame,1);
    y = FIRLowPass(x);
    SpecAna(x, y);
end
release(SpecAna)