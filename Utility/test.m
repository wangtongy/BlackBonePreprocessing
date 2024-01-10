
subject_whole = load_names('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/ToAndrew/Training_testing_20231204.txt');
addpath('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Preprocessing/Scripts/');
addpath('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Matlab_NIFTI_IO/');

ct_folder = '//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/ToAndrew/CT_mk';
for i = 1:length(subject_whole)
    if length(subject_whole{i}) == 2
        ct_mk = sprintf('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/SB_3D_Data/CT_mask/0%s_mk.nii.gz',subject_whole{i});
        if exist(ct_mk,'file')
            change_new = sprintf('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/SB_3D_Data/CT_mask/%s_mk.nii.gz',subject_whole{i});
            movefile(ct_mk,change_new);
        else
            fprintf('\n subject_number:%s \n ',subject_whole{i});
            continue
        end
    elseif length(subject_whole{i})==3
        change_new = sprintf('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/RSB_3D_Paul/%s_mk.nii.gz',subject_whole{i});
    end
    
    if exist(change_new,'file')
        copyfile(change_new,ct_folder);
    else 
        fprintf('\n subject_number:%s \n ',subject_whole{i});
        continue
    end
end

keep_only_largest_region(ct_folder,subject_whole,'mk');
