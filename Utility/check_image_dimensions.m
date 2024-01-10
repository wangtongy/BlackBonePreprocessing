

function [dimx_max, dimy_max, dimz_max] = check_image_dimensions(names_all, name_input_dir, names_ext)

   nums_all = length(names_all);
   nums_ext = length(names_ext);
   
   dimx_max = 1;
   dimy_max = 1;
   dimz_max = 1;
      
   for i=1:nums_all,
      name_in = sprintf('%s/%s_%s.nii.gz', name_input_dir, names_all{i}, names_ext{1});

      nii = load_untouch_nii(name_in);
      [dimx1, dimy1, dimz1] = size(nii.img);
      clear nii;
      
      if dimx1>dimx_max
         dimx_max = dimx1;
      end;
      
      if dimy1>dimy_max
         dimy_max = dimy1;
      end;

      if dimz1>dimz_max
         dimz_max = dimz1;
      end;

      for j=2:nums_ext,
         name_tmp = sprintf('%s/%s_%s.nii.gz', name_input_dir, names_all{i}, names_ext{j});
         nii = load_untouch_nii(name_tmp);
         [dimx_tmp, dimy_tmp, dimz_tmp] = size(nii.img);
      
         if dimx_tmp~=dimx1 | dimy_tmp ~= dimy1 | dimz_tmp ~= dimz1
            fprintf('please check %s for image size !\n', name_tmp);
	    pause;
         end;
	 
	 clear name_tmp nii;
      end;
   end;      
         
