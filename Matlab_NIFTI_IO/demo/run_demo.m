

%% Try save directly...
clear;clc;
fileIn = '.\\WSH001_MR1_dti.nii.gz';
imgIn = niftiread(fileIn);
infoIn = niftiinfo(fileIn);
fileOut = '.\\WSH001_MR1_dti_resave.nii.gz';
niftiwrite(imgIn,fileOut,infoIn); %% write to an "un-zipped" .nii.nii not good
niftigzwrite(imgIn,fileOut,infoIn); %% good to use

%% Cast to double 
clear;clc;
fileIn = '.\\WSH001_MR1_dti_resave.nii.gz';
fileOut = '.\\WSH001_MR1_dti_resave_double.nii.gz';
imgIn = double(niftiread(fileIn));
infoIn = niftiinfo(fileIn);
niftigzwrite(imgIn,fileOut,infoIn); %% Data type does not mat
infoIn.Datatype = 'double';
niftigzwrite(imgIn,fileOut,infoIn); %% Data type does not match...

%% Single frame
clear;clc;
fileIn = '.\\WSH001_MR1_dti_resave_double.nii.gz';
fileOut = '.\\WSH001_MR1_dti_0.nii.gz';
save_single_frame_from_4d(fileIn,fileOut,1)