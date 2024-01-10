function weight_split_mask(head_in, ct_header,mask_out, weight_bone, weight_others)
%%%% head_in is the 3-class mask: 3: bone, 2:st_tissue, 1:air,0:bg
addpath '/data/anlab/TongyaoW/Matlab_NIFTI_IO';
mk = niftiread(head_in);
header = niftiinfo(ct_header);
mk_new = mk; 
mk_new(mk_new==3) = weight_bone;
mk_new(mk_new==2)=weight_others;
mk_new(mk_new ==1) = weight_others; 
niftigzwrite(mk_new,mask_out,header);
end