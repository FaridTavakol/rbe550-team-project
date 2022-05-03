function path=circularPath(posNeedle,goal,N)
%generates a path lying on a circle segment aligned with the initial needle
%pose and the final target point.
%posNeedle = current needle pose [4x4]
%goal = target point where the needle should end up [3x1]
%N = amount of intermediate points to be generated
%path = path starting at posNeedle and ending at goal [3xN]
%Note: All coordinates are [x;y;z] where x is the insertion axis

% find the radius and angle needed to reach the target point
[rad,theta_d,~]=findParameters(posNeedle,goal,0,0);

% generate coordinates along the x-axis (insertion axis)
x=linspace(0,goal(1,end)-posNeedle(1,end),N);

% generate coordinates along the z-axis (circle is still in 1 plane)
z=sqrt(rad^2-x.^2)-rad;

% generate path in plane
path=[x;zeros(size(x));z];

%compensate for angle that the needle already has
theta_d2=atan2d(posNeedle(3,2),posNeedle(3,3));

% rotate path so plane is aligned with needle origin and target point
for k=1:size(path,2)
    path(:,k)=rotM((theta_d+theta_d2)/180*pi,'x')*path(:,k)+posNeedle(1:3,end);
end

% if any(imag(path(:)))
%     error('This combination of initial needle pose and target point results in an incorrect path');
% end
%path(:,end)=goal;
%path=real(path);
% display path if needed
% plot3(path(1,:),path(2,:),path(3,:),'.');
% xlabel('x');
% ylabel('y');
% zlabel('z');
% axis image
end