function rot=findAngle(posNeedle,NGoal)
% Computes the angle around the x-axis of a normalized target coordinate.
%
% Tar = Transformation matrix to desired point. needle tip at 0,0,0 aligned
% with x axis [4,4]
% rot = angle around x-axis towards target Tar [1]
%
% See also: findCurvature.m, findParameters.m

% Homogenous transformation. Put target in needle tip frame.
Tar = posNeedle^-1*[eye(3) NGoal(1:3,end);0 0 0 1];

% Calculate angle, where 0 degrees corresponds with negative y-axis.
rot=atan2(Tar(3,4),Tar(2,4))+1/2*pi;

end