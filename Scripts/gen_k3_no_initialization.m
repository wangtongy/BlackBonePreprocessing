
% This is part of the package developed to determine consistent brain region for CSF volume analysis in brain CT.
% Please contact yasheng.chen@gmail.com for questions and comments.
% Created on Nov 14, 2018
% author: Yasheng Chen

function gen_k3_no_initialization(im, mk,info, name_k3)
   addpath('/data/anlab/TongyaoW/ParnaMR2CT prep/Matlab_NIFTI_IO');
   
   I = find(mk>0);
   val = im(I);
   [idx, c] = kmeans(val, 3,'MaxIter',10000000);

   [c_sorted, c_index] = sort(c, 'ascend');

   labels = zeros(size(val));
   I1=find(idx==c_index(1));
   I2=find(idx==c_index(2));
   I3=find(idx==c_index(3));

   labels(I1) = 1;
   labels(I2) = 2;
   labels(I3) = 3;

   k3_out = zeros(size(mk));
   k3_out(I) = labels;
   k3_out = single(k3_out);
   niftigzwrite(k3_out,name_k3,info);
end