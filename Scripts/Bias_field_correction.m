function Bias_field_correction(Dcm_folder, folder,subject_list)

parfor i = 1:length(subject_list)
    nameIn = sprintf('%s/%s_dcm.nii.gz',Dcm_folder,subject_list{i});
    nameOut = sprintf('%s/%s_correction_MR.nii.gz',folder,subject_list{i});
    n4 = sprintf('N4BiasFieldCorrection -d 3 -i %s -o %s', nameIn,nameOut);
    system(n4);
end

end