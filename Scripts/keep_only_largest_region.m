
function  keep_only_largest_region(folder, out,subject_list,ext)
   
    parfor i = 1:length(subject_list)
        fprintf('\n%s',subject_list{i});
        mk_in_name = sprintf('%s/%s_%s_mk.nii.gz',folder,subject_list{i},ext);
        mk_out_name = sprintf('%s/%s_%s_mk.nii.gz',out,subject_list{i},ext);
        if ~exist(mk_in_name,'file')
            continue
        end
        info = niftiinfo(mk_in_name);
        mk_in = niftiread(mk_in_name);
    
        dim_mk = size(mk_in);
        mk_out = mk_in;

        if length(dim_mk) == 2
          mk_labeled = bwlabel(mk_in);
        else
          mk_labeled = bwlabeln(mk_in);
        end
    
        num_regions = max(mk_labeled(:));
        fprintf('num_regions: %d',num_regions);

        if num_regions == 1
            
            continue
        else
            fprintf('\n %s',subject_list{i});
            num_in_each_region = zeros(num_regions, 1);
        
            for j=1:num_regions
              I = find(mk_labeled == j);
              num_in_each_region(j) = length(I);
              
            end
        
            [num_max, index_max] = max(num_in_each_region);
        
            I = find(mk_labeled~= index_max);
            mk_out(I) = 0;
        
            
            niftigzwrite(mk_out,mk_out_name,info);
            
        end
    end

end

