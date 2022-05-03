function [posNeedle2]=bicycleKinematicsOneIteration(posNeedle,needleRad,theta,insDepth)

theta=theta/180*pi;
e1=[0;1;0];
e3=[1;0;0];
kappa=1/needleRad;
V1=[e3;kappa*e1];
V2=[zeros(3,1);e3];
l2=0;%10.33;


u1=insDepth;
u2=theta;

needleFrame=posNeedle;
needleFrame(1:3,end)=posNeedle(1:3,end)-posNeedle(1:3,1:3)*l2*e3;
needleFrame2= needleFrame*expSE3((u1*toLieSE3(V1)+u2*toLieSE3(V2)));
posNeedle2=needleFrame2;
posNeedle2(1:3,end) = needleFrame2(1:3,1:3)*l2*e3 + needleFrame2(1:3,end);



end