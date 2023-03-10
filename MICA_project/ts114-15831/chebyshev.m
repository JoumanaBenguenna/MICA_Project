function Hd = chebyshev
%CHEBYSHEV Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.12 and Signal Processing Toolbox 9.0.
% Generated on: 22-May-2022 06:14:16

% Chebyshev Type I Highpass filter designed using FDESIGN.HIGHPASS.

% All frequency values are in Hz.
Fs = 200;  % Sampling Frequency

Fstop = 48;          % Stopband Frequency
Fpass = 51;          % Passband Frequency
Astop = 80;          % Stopband Attenuation (dB)
Apass = 1;           % Passband Ripple (dB)
match = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.highpass(Fstop, Fpass, Astop, Apass, Fs);
Hd = design(h, 'cheby1', 'MatchExactly', match);

% [EOF]
