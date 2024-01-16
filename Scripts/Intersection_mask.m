function Intersection_mask(folder, folder_out, subject_list)

parfor i = 1:length(subject_list)
    ct_mk = sprintf('%s/%s_ct_mk.nii.gz',folder,subject_list{i});
    mr_mk = sprintf('%s/%s_r1_mk.nii.gz',folder,subject_list{i});
    if ~exist(ct_mk,'file')|~exist(mr_mk,'file')
        fprintf('missing %s or %s',ct_mk,mr_mk);
        continue
    end
    intersection_out = sprintf('%s/%s_mk.nii.gz',folder_out,subject_list{i});
    ct_img= niftiread(ct_mk);
    mr_img= niftiread(mr_mk);
    info = niftiinfo(ct_mk);
    index = (mr_img~=ct_img);
    new_mk = ct_img;
    new_mk(index) = 0;
    new_mk = single(new_mk);
    niftigzwrite(new_mk,intersection_out,info);
end

end