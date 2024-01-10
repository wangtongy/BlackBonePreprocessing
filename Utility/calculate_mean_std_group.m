
function [meanv, stdv, num_voxels_included] = calculate_mean_std_group(folder, subject_list,ext)

   nums_all = length(subject_list);
   
   val = [];
   
   for i=1:nums_all     
      name_in = sprintf('%s/%s_%s.nii.gz',folder,subject_list{i},ext);
      name_mk = sprintf('%s/%s_mk.nii.gz',folder,subject_list{i});
      name_in_tmp = name_in;
      name_mk_tmp = name_mk;
      
      if ~exist(name_in_tmp) | ~exist(name_mk_tmp)
         fprintf('caluclate_mean_sted_group %s or %s do not exist!\n', name_in_tmp, name_mk_tmp);
	     continue;
      end;

      im = niftiread(name_in_tmp);
      mk = niftiread(name_mk_tmp);


      [dim1, dim2, dim3] = size(im);
      [dim4, dim5, dim6] = size(mk);

      if dim1~=dim4 | dim2~=dim5 | dim3~=dim6
         fprintf('%s %s size does not match!\n', name_in_tmp, name_mk_tmp);
	 pause;
      end;

      I = find(mk>0);
      val_tmp = im(I);
      
      num_voxels_included(i) = length(I);
      
      val = [val' val_tmp']';

      clear nii1 nii2 im mk I val_tmp;
      clear nnn name_in_tmp name_mk_tmp;
   end;
   
   meanv = mean(val);
   stdv = std(val);
   
   clear val;
end