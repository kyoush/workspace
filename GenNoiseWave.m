function x = GenNoiseWave(Duration, Amp)
%        x = Amp * (rand(1, Duration) - 0.5 );
        x = wgn(1, Duration, 1);
        x = Amp * x /max(abs(x));
        
end