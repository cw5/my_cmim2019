% ---------------------------------------------
% function osc_EC.m
% author: Carina Witt
% 05.03.2019
%
% plot total energy of oscillation
% applying the Forward Euler scheme
% for numerical calculation
%----------------------------------------------

close all
clear all
clc

% parameters
omega = 2;           % frequency
P     = 2*pi/omega;  % period
iP    = 20;          % intervals per period
dt    = P/iP;        % time step
T     = 3*P;         % total time: 3 periods 
N_t   = floor(T/dt); % total intervals

% create time grid
t     = linspace(0, N_t*dt, N_t +1);

% initialization
u = zeros(N_t +1, 1); 
v = zeros(N_t +1, 1);

% initial condition
X_0  = 2;
u(1) = X_0;
v(1) = 0;

% apply Euler-Cromer scheme 
for n = 1:N_t
    v(n+1) = v(n) - dt * omega^2 * u(n);
    u(n+1) = u(n) + dt * v(n+1);
end

% call function osc_energy
[E_pot,E_kin] = osc_energy(u, v, omega);

% total energy = sum of potential and kinetic energy
E_tot = E_pot + E_kin;

% plot the total energy
figure(99)
plot(t,u)
figure(1)
plot(t,E_pot)
figure(2)
plot(t,E_kin)
figure(3)
plot(t,E_tot)
xlabel('time')
ylabel('Total Energy')
