function copy_file(folder_in, destination,subject_list,ext)
if ~exist(destination,'file')
    mkdir(destination);
end
for i = 1:length(subject_list)
        filesmk = sprintf('%s/%s_%s.nii.gz',folder_in,subject_list{i},ext);
        if ~exist(filesmk,'file')
            fprintf('does not exist %s \n',filesmk);
            continue
        end
        copyfile(filesmk,destination);
    
end