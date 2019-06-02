%% example %%
%
% example script file demonstrating how to run SEISMICAIRGUN and how to
% display outputs

clear all; 
close all;
clc;

addpath source/

% airgun firing configuration
airgunParams = [1600, 1000, 16]; % pressure [psi], volume [in^3], port area [in^2]
depth = 10; %depth of airgun [m]
r = 75; %distance from source to receiver [m]
physConst = physical_constants(depth, r); %load physical constants

% run SEISMICAIRGUN
output = AirgunBubbleSolveOutput(airgunParams, physConst, false);

% display outputs

figure(1); clf;
%plot(output.t, output.R);
plotyy(output.t, output.R, output.t, output.U);

figure(2); clf;
plot(output.tPres, output.pPres);

figure(4); 
plot(output.t, output.Y(3,:));
hold on;
plot(output.t, output.Y(6,:));

figure(3); clf;
loglog(output.f, output.P);