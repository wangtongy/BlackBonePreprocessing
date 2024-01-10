function edge_filtering(folder,out,subject_list,ext)
     poolobj = parpool(15);
    parfor i=1:length(subject_list)
  
        name_in = sprintf('%s/%s_%s.nii.gz',folder,subject_list{i},ext);
        name_out= sprintf('%s/%s_edge_%s.nii.gz',out,subject_list{i},ext);
        if exist(name_out,'file')
            continue
        end
        if exist(name_in,'file')
            nii2 = niftiread(name_in);
            info = niftiinfo(name_in);
            [dim1, dim2, dim3] = size(nii2);
            ImgFiltered = zeros(dim1, dim2, dim3);
%             Kernel1=[-1 -1 -1 
%             -1 9 -1 
%             -1 -1 -1];
              Kernel1=[-1/8 -1/8 -1/8 
            -1/8 2 -1/8 
            -1/8 -1/8 -1/8];
    
            for j= 1:dim3
                CTChannel = nii2(:,:,j); 
                filteredImage = conv2(double(CTChannel), Kernel1, 'same');
                ImgFiltered(:,:,j) = filteredImage;
            end
           info.Datatype = 'single';
           niftigzwrite(single(ImgFiltered),name_out,info);
        else
            fprintf('\n missing: %s \n',name_in);
            continue;
        end
    end
     delete(poolobj);
end