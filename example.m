%% example %%
%
% example script file demonstrating how to run SEISMICAIRGUN and how to
% display outputs

clear all; 
close all;
clc;

set(0,'DefaultLineLineWidth',2);
set(0,'DefaultAxesFontSize',16);

addpath source/

% airgun firing configuration
airgunParams = [1600, 1000, 16]; % pressure [psi], volume [in^3], port area [in^2]
depth = 10; %depth of airgun [m]
r = 75; %distance from source to receiver [m]
physConst = physical_constants(depth, r); %load physical constants

% run SEISMICAIRGUN
output = AirgunBubbleSolveOutput(airgunParams, physConst, false);

%% display outputs %%

% bubble radius
figure(1); clf;
subplot(2,2,1);
plot(output.t, output.R);
xlabel('Time (s)');
ylabel('m');
title('(a) Bubble radius');
ylim([0.2 0.8]);
grid on;

% bubble wall velocity
subplot(2,2,2);
plot(output.t, output.U);
xlabel('Time (s)');
ylabel('m/s');
title('(b) Bubble wall velocity');
ylim([-18 35])
grid on;

% pressure perturbation (source signature) in time domain in bar m
subplot(2,2,3);
plot(output.tPres, output.pPres*r*1e-5);
xlabel('Time (s)');
ylabel('bar m');
title('(c) Source signature');
ylim([-5 6]);
grid on;

% pressure perturbation (source signature) in frequency domain
subplot(2,2,4);
loglog(output.f, output.P);
xlabel('Frequency (Hz)');
ylabel('dB re \mu Pa/Hz');
title('(d) Source signature');
xlim([1 1000]);
grid on;
