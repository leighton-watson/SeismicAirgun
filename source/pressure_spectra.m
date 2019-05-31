function [f, P, Psym] = pressure_spectra(tPres, pPres)
% [f, P] = pressure_spectra(t, p)

dt = 5e-4;
t_int = min(tPres):dt:max(tPres);
p_int = pchip(tPres, pPres, t_int);

L = length(t_int); %length of signal
Fs = 1/((max(t_int)-min(t_int))/L); %sampling frequency
NFFT = 2^nextpow2(L); %next power of 2 from length

Psym = fft(p_int,NFFT)/L; %fourier transform of pressure signal
P = 2*abs(Psym(1:NFFT/2+1)); %single sided amplitude spectrum
refP = 1e-6; 
P = mag2db((P/refP));
f = (Fs/2)*linspace(0,1,NFFT/2+1); %frequency vector

