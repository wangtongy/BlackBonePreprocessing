function normalize_images_in_dir_ct_self(name_input_dir, name_output_dir, names_all,name_ext,param)
        all_mean = zeros(1,length(names_all));
        all_std = zeros(1,length(names_all));
        parfor i=1:length(names_all),
               nnn = names_all{i};
               
               name_in = sprintf('%s/%s_nonorm_%s.nii.gz', name_input_dir, nnn, name_ext);
               name_mk = sprintf('%s/%s_ct_mk.nii.gz', name_input_dir, nnn);
               name_out = sprintf('%s/%s_%s.nii.gz', name_output_dir, nnn, name_ext);
               if ~exist(name_mk,'file')
                   disp('no mask');
                   continue
               end
               if ~exist(name_in,'file')
                   fprintf('\n missing: %s \n',name_in)
                   continue 
               end
               if exist(name_out,'file')
                   continue
               end
               nii = niftiread(name_in);
               mk = niftiread(name_mk); 
              
               im_out = nii;
               im_out(mk==0)= -1024; %make the background as -1024;
               
        
               if ~exist(name_in,'file')
                   fprintf('\n missing: %s \n',name_in)
                   continue 
               end
        
               info = niftiinfo(name_in);
        
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               
              val = im_out(mk == 1); %value inside of the head mask;
              meanv = mean(val); % mean calculated based of the values inside the head
              stdv = std(val); 
              im_out_norm = (im_out-meanv)/(param*stdv);
              all_mean(1,i) = meanv;
              all_std(1,i) = stdv;

              
        
               J1 = find(im_out_norm>2);
               J0 = find(im_out_norm<-2);  
               im_out_norm(J1) = 2;
               im_out_norm(J0) = -2;
        
        
               info.Datatype = 'single';
        
               niftigzwrite(single(im_out_norm), name_out, info);
        
               %%%%%%%%%%%%%%%%
               
        end
        filenamemean = sprintf('%s/mean.xls',name_output_dir);
        filenamestd = sprintf('%s/std.xls',name_output_dir);
        writematrix(all_mean,filenamemean);
        writematrix(all_std,filenamestd);
end