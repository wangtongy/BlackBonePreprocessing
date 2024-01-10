%% copy file into folder; then change name in that folder to mr_dcm;
path = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset';
addpath(genpath('/data/anlab/TongyaoW/BlackBoneProject/Preprocessing'));
subject_number_mr = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/ToAndrew/move_header.txt');
parpool(15);
parfor i = 1:length(subject_number)
    old_dcm = sprintf('%s/Old/MRI_Data',path);
    old_name = sprintf('MRI%s.nii.gz',subject_number{i});
    new_dcm = sprintf('%s/MRI_Dicom',path);
    new_name = sprintf('%s_dcm.nii.gz',subject_number{i});
    old_data = fullfile(old_dcm,old_name);
    new_data = fullfile(new_dcm,new_name);
    if ~exist(old_data,'file')
        fprintf('\n missing:MRI%s.nii.gz \n',subject_number{i});
        continue
    end
    copyfile(old_data,new_dcm);
    if exist(new_data,'file')
        fprintf('\n already exist %s_dcm.nii.gz \n',subject_number{i})
        continue 
    end
    movefile(old_data,new_data);
end