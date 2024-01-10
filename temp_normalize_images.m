clear all;

names_all = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/ToAndrew/validation_g1.txt');
nums_all = length(names_all);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
threshold_hu_air = -500;
threshold_hu_bone =200;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ext_name{1} = 'ct';
ext_name{2} = 'r1';

num_features = length(ext_name);

val_mean = zeros(num_features, 1);
val_std = zeros(num_features, 1);
% 
val_mean_subject = zeros(num_features, nums_all);
val_std_subject = zeros(num_features, nums_all);
num_zeros_subject = zeros(num_features, nums_all);
% 
dimx = zeros(num_features, nums_all);
dimy = zeros(num_features, nums_all);
dimz = zeros(num_features, nums_all);
% 
prctile_thresholds = [0.1, 0.5, 1, 99, 99.5, 99.9];
num_prctiles = length(prctile_thresholds);

prctile_values = zeros(num_features, num_prctiles);
% 
for ii=1:num_features,
   val = [];

   for i=1:nums_all,
      nnn = names_all{i};
      if strcmp(ext_name{ii},'ct') == 1
          new_ext = 'edge_ct';
      else
          new_ext = 'nonorm_r1';
      end
      name_in = sprintf('./Data/3D_Dataset/Pre_Data/%s_%s.nii.gz', nnn, new_ext);
      name_mk = sprintf('./Data/3D_Dataset/Pre_Data/%s_mk.nii.gz', nnn);

%       if ~exist(name_in) | ~exist(name_mk)
%          continue;
%       end;

%       nii1 = load_untouch_nii(name_in);
%       nii2 = load_untouch_nii(name_mk);
        im = niftiread(name_in);
        mk = niftiread(name_mk);

%       im = nii1.img;
%       mk = nii2.img;

      [dim1, dim2, dim3] = size(im);
      [dim4, dim5, dim6] = size(mk);

      if dim1~=dim4 | dim2~=dim5 | dim3~=dim6
         fprintf('%s size does not match!\n', nnn);
      end;

      dimx(ii,i) = dim1;
      dimy(ii,i) = dim2;
      dimz(ii,i) = dim3;
      im=double(im);
      I = find(mk>0);
      val_tmp = im(I);
      
      val_mean_subject(ii,i) = mean(val_tmp);%ii is the number of ext(ct,r1),i is the number of subject. 
      val_tmp=double(val_tmp);
      val_std_subject(ii,i) = std(val_tmp);

      I =find(val_tmp==0);
      num_zeros_subject(ii,i) = length(I);
    
      val = [val' val_tmp']';

      clear nii1 nii2 im mk I val_tmp;
      clear nnn name_in name_mk;
   end;

   val_all{ii} = val;

   val_mean(ii) = mean(val);% group mean and std
   val_std(ii) = std(val);

   for i=1:num_prctiles,
      prctile_values(i) = prctile(val, prctile_thresholds(i));
   end;

   clear val;
end;

 save ws_mean_std.mat;
% 
disp('done with calculating the mean/std');

dimx_max = max(dimx(:));
dimy_max = max(dimy(:));
dimz_max = max(dimz(:));

%%%%%%%%%%%%%%%%%%%%%%%%%normalize the images
%%%generate the masks

for i=1:nums_all,
   nnn = names_all{i};

   name_in_ct = sprintf('./Data/3D_Dataset/Pre_Data/%s_edge_ct.nii.gz', nnn);
   name_in_mk = sprintf('./Data/3D_Dataset/Pre_Data/%s_mk.nii.gz', nnn);

   name_out = sprintf('./Data/3D_Dataset/Old_norm/validation_1/%s_mk.nii.gz', nnn);
   
   nii_ct = niftiread(name_in_ct);
   nii_mk = niftiread(name_in_mk);
   info = niftiinfo(name_in_mk);
   info.Datatype = 'double';
   [dim1, dim2, dim3] = size(nii_ct);

   [sx_in, ex_in, sx_out, ex_out] = adjust_image_size(dim1, dimx_max);
   [sy_in, ey_in, sy_out, ey_out] = adjust_image_size(dim2, dimy_max);
   [sz_in, ez_in, sz_out, ez_out] = adjust_image_size(dim3, dimz_max);
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%
   mk_tmp = zeros(dim1, dim2, dim3);
   mk_out = zeros(dimx_max, dimy_max, dimz_max);
   
   I1 = find(nii_ct <= threshold_hu_air  & nii_mk>0);
   I3 = find(nii_ct >= threshold_hu_bone & nii_mk>0);
   I2 = find(nii_ct >  threshold_hu_air  & nii_ct<threshold_hu_bone & nii_mk>0);    
   
   mk_tmp(I1) = 1;
   mk_tmp(I2) = 2;
   mk_tmp(I3) = 3;

   mk_out(sx_out:ex_out, sy_out:ey_out, sz_out:ez_out) = mk_tmp(sx_in:ex_in, sy_in:ey_in, sz_in:ez_in);

   niftigzwrite(mk_out, name_out,info);

   clear nnn name_in_ct name_in_mk name_out nii_ct nii_mk mk_tmp mk_out;
