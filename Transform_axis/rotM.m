function [ A ] = rotM( theta,dir )
% generates 3d rotation matrix
% theta=angle in radians
% dir = axis on which to rotate around.

if strcmp(dir,'x');
    A=[1,0,0;0,cos(theta),-sin(theta);0,sin(theta),cos(theta)];
end
if strcmp(dir,'y');
    A=[cos(theta),0,sin(theta);0,1,0;-sin(theta),0,cos(theta)];
end
if strcmp(dir,'z');
    A=[cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1];
end

end

