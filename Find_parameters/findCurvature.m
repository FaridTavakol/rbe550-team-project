function [R]=findCurvature(posNeedle,Pg,rot)
% Calculates the radius of a circle between a vector and a point in a plane
% described by angle rot.
%
% Position and rotation of needle [4,4]
% Pg: x,y,z -coordinates of goal [3,1]
% angle of needle (direction to steer to) [1]
% Cmin: Minimum curvature possible for needle [1]
% R: radius of circle connecting Pn to Pg perpendicular to the needle in
% plane described by rot in mm [1]
%
% See also: findAngle.m, findParameters.m

% Homogenous transformation of target point. Put target in needle frame.
Pg=posNeedle^-1*[eye(3),Pg;0,0,0,1];
       
% Rotate Pg to xz plane        
Pg=[1,0,0,0;0,cos(rot),-sin(rot),0;0,sin(rot),cos(rot),0;0,0,0,1]^-1* Pg;

% calculate coefficients of line perpendicular to, and through the centre of the line
% going through both points. (f(x)=a*x+b);
a=-Pg(1,4)/Pg(3,4);
b=Pg(3,4)/2-a*Pg(1,4)/2;

% radius of circle perpendicular to x-axis is equal to f(0)=b;
R=abs(b);

% if radius is infinite. Just set it to a large number to prevent errors.
if isinf(R)
    R=9999999999;
end

end