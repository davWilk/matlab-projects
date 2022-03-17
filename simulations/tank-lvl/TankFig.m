classdef TankFig
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        Fig
        Axes
        TankHeight
        TankArea
        PipeIn_x = [0    0.23 0.23 0.22 0.26 0.25 0.25 0];
        PipeIn_y = [0.64 0.64 0.62 0.6 0.6  0.62 0.66 0.66];
        PipeOut_x = [0.7 0.85 0.85 0.835 0.835 0.7];
        PipeOut_y = [0.02 0.02 -0.095 -0.095 0 0];
        Fill_x = [0.22 0.26 0.26 0.22];
        Fill_y = [0.6 0.6 0 0];
        Tank_x = [0.2 0.7 0.7 0.2 0.2];
        Tank_y = [0 0 0.6 0.6 0];
    end
    
    methods
        function obj = TankFig(h_max, A)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.Fig = figure;
            obj.Axes = axes();
            set(gca, 'xtick', []);
            obj.TankHeight = h_max;
            obj.TankArea = A;
            drawTank(obj);
        end
        
        function update(obj, h, fi, fo, t)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            drawTank(obj);
            pct_h = h / obj.TankHeight;
            x_area = [0.2 0.7 0.7 0.2];
            y_area = [0 0 pct_h*0.6 pct_h*0.6];
            hold on;
            text(0.7, 0.9, "t = "+t)
            text(0.7, 0.83, "f_i_n = "+sprintf('%.4f',fi)+'m^3s^{-1}');
            text(0.7, 0.76, "f_o_u_t = "+sprintf('%.4f',fo)+'m^3s^{-1}');
            fill(obj.Axes, x_area, y_area, 'blue');
            if fi ~= 0
                fill(obj.Axes, obj.PipeIn_x, obj.PipeIn_y, 'blue');
                fill(obj.Axes, obj.Fill_x, obj.Fill_y, 'blue'); 
            end
            if fo ~= 0
                fill(obj.Axes, obj.PipeOut_x, obj.PipeOut_y, 'blue');
            end
            hold off;
        end
    end

    methods (Access = private)        
        function drawTank(obj)
            % drawing tank
            plot(obj.Axes, obj.Tank_x, obj.Tank_y, 'LineWidth', 2.0, 'Color', 'black');

            % drawing pipes
            hold on
            plot(obj.Axes, obj.PipeIn_x, obj.PipeIn_y, 'LineWidth', 2.0, 'Color', 'black');
            plot(obj.Axes, obj.PipeOut_x, obj.PipeOut_y, 'LineWidth', 2.0, 'Color', 'black');
            set(gca, 'xtick', []);
            set(gca, 'ytick', []);
            xlim([0 1]);
            ylim([-0.1 1]);
        end
    end
end

