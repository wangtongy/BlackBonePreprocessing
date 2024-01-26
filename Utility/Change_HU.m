function Change_HU(folder,names_all)
for i = 1:length(names_all)
    name = sprintf('%s/%s_dcm.nii.gz',folder,names_all{i});
    info = niftiinfo(name); % Read in the nifti header
    AdditiveOffset = info.AdditiveOffset; % Get the AdditiveOffset which is like the RescaleIntercept
    fprintf('The current AdditiveOffset is %d.\n\n', AdditiveOffset);
    info.AdditiveOffset = -1024; % Replace the -8192 with -1024.
    imgbeforechange = niftiread(name); % Read in the newly created nifti file
    img = imgbeforechange - 7168; % Subtract 7168 from each voxel to give the air values near zero
    niftigzwrite(img,name,info); % Save the changed nifti file.
end
end 