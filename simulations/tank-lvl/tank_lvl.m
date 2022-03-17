%% setup
clc
clear
close all

%% plant params
A = 1;
h_max = 2; % 2m height of tank
h = 2; %initial condition
rho = 1; %density of liquid
R = 0.001; %assuming linear resistance to flow -> fout = R*rho*g*h(t)

%% controller params
fi = 0; %initial input flow;

%% sim params
sim_time = 50; % sim time in seconds
dt = 0.01;
fig_dt = 10*dt;


tank = TankFig(h_max, A);

for t = 0:dt:sim_time
    idx = int16(t / dt) + 1; % current list index
    [h, fi, fo, ov] = fn_tank_lvl(h, fi, R, rho, h_max, A, dt);

    % updating figure every 'fig_dt' time interval
    if mod(t, fig_dt) == 0
        tank.update(h, fi, fo, t);
        pause(0.0001);
    end
end



