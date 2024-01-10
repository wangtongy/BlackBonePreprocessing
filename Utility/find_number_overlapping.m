function find_number_overlapping(txtfilepath,CT_folder_txt, MR_folder_txt)
    fid_create = fopen(txtfilepath,'wt'); %create a txt
    fclose(fid_create);
    ct_subject_number = load_names(CT_folder_txt); 
    disp('finish loading ct subject number from txt file');
    mr_subject_number =  load_names(MR_folder_txt);% load MR subjects names
    disp('finish loading mr subject number from txt file');
    for i=1:length(ct_subject_number)
        for j = 1:length(mr_subject_number)
            if ct_subject_number{i} == mr_subject_number{j}
                fid = fopen(txtfilepath,'at');
                fprintf(fid,'%s\n',ct_subject_number{i});
                fclose(fid);
            else
                continue
            end
        end 
    end
end