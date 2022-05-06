%% clear and close everything
clc;clear;close all
timer=tic;
%% Add paths
addpath('CURV/');
addpath('Retrace_pose/');
addpath('Transform_axis/');
addpath('Pathfinding/');
addpath('Visualization/');
addpath('Paths/');

%% Load Generated Trajectory File
file='4_smooth.xyz';
Goal = transpose(importdata(file)); 
%% intermediate steps used for model
stepsMod=5;

%% add subfolders in search path
dirs = regexp(genpath(pwd),['[^;]*'],'match');
for i=1:length(dirs)
    addpath(char(dirs(i)));
end

%% Initiation

% request current robot positionf
rotAbsolute=0;
insDepthAbsolute=0;

%find initial position of Goal IN ROBOT COORD RAS
% Goal=[0,  5,  -5, -3, -6;
%       -2,  5,  -1, 2, 10;
%       50, 100,200, 400,600];
% Goal=[1,4;0,3;60,200];

%find initial position of needle IN ROBOT COORD
needleTraj=[Goal(1,1);Goal(2,1);Goal(3,1)];

%convert coordinates so models can use them
needleTraj=robotToNeedle(needleTraj);
Goal=robotToNeedle(Goal);

%save current needle pose
posNeedleCur=retraceNeedlePoseLine(needleTraj,rotAbsolute);
posNeedleCurMod=posNeedleCur;

%% set parameters
%minimum radius
Rmin=50; %mm

%insertion step size
insDepth=3; %mm

%pathplanning
disp('the path to be followed');
disp(Goal);
%plot start and goal
% figure(1);hold on;
% plot3(needleTraj(1,end),needleTraj(2,end),needleTraj(3,end),'go');
% plot3(Goal(1,end),Goal(2,end),Goal(3,end),'go');


% check if target is possible with this given minimum radius and target.
if checkIfPossible(posNeedleCur,Goal(1:3,end),Rmin)==0
    warning('This needle insertion is not possible with the given target/radius');
    return
end

%% IN CASE OF AN NESSESARY ABORT!  %%## what is the backup? any tricks in code that can be uncommented? 
% load('backup.mat');
%save('backup.mat');
disp(posNeedleCur);
disp('Press a button to start!');
pause

%% Create (sub)folders and filenames to save the .csv data
C=clock;
foldername=['Experiments_Date_',num2str(C(1)),'_',num2str(C(2)),'_',num2str(C(3))];
foldername2=['Experiment_Simulation_time_',num2str(C(4)),'_',num2str(C(5))];
filename=['_',date,'_time_',num2str(C(4)),'_',num2str(C(5)),'.csv'];

mkdir(foldername);
mkdir(foldername,foldername2);

%memory preallocation for speed and reset counters
dataCounter1=0;    %%## what's the dataCounter? not used? 
dataCounter2=1;
needleDataModClosed=[];
needleDataTrack=needleTraj;
parameters=[];

