function output = SeismicAirgun(airgunParams, physConst, dt, plot_solution)
%output = SeismicAirgun(airgunParams, physConst)
%
%Solves the equations governing the airgun/bubble behaviour. Variables ae
%output. This code works for a single airgun firing configurations.
   
% set default options
if (nargin <= 2 || isempty(plot_solution)); plot_solution = false; end

airgunInit = airgun_initialization(airgunParams, physConst);
bubbleInit = bubble_initialization(airgunInit, physConst);

initCond = initCond_save(bubbleInit, airgunInit);
initCond = [initCond, physConst.depth, initCond(1)^3];
params = params_save(bubbleInit, airgunInit, physConst);

options = odeset('RelTol',1e-6);
sol = ode45(@modified_herring_eqn, physConst.time, initCond, options, params);
Y = sol.y;

t = sol.x'; %time vector
R = sol.y(1,:)'; %bubble radius
U = sol.y(2,:)'; %bubble wall velocity
    
[~, solDY] = deval(sol, t);
A = solDY(2,:)'; %bubble wall acceleration

[tDir, pDir] = pressure_eqn(t, R, U, A, physConst.rho_infty, physConst.c_infty, physConst.r); %direct arrival
[tGhost, pGhost] = pressure_eqn(t, R, U, A, physConst.rho_infty, physConst.c_infty, ... %ghost
    physConst.r + 2*physConst.depth);
tInterp = min(tDir):dt:min(max(tDir),physConst.time(end));
pDirInterp = pchip(tDir, pDir, tInterp);
pGhostInterp = pchip(tGhost, pGhost, tInterp);

pPres = pDirInterp - pGhostInterp;
pPresBarM = pPres * 1e-5 * physConst.r;
[f, P, Psym] = pressure_spectra(tInterp, pPres*physConst.r);

pDirBarM = pDirInterp * 1e-5 * physConst.r;
[fDir, PDir, PsymDir] = pressure_spectra(tInterp, pDirInterp*physConst.r);

if plot_solution

    subplot(2,1,1); plot(tInterp, pDirBarM, 'LineWidth', 2); hold on;
    xlabel('Time (s)'); ylabel('Pressure (bar m)');
    subplot(2,1,2); semilogx(fDir, PDir, 'LineWidth', 2); hold on;
    xlabel('Frequency (Hz)'); ylabel('dB re \mu Pa/Hz');

end


%save outputs
output.t = t;
output.Y = Y;
output.R = R;
output.U = U;
output.A = A;
output.tPres = tInterp;
output.pDir = pDirInterp;
output.pGhost = pGhostInterp;
output.pPres = pPres;
output.pPresBarM = pPresBarM;
output.f = f;
output.P = P;
output.Psym = Psym;
output.pDirBarM = pDirBarM;
output.fDir = fDir;
output.PDir = PDir;
output.PsymDir = PsymDir;

