function skull_stripped(folder,subject_list)

num_all = length(subject_list);
parfor i = 1:num_all
    in = sprintf('%s/%s_nonorm_r1.nii.gz',folder,subject_list{i});
    if ~exist(in,'file')
        continue 
    end
    out = sprintf('%s/%s_brain.nii.gz',folder,subject_list{i});
    b2 =  sprintf('bet %s %s',in,out);
    system(b2);
    img_out = niftiread(out);
    info = niftiinfo(in);
    img_out_new = img_out;
    img_out_new(img_out ~= 0) = 1;
    img_out_new = single(img_out_new);
    niftigzwrite(img_out_new,out,info);
end
end