function Analyze_Save_Dicom(dicompath,subject_list)
for i = 1:length(subject_list)
        subject_name = sprintf('RSB-%s',subject_list{i});
        dicomdirpath=strcat(dicompath, '/', subject_name); % create the subject's Analyze filename path
        analyze_name = 'Uncorrected_6-400';
        image=analyze75read(strcat(dicomdirpath,'/',analyze_name));
        seriesNumber = 171; % or 191 (corresponding to above series descriptions)
        image=flip(image);        
        seriesDescription = 'fl3d_vibe_GA_6-400';
        
        convertToDicom(dicomdirpath, image, seriesDescription, seriesNumber,subject_name);            
end
end