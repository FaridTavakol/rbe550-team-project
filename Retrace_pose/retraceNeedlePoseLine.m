function needlePose=retraceNeedlePoseLine(posHist,xAngle) %xAngle
% Determines the pose of a needle by fitting a 1st degree polynomial to the
% points within the last 5 mm.
% posHist = list of xyz coordinates containing the known positions of the
% needle tip.
% xAngle = current axial rotation of the needle.

% determine which points to use for retracing the pose
lastPointsWithinmm=5;
%nPoints=25;
nPoints=sum(posHist(1,:)>posHist(1,end)-lastPointsWithinmm);   %%## nPoints size of greater than 5mm
if nPoints>=size(posHist,2)
    nPoints=size(posHist,2)-1;
end

% get x-y-z coordinates from the last n points  %%## in robot frame  
x=posHist(1,end-nPoints:end);
y=posHist(2,end-nPoints:end);
z=posHist(3,end-nPoints:end);

% fit a*x+b=y A(1) = a A(2)=b
A=[x(:),ones(size(x(:)))]\y(:);

% fit c*x+d=z B(1) = c B(2)=d
B=[x(:),ones(size(x(:)))]\z(:);

% find angle of line around z-axis
theta1=atan(A(1));

% determine angle of line around y-axis
theta2=-atan(B(1));
%%!!! Why would this angle be negative! it doesn't make sence!  %%##??

% generate the rotation matrices corresponding to the calculated angles
Rz=rotM(theta1,'z');
Ry=rotM(theta2,'y');
Rx=rotM(xAngle/180*pi,'x');
Rpose=Rz*Ry*Rx;
needlePose=[Rpose,posHist(:,end);0,0,0,1];

    if any(isnan(needlePose(:))) | size(x)==[1,1]
        needlePose=[Rx,posHist(:,end);0,0,0,1];
    end
    %display if nessesary
%     plotFromPose3d(needlePose); hold on
%     plot3(posHist(1,:),posHist(2,:),posHist(3,:),'.');
end