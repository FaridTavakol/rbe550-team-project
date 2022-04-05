function  w = dutyCycle(time)
%  This function calculates a duty-cycle time series based on the total simulation
%  time
%  time: Total simulation time e.g., 8 sec

%   
%  Source: Minhas et. al. Modeling of Needle Steering via Duty-Cycled
%  Spinning

global w_max        % Maximum rotational velocity
global duty_cycle   % Desired duty-cycle e.g., D = 0.33, 0.67, 0.93
global T            % Period

D = T * duty_cycle;

if 0 <= rem(time, T) && rem(time,T) < T - D
    w = 0;
else
    w = w_max;
end

end