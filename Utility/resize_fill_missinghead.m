%% 
addpath('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Matlab_NIFTI_IO');

resize_name = '//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/3D_Dataset/CT_Dicom/049_dcm.nii.gz';
folder = '//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/3D_Dataset/CT_Dicom/before_resize';
ct_SB_14 = niftiread(resize_name);
ctinfo = niftiinfo(resize_name);
copyfile(resize_name,folder)
ct_new = zeros(512,512,592);
ct_new = single(ct_new);
ct1new = ct_new;
ct1new(:,:,1:453) = ct_SB_14(:,:,140:592);
ct1new(:,:,454:592) = 0;
ctinfo.Datatype = 'single';
niftigzwrite(ct1new,resize_name,ctinfo);


files = dir('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/RSB_3D_Paul/MR_mask');
names = {files.name};
cd('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/RSB_3D_Paul/MR_mask')
for i = 3:length(names)
    first = names{i}(1:3);
    second = names{i}(end-9:end);
    new_name = strcat(first,'_r1',second);
    old = names{i};
    if ~exist(new_name)
        movefile(old,new_name);
    end
end
    