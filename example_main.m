%% example_main %%
%
% This is an example script file that shows how to specify the firing
% properties, run SeismicAirgun, display and save the outputs.

clear all; clc;

addpath source/

% Source Firing Configuration
src_pressure = 1000; % source pressure [psi]
src_volume = 10000; % source volume [in^3]
src_area = 80; % port area of source [in^2]
src_depth = 10; % depth of source [m]

% pressure (psi), volume (in^3), port/throat area (in^2)
src_props = [src_pressure, src_volume, src_area]; 

% save direct arrival
save_outputs = false; % false = do not save outputs, true = save outputs

% plot direct arrival 
plot_outputs = false; % false = do not plot outputs, true = plot outputs

% Physical and Tuning Parameters
r = 100; % distance from source to receiver. For purposes of ghost, receiver is assumed to be directly below source
time = [0 2]; % time [s]
alpha = 0.8; % tuning parameter - decay of amplitude of pressure perturbation
beta = 0; % % tuning parameter - rate of ascent of bubble
physConst = physical_constants(src_depth, r, time, alpha, beta); % physical constant
dt = 1.25e-5; % sampling interval

% run solver
% true or false flag determines if time series and spectra are plotted
output = SeismicAirgun(src_props, physConst, dt, plot_outputs);  

% direct arrival
pDirBarM = output.pDirBarM; 

if save_outputs

    % define string for saving
    directArrivalString = strcat('dirArr_',...
        num2str(src_pressure),'psi_',...
        num2str(src_volume),'cui_',...
        num2str(src_area),'sqi_',...
        num2str(src_depth),'m');
    
    % write as an ascii
    save(directArrivalString,'pDirBarM','-ascii');
    
    % write as a binary
    directArrivalStringBin = strcat(directArrivalString,'.bin');
    fileID = fopen(directArrivalStringBin,'w');
    fwrite(fileID,output.pDirBarM,'single');
    fclose(fileID);
    
%     % write as SEGY %%% need to correct this. does not write succesfully.
%     pSEGY = pchip(output.tPres, output.pPresBarM, output.t)';
%     WriteSegy('sig_2000psi_400ci.segy',pSim1,'dt',dt);

end

