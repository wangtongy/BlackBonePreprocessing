
function normalize_images_in_dir_parna(name_input_dir, name_output_dir, names_all,name_ext, sign_group_normalization)
addpath('/data/anlab/TongyaoW/BlackBoneProject/Matlab_NIFTI_IO');
nums_all = length(names_all);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%normalize the images
for i=1:nums_all,
   nnn = names_all{i};
   name_in = sprintf('%s/%s_nonorm_%s.nii.gz', name_input_dir, nnn, name_ext);
   name_mk = sprintf('%s/%s_r1_mk.nii.gz', name_input_dir, nnn);
   if ~exist(name_mk,'file')
       disp('no mask');
       continue
   end
   mk = niftiread(name_mk);
   I0 = find(mk==0);
   I1 = find(mk>0);
   clear name_mk name_nii;
   name_out = sprintf('%s/%s_%s.nii.gz', name_output_dir, nnn, name_ext);
   if ~exist(name_in,'file')
       disp('no name_in');
       continue 
   end
   nii = niftiread(name_in);
   info = niftiinfo(name_in);
   [dimx_max, dimy_max, dimz_max] = size(nii);

%    w = info.ImageSize;    
%    dim1 = w(1);
%    dim2 = w(2);
%    dim3 = w(3);
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    [sx_in, ex_in, sx_out, ex_out] = adjust_image_size(dim1, dimx_max);
%    [sy_in, ey_in, sy_out, ey_out] = adjust_image_size(dim2, dimy_max);
%    [sz_in, ez_in, sz_out, ez_out] = adjust_image_size(dim3, dimz_max);

   im_out = zeros(dimx_max, dimy_max, dimz_max);
   
   if strcmp(name_ext, 'ct') == 1
      im_out = im_out - 1000;
   end;

   im_out= nii;
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   if sign_group_normalization == 0
      val = im_out(I1);
      meanv = mean(val);
      stdv = std(val);
      %im_out = (im_out-meanv)/(2*stdv); yasheng
      im_out = (im_out-meanv)/(5*stdv);
   else
      im_out = (im_out-mean_group) / (5*std_group);
   end;
 
    J1 = find(im_out>1);
   J0 = find(im_out<-1);  
   im_out(J1) = 1;
   im_out(J0) = -1;

   info.Datatype = 'single';
   im_out = single(im_out);
   niftigzwrite(im_out, name_out, info);

   %%%%%%%%%%%%%%%%
   clear name_in name_out nii im im_out J0 J1;
   clear nnn name_mk nii mk I0 I1 nii;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ct  113.1875+424.5913
%r1  1.7213+1.4155
%r2  557.1111+207.8928

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%these are the old values.
%val_ct   = 111.1232     1.7078    565.5527      205.1244     1212.8921
%val_std  = 436.3707     1.4691    199.0492      110.9434     425.9231


