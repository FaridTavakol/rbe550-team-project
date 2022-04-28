%%
close all;  clear all; clc;
%% Add obstacle
r = 3;
xc = 20;   yc = 30;   zc = 100;
hold on;
add_obstacle(r,[xc, yc, zc],'m', 0.9);

%% Draw tight bounding box
len = r*2;
draw_cube([len len len], [xc, yc, zc], 'k', 0.4);

%% Draw loose bounding box
len = r*2 + 4;
draw_cube([len len len], [xc, yc, zc], 'm', 0.2);

%% Draw phantom
x = 50;    y = 50;      z = 200;
xc = x/2;   yc = y/2;   zc = z/2;
draw_cube([x y z], [xc, yc, zc], 'b', 0.1);
% Graph Styling
axis equal;
% len = n*1.2;
% axis([0 len 0 len 0 len]);
daspect([1 1 1]);
grid on;




%% Import data from C++
raw_filepath = '/home/emmanuel/workspace/ros-workspace/RBE550_ws/1_raw_path.txt';
P=importdata(raw_filepath);
hold on;
plot3(P(:,1), P(:,2), P(:,3), 'b', "LineWidth", 1);

smooth_filepath = '/home/emmanuel/workspace/ros-workspace/RBE550_ws/1_smooth_path.txt';
P=importdata(smooth_filepath);
hold on;
plot3(P(:,1), P(:,2), P(:,3), 'g', "LineWidth", 2);
%%