end

disp('done with resizing');
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%normalize the images
% for ii=1:num_features,
%    
%    for i=1:nums_all,
%       nnn = names_all{i};
% 
%       if ii<=num_features,
%          mmm = ext_name{ii};
%       end;
% 
%       name_in = sprintf('../Code_matlab_20190319/Input/%s_%s.nii.gz', nnn, mmm);
%       name_out = sprintf('../Code_matlab_20190319/NewNormalizd/%s_%s.nii.gz', nnn, mmm);
% 
%       nii = load_untouch_nii(name_in);
%       [dim1, dim2, dim3] = size(nii.img);
% 
%       [sx_in, ex_in, sx_out, ex_out] = adjust_image_size(dim1, dimx_max);
%       [sy_in, ey_in, sy_out, ey_out] = adjust_image_size(dim2, dimy_max);
%       [sz_in, ez_in, sz_out, ez_out] = adjust_image_size(dim3, dimz_max);
% 
%       im_out = zeros(dimx_max, dimy_max, dimz_max);
% 
%       if ii==1,
%          im_out = im_out-1024;
%       end;
% 
%       im_out(sx_out:ex_out, sy_out:ey_out, sz_out:ez_out) = nii.img(sx_in:ex_in, sy_in:ey_in, sz_in:ez_in);
% 
%       save_nii_yasheng(im_out, nii.hdr.dime.pixdim(2), nii.hdr.dime.pixdim(3), nii.hdr.dime.pixdim(4), nii.hdr.dime.datatype, name_out);
% 
%       clear nnn mmm name_in name_out nii im_out;
%    end;
% end;
% 
%  disp('done with resizing');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for ii=1:num_features,
   for i=1:nums_all,
      nnn = names_all{i};
      if strcmp(ext_name{ii},'ct') == 1
          new_ext = 'edge_ct';
      else
          new_ext = 'nonorm_r1';
      end
      name_im = sprintf('./Data/3D_Dataset/Pre_Data/%s_%s.nii.gz', nnn, new_ext);
      name_mk = sprintf('./Data/3D_Dataset/Pre_Data/%s_mk.nii.gz', nnn);
      name_out = sprintf('./Data/3D_Dataset/Old_norm/validation_1/%s_%s.nii.gz', nnn,ext_name{ii});

      if ~exist(name_im)
         continue;
      end;

      mk = niftiread(name_mk);
 

      im = niftiread(name_im);
      info_im = niftiinfo(name_im); 
      info_im.Datatype = 'double';

      I0 = find(mk==0);
      I1 = find(mk>0);

      if ii>=num_features-1,  %1
         im2 = double(im-val_mean_subject(ii, i))/(5*val_std_subject(ii, i));
         I = im2>1.0;  im2(I) = 1;
         I = find(im2<-1.0); im2(I) = -1;   
      %else
         %im = (im-val_mean(ii))/(2*val_std(ii));
      end;
            
%       if ii~=2
%          im2(I0) = 0;
      %end;

      niftigzwrite(im2,name_out,info_im);

      clear nii im mk name_im name_out name_mk nnn val;
   end;
end;
% % % % 
% % % %val_mean = 111.1232     1.7078    565.5527      205.1244     1212.8921
% % % %val_std  = 436.3707     1.4691    199.0492      110.9434     425.9231
% % % 
% % % %%this was the old value when T1 was not included
% % % %val_mean =  40.0451    1.5920  531.7949
% % % %val_std =   506.9157   1.4096  236.4510
% % % 
