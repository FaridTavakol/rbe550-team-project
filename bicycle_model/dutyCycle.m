function  w = dutyCycle(time, desiredCurvature, naturalCurvature, delta)
%  This function calculates the desired rotation velocity based on
% a duty-cycle time series.
% Inputs:
% time: Total simulation time e.g., 8.2 sec
% desiredCurvature
% naturalCurvature
% delta: Regular Time Period T


%  Source: Patil et. al. 2010 Interactive Motion Planning for Steerable
%  Needles in 3D Environments with Obstacles

% Use the time to determine which duty cycle period you are in,
% j=0,1,2,..
j = fix(time/delta);

% find desired duty cycle based on the curvature
tau = calcDutyCyclePeriod(desiredCurvature, naturalCurvature)/100;
if (j * delta) <= time && time <= delta * (j+ tau)
    % Zero duty-cycle means no rotationional speed
    if tau == 0
        w = 0;
        return
    end
    w = (2 * pi)/(delta * tau);
else 
    w = 0;
end

end