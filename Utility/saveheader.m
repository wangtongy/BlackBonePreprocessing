addpath('/data/anlab/TongyaoW/ParnaMR2CT prep/');
subject = {'010','37','044','060'};
number_list = 1:20:171;
number_list2 = 171:2:203; 
last = 204;
list = [number_list,number_list2,last];
addpath('/data/anlab/TongyaoW/BlackBoneProject/Matlab_NIFTI_IO/');
parpool(10);
parfor i = 1:length(subject)
    for j = 1:length(list)
       ctheader = niftiinfo(sprintf('/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/validation/%s_ct.nii.gz',subject{i}));
    
       mr = sprintf('/bmrc-homes/nmrgrp/nmr180/TongyaoW/Over_bone_over_weight/validation_g1_20230903/model_%d/%s_qt.nii.gz',list(j),subject{i});
       mr_img = niftiread(mr);
       mr_img = single(mr_img);
       niftigzwrite(mr_img,mr,ctheader);
    end
end
cd '/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/Ants/Uncertainty';
list = [4,6];
list2 = 23:49;
list3 = [list,list2];
for i = 1:length(list3)
   cpath = sprintf('/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/Ants/Uncertainty/%d',list3(i));
   cd(cpath);

   mr = '064_qt.nii.gz';
   if ~exist(mr,'file')
       disp('no mr');
   end
   mr_img = niftiread(mr);
   mr_img = single(mr_img);
   niftigzwrite(mr_img,mr,ctheader);
end
imgarray = zeros(49,720,722,393);
imgarray = single(imgarray);
for i = 1:49
    cpath = sprintf('/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/Ants/Uncertainty/%d',i);
    cd(cpath);
    img = niftiread('064_qt.nii.gz');
    imgarray(i,:,:,:) = img;
end

imgnewarray = zeros(29,720,722,393);
list = [20,21];
list2 = 23:49;
list = [list,list2];
for i = 1:length(list)
    imgnewarray(i,:,:,:) = imgarray(list(i),:,:,:);
end