path = '/data/anlab/TongyaoW/BlackBoneProject/Data/ToAndrew/BA_training/pCT';
img_et = niftiread(sprintf('%s/055_BA_et.nii.gz',path));
img = img_et*2*455.5916+111.5383;
mk = niftiread(sprintf('%s/055_mk.nii.gz',path));
img(mk==0) = -1000;
info = niftiinfo(sprintf('%s/055_BA_et.nii.gz',path)); 
niftigzwrite(img,sprintf('%s/055_BA.nii.gz',path),info);

%% 
testing = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/WH/test_g2.txt');
folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/WH/ModelD_WH_patch_96_edge/test_2';
parfor i = 1:length(testing)
   

        mk = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Pre_Data/%s_r1_mk.nii.gz',testing{i});
        ct = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Pre_Data/%s_nonorm_ct.nii.gz',testing{i});
        mr = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Normalized/%s_r1.nii.gz',testing{i});
    
    if ~exist(mk,'file') | ~exist(ct,'file') | ~exist(mr,'file')
        disp(testing{i})
        continue
    end
    copyfile(mk,folder);
    copyfile(ct,folder);
    copyfile(mr,folder);
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