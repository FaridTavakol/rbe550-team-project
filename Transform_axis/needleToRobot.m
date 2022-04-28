function [ coord ] = needleToRobot( coord )
% transforms xyz coordinates (as used by parameter calculating algorithm) to RAS coordinates
% as used by MRI or robot

if size(coord)==[4,4]
    T1=[[1,0,0;0,0,1;0,-1,0],[0;0;0];0,0,0,1];
    T2=[[0,0,-1;0,1,0;1,0,0],[0;0;0];0,0,0,1];
    coord=T2*T1*coord;
elseif size(coord,1)==[3]
    T1=[1,0,0;0,0,1;0,-1,0];
    T2=[0,0,-1;0,1,0;1,0,0];
    for k=1:size(coord,2)
        coord(:,k)=T2*T1*coord(:,k);
    end
end

end

