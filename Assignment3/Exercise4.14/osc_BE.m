% ---------------------------------------------
% function osc_FE.m
% author: Carina Witt
% 05.03.2019
%
% Forward Euler scheme
% for numerical calculation of oscillations
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

% apply Backward Euler scheme
for n = 1:N_t
    u(n+1) = ( u(n)+dt*v(n) )/( 1+dt^2*omega^2 );
    v(n+1) = v(n) - dt * omega^2 * u(n+1);
end

% plot the results
plot(t,u)
xlabel('t')
ylabel('u')
