
function get_levelset_mask(folder, subject_list,ext)
      % Needed to run the levelset command
    addpath('/data/anlab/TongyaoW/BlackBoneProject/Preprocessing/Matlab_NIFTI_IO/');  
    addpath(genpath('/data/anlab/TongyaoW/BlackBoneProject/Preprocessing/Utility'));
    
%     poolobj = parpool(5);
    for i = 1:length(subject_list)
        tic
        fprintf('\nStarting levelset\n');
        name_in = sprintf('%s/%s_%s.nii.gz',folder,subject_list{i},ext);
        name_mk = sprintf('%s/%s_%s_mk.nii.gz',folder,subject_list{i},ext);
        if ~exist(name_in,'file')
            continue 
        end
        Head_mask(name_in,name_mk);
        toc
    end
%      delete(poolobj);
end
