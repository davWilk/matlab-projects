classdef PIDController
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        ref; % reference input, upon change we clear error summation
        intg_error; % error summation, used for integral action
        prev_error; % used for derivative action
        Kp;
        Ki;
        Kd;
        outMax;
        outMin;
    end
    
    methods
        function obj = PIDController(Kp, Ki, Kd, outMax, outMin)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.Kp = Kp;
            obj.Ki = Ki;
            obj.Kd = Kd;

            obj.outMax = outMax;
            obj.outMin = outMin;

            obj.intg_error = 0;
            obj.prev_error = 0;
        end
        
        function output = compute(obj, ref, y)
            %compute Apply PID control law to current error
            %   ref = current desired output, y = current state.

            %   Upon change in ref, integral summation and prev error is cleared
            if obj.ref ~= ref
                obj.intg_error = 0;
                obj.prev_error = 0;
            end

            err = ref - y; 
            obj.intg_error = obj.intg_error + err;

            p_term = obj.Kp * err;
            
            i_term = obj.Ki * obj.intg_error;
            if i_term > obj.outMax
                i_term = obj.outMax;
            elseif i_term < obj.outMin
                i_term = obj.outMin;
            end

            d_term = (err - obj.prev_error) * obj.Kd;
            
            % apply PID control law
            output = p_term + i_term + d_term;
            
            % saturate output if needed
            if output > obj.outMax
                output = obj.outMax;
            elseif output < obj.outMin
                output = obj.outMin;
            end

            % save current error as next iteration previous error
            % (Derivative action)
            obj.prev_error = err;
        end
    end
end

