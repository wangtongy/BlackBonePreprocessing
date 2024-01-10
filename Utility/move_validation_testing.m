path = '/data/anlab/TongyaoW/BlackBoneProject/Data/ToAndrew/BA_training/pCT';
img_et = niftiread(sprintf('%s/055_BA_et.nii.gz',path));
img = img_et*2*455.5916+111.5383;
mk = niftiread(sprintf('%s/055_mk.nii.gz',path));
img(mk==0) = -1000;
info = niftiinfo(sprintf('%s/055_BA_et.nii.gz',path)); 
niftigzwrite(img,sprintf('%s/055_BA.nii.gz',path),info);

%% 
testing = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/ToAndrew/Training_testing_20231204.txt');
folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/ToAndrew/Segmentation_mk';
for i = 1:length(testing)
    if length(testing{i}) == 2

        mk = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/SB_3D_Data/mask/%s_mk.nii.gz',testing{i});
%         ct = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/RSB_3D_Paul/%s_ct.nii.gz',testing{i});
%         mr = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/RSB_3D_Paul/normalized/%s_r1.nii.gz',testing{i});
    else
        mk = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/RSB_3D_Paul/mask/%s_mk.nii.gz',testing{i});
%         mk = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/SB_3D_Data/CT_mask/%s_mk.nii.gz',testing{i});
%         ct = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/SB_3D_Data/%s_ct.nii.gz',testing{i});
%         mr = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Old/MR2CT_old/3D_Dataset/SB_3D_Data/normalized/%s_r1.nii.gz',testing{i});
    end
%     if ~exist(mk,'file')|~exist(ct,'file')|~exist(mr,'file')
    if ~exist(mk,'file')
        disp(testing{i})
        continue
    end
    copyfile(mk,folder);
%     copyfile(ct,folder);
%     copyfile(mr,folder);
end

%%
for i = 11:length(testing)
    if length(testing{i}) == 2
        mk = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/ToAndrew/Segmentation_mk/0%s_k3.nii.gz',testing{i});
        new_mk = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/ToAndrew/Segmentation_mk/%s_mk.nii.gz',testing{i});
    else
        continue
    end
    if ~exist(mk,'file')
       disp(testing{i});
    elseif ~exist(new_mk,'file') && exist(mk,'file')
        movefile(mk,new_mk);
    end 
   
end