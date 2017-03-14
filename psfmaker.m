function psfdecon = psfmaker(psfs,zstepsize,d)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

midr = floor(size(psfs,1)/2);
midc = floor(size(psfs,2)/2);
midz = floor(size(psfs,3)/2);
rowalign = psfs(midr-1,midc,midz) >= psfs(midr+1,midc,midz);

if rowalign
    rows = (midr-6):(midr+5);
else
    rows = (midr-5):(midr+6);
end

psfcut = psfs(rows,:,:);
psfcut2 = psfcut - min(psfcut(:))+1;

z1 = ((1:size(psfcut2,3))-midz)*zstepsize;
x1 = 1:size(psfcut2,2); y1 = 1:size(psfcut2,1);
[xgrid1,ygrid1,zgrid1] = meshgrid(x1,y1,z1);

z2 = (-4:4)*d;
[xgrid2,ygrid2,zgrid2] = meshgrid(x1,y1,z2);
psfdecon = interp3(xgrid1,ygrid1,zgrid1,psfcut2,xgrid2,ygrid2,zgrid2);

end

