
function mk_out = imfill_3d_3views(mk_in)
addpath('/data/anlab/TongyaoW/BlackBoneProject/Matlab_NIFTI_IO');
   [dim1, dim2, dim3] = size(mk_in);
   mk_out = mk_in;

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   for i=1:dim1,
      mk_slice = squeeze(mk_out(i,:,:));
      mk_slice_filled = imfill(mk_slice, 'holes');
      mk_out(i,:,:) = mk_slice_filled;
      clear mk_slice mk_slice_filled;
   end;
      
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   for i=1:dim2,
      mk_slice = squeeze(mk_out(:,i,:));
      mk_slice_filled = imfill(mk_slice, 'holes');
      mk_out(:,i,:) = mk_slice_filled;
      clear mk_slice mk_slice_filled;
   end;

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   for i=1:dim3,
      mk_slice = squeeze(mk_out(:,:,i));
      mk_slice_filled = imfill(mk_slice, 'holes');
      mk_out(:,:,i) = mk_slice_filled;
      clear mk_slice mk_slice_filled;
   end;

