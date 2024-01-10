
function normalize_images_in_dir(name_input_dir, name_output_dir, names_all,name_ext, sign_group_normalization)

if sign_group_normalization == 1
    [mean_group,std_group,nums_ct] = calculate_mean_std_group(name_input_dir,names_all);
% write mean and std out;
    T = table(mean_group, std_group, nums_ct,'VariableNames',{'mean_group','std_group','number of ct'});
    nametable = sprintf('%s/mean_std_ct.txt',name_input_dir);
    writetable(T,nametable);
end
nums_all = length(names_all);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%normalize the images
%     poolobj = parpool(15);
    for i=1,
       nnn = names_all{i};
       if strcmp(name_ext,'ct') == 1
           new_ext = 'edge';
       else
           new_ext = 'nonorm';
       end
       name_in = sprintf('%s/%s_%s_%s.nii.gz', name_input_dir, nnn,new_ext, name_ext);
       name_mk = sprintf('%s/%s_%s_mk.nii.gz', name_input_dir, nnn,name_ext);
       name_out = sprintf('%s/%s_%s.nii.gz', name_output_dir, nnn, name_ext);
       if ~exist(name_mk,'file')
           disp('no mask');
           continue
       end

       nii = niftiread(name_in);
       mk = niftiread(name_mk); 
       clear name_mk name_nii;

       im_out = nii.*mk; %make the background as 0;
       I1 = find(mk>0);
       if strcmp(name_ext, 'ct') == 1 % make the background of ct as -1000;for mr, background is still 0;
          im_out(mk == 0) = -1000;
       end

       if ~exist(name_in,'file')
           fprintf('\n missing: %s \n',name_in)
           continue 
       end

       info = niftiinfo(name_in);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       if sign_group_normalization == 0
          val = im_out(I1); %value inside of the head mask;
          meanv = mean(val); % mean calculated based of the values inside the head
          stdv = std(val); 
          im_out = (im_out-meanv)/(2*stdv);
       else
          im_out = (im_out-mean_group) / (2*std_group);
       end;

        J1 = find(im_out>2);
       J0 = find(im_out<-2);  
       im_out(J1) = 2;
       im_out(J0) = -2;


       info.Datatype = 'single';

       niftigzwrite(single(im_out), name_out, info);

       %%%%%%%%%%%%%%%%
       clear name_in name_out nii im im_out J0 J1;
       clear nnn name_mk nii mk I0 I1 nii;
    end
    delete(poolobj);
