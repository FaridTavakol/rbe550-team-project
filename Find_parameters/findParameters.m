function [rad,theta_d,l]=findParameters(posNeedle,NGoal,Rmin,insDepth)
% calculates parameters to send to robot
% posNeedle =[4x4] matrix containing rotation and position of needle.
% Path = [3xN] matrix containing all subsequent path points.
% Kmin = minimal curve radius [mm].
% insDepth = depth of insertion per step.
%
% See also: findAngle.m, findCurvature.m

% find angle of target relative to needle
rot=findAngle(posNeedle,NGoal);
% find radius of curve needed to go from needle pos. to target point.
rad=findCurvature(posNeedle,NGoal,rot);
if rad<Rmin
    rad=Rmin;
end

% calculate insertion depth.
l=insDepth; %note: Should this be the insertion depth along the x-axis, or the length of the curve in total? (my guess would be the last, if so, insDepth ~= l)

% Give angle in degrees instead of radians
theta_d=rot/pi*180;
end