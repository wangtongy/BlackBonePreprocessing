function dcm2nii(folderT1Dcm,subject_number,pointer)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%folderT1Dcm: top level folder that contains sub-folder of subject dicoms; 
%%subject_number: cell contains subject id; 2digit for SB (e.g 02), 3digit for RSB(e.g 002); 
%%0 is ct, 1 is mr;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(subject_number)
    name1 = sprintf('%s/%s_dcm',folderT1Dcm,subject_number{i});
    name1nii = strcat(name1,'.nii.gz');
    if exist(name1nii,'file')
        continue
    end
   
    if length(subject_number{i})== 3
        prefix = 'RSB';
    else
        prefix = 'SB';
    end
    disp(pointer);
     if pointer == 0 %'ct'
            disp(pointer)
            folder_name = sprintf('%s-%s_CT_3Ddataset',prefix, subject_number{i});
            Top_folder = fullfile(folderT1Dcm,folder_name);
    elseif pointer == 1 %'mr'
        folder_name = sprintf('%s-0%s',prefix,subject_number{i});
        Top_folder = fullfile(folderT1Dcm,folder_name);
    end
    disp(Top_folder);
    dcm_folder = generate_DCM_directory(Top_folder,pointer);
    name = sprintf('%s_dcm',subject_number{i});
    dcm2niix1 = sprintf('/data/anlab/TongyaoW/mricron/dcm2niix -9 -b n y -z y -v 0 -f  %s -o %s %s',name, folderT1Dcm,dcm_folder);
    system(dcm2niix1);
    cd(folderT1Dcm);
end
end 