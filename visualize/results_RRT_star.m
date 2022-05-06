%% Case 1: 1 obstacle and goal behind it
close all;  clear all; clc;

% Draw obstacle
r = 10;
xc = 15;   yc = 15;   zc = 200;
hold on;
add_obstacle(r,[xc, yc, zc],'m', 0.9);

% Draw tight bounding box
len = r*2;
draw_cube([len len len], [xc, yc, zc], 'k', 0.4);

% Draw phantom
add_phantom();
view([80 40]);

% Import data from C++
raw_filepath = '/home/emmanuel/workspace/ros-workspace/RBE550_ws/results/rrt_star/1_raw.xyz';
P=importdata(raw_filepath);
hold on;
plot3(P(:,1), P(:,2), P(:,3), 'b', "LineWidth", 0.75);

smooth_filepath = '/home/emmanuel/workspace/ros-workspace/RBE550_ws/results/rrt_star/1_smooth.xyz';
P=importdata(smooth_filepath);
hold on;
plot3(P(:,1), P(:,2), P(:,3), 'r', "LineWidth", 1);




%% Case 2: 2 obstacles same level with narrow passage and goal behind it
close all;  clear all; clc;

% Draw obstacle
r = 5;
xc = 15;   yc = 35;   zc = 200;
hold on;
add_obstacle(r,[xc, yc, zc],'m', 0.9);

% Draw obstacle2
r2 = 5;
xc2 = 35;   yc2 = 35;   zc2 = 200;
hold on;
add_obstacle(r,[xc2, yc2, zc2],'m', 0.9);

% Draw tight bounding box1
len = r*2;
draw_cube([len len len], [xc, yc, zc], 'k', 0.4);
% Draw tight bounding box2
len = r2*2;
draw_cube([len len len], [xc2, yc2, zc2], 'k', 0.4);

% Draw phantom
add_phantom();
view([80 40]);

% Import data from C++
raw_filepath = '/home/emmanuel/workspace/ros-workspace/RBE550_ws/results/rrt_star/2_raw.xyz';
P=importdata(raw_filepath);
hold on;
plot3(P(:,1), P(:,2), P(:,3), 'b', "LineWidth", 0.75);

smooth_filepath = '/home/emmanuel/workspace/ros-workspace/RBE550_ws/results/rrt_star/2_smooth.xyz';
P=importdata(smooth_filepath);
hold on;
plot3(P(:,1), P(:,2), P(:,3), 'r', "LineWidth", 1);





%% Case 3: 2 obstacles different levels with narrow passage and goal behind it - little aside
close all;  clear all; clc;

% Draw obstacle
r = 5;
xc = 15;   yc = 15;   zc = 200;
hold on;
add_obstacle(r,[xc, yc, zc],'m', 0.9);

% Draw obstacle2
r2 = 5;
xc2 = 35;   yc2 = 35;   zc2 = 300;
hold on;
add_obstacle(r2,[xc2, yc2, zc2],'m', 0.9);

% Draw tight bounding box1
len = r*2;
draw_cube([len len len], [xc, yc, zc], 'k', 0.4);
% Draw tight bounding box2
len = r2*2;
draw_cube([len len len], [xc2, yc2, zc2], 'k', 0.4);

% Draw phantom
add_phantom();

% Import data from C++
raw_filepath = '/home/emmanuel/workspace/ros-workspace/RBE550_ws/results/rrt_star/3_raw.xyz';
P=importdata(raw_filepath);
hold on;
plot3(P(:,1), P(:,2), P(:,3), 'b', "LineWidth", 0.75);

smooth_filepath = '/home/emmanuel/workspace/ros-workspace/RBE550_ws/results/rrt_star/3_smooth.xyz';
P=importdata(smooth_filepath);
hold on;
plot3(P(:,1), P(:,2), P(:,3), 'r', "LineWidth", 1);



%% Case 4: 3 obstacles different levels with narrow passage blocked and target behind it
close all;  clear all; clc;

% Draw obstacle
r = 5;
xc = 15;   yc = 15;   zc = 200;
hold on;
add_obstacle(r,[xc, yc, zc],'m', 0.9);

% Draw obstacle2
r2 = 5;
xc2 = 25;   yc2 = 25;   zc2 = 170;
hold on;
add_obstacle(r2,[xc2, yc2, zc2],'m', 0.9);

% Draw obstacle3
r3 = 10;
xc3 = 20;   yc3 = 20;   zc3 = 230;
hold on;
add_obstacle(r3,[xc3, yc3, zc3],'m', 0.9);

% Draw tight bounding box1
len = r*2;
draw_cube([len len len], [xc, yc, zc], 'k', 0.4);
% Draw tight bounding box2
len = r2*2;
draw_cube([len len len], [xc2, yc2, zc2], 'k', 0.4);
% Draw tight bounding box3
len = r3*2;
draw_cube([len len len], [xc3, yc3, zc3], 'k', 0.4);

% Draw phantom
add_phantom();

% Import data from C++
raw_filepath = '/home/emmanuel/workspace/ros-workspace/RBE550_ws/results/rrt_star/4_raw.xyz';
P=importdata(raw_filepath);
hold on;
plot3(P(:,1), P(:,2), P(:,3), 'b', "LineWidth", 0.75);

smooth_filepath = '/home/emmanuel/workspace/ros-workspace/RBE550_ws/results/rrt_star/4_smooth.xyz';
P=importdata(smooth_filepath);
hold on;
plot3(P(:,1), P(:,2), P(:,3), 'r', "LineWidth", 1);






