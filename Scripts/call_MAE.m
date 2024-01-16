
path = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/WH';
validation_2 = load_names(sprintf('%s/validation_g2.txt',path));
List1 = 50; 
List2 = 51:10:401;
List3 = 400:5:480;
% List4 = 423:5:443;
% List5 = 444:449;
model_number = [List1,List2,List3];
MAE_noedge_bone3 = zeros(length(model_number),7);
for i = 1:length(model_number)
    folder_ct = sprintf('%s/ModelD_WH_patch_96_edge/validation_2',path);
    folder_pct = sprintf('%s/ModelD_WH_patch_96_edge/validation_2/pCT/model_%d',path,model_number(i));
    L2 = calculate_whole_head_MAE(folder_ct,folder_pct,validation_2,'edge_ct','qt');
    MAE_noedge_bone3(i,:) = L2;
end

% MAE_BaselineBA = [];

List1 = 630:2:642; 
% List2 = 51:5:121;
% List3 = 122:2:132;
% List4 = 133:143;
MAE_patch96_WH = zeros(length(model_number),1);
model_number = List1;
parpool(8);
for i = 1:length(model_number)
    folder_ct = sprintf('%s/WH_overweighting/test_02',path);
    folder_pct = sprintf('%s/WH_overweighting/test_02/pCT/model_%d',path,model_number(i));
    L2 = calculate_whole_head_MAE(folder_ct,folder_pct,test_02,'nonorm_ct','qt');
    MAE_patch96_WH(i,:)=L2;
end

