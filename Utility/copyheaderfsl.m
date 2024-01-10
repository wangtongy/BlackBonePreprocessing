%% copy header
number = {'028','047','049','050','056','064','075','083'};
source = '/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/SB_3D_Data/91_ct.nii.gz';
for i = 1:length(number)
    
    dest = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/Over_suture_over_weight/Ants/Unregister/%s_r1.nii.gz',number{i});
    fslcp = sprintf('fslcpgeom %s %s',source,dest); 
    system(fslcp);
end