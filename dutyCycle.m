function  w = dutyCycle(time, curvature)
%  This function calculates the desired rotation velocity based on 
% a duty-cycle time series.
%  time: Total simulation time e.g., 8.2 sec

%  Source: Patil et. al. 2010 Interactive Motion Planning for Steerable
%  Needles in 3D Environments with Obstacles

global naturalCurvature % Natural curvature of needle
global delta            % Regular Time Periods
k = 10;                 % Sufficiently large value to satisfy w(t) >> u(t) based on Patil et al. 2010

% Use the time to determine which duty cycle period you are in,
% j=0,1,2,..
j = fix(time);

% find desired duty cycle based on the curvature
tau = calcDutyCyclePeriod(curvature, naturalCurvature);

% Duty cycle factor
tau = (1 - (curvature/naturalCurvature));

if (j * delta) <= time && time <= delta * (j+tau)
        w = (2 * k * pi)/(delta * tau);
if delta * (j+tau) < time && time < (j+1) * delta
    w = 0;
end

end