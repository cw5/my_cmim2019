% ---------------------------------------------
% function osc_energy.m
% author: Carina Witt
% 05.03.2019
%
% returns the potential and kinetic energy
% of an oscillating system
%----------------------------------------------

function [E_pot,E_kin] = osc_energy(u, v, omega)

E_pot = 1/2 * omega^2 * u.^2;
E_kin = 1/2 * v.^2;

end %function