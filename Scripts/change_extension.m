function change_extension(folder, inext, outext,subject_list)
for i = 1:length(subject_list)
    file = sprintf('%s/%s_%s.nii.gz',folder,subject_list{i},inext);
    outfile = sprintf('%s/%s_%s.nii.gz',folder,subject_list{i},outext);
    if exist(outfile,'file') 
        fprintf('exist %s \n',outfile);
        continue 
    end
    if ~exist(file,'file')
        fprintf('donot exist %s \n',file);
        continue
    end
    movefile(file,outfile);
end