
addpath('/data/anlab/TongyaoW/BlackBoneProject/Code_matlab_new/');
path = '/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight';
subject_name = load_names('/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/training_g.txt');
subject_name = {'19'};
parpool(6);
for i = 1
    %% load mk %% 
    ct = niftiread(sprintf('%s/ct/%s_ct.nii.gz',path,subject_name{i}));
    mask = niftiread('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/SB_3D_Data/mask/19_weight.nii.gz');
    mk_new = mask; 
    mk_new(mask==10)=1;
    mk_new(mask==1) = 0;
%     mk_new = ct;
%     mk_new(ct>=200) = 1;
%     mk_new(ct<200)=0;
%% generate air mask %%
   
    air_mk = ct;
    air_mk(ct >= -200) = 1;% non air
    air_mk(ct < -200) = 0;% air = 0
    fill_1 = imfill_3d_3views(air_mk,26);
    sinus_mk = fill_1-air_mk;
    sinus_mkout = sprintf('%s/training/%s_sinus_mk.nii.gz',path,subject_name{i});
    niftigzwrite(sinus_mk,sinus_mkout,header);
    mask_comb = mk_new + sinus_mk;
    niftigzwrite(mask_comb,sinus_mkout,header);
%% imdilate
    se = strel('sphere',3);
    mask_dila = imdilate(mask_comb,se);
   
    %% imclose
    mask_close = imclose(mask_dila,se);
%% fill small holes
    pre_fill = imfill_3d_3views(mask_close,6);
    holesVolume = ~mask_close & pre_fill; 
    cc = bwconncomp(holesVolume, 6); % 26 defines the 3D connectivity
    stats = regionprops(cc, 'Area', 'FilledImage', 'BoundingBox');
    areaThreshold = 10000;
    for k = 1:numel(stats)
        if stats(k).Area < areaThreshold
            bb = round(stats(k).BoundingBox);
            % Extract the bounding box coordinates
            xRange = bb(2) : (bb(2) + bb(5) - 1);
            yRange = bb(1) : (bb(1) + bb(4) - 1);
            zRange = bb(3) : (bb(3) + bb(6) - 1);
            
            % Replace the hole in the original volume using the FilledImage property
            mask_close(xRange, yRange, zRange) = mask_close(xRange, yRange, zRange) | stats(k).FilledImage;
        end
    end
%% erose back
    se_back = strel('sphere',2);
    mask_final = imerode(mask_close,se_back);
    whole_mk = niftiread(sprintf('%s/training/whole_hd/%s_mk.nii.gz',path,subject_name{i}));
    mask_final_final = mask_final;
    mask_final_final(mask_final==1&whole_mk==1)=0.8;
    mask_final_final(mask_final==0&whole_mk ==1)=0.2;
    mask_final_final = mask_final_final.*whole_mk;
    header = niftiinfo(sprintf('%s/training/%s_ct.nii.gz',path,subject_name{i}));
    niftigzwrite(mask_final_final,sprintf('%s/training/%s_mk.nii.gz',path,subject_name{i}),header);
end
parpool(10);
parfor i = 1:length(subject_name)
    mk = sprintf('/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/whole_hd/%s_mk.nii.gz',subject_name{i});
    hd_mk = sprintf('/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/training_g1_20231031/%s_mk.nii.gz',subject_name{i});
    hd_mkimg = niftiread(hd_mk);
    mk_img = niftiread(mk);%whole head
    mk_new = single(hd_mkimg.*mk_img);
    out = sprintf('/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/bone_mk/%s_mk.nii.gz',subject_name{i});
    header = niftiinfo(hd_mk);
    niftigzwrite(mk_new,out,header);
end
%% 

mk = niftiread('/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/training_g1_20231031/19_mk.nii.gz');
whole_mk = niftiread('/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/whole_hd/19_mk.nii.gz');
mk_new = mk;
mk_new(whole_mk==1&mk==1)=0.8;
mk_new(whole_mk==1&mk~=1)=0.2;
imagesc(mk_new(:,:,126));colormap('gray');
out = '/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/bone_mk/19_mk.nii.gz';
header = niftiinfo('/data/anlab/TongyaoW/BlackBoneProject/UNCERTAIN/Over_suture_over_weight/bone_mk/19_mk.nii.gz');
niftigzwrite(single(mk_new),out,header);