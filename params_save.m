function params = params_save(bubbleInit, airgunInit, physConst)

Rgas = physConst.Rgas;
gamma = physConst.gamma;
p_infty = physConst.p_infty;
rho_infty = physConst.rho_infty;
T_infty = physConst.T_infty;
c_infty = physConst.c_infty;

cv = physConst.cv;
cp = physConst.cp;
M = physConst.M;
kappa = physConst.kappa;

t_fire = max(physConst.time); %%%%%%NEED TO CHANGE THIS !!!!!

V_airgun = airgunInit.V;
A = airgunInit.A;
init_m_airgun = airgunInit.m;



params = [Rgas, gamma, p_infty, rho_infty, T_infty, V_airgun, A, cv, cp,...
    M, kappa, c_infty, t_fire, init_m_airgun];
