%% example_compareNucleus %%
%
% Compare pressure perturbation between simulation and Nucleus data for the
% two airguns that are used to generate the synthetic examples

clear all; clc;

% plotting properties
set(0,'DefaultLineLineWidth',3);
set(0,'DefaultAxesFontSize',16);

% add path to source code
addpath source/

%%% nucleus data %%%
% The nucleus data (nuc.csv) contains 65 different firing configurations
% (different pressures and volumes). The pressures and volumes are
% contained in nucProperties.csv (first column is pressure [psi], second column
% is volume [in^3]).
data = csvread('nuc.csv'); % load Nucleus data
[ns, nt] = size(data); % ns = number of samples in trace, nt = number of traces
dt = 500e-6; % sampling interval
t = 0:dt:(ns-1)*dt; %time vector
nucProp = csvread('nucProperties.csv'); %load airgun properties [pressure (pis); volume (cui)]

i = 51; % select nucleus signature 
disp('Properties of Nucleus Signature:');
disp(strcat('Pressure=',num2str(nucProp(i,1)),'psi'));
disp(strcat('Volume=',num2str(nucProp(i,2)),'in^3'));

figure(1); clf;
subplot(2,1,1);
plot(t, data(:,i),'-');
xlabel('Time (s)');
ylabel('Pressure (bar m)');

%%% SeismicAirgun simulation
src_pressure = nucProp(i,1); % source pressure [psi]
src_volume = nucProp(i,2); % source volume [in^3]
src_area = 10; % port area of source [in^2]
src_depth = 10; % depth of source [m]

% pressure (psi), volume (in^3), port/throat area (in^2)
src_props = [src_pressure, src_volume, src_area]; 

dt = 1.25e-5; % sampling interval
time = [min(t) max(t)]; % bounds on time vector
r = 1; % distance from airgun to receiver.
alpha = 0.8; % tuning parameter - decay of amplitude of pressure perturbation
beta = 1; % % tuning parameter - rate of ascent of bubble
physConst = physical_constants(src_depth, r, time, alpha, beta); % physical constant
plot_outputs = false; % false = do not plot outputs, true = plot outputs
output = SeismicAirgun(src_props, physConst, dt, plot_outputs);
output.tPres = [0 output.tPres];
output.pPresBarM = [0 output.pPresBarM];
figure(1); hold on;
plot(output.tPres, output.pPresBarM,'LineStyle',':');
legend('Nucleus','Simulation');

% convert to frequency domain and plot
[fData, PData, ~] = pressure_spectra(t, data(:,i)*1e5); % data (converted to Pa)
subplot(2,1,2);
semilogx(fData, PData);
hold on;
xlabel('Frequency (Hz)');
ylabel('dB re \mu Pa/Hz');


[fSim, PSim, ~] = pressure_spectra(output.tPres(2:end), output.pDir); % simulation
plot(fSim, PSim,':');
legend('Nucleus','Simulation');
xlim([1 1000])

