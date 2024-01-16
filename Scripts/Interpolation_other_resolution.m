function Interpolation_other_resolution(Input_folder,out, subject_list,ext)
    cd(Input_folder)
    template = strcat(Input_folder,'/','TEST_tmp_higher.nii.gz');
    if exist(template, 'file')
        disp('have Test_tmp_higher.nii.gz')
    else
        disp('No Template, generating a new one')
        fslcreate = sprintf('fslcreatehd 320 320 224 1 0.6 0.6 0.8 1 0 0 0 4 TEST_tmp_higher.img');
        system(fslcreate);
    end
    
    parfor i = 1:length(subject_list)
        
        nameIn =sprintf('%s/%s_dcm.nii.gz',Input_folder,subject_list{i});
        nameout = sprintf('%s/%s_nonorm_%s.nii.gz',out,subject_list{i},ext);
        
        disp(nameIn);
        if ~exist(nameIn,'file')
            fprintf('\n missing %s \n',subject_list{i})
            continue 
        end
        
        flirt = sprintf('flirt -in %s -applyxfm -init ${FSLDIR}/etc/flirtsch/ident.mat -out %s -paddingsize 0.0 -interp trilinear -ref TEST_tmp_higher.nii.gz', nameIn,nameout);
        system(flirt);
    end
  
end