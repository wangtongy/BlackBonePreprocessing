function Registration_again(folder,subject_number,dofnumber, costfunction)
parfor i = 1:length(subject_number)
    tic
    nameIn = sprintf('%s/%s_nonorm_r1.nii.gz',folder,subject_number{i});
    nameRef = sprintf('%s/%s_nonorm_ct.nii.gz',folder,subject_number{i});
    nameMat = sprintf('%s/transform_matrix/%s_transform.nii.gz',folder,subject_number{i});
    nameOut = sprintf('%s/%s_nonorm_r1_new.nii.gz',folder,subject_number{i});
    refweight = sprintf('%s/%s_weighted_bone_mk.nii.gz',folder,subject_number{i});
    if ~exist(nameIn,'file')
        fprintf('\n ~exist %s \n',nameIn);
        continue
    end

%    if ~exist(refweight,'file')
%        fprintf('\n ~exist %s \n',refweight);
%        continue
%    end
    if ~exist(nameRef,'file')
        fprintf('\n ~exist %s \n',nameRef);
        continue
    end
    
    
     flirt = sprintf('flirt -dof %d -cost %s  -in %s -ref %s -omat %s -refweight %s -o %s', dofnumber,costfunction,nameIn, nameRef, nameMat, refweight, nameOut);
%     flirt = sprintf('flirt -dof %d -cost %s  -in %s -ref %s -omat %s -o %s', dofnumber,costfunction,nameIn, nameRef, nameMat, nameOut);
    disp(flirt);
    system(flirt);
   
    disp('loading ct header...');
    ctheader = niftiinfo(nameRef);
    reg_mr = niftiread(nameOut);
    niftigzwrite(reg_mr, nameOut,ctheader);
    disp('ct header copy completed');
    toc
end 
end