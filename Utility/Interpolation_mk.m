function Interpolation_mk(Input_folder,out, subject_list)
    cd(Input_folder)
    
    template = strcat(Input_folder,'/',sprintf('TEST_tmp_mask.nii.gz'));
    if exist(template, 'file')
        disp('have Test_tmp_mask.nii.gz')
    else
        disp('No Template, generating a new one')
   
        fslcreate = sprintf('fslcreatehd 217 217 197 1 1 1 1 1 0 0 0 4 TEST_tmp_mask.img');
        disp(fslcreate);
        system(fslcreate);
    end
    poolobj = parpool(15);
    parfor i = 26
        nameIn =sprintf('%s/%s_r1_mk.nii.gz',Input_folder,subject_list{i});
        nameout = sprintf('%s/%s_r1_mk.nii.gz',out,subject_list{i});
        disp(nameIn);
        flirt = sprintf('flirt -in %s -applyxfm -init ${FSLDIR}/etc/flirtsch/ident.mat -out %s -paddingsize 0.0 -interp nearestneighbour  -ref TEST_tmp_mask.nii.gz', nameIn,nameout);
        system(flirt);
    end
    delete(poolobj);
end