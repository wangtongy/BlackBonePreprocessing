
direc = '//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/3D_Dataset/WH/test_1/pCT_WH_96_t_86/DICOM';
img = niftiread('//tesla01.rad.wustl.edu/data/TongyaoW/BlackBoneProject/Data/3D_Dataset/WH/test_1/pCT_WH_96_t_86/02_qt.nii.gz');
I = flip(permute(img,[2 1 3]),1);

convertToDicom(dir,I,'02_pct',113);
function convertToDicom(patientDir,I,seriesDescription,seriesNumber)

% seriesDescription = 'fl3d_vibe_GA_6-400Unc' or 'fl3d_vibe_GA_6-400Corr';
% seriesNumber = 171 or 191 (corresponding to above series descriptions)

cd \\tesla01.rad.wustl.edu\data\TongyaoW\BlackBoneProject\Data\3D_Dataset\CT_Dicom\SB-02_CT_3Ddataset\DICOM\00009016\AA78E57C\AA59B9B9\00006D4C
% 240 slices for SB-030
% cd /export/data1/Cihat/BlackBone/SLCH/SB-030/DICOMs/

a = dir('*');
a = a(3:end);
if isempty(a)
    a = dir('*.dcm');
end

instanceNumbers = zeros(length(a),1);
for k = 1:length(a)
    info(k) = dicominfo(a(k).name);
end

[~,sortingInd] = sort(instanceNumbers);
info = info(sortingInd);

ind = strfind(patientDir,'SB-');
patientID = patientDir(ind:ind+5);

cd(direc)
seriesDescription ='02pct';
I = I*15000;
I = uint16(I);
mkdir(seriesDescription)
rmfield(info,{'WindowWidth'}); 
rmfield(info,{'RescaleIntercept'});
rmfield(info,{'RescaleSlope'});
% for k = 1:size(I,3)
for k = 1:length(a)
    info(k).Width = 720 ; 
    info(k).Height =722 ;
    info(k).SliceThickness = 0.5;
    info(k).Rows = 720;
    info(k).Columns = 722;
    info(k).OverlayRows_0 = 720;
    info(k).OverlayColumns_0 = 722;
    info(k).PixelSpacing = [0.3;0.3];
    % IMPORTANT: Update patient name
    dicomwrite(I(:,:,k),[seriesDescription '/File' repmat('0',1,k<100) repmat('0',1,k<10) num2str(k) '.dcm'],info(k));
    disp(['Slice ' num2str(k)])
end
end