function Registration(folder,subject_number,dofnumber,inext,refext,outext)
parfor i = 1:length(subject_number)
    tic
    nameIn = sprintf('%s/%s_%s.nii.gz',folder,subject_number{i},inext);
    nameRef = sprintf('%s/%s_%s.nii.gz',folder,subject_number{i},refext);
    nameMat = sprintf('%s/transform_matrix/%s_transform.nii.gz',folder,subject_number{i});
    nameOut = sprintf('%s/%s_%s.nii.gz',folder,subject_number{i},outext);
    refweight = sprintf('%s/%s_weighted_bone_mk.nii.gz',folder,subject_number{i});
    if ~exist(nameIn,'file')
        fprintf('\n ~exist %s \n',nameIn);
        continue
    end
       if ~exist(refweight,'file')
           fprintf('\n ~exist %s \n',refweight);
           continue
       end
    if ~exist(nameRef,'file')
        
        fprintf('\n ~exist %s \n',nameRef);
        continue
    end
    
    
    flirt = sprintf('flirt -dof %d -cost mutualinfo  -in %s -ref %s -omat %s -refweight %s -o %s', dofnumber,nameIn, nameRef, nameMat, refweight, nameOut);
    disp(flirt);
    system(flirt);
   
    disp('loading ct header...');
    ctheader = niftiinfo(nameRef);
    reg_mr = niftiread(nameOut);
    niftigzwrite(single(reg_mr), nameOut,ctheader);
    disp('ct header copy completed');
    toc
end 

end