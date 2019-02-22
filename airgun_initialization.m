
function airgunInit = airgun_initialization(airgunParams, physConst)
% airgunInit = airgun_initialization(airgunParams, physConst)

airgunPressure = airgunParams(1);
airgunVolume = airgunParams(2);
airgunArea = airgunParams(3);

airgunInit.p = airgunPressure*6894.8; %airgun pressure [Pa]
airgunInit.V = airgunVolume*1.63871e-5; %airgun volume [m^3]
airgunInit.A = airgunArea*6.4516e-4; %airgun port area [m^2]
airgunInit.T = physConst.T_infty; %airgun temperature [K]
airgunInit.m = airgunInit.p*airgunInit.V/(physConst.Rgas*airgunInit.T); %mass inside airgun [kg]
