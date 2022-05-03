function [NextP] = nextPath(Pt2,Path)
% picks the next path point to follow. Assuming needle is continous along
% x-axis.
% Pt2 = coordinates of needle tip [3,1];
% Path = path coordinates [3,n];
% NextP = Coordinates of pathpoint to be followed

n=size(Path,2);
while Pt2(1,end)<Path(1,n)
    n = n-1;
    if n==0
        break
    end
end
n=n+1;

if n~=1 && Pt2(1,end) > Path(1,end-1)
    n = size(Path,2);
end

NextP = Path(:,n);
end