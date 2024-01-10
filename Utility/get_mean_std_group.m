
fuction [mean_subj, std_subj, mean_group, std_group] = get_mean_std_group(names_im, names_mk)

   nums_all = length(names_im);
   
   mean_subj = zeros(nums_all, 1);
   std_subj = zeros(nums_all, 1);

   for i=1:nums_all,
      if ~exist(name_im{i}) | ~exist(name_mk{i})
         fprintf('%s does not exist!\n', name_im{i});
         pause;
      end;

      nii1 = load_untouch_nii(name_im{i});
      nii2 = load_untouch_nii(name_mk{i});

      im = nii1.img;
      mk = nii2.img;

      [dim1, dim2, dim3] = size(im);
      [dim4, dim5, dim6] = size(mk);

      if dim1~=dim4 | dim2~=dim5 | dim3~=dim6
         fprintf('%s size does not match!\n', nnn);
      end;

      I = find(mk>0);
      val_tmp = im(I);

      mean_subject(i) = mean(val_tmp);
      std_subject(i) = std(val_tmp);

      val = [val' val_tmp']';

      clear nii1 nii2 im mk I val_tmp;
      clear nnn name_in name_mk;
   end;

   mean_group = mean(val);
   std_group = std(val);
   
   clear val; 

