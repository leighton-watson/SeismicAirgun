function [dYdt] = modified_herring_eqn(t, Y, params)

%% LOAD VARIABLES AND PARAMETERS %%

%%%VARIABLES
R = Y(1);
U = Y(2);
m_bubble = Y(3);
T_bubble = Y(4);
p_airgun = Y(5);
m_airgun = Y(6);

%%%PARAMETERS
Rgas = params(1);
gamma = params(2);
p_infty = params(3);
rho_infty = params(4);
T_infty = params(5);
V_airgun = params(6);
A = params(7);
cv = params(8);
cp = params(9);
M = params(10);
kappa = params(11);
c_infty = params(12);
t_fire = params(13);
init_m_airgun = params(14);

%%%COMPUTE REQUIRED QUANTITIES
mu = 1e-3;
Re = abs(rho_infty*R*U/mu);
Pr = abs(cp*mu/kappa);
d = 4*(2*R)*Re^(-3/4)*Pr^(-1/2);

V_bubble = 4/3*pi*R^3;
p_bubble = m_bubble*Rgas*T_bubble/V_bubble;
T_airgun = p_airgun*V_airgun/(m_airgun*Rgas);

dVdt = 4*pi*R^2*U;
dQdt = 4*pi*M*kappa/d*R^2*(T_bubble - T_infty);

Tc = T_bubble - 273.15; %convert temp in bubble to Celsius
pv = 0.6108*exp((17.27*Tc)./(Tc+237.3)); %vapor pressure [kPa]
pv = pv*1000; %vapor pressure [Pa]

%% UPDATE VARIABLES %%

%%%BUBBLE MASS%%%
if (t < t_fire) && (m_airgun > 0.55*init_m_airgun) && (p_airgun > p_bubble); %airgun is firing
    if p_airgun/p_bubble < ((gamma+1)/2)^(gamma/(gamma-1));
        dm_bubble_dt = p_airgun*A*(gamma/(Rgas*T_infty))^(1/2)*...
            (2/(gamma-1))^(1/2)*((p_airgun/p_bubble)^((gamma-1)/gamma)-1)^(1/2);
    else
        dm_bubble_dt = p_airgun*A*(gamma/(Rgas*T_infty))^(1/2);
    end
else %airgun is not firing
    dm_bubble_dt = 0;
end

%%%AIRGUN MASS%%%
dm_airgun_dt = -dm_bubble_dt;

%%%AIRGUN PRESSURE%%%
dT_airgun_dt = (cp*T_airgun*dm_airgun_dt - cv*T_airgun*dm_airgun_dt)/(m_airgun*cv);
dp_airgun_dt = (Rgas/V_airgun)*(T_airgun*dm_airgun_dt + m_airgun*dT_airgun_dt);

%%%BUBBLE TEMP%%%
dT_bubble_dt = (1/(m_bubble*cv))*(cp*T_airgun*dm_bubble_dt -...
    cv*T_bubble*dm_bubble_dt - dQdt - p_bubble*dVdt);

%%%BUBBLE PRESSURE%%%
dp_bubble_dt = (Rgas/V_bubble^2)*(V_bubble*m_bubble*dT_bubble_dt +...
    V_bubble*T_bubble*dm_bubble_dt-dVdt*m_bubble*T_bubble);

%%%BUBBLE RADIUS%%%
dR_dt = U;

%%%BUBBLE VELOCITY%%%
dU_dt = (1/R)*(1/rho_infty*(p_bubble-p_infty+pv + R*dp_bubble_dt/c_infty) - 3/2*U^2);

%% EVOLVE SOLUTION %%

dYdt = [dR_dt; dU_dt; dm_bubble_dt; dT_bubble_dt;...
    dp_airgun_dt; dm_airgun_dt];