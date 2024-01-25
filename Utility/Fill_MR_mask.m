%% use threshold to generate mr mask
%%%%%% may need to modify
subject_number = {'19'};
folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/fix_mask';
outf = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/fix_mask/fix';
img = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/fix_mask/%s_nonorm_r1.nii.gz',subject_number{1});
out = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/fix_mask/%s_r1_mk1.nii.gz',subject_number{1});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img_ni = niftiread(img);
info = niftiinfo(img);
threshold = 80;
img_ni_new = img_ni;
img_ni_new(img_ni > threshold) = 1;
img_ni_new(img_ni <= threshold) = 0;
niftigzwrite(img_ni_new,out,info);

fill1 = imfill_3d_3views(img_ni_new);
niftigzwrite(fill1,out,info);
keep_only_largest_region(folder,subject_number,'r1');
%% imclose
se = strel('sphere',2);
subject_number = {'19'};
folder = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/fix_mask';
out = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/fix_mask/%s_r1_mk.nii.gz',subject_number{1});
img_ni = niftiread(out);
info = niftiinfo(out);
new_img = imclose(img_ni,se);
fill1 = imfill_3d_3views(new_img);

niftigzwrite(fill1,out,info);

%% Fill using itk snap
%%%%%% need to change the path below
fill_mk = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/fix_mask/45_fill_mask.nii.gz';
original_mk = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/fix_mask/45_r1_mk.nii.gz';
%%%%%%%%%%%%%%%%%%%%%%%
fill_mk_img = niftiread(fill_mk);
original_info = niftiinfo(original_mk);
original_mk_img = niftiread(original_mk);
niftigzwrite(single(fill_mk_img),fill_mk,original_info);
fill_mk_img = niftiread(fill_mk);
comb = original_mk_img + fill_mk_img;
comb_new = comb; 
comb_new(comb == 2) = 1;
niftigzwrite(single(comb_new),original_mk,original_info);
%% copy ct header
subject = {'037'};
for i = 1:length(subject)
    ct_img = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/WH/ModelD_WH_patch_96_edge/test_2/%s_nonorm_ct.nii.gz',subject{i});
    info = niftiinfo(ct_img); 
    qt = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/WH/ModelD_WH_patch_96_edge/test_2/fix/RSB-037/%s_qt.nii.gz',subject{i});
    qt_img = niftiread(qt);
    niftigzwrite(single(qt_img),qt,info);
end
%%
nonorm_r1 = '037_nonorm_r1.nii.gz';
r1_img = niftiread(nonorm_r1);
info = niftiinfo(nonorm_r1);
mk = '037_r1_mk.nii.gz';
mk_img = niftiread(mk);
niftigzwrite(mk_img,mk,info);
folder = pwd;
normalize_images_in_dir_mr(folder,folder,{'19'},'r1',2);