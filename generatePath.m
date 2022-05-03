% Testing the CURV steering approach
function generatePath(desiredCurvature, targetPoint)
close all;
load('/home/farid/Downloads/Q.mat')
% Unit Vectors
global e1;
e1 = [1;0;0];
global e2;
e2 = [0;1;0];
global e3;
e3 = [0;0;1];

% Geometric Relations
global l1;
l1 = 40;      %mm
global l2;
l2 = 0;%23.775;  %mm For unicycle model this will be zero

% naturalCurvature= 0.00449;
naturalCurvature= 0.1938;

global V1;
V1 = [e3; naturalCurvature * e1];
global V2;
V2 = [zeros(3,1); e3];

% Duty cycle period = t_rot + t_insertion
delta = 0.25;

% desiredCurvature = 0.1;
tau = calcDutyCyclePeriod(desiredCurvature, naturalCurvature)/100;

% Time step for simulation
if tau==0
    step = 0.0005;
else
    step = tau/10000;
end

% Simulation configuration
simulationTime = 20;       %second
% time = 0:step:simulationTime;  % simulation run time
numberOfIterations = simulationTime/step + 1;
time = 0;


% Initial conditions:
% needleTipPos = zeros(3,1,numberOfIterations);
needleTipPos(:,:,1) = [0;0;0];

% Initial coordinate frame
% Gab = zeros(4,4, numberOfIterations);
Gab(4,4,:) = 1;

%calculate rotation
desiredTheta= atan2(targetPoint(2),targetPoint(1)) + (pi/2);

Gab(:,:,1) = [cos(desiredTheta) -sin(desiredTheta)  0 0;...
              sin(desiredTheta) cos(desiredTheta)  0 0;...
               0 0 1 0;...
               0 0 0 1];
% The position of the origin of the transform Gab in each iteration
% FramePos = zeros(3, 1, numberOfIterations);
FramePos(1:3,1) =  Gab(1:3,4,1)';

% Configuration
insertionSpeed = 1;      % mm/s

% theta = zeros(1,numberOfIterations);   % Initial steering direction angle
theta(1) = 0.0;
% RotationSpeed = zeros(1,numberOfIterations);
% w_hat = zeros(1,numberOfIterations);
% TotalInsertionDistance = zeros(1,numberOfIterations);

%% Could also add a rotation speed parameter to override w_max
for i = 1:numberOfIterations
    
    RotationSpeed(i) = dutyCycle(time(i), desiredCurvature, naturalCurvature, delta);
    time(i+1) = time(i)+step;
    % Determine angle for the next iteration
    theta(i+1) = theta(i) + RotationSpeed(i) * step;
    if theta(i+1) > 2*pi
        theta(i+1) = theta(i+1) - (2*pi);
    end

    u1 = insertionSpeed * step;
    u2 = RotationSpeed(i) * step;


    % Calculating the kinematics using nonholonomic bicycle model
    [Gab(:,:,i+1), needleTipPos(:,:,i)] = bicycleKinematicsModelOneIteration(Gab(:,:,i), u1, u2);
    FramePos(:,:,i+1) = Gab(1:3,4,i+1);
    if FramePos(1,1,i+1)>= targetPoint(1) && FramePos(2,1,i+1) >=targetPoint(2)
        break
    end

end
% Display output
figure
hold on;
subplot(2,1,1)
plot(time,theta,'r','Linewidth',2);
grid on
title('Needle Rotation Angle Setpoints')
xlabel('Time (sec)')
ylabel('Rotation Angle (rad)')
subplot(2,1,2)
plot(time(1:end-1),RotationSpeed,'b','Linewidth',2);
grid on
title('Needle Rotation Speed')
xlabel('Time (sec)')
ylabel('Rotation Speed (rad/sec)')

%Plot Trajectory
figure
hold on;

% needleTipPos(1,1:end) = 0;
% FramePos(1,:)= 0

% plot3(needleTipPos(1,1:end),needleTipPos(2,1:end), needleTipPos(3,1:end), 'r','Linewidth',2);
% Shift frame pose
plot3(FramePos(1,:), FramePos(2,:), FramePos(3,:), 'b','Linewidth',2);
grid on
% set(gca,'DataAspectRatio', [1 1 1]);
xlabel('x(mm)')
ylabel('y(mm)')
zlabel('z(mm)')
title('simulated trajectory')
legend('tip','frame')
plot3(Q(1,:),Q(2,:),Q(3,:), 'b.')
% axis equal


return
%Plot Trajectory
figure
hold on;
plot(needleTipPos(3,:),needleTipPos(2,:), 'r','Linewidth',2);
plot(FramePos(3,:), FramePos(2,:), 'b','Linewidth',2);
% set(gca,'DataAspectRatio', [1 1 1]);
grid on
xlabel('z(mm)')
ylabel('y(mm)')
title('simulated trajectory')
legend('tip','frame')
% axis equal


%Plot Trajectory
figure
subplot(3,1,1)
hold on;
plot(FramePos(3,:), FramePos(2,:), 'b','Linewidth',2);
grid on
ylabel('y(mm)')
xlabel('z(mm)')
title('simulated trajectory of frame vs time')
% axis equal
subplot(3,1,2)
hold on;
plot(FramePos(3,:), FramePos(1,:), 'g','Linewidth',2);
grid on
ylabel('x(mm)')
xlabel('z(mm)')
subplot(3,1,3)
hold on
ylabel('y(mm)')
xlabel('x(mm)')
plot(FramePos(1,:), FramePos(2,:), 'r','Linewidth',2);



% set(gca,'DataAspectRatio', [1 1 1]);
end
% %Plot Trajectory
% figure(4);
% hold on;
% plot(time, [needleTipPos(1,1:end); needleTipPos(2,1:end)]);
% grid on
% title('simulated trajectory of tip vs time')
% xlabel('Time(sec)')
% ylabel('position(mm)')
% legend('x','y')
