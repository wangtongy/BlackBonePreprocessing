

%% 
% testing = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/WH/training_g1.txt');
testing = resize_subject;
folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/low_ct';
parfor i = 1:length(testing)
   

        mk = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Pre_Data/%s_correction_MR.nii.gz',testing{i});
%         ct = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Pre_Data/%s_nonorm_ct.nii.gz',testing{i});
%         mr = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Normalized/%s_r1.nii.gz',testing{i});
%     
%     if ~exist(mk,'file') | ~exist(ct,'file') | ~exist(mr,'file')
    if ~exist(mk,'file') 
        disp(testing{i})
        continue
    end
    copyfile(mk,folder);
%     copyfile(ct,folder);
%     copyfile(mr,folder);
end

%% 
