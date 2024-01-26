function final_path = generate_DCM_directory(Top_level_folder,pointer)
%%%%%%%%%%%%
% The objective of this step is to traverse all of the folders in the CT
% directory to find the location of the dcm files and save the full
% directory path in the DCM_directory matrix.  The Dicom images are typically
% located in the deepest directory.  
% NOTE: Dicom files ending in .dcm are not necessary for Step 3 below to
% convert the CT files to Nifti format.
% pointer: 0 --> ct; 1 --> mr;
% 
%%%%%%%%%%%%%
if pointer == 0
    cd(Top_level_folder)
    Sub_2layer = dir(Top_level_folder);%31 cell,loop over
    dirFlags = [Sub_2layer.isdir];
    sub_2layer = Sub_2layer(dirFlags);
    subFolderNames_2layer = {sub_2layer(3:end).name}; 
    f_name = subFolderNames_2layer{1};% first directory 
    lastlayer_dir = dir(f_name);% second directory
    dirFlags_sub = [lastlayer_dir.isdir];
    sub_3layer = lastlayer_dir(dirFlags_sub);
    temp_dir = sub_3layer(3).name;
    
    cd(f_name); % open the first directory
    DicomDir = genpath(temp_dir); 
    remain = DicomDir;
    listOfFolderNames = {};
    while true
        [singleSubFolder, remain] = strtok(remain, ':');
    if isempty(singleSubFolder)
        break;
    end
    listOfFolderNames = [listOfFolderNames singleSubFolder]; 
    end
    new_list = {};
    for i = 1:length(listOfFolderNames)
        if contains(listOfFolderNames{i},'DICOM') == 1
            new_list{end+1} = listOfFolderNames{i};
        else 
            continue
        end 
    end
    % new_list empty means no snapshots
    if isempty(new_list) && strcmp(f_name,'DICOM') == 0
        final_folder_name = listOfFolderNames{end};
        path = dir(final_folder_name);
        new_path = path(3).name;
        all_path = genpath(fullfile(final_folder_name,new_path,'DICOM'));
        slash_colon = find(all_path == ':');
        final_half = all_path(slash_colon(end-1)+1:slash_colon(end)-1);
        final_path = fullfile(Top_level_folder,f_name,final_half);
   
    elseif ~isempty(new_list)
        final_folder = new_list{end};
        final_path = fullfile(Top_level_folder,f_name,final_folder);
    elseif isempty(new_list) && strcmp(f_name,'DICOM') == 1
        final_folder = listOfFolderNames{end};
        final_path = fullfile(Top_level_folder,f_name,final_folder);
    end

elseif pointer == 1
    folder_name = 'fl3d_vibe_GA_6-400Corr';
    final_path =fullfile(Top_level_folder,folder_name);
    if ~exist(final_path,'dir')
        folder_name = 'fl3d_vibe_GA_6-400Unc';
        final_path = fullfile(Top_level_folder,folder_name);
    end
end
end