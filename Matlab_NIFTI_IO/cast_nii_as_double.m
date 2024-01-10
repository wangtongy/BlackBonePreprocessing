%% Cast nifti as double (from int16)

%% History

%% 2022/09/23 Chunwei
    %% Create file


function cast_nii_as_double(fileName)

infoNow = niftiinfo(fileName);
infoNow.Datatype = 'double';
img = double(niftiread(fileName));
niftigzwrite(img,fileName,infoNow);
