function [h, f_i, f_o, overflow] = fn_tank_lvl(h, f_i, R_o, rho, H, A, dt)
%FUNC_TANK_LVL Plant model of tank level
%   Takes inputs of:
%       h - Current Tank Height
%       f_i - Flow In
%       R_o - Resistance to Flow Out
%       H - Tank Height 
%       A - Tank Area
%       dt - Simulation step time
    overflow = 0;
    g = 9.81;
    % flow out
    f_o = (R_o/A) * rho * g * h;
    h = h + dt*((f_i/A) - f_o);
    
    if h > H
        h = H;
        overflow = 1;
    end
end

