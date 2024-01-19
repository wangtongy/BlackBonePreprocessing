function call_nifti_to_dcm(subject_list,outdir,original_dcm_folder,niftipath,ext)


for i = 1:length(subject_list)
    if length(subject_list{i})== 3
        prefix = 'RSB';
    else
        prefix = 'SB';
    end
    folder_name = sprintf('%s-%s_CT_3Ddataset',prefix, subject_list{i});
    Top_folder = fullfile(original_dcm_folder,folder_name);
    try
    dcm_folder = generate_DCM_directory(Top_folder,0);
    catch
        fprintf('Generate DCM directory %s fail \n',subject_list{i});
        continue
    end
    I = niftiread(sprintf('%s/%s_%s.nii.gz',niftipath,subject_list{i},ext));
    series = sprintf('%s_%s',prefix,subject_list{i});
    try
    Nifti_to_Dicom(dcm_folder,outdir,series,I);
    catch ME
        fprintf("nifti to dicom fail %s, error message: %s \n",original_dcm_folder{i},ME.message);
        continue
    end
end