%% example_dispOutputs %%
%
% This is an example script file that shows how to display more outputs
% than example_main.m - such as bubble wall velocity, mass and temperature
% (of both source and bubble). 

addpath source/

% Source Firing Configuration
src_pressure = 1000; % source pressure [psi]
src_volume = 10000; % source volume [in^3]
src_area = 80; % port area of source [in^2]
src_depth = 10; % depth of source [m]

% pressure (psi), volume (in^3), port/throat area (in^2)
src_props = [src_pressure, src_volume, src_area]; 

% Physical and Tuning Parameters
r = 100; % distance from source to receiver. For purposes of ghost, receiver is assumed to be directly below source
time = [0 2]; % time [s]
alpha = 0.8; % tuning parameter - decay of amplitude of pressure perturbation
beta = 0; % % tuning parameter - rate of ascent of bubble
physConst = physical_constants(src_depth, r, time, alpha, beta); % physical constant
dt = 1.25e-5; % sampling interval

% run solver
output = SeismicAirgun(src_props, physConst, dt, false);

%% display outputs %%

% bubble radius
figure(1); clf;
subplot(2,2,1);
plot(output.t, output.R);
xlabel('Time (s)');
ylabel('m');
title('Bubble radius');
grid on;

% bubble wall velocity
subplot(2,2,2);
plot(output.t, output.U);
xlabel('Time (s)');
ylabel('m/s');
title('Bubble wall velocity');
grid on;

% pressure perturbation (source signature) in time domain in bar m
subplot(2,2,3);
plot(output.tPres, output.pPres*r*1e-5);
xlabel('Time (s)');
ylabel('bar m');
title('Source signature');
grid on;

% pressure perturbation (source signature) in frequency domain
subplot(2,2,4);
loglog(output.f, output.P);
xlabel('Frequency (Hz)');
ylabel('dB re \mu Pa/Hz');
title('Source signature');
xlim([1 1000]);
grid on;

% plot other outputs
figure(2); clf;

% mass
subplot(2,1,1);
plot(output.t, output.Y(3,:));
xlabel('Time (s)');
ylabel('kg');
title('Mass');
grid on;
xlim([0 0.5])

% temperature
subplot(2,1,2);
plot(output.t, output.Y(4,:));
xlabel('Time (s)');
ylabel('K');
title('Temperature');
grid on;
