%% load subejct number and LOAD All needed folders: 1 ct dicom folders, 1 mr dicom folder, 1 folder holds everything before normalization, 1 final folder saved normalized ct and mr and intersection head mask; (ready to use);

Dcm_ct_Folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/CT_Dicom';
Center_folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Pre_Data';
Dcm_mr_Folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/MRI_Dicom';
final_folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Normalized';
addpath(genpath('/data/anlab/TongyaoW/BlackBoneProject/Preprocessing/'));
subject_number = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/ToAndrew/Training_testing_20231204.txt');
subject_number_mr = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/move_header.txt');
resize_subject = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/resize_subject.txt');
%% Load CT dicom and generate nifti files (dicom folder structure for ct may change sometimes, In general, SB 1-63 shared one data structure, and the rest of them shared the other one,)
% subject_number = {'056'};
dcm2nii(Dcm_ct_Folder,{'028'},0);
%% iNTERPOLATION CT
Interpolation(Dcm_ct_Folder,Center_folder,resize_subject);
%% Generate head mask and only get the largest part (to get rid of the ct holder in the bakground)
get_levelset_mask(Center_folder,resize_subject,'ct');
keep_only_largest_region(Center_folder,resize_subject,'ct');
%% Generate ct bone mask and weighted bone mask for future MR2CT registration
CT_Bone_mask(Center_folder,resize_subject);
edge_filtering(Center_folder,Center_folder,subject_number,'ct');
%% load MR Dicom and generate nifti files
% pointer = 2; %% 1 is the rsb ct dicom; 0 is the sb ct dicom; and 2 is the rsb mr dicom;3 is the sb mr dicom;
% dcm2nii(Dcm_mr_Folder,subject_number,pointer);
%% Bias field correction
Bias_field_correction(Dcm_mr_Folder,Center_folder,subject_number_mr);
%% registration from mr to ct
Registration(Center_folder,resize_subject,12,'mutualinfo'); %% 12 is the -dof number, can change if the current registration are not good;
% if results are not good, redo 
% bad_regis = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/bad_regis.txt');
% Registration_again(Center_folder,bad_regis,12,'corratio');
%% generate mr head mask
get_levelset_mask(Center_folder,resize_subject,'r1');
%% get the insersection mask
Intersection_mask(Center_folder, final_folder,subject_number);
%% Normalize CT and MR
normalize_images_in_dir(Center_folder,final_folder,subject_number,'ct',1);
normalize_images_in_dir_mr(folder,folder,resize_subject,'r1',2);