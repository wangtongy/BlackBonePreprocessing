
function get_levelset_mask(folder, subject_list)
      % Needed to run the levelset command
    addpath('/data/anlab/TongyaoW/BlackBoneProject/Matlab_NIFTI_IO/');  
    addpath(genpath('/data/anlab/TongyaoW/BlackBoneProject/Preprocessing/Utility'));

    for i = 1:length(subject_list)
        tic
        fprintf('\nStarting levelset\n');
        name_in = sprintf('%s/%s_correction_MR.nii.gz',folder,subject_list{i});
        name_mk = sprintf('%s/%s_r1_mk.nii.gz',folder,subject_list{i});
        name_ct = sprintf('%s/%s_nonorm_ct_low.nii.gz',folder,subject_list{i});
        name_ct_mk = sprintf('%s/%s_ct_mk.nii.gz',folder,subject_list{i});
        if ~exist(name_in,'file')
            continue 
        end
        Head_mask(name_in,name_mk);
        Head_mask(name_ct,name_ct_mk);
        toc
    end
end
