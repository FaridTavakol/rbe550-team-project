function [] = draw_cube(len, center, color, transparency)
%DRAW_CUBE Summary of this function goes here
%   Detailed explanation goes here
% len = [x y z]
    
    center = [center
              center
              center
              center];
    
    front = [0 0 0
             0 0 1
             1 0 1
             1 0 0];
    front = front - 0.5;
    back = front;
    back(:,2) = back(:,2) + 1;
    
    bottom = [0 0 0
              1 0 0
              1 1 0
              0 1 0];
    bottom = bottom - 0.5;
    top = bottom;
    top(:,3) = top(:,3) + 1;
    
    left = [0 0 0
            0 1 0
            0 1 1
            0 0 1];
    left = left - 0.5;
    right = left;
    right(:,1) = right(:,1) + 1;
    
    % Scaling cube 
    front = front.*len;     back = back.*len;
    bottom = bottom.*len;   top = top.*len;
    left = left.*len;       right = right.*len;
    
    % Moving cube
    front = front + center;     back = back + center;
    bottom = bottom + center;   top = top + center;
    left = left + center;       right = right + center;
    
    % Plotting
    hold on;    
    view(3);
    t = transparency;
    fill3(front(:,1), front(:,2), front(:,3), color, 'FaceAlpha',t);
    fill3(back(:,1), back(:,2), back(:,3), color, 'FaceAlpha',t);
    fill3(bottom(:,1), bottom(:,2), bottom(:,3), color, 'FaceAlpha',t);
    fill3(top(:,1), top(:,2), top(:,3), color, 'FaceAlpha',t);
    fill3(left(:,1), left(:,2), left(:,3), color, 'FaceAlpha',t);
    fill3(right(:,1), right(:,2), right(:,3), color, 'FaceAlpha',t);

end

