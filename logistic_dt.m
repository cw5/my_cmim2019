% ---------------------------------------------
% function logistic_dt.m
% author: Carina Witt
% 05.03.2019
%
% finds appropriate time step for the logistic problem
%----------------------------------------------

close all
clear all
clc

% initial value for time step dt
dt = 10;

% get results for initial time step value
[t_old,N_old] = logistic(dt);

k = 0;
% endless loop
while true 
            
    % update time step
    dt_k = 2^(-k)*dt
    
    % call function to compute result for current time step value
    [t,N] = logistic(dt_k);
    
    % plot results for last and current time step
    plot(t_old,N_old,t,N);
    legend('N for t_{k-1}','N for t_k')
    xlabel('t')
    ylabel('N')
    
    % ask user if loop shall be continued
    user_decision = input('Please type 0 if loop shall be terminated or type 1 to continue.\n');
    
    % either continue or stop loop
    if user_decision == 0
        break
    elseif user_decision == 1    
        % update k,t and N and go on with the loop
        k = k+1;
        t_old=t; N_old=N; 
    else
        error('Command not accepted.')
    end
    
end %while

% disply result
fprintf('The sufficient time step for the logistic model is %.5f.\n', dt_k);