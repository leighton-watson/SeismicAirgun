function [t_obs, p_obs] = pressure_eqn(t, R, U, A, rho_infty, c_infty, r)
% [t_obs, p_obs] = pressure(t, R, U, rho_infty, r)
%
% Compute the pressure field in the liquid at distance r from the center of
% the bubble. This is done using the volume formulation of Keller and 
% Kolodner (1956).                                  
                      
t_sig = t + r/c_infty; %time vector when signal arrives
delta_t = 1e-5; %spacing between time steps before signal arrives

t_bef = [min(t):delta_t:min(t_sig)-delta_t]'; %time vector before signal arrives
t_obs = [t_bef; t_sig]; %time vector, for before and after signal arrives

p_sig = rho_infty * ((2*R.*U.^2+A.*R.^2)./r - R.^4.*U.^2./(2*r^4)); %pressure signal
p_bef = zeros(length(t_bef),1);

p_obs = [p_bef; p_sig]; %pressure perturbation, for before and after signal arrives

end

