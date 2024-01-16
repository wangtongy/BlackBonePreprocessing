function normalize_images_in_dir_ct(name_input_dir, name_output_dir, names_all,name_ext)


    [mean_group,std_group] = calculate_mean_std_group(name_input_dir,names_all,'edge_ct');
% write mean and std out;
    T = table(mean_group, std_group,'VariableNames',{'mean_group','std_group'});
    nametable = sprintf('%s/mean_std_ct_edgegroup2.txt',name_output_dir);
    writetable(T,nametable);

nums_all = length(names_all);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%normalize the images

    parfor i=1:nums_all,
       nnn = names_all{i};
       
       name_in = sprintf('%s/%s_edge_%s.nii.gz', name_input_dir, nnn, name_ext);
       name_mk = sprintf('%s/%s_ct_mk.nii.gz', name_input_dir, nnn);
       name_out = sprintf('%s/%s_%s.nii.gz', name_output_dir, nnn, name_ext);
       if ~exist(name_mk,'file')
           disp('no mask');
           continue
       end

       nii = niftiread(name_in);
       mk = niftiread(name_mk); 
       

       im_out = nii.*mk; %make the background as 0;
      
        % make the background of ct as -1000;for mr, background is still 0;
       im_out(mk == 0) = -1000;
     

       if ~exist(name_in,'file')
           fprintf('\n missing: %s \n',name_in)
           continue 
       end

       info = niftiinfo(name_in);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
      im_out_norm = (im_out-mean_group) / (2*std_group);
      

        J1 = find(im_out_norm>2);
       J0 = find(im_out_norm<-2);  
       im_out_norm(J1) = 2;
       im_out_norm(J0) = -2;


       info.Datatype = 'single';

       niftigzwrite(single(im_out_norm), name_out, info);

       %%%%%%%%%%%%%%%%
       
    end
 
