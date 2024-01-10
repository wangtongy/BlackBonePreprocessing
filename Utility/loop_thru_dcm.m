%%%%% ty created on 11/29/2023 %%%%%%%%%%%%%%%%%%%%
%%%%%This code is aimed to loop through %%%%%%%%%%%
%%%%%dicom folder and then write the subject%%%%%%%
%%%%%number into a txt files for the future use%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loop_thru_dcm(folder,txtname)
    cd(folder)
    fid_create = fopen(txtname,'wt');
    fclose(fid_create);
    path = dir(folder);
    dirFlags_sub = [path.isdir];% check if anything is folder, then list as flag. 
    path_all = path(dirFlags_sub);
    path_name = {path_all(3:end).name};
    for i = 1:length(path_name)
        single_subject = path_name{i};
        if strcmp(single_subject(1:3),'RSB')
            subject_number_final = single_subject(5:7);
        else 
            subject_number_final = single_subject(4:5);
        end
            fid = fopen(txtname,'at');
            fprintf(fid,'%s\n',subject_number_final);
            fclose(fid);
    end
end