function dutyCycle = calcDutyCyclePeriod(curvature, naturalCurvature)
% Function to calculate desired duty cycle based on a given curvature
% Resource: Minhas et.al modeling of Needle Steering via Duty-Cycled
% Spinning

slope = (0 - naturalCurvature)/(100 - 0);
if curvature > naturalCurvature
    dutyCycle = 100;
else
    dutyCycle = (curvature-naturalCurvature)/slope;
end

end