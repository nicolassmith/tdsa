% computes noise curves useful for squeeze angle control calculations

fLim = [5 5000];
sqzdB = 6; % squeezing and antisqueezing leves
antiSqzdB = 10;

% compute for many angles
for angle = [0:90]
    [f,n] = sqzNoise(fLim,sqzdB,antiSqzdB,angle);
    tosave = [f,n];
    save(sprintf('results/sqz%02d.txt',angle),'tosave','-ascii')
end

% compute for no squeezing
[f,n] = sqzNoise(fLim,0,0,0);
tosave = [f,n];
save('results/nosqz.txt','tosave','-ascii')

% compute for filter cavity
[f,n] = filtcavNoise(fLim,sqzdB,antiSqzdB);
tosave = [f,n];
save('results/filtcav.txt','tosave','-ascii')
