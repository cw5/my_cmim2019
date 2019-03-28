% ---------------------------------------------
% function Newton_Raphson_Mechanics.m
% author: Carina Witt
% 28.03.2019
%
% Newton-Raphson-Scheme applied to a mechanical problem
%----------------------------------------------

close all
clear all
clc

% parameters
a     = 0.1; %m
b     = 0.2; %m
omega = 1;   %rad/s
time  = 0:0.001:20;

% Set parameters for Newton-Raphson scheme
maxiter = 100;
tol = 10^(-8);

% initialize result arrays for plot
x_res      = zeros(length(time),2);
x_dot_res  = zeros(length(time),2);
x_2dot_res = zeros(length(time),2);

% compute f(x) as vector
f = @(x,Phi) [a*cos(Phi)+b*cos(x(1))-x(2); a*sin(Phi)-b*sin(x(1))];
    
% compute Jacobian matrix
J = @(x) [-b*sin(x(1)) -1;
          -b*cos(x(1))  0];

% compute first time derivative of f
dfdt  = @(Phi) [-a*sin(Phi)*omega; a*cos(Phi)*omega];

% compute second time derivative of f
d2fdt = @(x,x_dot,Phi) [a*cos(Phi)*omega^2 + b*cos(x(1))*x_dot(1)^2; ...
                        a*sin(Phi)*omega^2 - b*sin(x(1))*x_dot(1)^2];

% loop over time steps
for i=1:length(time)
    
    t = time(i);
    
    % calculate angle Phi for time t
    Phi = pi/6 + omega*t;

    % define start vector x for the NR-scheme
    x = [0.2;0.2];

    % compute start vector f(x)
    f_value = f(x,Phi);
    
    iteration_counter = 0;
    % Perform Newton-Raphson loop
    while norm(f_value) > tol && iteration_counter < maxiter
        % compute deltax
        deltax = J(x)\-f_value;
        % update x
        x = x + deltax;
        % update f
        f_value = f(x,Phi);
        % increase iteration counter
        iteration_counter = iteration_counter + 1;
    end %while
    % Here, either a solution is found, or too many iterations
    if norm(f_value) > tol
        iteration_counter = -1;
    end %if
        
    % compute time derivative of x
    x_dot  = J(x)\-dfdt(Phi);
    % compute secon time derivative of x
    x_2dot = J(x)\d2fdt(x,x_dot,Phi);
    
    % save results
    x_res(i,:)      = x;
    x_dot_res(i,:)  = x_dot;
    x_2dot_res(i,:) = x_2dot;
        
end %for

% plot results
figure(1)
yyaxis left
plot(time,x_res(:,2),'LineWidth',1);
xlabel('t [s]');
ylabel('Angle \Theta [rad]');   
yyaxis right
plot(time,x_res(:,1),'LineWidth',1);
ylabel('Displacement d [m]');

figure(2)
yyaxis left
plot(time,x_dot_res(:,2),'LineWidth',1);
xlabel('t [s]');
ylabel('Velocity of \Theta [rad/s]');   
yyaxis right
plot(time,x_dot_res(:,1),'LineWidth',1);
ylabel('Velocity of d [m/s]');

figure(3)
yyaxis left
plot(time,x_2dot_res(:,2),'LineWidth',1);
xlabel('t [s]');
ylabel('Acceleration of \Theta [rad/s^2]');
yyaxis right
plot(time,x_2dot_res(:,1),'LineWidth',1);
ylabel('Acceleration of d [m/s^2]');
