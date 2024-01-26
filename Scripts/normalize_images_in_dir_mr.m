function normalize_images_in_dir_mr(name_input_dir, name_output_dir, names_all,inext,outext,param,skip)

        for i=1:length(names_all),
               nnn = names_all{i};
               
               name_in = sprintf('%s/%s_%s.nii.gz', name_input_dir, nnn,inext);
               name_mk = sprintf('%s/%s_r1_mk.nii.gz', name_input_dir, nnn);
               name_out = sprintf('%s/%s_%s.nii.gz', name_output_dir, nnn, outext);
               if ~exist(name_mk,'file')
                   disp('no mask');
                   continue
               end
               if ~exist(name_in,'file')
                   fprintf('\n missing: %s \n',name_in)
                   continue 
               end
               if skip
                    if exist(name_out,'file')
                        fprintf('exist files %s \n',name_out);
                        continue
                    end
               end

               nii = niftiread(name_in);
               mk = single(niftiread(name_mk)); 
              
        
               im_out = nii.*mk; %make the background as 0;
             
        
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
              
        
               J1 = find(im_out_norm>2);
               J0 = find(im_out_norm<-2);  
               im_out_norm(J1) = 2;
               im_out_norm(J0) = -2;
        
        
               info.Datatype = 'single';
        
               niftigzwrite((im_out_norm), name_out, info);
        
               %%%%%%%%%%%%%%%%
               
        end

end