function Interpolation(Input_folder,out, subject_list)
    cd(Input_folder)
    template = strcat(Input_folder,'/','TEST_tmp.nii.gz');
    if exist(template, 'file')
        disp('have Test_tmp.nii.gz')
    else
        disp('No Template, generating a new one')
        fslcreate = sprintf('fslcreatehd %d %d %d 1 0.3 0.3 0.5 1 0 0 0 4 TEST_tmp.img',);
        system(fslcreate);
    end
    poolobj = parpool(1);
    parfor i = 1:length(subject_list)
        
        nameIn =sprintf('%s/%s_dcm.nii.gz',Input_folder,subject_list{i});
        nameout = sprintf('%s/%s_nonorm_ct.nii.gz',out,subject_list{i});
        
        disp(nameIn);
        if ~exist(nameIn,'file')
            fprintf('\n missing %s \n',subject_list{i})
            continue 
        end
        flirt = sprintf('flirt -in %s -applyxfm -init /usr/local/pkg/fsl6.0/etc/flirtsch/ident.mat -out %s -paddingsize 0.0 -interp trilinear -ref TEST_tmp.nii.gz', nameIn,nameout);
        system(flirt);
        info = niftiinfo(nameIn);
        info.ImageSize = [720,722,393];    
    end
    delete(poolobj);
end