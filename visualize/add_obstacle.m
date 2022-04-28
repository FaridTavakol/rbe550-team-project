function [] = add_obstacle(r, center, color, transparency)
%DRAW_CUBE Summary of this function goes here
%   Detailed explanation goes here

    xc = center(1); yc = center(2); zc = center(3); % the center of sphere
    [X,Y,Z] = sphere();

    % Scale the sphere
    X = X * r;
    Y = Y * r;
    Z = Z * r;
    
    % Move the sphere
    X = X + xc;
    Y = Y + yc;
    Z = Z + zc;

    % Draw obstacle
    t = transparency;
    hold on;
    view(3);
    surf(X,Y,Z, 'FaceColor', color, 'FaceAlpha', t);
    shading interp; 
end

