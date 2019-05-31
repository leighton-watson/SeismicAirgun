function bubbleInit = bubble_initialization(airgunInit, physConst)
% bubbleInit = bubble_initialization(airgunInit, physConst)

bubbleInit.V = airgunInit.V; %bubble volume [m^3]
bubbleInit.R = ((3*bubbleInit.V)/(4*pi))^(1/3); %bubble radius [m]
bubbleInit.U = 0; %bubble velocity [m/s]
bubbleInit.T = physConst.T_infty; %bubble temperature [K]
bubbleInit.p = physConst.p_infty; %bubble pressure [Pa]
bubbleInit.m = (bubbleInit.p*bubbleInit.V)/(physConst.Rgas*bubbleInit.T); %bubble mass [kg]