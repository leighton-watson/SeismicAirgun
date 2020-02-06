function physConst = physical_constants(depth, r, time, alpha, beta)
% physConst = physical_constants()

%%%TIME%%%
t1 = time(1); % minimum time
t2 = time(2); % maximum time
physConst.time = [t1 t2]; %time to integrate over [s]

%%%THERMAL PROPERTIES%%%
physConst.Rgas = 287.06; %specific gas constant for dry air [J/kgK]
physConst.cv = 718; %heat capacity of air at constant volume [J/kgK]
physConst.cp = 1010; %heat capacity of air at constant pressure [J/kgK]
physConst.gamma = 1.4; %ratio of heat capacities for dry air
physConst.M = 10; %surface magnification due to turbulence
physConst.kappa = 0.04; %heat conduction coefficient

%%%CONSTANTS FROM TAIT'S EQUATION OF STATE%%%
physConst.B = 303975000; %constant from Tait's equation of state
physConst.n = 7; %constant from Tait's equation of state

%%%AMBIENT PROPERTIES%%%
physConst.rho_infty = 1000; %density infinitely far from bubble [kg/m^3]
physConst.depth = depth; %depth of airgun [m]
physConst.p0 = 1e5; %atmospheric pressure [Pa];
physConst.g = 9.8; %gravitational acceleration [m/s^2]
physConst.p_infty = physConst.p0 + physConst.rho_infty*physConst.g*physConst.depth; %pressure infinitely far from bubble [Pa]
physConst.T_infty = 273; %temperature infinitely far from bubble [K]
physConst.c_infty = sqrt(physConst.n*((physConst.p_infty + physConst.B)/physConst.rho_infty)); %speed of sound in liquid infinitely far from bubble
physConst.r = r; %distance from bubble to compute pressure field at [m]

%%%TUNING PARAMETERS%%%
physConst.massFracEjec = 0.05; % fraction of mass that is not ejected from source before port closes
physConst.alpha = alpha; % damping parameter on governing equation
physConst.beta = beta; % tuning parameter on buoyant velocity





