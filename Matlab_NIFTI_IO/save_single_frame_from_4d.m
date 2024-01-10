
function save_single_frame_from_4d(name_in, name_out, index)

   infoIn = niftiinfo(name_in);
   imgIn = double(niftiread(name_in));

   imgOut = squeeze(imgIn(:,:,:,index));
   infoIn.ImageSize(4) = [];
   infoIn.PixelDimensions(4) = [];

   niftigzwrite(imgOut,name_out,infoIn);

   clear nii;
   
