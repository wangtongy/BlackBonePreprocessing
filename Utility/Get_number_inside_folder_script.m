function Get_number_inside_folder_script(CT_folder, MR_folder)
    addpath('/data/anlab/TongyaoW/BlackBoneProject/Code');
    loop_thru_get_number(CT_folder,'subject_number_ct.txt');
    disp('finish getting subject number from CT_folder, subject_number_ct.txt file was created');
    loop_thru_get_number(MR_folder, 'subject_number_mr.txt');
    disp('finish getting subject number from MR_folder, subject_number_mr.txt file was created');
    
end