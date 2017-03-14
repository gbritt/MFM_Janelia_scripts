function mosaicspt(pathname,filelist,radius,score,thresh,link,displace,minlength,objmag,d,process,rollingrad,gaussrad)
%%
os = computer;

try
    MIJ.exit
catch
end

try
    Miji;
catch
    fijipath = uigetdir(pwd,'FIJI is not added to the search path.  Specify location of Fiji Scripts Folder');
    addpath(fijipath);
    try 
        Miji;
    catch
        error('MIJI not installed/configured.  See http://bigwww.epfl.ch/sage/soft/mij/ for details');
    end
end

cd(pathname);

switch os
    case {'PCWIN64','PCWIN32'}
        mkdir(fullfile(pwd,'temp'));
    case {'GLNXA64','GLNXA32','MACI64','MACI32'}
        mkdir(fullfile(pwd,'temp'));
end

numfiles = length(filelist);
xypixel = 16/objmag*150/200;
%%
for a = 1:numfiles
    %%
    mkdir(fullfile(pwd,'temp'));
    currfile = filelist{a};
    img = uint16(h5import2(pathname,currfile));
    [~,filepart] = fileparts(currfile);
    timepoints = size(img,4);
    img = reshape(img,size(img,1),size(img,2),size(img,3)*size(img,4));
    disp('Exporting to FIJI...')
    MIJ.createImage(img);
    txt = ['order=xyczt(default) channels=1 slices=9 frames=' num2str(timepoints) ' display=Grayscale'];
    MIJ.run('Stack to Hyperstack...',txt);
    txt3 =  ['channels=1 slices=9 frames=' num2str(timepoints) ' unit=micrometer pixel_width=' num2str(xypixel) ' pixel_height=' num2str(xypixel) ' voxel_depth=' num2str(d/1000)];
    MIJ.run('Properties...',txt3);
    if process
        MIJ.run('Subtract Background...', ['rolling=' num2str(rollingrad) ' stack']);
        MIJ.run('Gaussian Blur...', ['sigma=' num2str(gaussrad) ' stack']);
        MIJ.run('Save',['save=[' fullfile(pathname,[filepart '_preprocessed.tif']) ']']);
    else
        txt1 = ['save=[' fullfile(pwd,'temp','temp.tif') ']'];
        MIJ.run('Save',txt1);        
    end 
    disp('Performing Mosaic 3D SPT...')
    txt2 = ['radius=' radius ' cutoff=' score ' per/abs=' thresh ' link=' link ' displacement=' displace ' dynamics=Brownian'];
    MIJ.run('Particle Tracker 2D/3D', txt2); 
    disp([filelist{a} ' Done!'])
    if process
        mosaicfile = fullfile(pathname, ['Traj_' filepart '_preprocessed.tif.csv']);
    else
        mkdir(pwd,'temp');
        mosaicfile = fullfile(pwd,'temp','Traj_temp.tif.csv');
    end
    tracks = csv2tracks(mosaicfile,minlength,objmag,d); %#ok<NASGU>
    filesave2 = [filepart '_particletracks.mat'];
    save(fullfile(pathname,filesave2),'tracks');
    if ~process
        filesave = [filepart '_MOSAICdata.csv'];
        movefile(mosaicfile,fullfile(pathname,filesave));
        delete(fullfile(pwd,'temp','*'));
        %rmdir(fullfile(pwd,'temp'));
    end
    MIJ.run('Close')
end

