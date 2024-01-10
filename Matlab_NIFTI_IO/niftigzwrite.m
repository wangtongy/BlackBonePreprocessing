%% Wraps Matlab's niftiwrite function to generate .nii.gz files

%% 2022/09/19 Chunwei
    %% Create file


function niftigzwrite(varargin)

    fileName = varargin{2};
    if strcmp(fileName(end-2:end),'.gz')
        fileName = fileName(1:end-3);
        varargin{2} = fileName;
    end

    niftiwrite(varargin{:},'Compressed',true);