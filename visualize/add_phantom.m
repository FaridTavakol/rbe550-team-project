function [] = add_phantom()

    x = 50;    y = 50;      z = 600;
    xc = x/2;   yc = y/2;   zc = z/2;
    draw_cube([x y z], [xc, yc, zc], 'b', 0.1);
    
    % Graph Styling
    axis equal;
    % len = n*1.2;
    % axis([0 20 0 20 0 600]);
    daspect([1 1 1]);
    grid on;
    xlabel('x');
    ylabel('y');
    zlabel('z');
end

