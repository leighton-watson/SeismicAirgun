%% example %%
%
% example script file demonstrating how to run SEISMICAIRGUN and how to
% display outputs

clear all; 
%close all;
clc;

set(0,'DefaultLineLineWidth',2);
set(0,'DefaultAxesFontSize',16);

addpath source/

% airgun firing configuration
airgunParams = [2000, 1000, 16]; % pressure [psi], volume [in^3], port area [in^2]
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

% % plot other outputs
% figure(2); clf;
% 
% % bubble radius
% subplot(2,2,1);
% plot(output.t, output.R);
% xlabel('Time (s)');
% ylabel('m');
% title('Bubble radius');
% ylim([0.2 1]);
% grid on;
% 
% % bubble wall velocity
% subplot(2,2,3);
% plot(output.t, output.U);
% xlabel('Time (s)');
% ylabel('m/s');
% title('Bubble wall velocity');
% ylim([-18 35])
% grid on;
% 
% % mass
% subplot(2,2,4);
% plot(output.t, output.Y(3,:));
% xlabel('Time (s)');
% ylabel('kg');
% title('Mass');
% hold on;
% plot(output.t, output.Y(6,:));
% legend('Bubble','Source');
% grid on;
% xlim([0 0.05])
% 
% % temperature
% subplot(2,2,2);
% plot(output.t, output.Y(4,:));
% xlabel('Time (s)');
% ylabel('K');
% title('Temperature');
% hold on;
% % T = (P*V)/(Q*m)
% airgun_temp = (output.Y(5,:).*airgunParams(2)*1.63871e-5)./...
%     (physConst.Rgas.*output.Y(6,:));
% plot(output.t, airgun_temp);
% legend('Bubble','Source');
% grid on;
% xlim([0 1])