function convertToDicom(patientDir,I,seriesDescription,seriesNumber,patientID)

% seriesDescription = 'fl3d_vibe_GA_6-400Unc' or 'fl3d_vibe_GA_6-400Corr';
% seriesNumber = 171 or 191 (corresponding to above series descriptions)

% Use the Dicom header information from RSB-038 for all Dicom files
if size(I,3) == 224
    cd '/data/anlab/TongyaoW/BlackBoneProject/DicomExample/RSB-038/fl3d_vibe_GA_6-400Unc'; % Use subject RSB-038 DICOMs since this is the standard number of slices
elseif size(I,3) == 192
    cd '/data/anlab/TongyaoW/BlackBoneProject/DicomExample/RSB-019/fl3d_vibe_GA_6-400Unc'; % Use subject RSB-019 DICOMs since the DICOMs are enhanced
elseif size(I,3) == 240    
    cd '/data/anlab/TongyaoW/BlackBoneProject/DicomExample/SB-030/fl3d_vibe_GA_6-400Unc'; % Use subject SB-030 DICOMs since there are 240 slices
else
    fprintf('\nThe number of slices is %s and was not found to convert the Analyze file to Dicom.\n\n', size(I,3));
    return;
end

% Get the directory information from the Dicom directory for RSB-038
a = dir('*.IMA');
if isempty(a)
    a = dir('*.dcm');
end

% Get the Dicom header information from each of the Dicom files in RSB-038
instanceNumbers = zeros(length(a),1);
for k = 1:length(a)
    info(k) = dicominfo(a(k).name);
    instanceNumbers(k) = info(k).InstanceNumber;    
end

[~,sortingInd] = sort(instanceNumbers);
info = info(sortingInd);

% Get the participants directory name and change directory to the one
% found.

cd(patientDir);

I = I*15000; % The Analyze image contains normalized values and must be muliplied by 15000 to create the MR values.
I = uint16(I); % Make the image file uint16.
mkdir(seriesDescription)
for k = 1:size(I,3)
    info(k).SeriesDescription = seriesDescription;
    info(k).ProtocolName = seriesDescription;
    info(k).SeriesNumber = seriesNumber;
    info(k).PatientName = patientID;
    info(k).PatientID = patientID;
    dicomwrite(I(:,:,k),[seriesDescription '/File' repmat('0',1,k<100) repmat('0',1,k<10) num2str(k) '.dcm'],info(k));
    disp(['Slice ' num2str(k)])
end