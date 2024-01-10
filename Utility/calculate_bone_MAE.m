function L2 = calculate_bone_MAE(folder_CT,folder_pCT,subject_list,ext_ct,ext)
    L2 = zeros(1,length(subject_list));
    parfor i = 1:length(subject_list)
        tic
        %%%%%%% non-normalized CT %%%%%%%%
        name_ct = sprintf('%s/%s_%s.nii.gz',folder_CT, subject_list{i},ext_ct);
        %%%%%%% pCT %%%%%%%%%%%%%%%
        name_in1= sprintf('%s/%s_%s.nii.gz',folder_pCT,subject_list{i},ext);% pct
        %%%%%%% whole head %%%%%%%%%
        whole_mk = sprintf('%s/%s_seg_mk.nii.gz',folder_CT,subject_list{i});
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ~exist(name_in1,'file')
            fprintf('\n missing: %s \n',name_in1);
            continue
        end
        pct = niftiread(name_in1);% pCT
        mk = niftiread(whole_mk);
        ct = niftiread(name_ct);
        new_pct = pct;
        new_ct = ct;
        new_ct(mk ~= 3) = 0;
        new_pct(mk ~= 3) = 0;
        im=double(new_ct);
        im2=double(new_pct);

        val_tmp = im(mk == 3);% CT value inside head

        MAEvalue=sum(abs(im(:)-im2(:)))/numel(val_tmp);

        L2(1,i)=MAEvalue;%save all subjects for each model
        toc
    end
end
