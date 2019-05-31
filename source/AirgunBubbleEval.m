%% AIRGUN BUBBLE EVAL %%

figure(1); hold on;  %clear figures
%set(0,'DefaultAxesFontSize',10);
set(0,'DefaultLineLineWidth',2);

%airgun firing configuration
%pressure (psi), volume (in^3), port area (in^2)
A = [2000, 1000, 16; %conventional airgun
    600 3333.3 62]; %low pressure source


depth = 1; r = 75; %specify depth of airgun and distance from bubble to observer
physConst = physical_constants(depth, r); %load physical constants
AirgunBubbleSolve(A, physConst); %works for multiple firing configurations
%output = AirgunBubbleSolveOutput(A, physConst, false); %run solver - only works for a single firing configuration

% %save output
% pBarM = output.pPres * 1e-5 * physConst.r;
% save('sourceSignature','pBarM','-ascii');
% 
% % 
% % %set figure properties
% % titleString = strcat('Depth=',num2str(physConst.depth),'m');
% % figure(1); subplot(2,1,1); xlabel('time (s)'); ylabel('\Delta p (bar m)'); 
% % title(titleString); xlim([0 1]);
% % subplot(2,1,2); xlabel('frequency (Hz)'); ylabel('power (dB)'); xlim([1 1000])
% 
% m = output.Y(3,:);
% t = output.t';
% pa = output.Y(5,:);
% 
% rhoa = pa./ (physConst.Rgas*physConst.T_infty);
% rhoa = rhoa(1:end-1);
% 
% dmdt = (m(2:end)-m(1:end-1)) ./ (t(2:end)-t(1:end-1));
% t_dt = t(1:end-1);
% u = dmdt .* (1./rhoa) .* (1/(A(3)*6.4516e-4));
% figure;
% semilogx(t_dt, u);
% 
