%% flipping
subject = {'10'};
for i= 1:length(subject)
    ct = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/Pre_Data/%s_nonorm_ct.nii.gz',subject{i});
    ct_img = niftiread(ct);
    info = niftiinfo(ct);
    ct_img_new=flip(flip(ct_img,1),2);
    
    out_ct = sprintf('%s_ct_flip.nii.gz',subject{i});
    niftigzwrite(ct_img_new,out_ct,info);
    pct = sprintf('%s_qt.nii.gz',subject{i});
    pct_img = niftiread(pct);
    niftigzwrite(single(pct_img),pct,info);
    pct_img2 = niftiread(pct);
    qt_img_new=flip(flip(pct_img,1),2);
   
    out_qt = sprintf('%s_qt_flip.nii.gz',subject{i});
    niftigzwrite(single(qt_img_new),out_qt,info);
end
    
    