function [f,noiseTot] = filtcavNoise(fLim,sqzdB)
% returns noise of aligo plus squeezer with filter cav

f_LOLO = fLim(1);
f_HIHI = fLim(2);

addpath gwinc

ifo = IFOModel;

% hack in all the necessary ifo parameters to get it to run
ifo.modeSR = 0;

ifo.Squeezer.Type = 'Freq Dependent';
ifo.Squeezer.AmplitudedB = sqzdB;         % SQZ amplitude [dB]
%ifo.Squeezer.AntiAmplitudedB = antisqzdB;         % antiSQZ amplitude [dB]
ifo.Squeezer.InjectionLoss = 0.15;      %power loss to sqz
ifo.Squeezer.SQZAngle = 0;              % SQZ phase [radians]

% Parameters for frequency dependent squeezing
ifo.Squeezer.FilterCavity.fdetune = -22;  % detuning [Hz]
ifo.Squeezer.FilterCavity.L = 100;        % cavity length
ifo.Squeezer.FilterCavity.Ti = 0.185e-3;       % input mirror trasmission [Power]
ifo.Squeezer.FilterCavity.Te = 3e-6;          % end mirror trasmission
ifo.Squeezer.FilterCavity.Lrt = 15e-6;    % round-trip loss in the cavity
ifo.Squeezer.FilterCavity.Rot = 0*pi/180;         % phase rotation after cavity

[sss,nnn] = gwinc(f_LOLO,f_HIHI,ifo,SourceModel,2);

f = nnn.Freq.';
noiseTot = sqrt(nnn.Total.');

end


