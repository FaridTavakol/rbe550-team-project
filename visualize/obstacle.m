clear all; clc; close all;

%% Obstacle

n=100;
[px,py,pz] = meshgrid(1:n, 1:n, 1:n);
radius = 10;
xc = 40; yc = 30; zc = 40; % the center of sphere
logicalSphere = (px-xc).^2 + (py-yc).^2 + (pz-zc).^2 <=radius*radius;
X = zeros(n,n,n);
X(logicalSphere) = 1; % set to zero
 
axis([0,n,0,n,0,n])
p=patch(isosurface(px,py,pz,X,0));
set(p, 'FaceColor', 'red', 'EdgeColor', 'none');
daspect([1 1 1])
view(3)
hold on 
scatter3(px(:),py(:),pz(:),1,X(:), 'filled')
xlabel('x');
ylabel('y');
zlabel('z');
camlight; lighting phong



%% Cone from paper
[X,Y] = meshgrid(-1:0.5:1 -1:0.5:1);
Z = sqrt(2*1*sqrt(X.^2 + Y.^2)- (X.^2 + Y.^2));
% Z = abs(Z);
% surf(X,Y,Z);
plot(X,Y)
xlabel('x');
ylabel('y');
zlabel('z');




%% 1d - Plot Linear Beizier curve given 2 points
t = 0:0.05:1;
p0 = 2;
p1 = 5;
L = (1-t)*p0 + t*p1;
plot(t,L);
%% 2d - Plot Linear Beizier curve given 2 points
t = 0:0.05:1;
p0 = [5 3]';
p1 = [5 7]';
L = (1-t).*p0 + t.*p1;
plot(L(1,:),L(2,:));
axis([0 10 0 10]); 
%% 3d - Plot Linear Beizier curve given 2 points
t = 0:0.05:1;
p0 = [2 3 1]';
p1 = [5 7 4]';
L = (1-t).*p0 + t.*p1;
plot3(L(1,:),L(2,:),L(3,:), 'r--x');
axis([0 10 0 10 0 10]); 


%% 1d - Plot Quadratic Beizier curve given 3 points
t = 0:0.05:1;
p0 = 2;
p1 = 5;
p2 = 7;
Q = (1-t).^2*p0 + 2*(1-t).*t*p1 + t.^2*p2;
plot(t,Q);
%% 2d - Plot Quadratic Beizier curve given 2 points
t = 0:0.25:1;
p0 = [1 5]';
p1 = [2 12]';
p2 = [8 1]';
figure(2);
Q = (1-t).^2.*p0 + 2*(1-t).*t.*p1 + t.^2.*p2;
plot(Q(1,:),Q(2,:));
axis([0 10 0 10]); 




%% Simulate RRT output with quadratic beizer curve given 3 points
close all; clear all;
% Simulate RRT output
x = 1:0.5:10;
y = randi([5,15], [1,width(x)]);
path = [x;y];
figure(1);
plot(path(1,:), path(2,:));
axis([0 20 0 20]); 
% Smooth using 2d quadratic biezer curve
figure(2);
t = 0:0.1:1;
% for ii=1:(width(path)-2)
%     p0 = path(:,ii);
%     p1 = path(:,ii+1);
%     p2 = path(:,ii+2);
%     Q = (1-t).^2.*p0 + 2*(1-t).*t.*p1 + t.^2.*p2;
%     plot(Q(1,:), Q(2,:));
%     axis([0 20 0 20]); 
%     hold on;
% end
p0 = path(:,1);
p1 = path(:,ceil(width(path)/2));
p2 = path(:,width(path));
Q = (1-t).^2.*p0 + 2*(1-t).*t.*p1 + t.^2.*p2;
plot(Q(1,:), Q(2,:));
axis([0 20 0 20]); 






%% Simulate RRT output with 2d cubic beizer curve given 4 points
close all; clear all;
% Simulate RRT output
x = 1:0.5:10;
y = randi([5,10], [1,width(x)]);
path = [x;y];
figure(1);
plot(path(1,:), path(2,:));
axis([0 20 0 20]); 
% Smooth using 2d cubic biezer curve
figure(2);
t = 0:0.1:1;
p0 = path(:,1);                     % 1st point - 0%
p1 = path(:,ceil(width(path)/3));   % 2nd point - 33%
p2 = path(:,ceil(width(path)/3)*2); % 3rd point - 66%
p3 = path(:,width(path));           % 4th point - 100%
C = (1-t).^3.*p0 + 3*(1-t).^2.*t.*p1 + 3*(1-t).*t.^2.*p2 + t.^3.*p3;
plot(C(1,:), C(2,:));
axis([0 20 0 20]); 








