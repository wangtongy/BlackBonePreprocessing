function Head_mask(name_in, name_mk)

fprintf('\n %s \n',name_in);
levelset = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Preprocessing/bin/levelset %s %s -b', name_in, name_mk);
system(levelset);
clear levelset;

nii = niftiread(name_mk);
info = niftiinfo(name_in);
I1 = find(nii>.5);
I0 = find(nii<=0.5);
nii(I1) = 1;
nii(I0) = 0;

mk = single(imfill_3d_3views(nii));

info.Datatype = 'single';

niftigzwrite(mk,name_mk, info)
fprintf('completed');

clear nii mk;