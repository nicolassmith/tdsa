function [f,noiseTot] = sqzNoise(fLim,sqzdB,antisqzdB,angle)
% Runs GWINC with some nominal parameters

f_LOLO = fLim(1);
f_HIHI = fLim(2);

addpath gwinc

ifo = IFOModel;

% hack in all the necessary ifo parameters to get it to run
ifo.modeSR = 0;

ifo.Squeezer.Type = 'Freq Independent';
ifo.Squeezer.AmplitudedB = sqzdB;         % SQZ amplitude [dB]
ifo.Squeezer.AntiAmplitudedB = antisqzdB;         % antiSQZ amplitude [dB]
ifo.Squeezer.InjectionLoss = 0.05;      %power loss to sqz
ifo.Squeezer.SQZAngle = angle*pi/180;             % SQZ phase [radians]

[sss,nnn] = gwinc(f_LOLO,f_HIHI,ifo,SourceModel,2);

f = nnn.Freq.';
noiseTot = sqrt(nnn.Total.');

end