%% Create initial .csv files
dlmwrite([foldername,'/',foldername2,'/','InitialPosition',filename],posNeedleCur(:)', '-append');
dlmwrite([foldername,'/',foldername2,'/','Track',filename],needleTraj', '-append');
dlmwrite ([foldername,'/',foldername2,'/','Model',filename], needleDataModClosed', '-append');
dlmwrite ([foldername,'/',foldername2,'/','parameters',filename], parameters, '-append');
dlmwrite ([foldername,'/',foldername2,'/','Goal',filename], Goal', '-append');
grid on
% PlotObstacles(path,obstacleDimension,phantomDimension)
%run until target is reached
while needleDataTrack(1,end)<Goal(1,end)-1
    % clear screen
    clc;
    grid on
    % if target is closer than insertiondepth change insertiondepth
    if Goal(1,end)-needleDataTrack(1,end)<insDepth;
        insDepth=Goal(1,end)-needleDataTrack(1,end);
    end
    
    % Set next target point if multiple goals
    NGoal=nextPath(needleDataTrack(1,end),Goal);%spline3d(insDepthAbsolute+insdepth,posNeedle,[eye(3),Goal;0,0,0,1]);
    
    % Calculate Parameters
    [radIdeal,theta_d,l]=findParameters(posNeedleCur,NGoal,Rmin,insDepth);
    
    %convert rad to alpha
    [alpha,rad]=useLookup(radIdeal,'CURVLookup.csv');
    
    % set absolute parameters                   
    rotAbsolute=mod(rotAbsolute+theta_d,360);
    insDepthAbsolute=insDepthAbsolute+l;
    
    % save parameters
    parameters=[alpha,radIdeal,rotAbsolute,insDepthAbsolute,needleDataTrack(1,end),rad];
    dlmwrite ([foldername,'/',foldername2,'/','parameters',filename], parameters, '-append');
    
    disp('rotating to angle');
    % rotate to correct angle first:
    pause(0.005);
    disp('Done');
    disp('sending all parameters');
    disp([alpha,rotAbsolute,insDepthAbsolute]);

    disp('inserting needle');
    % wait until needle does not move anymore
    %request needle track
    
    for k=1:stepsMod
        posNeedleCurMod=NeedleModelBicycle(posNeedleCurMod,Rmin,theta_d,insDepth/stepsMod);
        theta_d=0;
        posNeedleRob(:,k)=posNeedleCurMod(1:3,end);
    end
    needleTraj=posNeedleRob;
    
    %save needle track
    dlmwrite([foldername,'/',foldername2,'/','Track',filename],needleTraj', '-append');
    needleDataTrack=[needleDataTrack,needleTraj];

    
    pause(0.1);
    disp('insertion done');
    disp('current needle position');
    disp(needleDataTrack(:,end));
    
    % get current needle pose from recorded data
    posNeedleCur=retraceNeedlePoseLine(needleDataTrack,rotAbsolute);
    
    %update needle model with measured needle position
    posNeedleMod1=posNeedleCur;
    
    %use needle model
    posNeedleMod2=NeedleModelBicycle(posNeedleMod1,Rmin,theta_d,l);
    
    needleDataModClosed(:,2)=posNeedleMod2(:);  %%## Mod1 is current estimated needle pose with actual tracking data; Mod2 is the predicated with unicycle model 
    needleDataModClosed(:,1)=posNeedleMod1(:);
    
    % save model data
    dlmwrite([foldername,'/',foldername2,'/','Model',filename], needleDataModClosed', '-append');
       
    %plot current position (model and measured)
    figure(2);cla;
    plot3(needleDataModClosed(13,:),needleDataModClosed(14,:),needleDataModClosed(15,:),'ko'); hold on;
    plot3(needleDataTrack(1,:),needleDataTrack(2,:),needleDataTrack(3,:),'g.');hold on;
    plotFromPose3d(posNeedleCur);hold on;
    plot3(Goal(1,:),Goal(2,:),Goal(3,:),'xr');
    axis image
    hold on
    add_obstacle(5,[15,18,100],'r',0.5,3);
    add_obstacle(5,[25,36,125],'r',0.5,3);
    add_obstacle(10,[20,22,170],'r',0.5,3);
    add_cube(10,[15,18,100],'k',0.2);
    add_cube(10,[25,36,125],'k',0.2);
    add_cube(20,[20,22,170],'k',0.2);



end


% show quick results
clc;
disp('Done!');
disp('last known position');
disp(needleDataTrack(1:3,end));
disp('target point: ');
disp(Goal);
disp('absolute difference: ');
error=norm((needleDataTrack(:,end)-Goal(1:3,end)));
disp(error);
% % reward when error is below 1 mm.
% if error<1;
%     reward;
% end

% end
disp('done!, time taken:');
timeTaken=toc(timer);
disp(timeTaken);

dlmwrite ([foldername,'/',foldername2,'/','Time',filename], timeTaken, '-append');