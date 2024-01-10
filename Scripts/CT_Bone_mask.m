function CT_Bone_mask(folder, subject_list)
%%%%Input %%%%%%%
%folder: folder that saved images; subject_list: subject_id;
%This function will create three files: segmentation mask: xxx_seg_mk.nii.gz
% weighted bone mask (bone 10, rest 1): xxx_weighted_bone_mk.nii.gz
% CT with no holder in the background: xxx_nonorm_ct.nii.gz
%%%%%%%%%%%%%%%%
addpath('/data/anlab/TongyaoW/BlackBoneProject/Preprocessing/Utility');
poolobj = parpool(7);
parfor i = 1:length(subject_list)
    tic
    in = sprintf('%s/%s_nonorm_ct.nii.gz',folder,subject_list{i});
    hd_mk = sprintf('%s/%s_mk.nii.gz',folder,subject_list{i});
    hd_bone = sprintf('%s/%s_seg_mk.nii.gz',folder,subject_list{i});
    if ~exist(in,'file')|~exist(hd_mk,'file')
        continue
    end
    ct_img = niftiread(in);
    mk_img = niftiread(hd_mk);
    info = niftiinfo(in);
    ct_no_holder = ct_img;
    ct_no_holder(mk_img ~= 1) = -1024; 
    niftigzwrite(ct_no_holder,in,info);
    
    gen_k3_no_initialization(ct_no_holder,mk_img,info, hd_bone);

    CT_bone = niftiread(hd_bone);
    info = niftiinfo(hd_bone);

    weight = CT_bone;
    weight(CT_bone~=3) = 1;
    weight(CT_bone==3) = 10;
    weight_out = sprintf('%s/%s_weighted_bone_mk.nii.gz',folder,subject_list{i});
    niftigzwrite(weight,weight_out,info);
    toc
end
delete(poolobj);
end