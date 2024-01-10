%% Loop thru all things
function loop_thru_get_number(path,txtname)
%path = '/data/anlab/TongyaoW/BlackBoneProject/MRI_Data/SB';
    cd(path)
    all_name = dir(path);
    fid_create = fopen(txtname,'wt');
    fclose(fid_create);
    for i = 3:length(all_name)
        single_subject = all_name(i).name;
        if strcmp(single_subject(end-8:end),'ct.nii.gz') == 1
            subject_number = regexp(single_subject,'[\d]+','match');
            subject_number_final = subject_number{1};
            fid = fopen(txtname,'at');
            fprintf(fid,'%s\n',subject_number_final);
            fclose(fid);
        else
            continue
        end
    end
    
end