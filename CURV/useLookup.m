function [ alpha,radout ] = useLookup(rad,filename)
% Uses a lookup table to find the closest corresponding value alpha to a
% desired radius. To be used with CURV algorithm.
% 
% [alpha,rad] = useLookup(rad,filename) compares the data in the .csv file
% 'filename' with the desired radius rad. Outputs the value alpha and the
% predicted resulting radius radout.
% 
% - first column of 'filename.csv' should contain the alpha values
% corresponding with the radii in the second column.
% 
% See also: CURVLookup.csv

% Copyright: Tim van Katwijk, t.vankatwijk@student.utwente.nl
% Date: 2014/30/09    
% University of Twente, Netherlands & 
% Worcester Polytechnic Institute, United States

M=csvread(filename);
[~,ind]=min(abs(M(:,2)-rad));
alpha=M(ind,1);
radout=M(ind,2);
end