%% Simulate RRT output with 3d cubic beizer curve given 4 points
close all; clear all;
% Simulate RRT output
x = 1:0.5:20;
y = randi([5,10], [1,width(x)]);
z = randi([5,15], [1,width(x)]);
path = [x;y;z];
figure(1);
plot3(path(1,:), path(2,:), path(3,:), 'k--');
axis([0 20 0 20 0 20]); 

% Smooth using 3d cubic biezer curve
t = 0:0.1:1;
del = ceil(linspace(1,width(path),4));
p0 = path(:,1);                     % 1st point - 0%
p1 = path(:,del(2));   % 2nd point - 33%
p2 = path(:,del(3)); % 3rd point - 66%
p3 = path(:,del(4));           % 4th point - 100%
C = (1-t).^3.*p0 + 3*(1-t).^2.*t.*p1 + 3*(1-t).*t.^2.*p2 + t.^3.*p3;
hold on
plot3(C(1,:), C(2,:), C(3,:), 'r');
axis([0 20 0 20 0 20]); 

% Find curvature of bieze curve
% r = 1;
% t = 0:0.05:1;
% p0 = [0 0 0]';
% p1 = [2 1 0]';
% p2 = [4 0 0]';
% p3 = [6 0 0]';
% C = (1-t).^3.*p0 + 3*(1-t).^2.*t.*p1 + 3*(1-t).*t.^2.*p2 + t.^3.*p3;
% hold on
% plot3(C(1,:), C(2,:), C(3,:), 'b-x');
% axis([0 20 0 20 0 20]); 
Cd = 3*(1-t).^2.*(p1-p0) + 6*(1-t).*t.*(p2-p1) + 3*t.^2.*(p3-p2);
Cdd = 6*(1-t).*(p2-2*p1+p0) + 6*t.*(p3-2*p2+p1);
k = abs(cross(Cd, Cdd)) / (norm(Cd)).^3
norm(k)





%% Simulate obstacle and RRT output with 3d cubic beizer curve given 4 points
%% obstacle
n=100;
[px,py,pz] = meshgrid(1:n, 1:n, 1:n);
radius = 10;
xc = 40; yc = 30; zc = 40; % the center of sphere
logicalSphere = (px-xc).^2 + (py-yc).^2 + (pz-zc).^2 <=radius*radius;
X = zeros(n,n,n);
X(logicalSphere) = 1; % set to zero

axis([0,n,0,n,0,n])
p=patch(isosurface(px,py,pz,X,0));
set(p, 'FaceColor', 'red', 'EdgeColor', 'none');
daspect([1 1 1])
view(3)
hold on 
scatter3(px(:),py(:),pz(:),1,X(:), 'filled')
xlabel('x');
ylabel('y');
zlabel('z');

% Simulate RRT output
x = 0:0.5:60;
y = x;
% y = randi([0,50], [1,width(x)]);
z = randi([50,65], [1,width(x)]);
path = [x;y;z];
path = [path [xc+20;yc+20;zc]];
% figure(1);
hold on
plot3(path(1,:), path(2,:), path(3,:),'LineWidth', 2);
% axis([0 20 0 20 0 20]); 

% Smooth using 3d cubic biezer curve
% figure(2);
hold on
t = 0:0.1:1;
p0 = path(:,1);                     % 1st point - 0%
p1 = path(:,ceil(width(path)/3));   % 2nd point - 33%
p2 = path(:,ceil(width(path)/3)*2); % 3rd point - 66%
p3 = path(:,width(path));           % 4th point - 100%
C = (1-t).^3.*p0 + 3*(1-t).^2.*t.*p1 + 3*(1-t).*t.^2.*p2 + t.^3.*p3;
plot3(C(1,:), C(2,:), C(3,:), 'g-x', 'LineWidth', 3);
% axis([0 20 0 20 0 20]); 






