function [ ] = AirgunBubbleSolve(airgunParams, physConst)
%[ ] = AirgunBubbleSolve(airgunParams, physConst)
%
%Solves the equations governing the airgun/bubble behaviour. No variables ae
%output. This code works for multiple airgun firing configurations.

[m,~] = size(airgunParams);
S = cell(m,1);

for i = 1:m;
    
    s = strcat(num2str(airgunParams(i,1)),'psi,',num2str(airgunParams(i,2)),'in^3,',...
        num2str(airgunParams(i,3)),'in^2'); 
    
    airgunInit = airgun_initialization(airgunParams(i,:), physConst);
    bubbleInit = bubble_initialization(airgunInit, physConst);
    
    initCond = initCond_save(bubbleInit, airgunInit);
    params = params_save(bubbleInit, airgunInit, physConst);
    
    sol = ode45(@modified_herring_eqn, physConst.time, initCond, [], params);
    
    t = sol.x'; %time vector
    R = sol.y(1,:)'; %bubble radius
    U = sol.y(2,:)'; %bubble wall velocity
    
    [~, solDY] = deval(sol, t);
    A = solDY(2,:)'; %bubble wall acceleration
       
    [tDir, pDir] = pressure_eqn(t, R, U, A, physConst.rho_infty, physConst.c_infty, physConst.r); %direct arrival
    [tGhost, pGhost] = pressure_eqn(t, R, U, A, physConst.rho_infty, physConst.c_infty, ... %ghost
        physConst.r + 2*physConst.depth);
    
    dt = 1e-5;
    tInterp = min(tDir):dt:max(tDir);
    pDirInterp = pchip(tDir, pDir, tInterp);
    pGhostInterp = pchip(tGhost, pGhost, tInterp);
    
    pPres = pDirInterp - pGhostInterp;
    pPresBarM = pPres * 1e-5 * physConst.r;
    
    figure(1); subplot(2,1,1); 
    plot(tInterp, pPresBarM, 'DisplayName', s); hold on;
    
    [f, P] = pressure_spectra(tInterp, pPres*physConst.r);
    figure(1); subplot(2,1,2); 
    semilogx(f, P, 'DisplayName', s); hold on;
    
    S(i) = {s};
    
end

