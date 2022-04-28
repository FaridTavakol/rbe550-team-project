function [ coord ] = robotToNeedle( coord )
% transforms RAS coordinates (as used by MRI or robot) to xyz coordinates
% as used by the parameter calculating algorithm.

if size(coord)==[4,4]                        %%## for matrix? 
    T1=[[1,0,0;0,0,-1;0,1,0],[0;0;0];0,0,0,1];
    T2=[[0,0,1;0,1,0;-1,0,0],[0;0;0];0,0,0,1];
    coord=T1*T2*coord;
elseif size(coord,1)==[3]                    %%## for position only? 
    T1=[1,0,0;0,0,-1;0,1,0];
    T2=[0,0,1;0,1,0;-1,0,0];
    for k=1:size(coord,2)
        coord(:,k)=T1*T2*coord(:,k);
    end
end

end

