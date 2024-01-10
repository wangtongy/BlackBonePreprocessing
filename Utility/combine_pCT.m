function combine_pCT(folder,subject_list)

addpath(genpath('/data/anlab/TongyaoW/BlackBoneProject/Preprocessing'));
subject_len = length(subject_list);
for i = 1:subject_len
    pCT_BA = niftiread(sprintf('%s/%s_BA_new.nii.gz',folder,subject_list{i}));
    pCT_WH = niftiread(sprintf('%s/%s_WH_new.nii.gz',folder,subject_list{i}));
    pCT_BM = niftiread(sprintf('%s/%s_BM.nii.gz',folder,subject_list{i}));
    %pCT_bone =niftiread(sprintf('%s/%s_weight.nii.gz',folder,subject_list{i}));
%      pCT_bone(pCT_bone == 10) = 0;
    pCT_comb = pCT_BA.*(1-pCT_BM) + pCT_WH.*pCT_BM;
    pCT_comb = double(pCT_comb);
    info = niftiinfo(sprintf('%s/%s_ct.nii.gz',folder,subject_list{i}));
    info.Datatype = 'double';
    out = sprintf('%s/%s_pCT_new.nii.gz',folder,subject_list{i});
    niftigzwrite(pCT_comb,out,info);
end