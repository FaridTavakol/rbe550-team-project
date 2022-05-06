function modelledPathFromParameters=recreatePathUsingParameters(parameters,posNeedle0,Rmin)

    modelledPathFromParameters=NaN(16,size(parameters,2));
    modelledPathFromParameters(:,1)=posNeedle0(:);
    needleRad=Rmin*ones(size(parameters(2,:)));
    theta=[parameters(3,1:end)]-[0,parameters(3,1:end-1)];
    insDepth=[parameters(4,1:end)]-[0,parameters(4,1:end-1)];
    
for k=2:length(parameters)
    modelledPathFromParameters(:,k)=reshape(NeedleModelBicycle(reshape(modelledPathFromParameters(:,k-1),4,4),needleRad(k-1),theta(k-1),insDepth(k-1)),[],1);
end

end