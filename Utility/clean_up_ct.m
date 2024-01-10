function clean_up_ct(folder,mk_folder,subject_list,ext)
addpath('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Matlab_NIFTI_IO');
for i = 1:length(subject_list)
    old_ct = sprintf('%s/%s_%s.nii.gz',folder,subject_list{i},ext);
    if ~exist(old_ct)
        continue 
    end
    ct = niftiread(old_ct);
    info = niftiinfo(old_ct);
    mk = niftiread(sprintf('%s/%s_mk.nii.gz',mk_folder,subject_list{i}));
    new = ct;
    new(mk==0) = -1000;
    % old ct into a new folder
    new_folder = sprintf('%s/before_cleanup',folder);
    if ~exist(new_folder,'dir')
        mkdir(new_folder);
    end
    movefile(old_ct,new_folder);
    niftigzwrite(new,old_ct,info);
end
    
