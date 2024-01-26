%% low ct main script
Dcm_ct_Folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/CT_Dicom';
Center_folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Pre_Data';
Dcm_mr_Folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/MRI_Dicom';
Low_Center = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/low_ct';
final_folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/low_ct/Normalized';
addpath(genpath('/data/anlab/TongyaoW/BlackBoneProject/Preprocessing/'));
%% Get MR mask
get_levelset_mask(Low_Center,testing_1,'correction_MR');

%% change correct MR name as r1

%% Register CT to MR
Registration(Low_Center,resize_subject,12,'mutualinfo'); %% 12 is the -dof number, can change if the current registration are not good;

%% Generate CT mask;

%% Normalize CT and MR
normalize_images_in_dir_mr(Low_Center,final_folder,testing_1,'r1',2);
%% Get intersection mask