function convertToDicom(patientDir,I,seriesDescription,seriesNumber)

% seriesDescription = 'fl3d_vibe_GA_6-400Unc' or 'fl3d_vibe_GA_6-400Corr';
% seriesNumber = 171 or 191 (corresponding to above series descriptions)

if size(I,3) <= 224
    cd /export/data1/Cihat/BlackBone/CCIR/SB-019/DICOMs/ % Use 19 DICOMs for 22 as the DICOMs are enhanced
else
    % 240 slices for SB-030
    cd /export/data1/Cihat/BlackBone/SLCH/SB-030/DICOMs/
end

a = dir('*.IMA');
if isempty(a)
    a = dir('*.dcm');
end

instanceNumbers = zeros(length(a),1);
for k = 1:length(a)
    info(k) = dicominfo(a(k).name);
    instanceNumbers(k) = info(k).InstanceNumber;    
end

[~,sortingInd] = sort(instanceNumbers);
info = info(sortingInd);

ind = strfind(patientDir,'SB-');
patientID = patientDir(ind:ind+5);

cd(patientDir)

I = I*15000;
I = uint16(I);
mkdir(seriesDescription)
for k = 1:size(I,3)
    info(k).SeriesDescription = seriesDescription;
    info(k).ProtocolName = seriesDescription;
    info(k).SeriesNumber = seriesNumber;
    % IMPORTANT: Update patient name
    info(k).PatientName = patientID;
    info(k).PatientID = patientID;
    dicomwrite(I(:,:,k),[seriesDescription '/File' repmat('0',1,k<100) repmat('0',1,k<10) num2str(k) '.dcm'],info(k));
    disp(['Slice ' num2str(k)])
end