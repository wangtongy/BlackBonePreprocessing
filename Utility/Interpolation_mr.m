function Interpolation_mr(Input_folder,out, subject_list,old_folder)
    cd(Input_folder)
    for i = 1:length(subject_list)
            
            template_sub=sprintf('%s/%s_pCT.nii.gz',old_folder,subject_list{i});
            template_size_info = niftiinfo(template_sub);
            x = template_size_info.ImageSize(1);
            y =  template_size_info.ImageSize(2);
            z =  template_size_info.ImageSize(3);
            template = strcat(Input_folder,'/',sprintf('%s_TEST_tmp_mr.nii.gz',subject_list{i}));
            if exist(template, 'file')
                disp('have Test_tmp_mr.nii.gz')
            else
                disp('No Template, generating a new one')
                nameTemplate = sprintf('%s_TEST_tmp_mr',subject_list{i});
                fslcreate = sprintf('fslcreatehd %d %d %d 1 0.3 0.3 0.5 1 0 0 0 4 %s.img',x,y,z,nameTemplate);
                disp(fslcreate);
                system(fslcreate);
            end

                nameIn =sprintf('%s/%s_r1.nii.gz',Input_folder,subject_list{i});
                nameout = sprintf('%s/%s_inter_r1.nii.gz',out,subject_list{i});
                disp(nameIn);
                flirt = sprintf('flirt -in %s -applyxfm -init /usr/local/pkg/fsl6.0/etc/flirtsch/ident.mat -out %s -paddingsize 0.0 -interp trilinear -ref %s.nii.gz', nameIn,nameout,nameTemplate);
                system(flirt);
    end
end