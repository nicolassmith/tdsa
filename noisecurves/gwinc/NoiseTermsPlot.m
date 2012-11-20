%% 
ifo = IFOModel;
[ss,nn] = gwinc(5,5000,ifo,SourceModel,2);
ff = nn.Freq;

%% suspension thermal noise in gwinc is obsolete
%% use M Barton's mathematica model output

mbquadlite2lateral_20090819TM_TN;
tvec = sqrt(xvec.^2 + (1e-3*zvec).^2);
tvec = tvec*2;  % 4 masses
nn.SuspThermalB = interp1(fvec,tvec,ff,[],0);
nn.SuspThermalB = nn.SuspThermalB.^2/(4000^2);  % convert to strain

% recalculate the total
nn.Total = nn.ResGas + nn.SuspThermalB + nn.Quantum + nn.Newtonian + ...
    nn.Seismic + nn.MirrorThermal.Total;


hndls = loglog(ff,sqrt(nn.Quantum),'-',...         % Quantum Unification  
                 ff,sqrt(nn.Seismic),'-',...        % Seismic
                 ff,sqrt(nn.Newtonian),'-',...         % Gravity Gradients
                 ff,sqrt(nn.SuspThermalB),'-',...         % Suspension thermal
                 ff,sqrt(nn.MirrorThermal.CoatBrown),'-',...         % Coating Brownian
                 ff,sqrt(nn.MirrorThermal.CoatTO),'--',...       % Coating thermooptic
                 ff,sqrt(nn.MirrorThermal.SubBrown),'--',...        % Substrate brownian
                 ff,sqrt(nn.ResGas),'--',...        % Gas
                 ff,sqrt(nn.Total),'k');            % Total Noise
  set(hndls(1:(end)),'LineWidth',3);
  leggravg = strcat('Newtonian background(\beta=',num2str(ifo.Seismic.Beta),')');
  legpower = [num2str(ifo.Laser.Power,'%3.1f') ' W'];
  lh = legend('Quantum noise',...
         'Seismic noise',...
         'Gravity Gradients',...
         'Suspension thermal noise',...
         'Coating Brownian noise',...
         'Coating Thermo-optic noise',...
         'Substrate Brownian noise',...
         'Excess Gas',...
         'Total noise',...
         'Location','NorthEast');
  set(lh,'fontsize',14);
  xlabel('Frequency [Hz]','FontSize',16);
  ylabel('Strain [1/\surdHz]','FontSize',16);
  grid;
  axis([5 5000 3e-25 3e-21]);
  %title(['AdvLIGO Noise Curve: P_{in} = ' legpower],'FontSize',18)  
  
  clrtable=[0.7   0.0   0.9
            0.6   0.4   0.0
            0.0   0.8   0.0
            0.3   0.3   1.0
            1.0   0.2   0.1
            0.0   1.0   0.9
            1.0   0.7   0.0
            0.8   1.0   0.0
            1.0   0.0   0.0
            0.3   0.3   0.3];
  for gag = 1:(length(hndls) - 1)
    set(hndls(gag), 'color',clrtable(gag,:));
  end  
  set(hndls(end),'linewidth',5,'color',0.15*[1 1 1]);
  

%% Code for making a prettier looking plot %%
if 1
grid off
grid on
%grid minor
%hTitle  = title ('My Publication-Quality Graphics');
hXLabel = xlabel('Frequency [Hz]'                     );
hYLabel = ylabel('Strain [1/\surdHz]'                      );

axis([5 5000 3e-25 3e-21]);

set(hndls, ...
  'LineWidth'       , 4           );



set( gca                       , ...
    'FontName'   , 'Helvetica'     , ...
    'FontSize'   , 28          );
set([hXLabel, hYLabel], ...
    'FontName'   , 'Helvetica');
%set([hLegend, gca]             , ...
%    'FontSize'   , 8           );
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 28          );
%set( hTitle                    , ...
%    'FontSize'   , 12          , ...
%    'FontWeight' , 'bold'      );

set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , .1*[.3 .3 .3], ...
  'YColor'      , .1*[.3 .3 .3], ...
  'YTick'       , logspace(-25,-11,15), ...
  'LineWidth'   , 1         );
    
orient landscape
set(gcf,'PaperPositionMode','auto')
%saveas(gcf, 'AllNoise', 'png')
print -dpng -r300 aLIGO_gwinc.png
%!convert -rotate 90 test.png SensEvo.pdf
%print -depsc -tiff -r600 aLIGO_gwinc
%% Convert from png to PDF
[a,b] = system('convert -rotate 90 aLIGO_gwinc.png aLIGO_gwinc.pdf');
if a ~= 0
    disp(' ')
    disp('PDF Generation Error')
    disp(' ')
end


%!convert -rotate 90 AllNoise.eps AllNoise.pdf

end