
Low_Center_folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/low_ct';
Low_Norm_folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/low_ct/Normalized';
%% Registration
Registration_CT2MR(Dcm_ct_Folder,Center_folder,Low_Center_folder,resize_subject,12,'mutualinfo');

%% create ct and mr mk; 

training_1 =load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/WH/training_g1.txt');
get_levelset_mask(Low_Center_folder,training_1);
%% Normalized ct and mr
normalize_images_in_dir_ct(Low_Center_folder,Low_Norm_folder,training_1,'ct','low_g1');
normalize_images_in_dir_mr(Low_Center_folder,Low_Norm_folder,training_1,'r1',2);
%% get intersection

Intersection_mask(Low_Center_folder, Low_Norm_folder,training_1);
