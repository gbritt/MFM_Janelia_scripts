function [img,metadata] = readnd22(filename,pathname)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if ~iscell(filename)
    filename = {filename};
end

for a = 1:length(filename)
    data = bfOpen3DVolume([pathname filename{a}]);
    data1 = data{1};
    img = data1{1}; clear data1;
    omeMeta = data{1,4};
end
numframes = size(img,3);
metadata = zeros(numframes,5);

for b = 0:(numframes-1)
    metadata(b+1,1) = b;
    try
        metadata(b+1,2) = double(omeMeta.getPlanePositionX(0,b));
    catch
    end
    
    try
        metadata(b+1,3) = double(omeMeta.getPlanePositionY(0,b));
    catch
    end
    
    try
        metadata(b+1,4) = double(omeMeta.getPlanePositionZ(0,b));
    catch
    end
    
    try
        metadata(b+1,5) = double(omeMeta.getPlaneDeltaT(0,b));
    catch
    end
end

