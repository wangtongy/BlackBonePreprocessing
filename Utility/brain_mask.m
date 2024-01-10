function brain_mask(folder, subject_list)

num_all = length(subject_list);
for i = 1:num_all
    in = sprintf('%s/%s_brain.nii.gz',folder,subject_list{i});
    out =sprintf('%s/%s_bm.nii.gz',folder,subject_list{i});
    in_img = niftiread(in);
    info = niftiinfo(in);
    mask = in_img;
    mask(in_img ~=0) = 1;
    niftigzwrite(mask,out,info);

end
end