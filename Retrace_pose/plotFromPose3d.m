function [] = plotFromPose3d( pose )
% plots a streight line corresponding with a given pose.

dz=-(-pose(3,1)/sqrt(pose(3,2)^2+pose(3,3)^2));
dy=(pose(2,1)/pose(1,1));

x=(pose(1,end)-5):0.1:(pose(1,end)+5);
y=dy*x+pose(2,end)-(dy*pose(1,end));
z=dz*x+pose(3,end)-(dz*pose(1,end));
plot3(x,y,z,'r-');hold on;
plot3(pose(1,end),pose(2,end),pose(3,end),'xk');
xlabel('x');
ylabel('y');
zlabel('z');
hold off;
end

