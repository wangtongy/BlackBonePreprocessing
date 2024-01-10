%% dilate
function dilate_mk(input,output,subject_list)
    for i = 1
        tic
        mk_02 = sprintf('%s/%s_r1_mk.nii.gz',input,subject_list{i});
        if ~exist(mk_02,'file')
            continue
        end
        out = sprintf('%s/%s_r1_mk.nii.gz',output,subject_list{i});
        if exist(out,'file')
            continue
        end
        mask = niftiread(mk_02);
        mask_info = niftiinfo(mk_02);
        se = strel('sphere',32);
        new_mask = imdilate(mask,se);
        niftigzwrite(new_mask,out,mask_info);
        toc
    end
end