
Low_Center_folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/low_ct';
Low_Norm_folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/low_ct/Normalized';
validation_1 = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/WH/validation_g1.txt');
%% Registration
Registration_CT2MR(Dcm_ct_Folder,Center_folder,Low_Center_folder,resize_subject,12,'mutualinfo');

%% create ct and mr mk; 

get_levelset_mask(Low_Center_folder,training_1,'nonorm_ct_low');
get_levelset_mask(Low_Center,validation_1,'correction_MR');


%% change mask name
change_extension(Low_Center,'ct','nonorm_ct',subject_1);
change_extension(Low_Center,'correction_MR_mk','r1_mk',validation_1);

%% Normalized ct and mr
normalize_images_in_dir_ct_self(Low_Center,final_folder,subject_1,'ct',2);
normalize_images_in_dir_mr(Low_Center,Low_Norm_folder,validation_1,'r1',2);
%% get intersection

Intersection_mask(Low_Center_folder, Low_Norm_folder,training_1);
