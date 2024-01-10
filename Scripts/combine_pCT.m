function combine_pCT(folder,subject_list)
parfor i = 1:length(subject_list)
    WH = sprintf('%s/%s_WH.nii.gz',folder,subject_list{i});
    BA = sprintf('%s/%s_BA.nii.gz',folder,subject_list{i});
    BM = sprintf('%s/%s_BM.nii.gz',folder,subject_list{i});
    if ~exist(WH,'file') | ~exist(BM,'file') | ~exist(BA,'file')
        continue
    end
    info = niftiinfo(WH);
    WH_img = niftiread(WH);
    BA_img = niftiread(BA);
    BM_img = niftiread(BM);

    combine_pCT = WH_img.*BM_img + BA_img.*(1-BM_img);
    out = sprintf('%s/%s_comb_pCT.nii.gz',folder,subject_list{i});
    niftigzwrite(combine_pCT,out,info);
end



