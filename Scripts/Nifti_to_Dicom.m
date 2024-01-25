function Nifti_to_Dicom(Dcm_path,NIFTI_path,seriesDescription,I)

cd(Dcm_path);

a = dir();
if isempty(a)
    a = dir('*.dcm');
else
    a = a(3:end);
end
slices = size(I,3);
Row = size(I,1);
Column = size(I,2);
% Get the Dicom header information from each of the Dicom files in RSB-038

instanceNumbers = zeros(slices,1);
for k = 1:slices
    info(k) = dicominfo(a(1).name);
    info(k).InstanceNumber = k;
%     instanceNumbers(k) = k;    
end

% [~,sortingInd] = sort(instanceNumbers);
% info = info(sortingInd);

cd(NIFTI_path);
I_f= flip(I,2);
I_p = permute(I_f,[2,1,3]);
RescaleIntercept = min(I_p(:));
RescaleSlope = max(I_p(:) - min(I_p(:))) / (2^16 - 1);
I_p = uint16((I_p-RescaleIntercept)-RescaleSlope);
mkdir(seriesDescription)
for k = 1:slices
    info(k).Rows = Row;
    info(k).Columns = Column;
    info(k).PixelSpacing = [0.3;0.3];
    info(k).SliceThickness = 0.5;
    info(k).Width = Row;
    info(k).Height = Column;
    info(k).ReconstructionDiameter = max([Row,Column]);
    info(k).RescaleIntercept = RescaleIntercept;
    info(k).RescaleSlope =RescaleSlope;
    dicomwrite(I_p(:,:,k),[seriesDescription '/File' repmat('0',1,k<100) repmat('0',1,k<10) num2str(k) '.dcm'],info(k));
    disp(['Slice ' num2str(k)])
end