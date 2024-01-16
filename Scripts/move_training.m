function move_training(input_folder,training_folder,subject_list)
if ~exist(training_folder)
    mkdir(training_folder);
end
cd(input_folder);
for i = 1:length(subject_list)
    file_name = sprintf('%s/%s_ct.nii.gz',input_folder,subject_list{i});
    file_mr =  sprintf('%s/%s_r1.nii.gz',input_folder,subject_list{i});
    file_mk = sprintf('%s/%s_mk.nii.gz',input_folder,subject_list{i});
    if ~exist(file_name,'file')
        fprintf('missing: %s \n',file_name);
        continue
    end
    if ~exist(file_mr,'file')
        fprintf('missing: %s \n',file_mr);
        continue
    end
    
    if ~exist(file_mk,'file')
        fprintf('missing: %s \n',file_mk);
        continue
    end
    copyfile(file_name,training_folder);
     copyfile(file_mr,training_folder);
     copyfile(file_mk,training_folder);
end
    
    