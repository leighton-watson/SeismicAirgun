%% main %%
%
% This is the main script file for SeismicAirgun. The code runs
% SeismicAirgun for a single firing configuration and saves the outputs.

addpath source/

% Source Firing Configuration
src_pressure = 1000; % source pressure [psi]
src_volume = 10000; % source volume [in^3]
src_area = 80; % port area of source [in^2]
src_depth = 10; % depth of source [m]

% pressure (psi), volume (in^3), port/throat area (in^2)
src_props = [src_pressure, src_volume, src_area]; 


% Physical Parameters
r = 100; % distance from source to receiver. For purposes of ghost, receiver is assumed to be directly below source
time = [0 6]; % time [s]
physConst = physical_constants(src_depth, r, time); % physical properties
dt = 1.25e-5; % sampling interval

% run solver
% true or false flag determines if time series and spectra are plotted
output = AirgunBubbleSolveOutput(src_props, physConst, dt, false); 

% direct arrival
pDirBarM = output.pDir * 1e-5 * physConst.r;

% plot direct arrival
% uncomment if you want to plot the direct arrival
% plot(output.tPres, pDirBarM);

% define string for saving
directArrivalString = strcat('dirArr_',...
    num2str(src_pressure),'psi_',...
    num2str(src_volume),'cui_',...
    num2str(src_area),'sqi_',...
    num2str(src_depth),'m');

% write as an ascii
%save(directArrivalString,'pDirBarM','-ascii');

% write as a binary
directArrivalStringBin = strcat(directArrivalString,'.bin');
fileID = fopen(directArrivalStringBin,'w');
fwrite(fileID,pDirBarM);
fclose(fileID);

