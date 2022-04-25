function dutyCycle = calcDutyCyclePeriod(desiredCurvature, naturalCurvature)
% Function to calculate desired duty cycle based on a given curvature
% Resource: Minhas et.al modeling of Needle Steering via Duty-Cycled
% Spinning

if desiredCurvature <0
     ME = MException('MyComponent:noSuchVariable', ...
        'Curvature can not be a negative number.');
    throw(ME)
end

slope = (0 - naturalCurvature)/(100 - 0);
if desiredCurvature > naturalCurvature
    dutyCycle = 0;
else
    dutyCycle = (desiredCurvature - naturalCurvature)/slope;
end

end