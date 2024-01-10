function copy_ct_header(input_folder,output_folder,subject_list,ext)

    for i = 1:length(subject_list)
        ct = sprintf('%s/%s_nonorm_ct.nii.gz',input_folder,subject_list{i});
        target = sprintf('%s/%s_%s.nii.gz',output_folder,subject_list{i},ext);
        info_ct = niftiinfo(ct);
        target_img = niftiread(target);
        target_img  = single(target_img);
        niftigzwrite(target_img,target,info_ct);
    end
end