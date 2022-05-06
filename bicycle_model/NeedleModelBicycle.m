function [posNeedle]=NeedleModelBicycle(posNeedle,needleRad,theta,insDepth)

if theta~=0
    posNeedle=bicycleKinematicsOneIteration(posNeedle,needleRad,theta,0);
end
if insDepth~=0
    posNeedle=bicycleKinematicsOneIteration(posNeedle,needleRad,0,insDepth);
end


end