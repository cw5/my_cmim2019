% ---------------------------------------------
% function logistic_dt.m
% author: Carina Witt
% 05.03.2019
%
% solution of the logistic problem
%----------------------------------------------

function [t,N] = logistic(dt)

% paramters for the function
T = 60; %months
M = 500;
r_bar = 0.1;

% initial value
N_0 = 100;

% function
r = @(N) r_bar*(1-N/M);
f = @(t,N) r(N)*N;

% time span as [dt, T]
tspan = [dt T];

% call function to solve ODE
[t, N] = ode_FE(f, tspan, N_0);

end %function