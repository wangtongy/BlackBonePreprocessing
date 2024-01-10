function move(folder_in, destination,subject_list)
if ~exist(destination,'file')
    mkdir(destination);
end
for i = 1:length(subject_list)
 
        mk = sprintf('%s_nonorm_ct.nii.gz',subject_list{i});
    %     filesr1 = sprintf('%s/%s_r1.nii.gz',folder_in,subject_list{i});
        filesmk = sprintf('%s/%s_nonorm_ct.nii.gz',folder_in,subject_list{i});
    %     copyfile(filesr1,destination);
%         new_name = sprintf('%s_nonorm_ct.nii.gz',subject_list{i});
%         new_folder = sprintf('%s/%s',destination,new_name);
%         old_folder = sprintf('%s/%s',destination,mk);
    
        copyfile(filesmk,destination);
%         movefile(old_folder,new_folder);
    
end