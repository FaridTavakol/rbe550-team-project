function flag=checkIfPossible(posNeedle,target,R)
% Check if a single target is feasible, given a needle pose, target position and
% minimum radius R. Assumes circular path.
%
% flag = 1 if feasible target.

% homogenous transformation of target to needle frame
target=posNeedle^-1*[eye(3),target(1:3,end);0,0,0,1];

% Calculate insertion depth needed to get to target
insDepth=target(1,end);
% Calculate total deflection needed to get to target %%## how to get the
% deflection? 
deflection=norm(target(2:3,end));
% Calculate y-coordinate of circle with minimum radius
Y=sqrt(R.^2-insDepth.^2);
% compare deflection of target with deflection of perfect circle
flag=abs(Y-R)>=deflection;

end