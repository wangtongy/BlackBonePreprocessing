testing = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/Over_suture_over_weight/testing_g.txt');

pathSB = '/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/SB_3D_Data';
pathRSB = '/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/RSB_3D_Paul';
destination = '/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/Over_suture_over_weight/testing';
for i = 1:length(testing)
    if length(testing{i}) == 3
        mk = sprintf('%s/Inter_mk/%s_mk.nii.gz',pathRSB,testing{i});
        mr = sprintf('%s/normalized/%s_r1.nii.gz',pathRSB,testing{i});
        copyfile(mk,destination);
        copyfile(mr,destination);
    else
        mk = sprintf('%s/Inter_mk/%s_mk.nii.gz',pathSB,testing{i});
        mr = sprintf('%s/normalized/%s_r1.nii.gz',pathSB,testing{i});
        copyfile(mk,destination);
        copyfile(mr,destination);
    end
end

[C,ia,ib] = intersect(training,all_subject,'stable');

AmisB = all_subject;
AmisB(ib) = []; 

%% 
h = randperm();