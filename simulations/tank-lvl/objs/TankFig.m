classdef TankFig
    %TankFig class for tank simulation figure
    %   Houses all logic required to draw/update current state of
    %   simulation
    
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
            %TankFig Constructs an instance of this class
            obj.Fig = figure;
            obj.Axes = axes();
            set(gca, 'xtick', []);
            obj.TankHeight = h_max;
            obj.TankArea = A;
            drawTank(obj);
        end
        
        function update(obj, h, fi, fo, t)
            %update Updates figure with supplied sim data
            %   h - height of liquid in tank
            %   fi - tank input flow
            %   fo - tank output flow
            %   t - current sim time
            drawTank(obj);
            pct_h = h / obj.TankHeight;
            x_area = [0.2 0.7 0.7 0.2];
            y_area = [0 0 pct_h*0.6 pct_h*0.6];
            hold on;
            text(0.7, 0.9, "t = "+t)
            text(0.7, 0.83, "f_{in} = "+sprintf('%.4f',fi)+'m^3/s');
            text(0.7, 0.76, "f_{out} = "+sprintf('%.4f',fo)+'m^3/s');
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
            % drawTank Draws tank onto figure
            
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

