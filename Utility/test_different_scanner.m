%% 
Spreadsheet = readtable('/data/anlab/TongyaoW/BlackBoneProject/Data/SB and RSB Subjects from inclusion and exclusion criteria V7d Tongyao is using 10-13-2023.xlsx');
name = Spreadsheet(1:96,4);
% Spreadsheet_new = table2cell(Spreadsheet);
name(1:96,2) = Spreadsheet(1:96,6);
name(1:96,3) = Spreadsheet(1:96,9);

name = table2cell(name);
list_Neaotom_age = {};
list_others_age = {};
for row = 1:96
     ages = name(row,3);

    if strcmp(name(row,2),'NAEOTOM Alpha') == 1
        list_Neaotom_age =[list_Neaotom_age;ages];
    else
        list_others_age = [list_others_age;ages];
    end
end

list_Neaotom = {};
list_Neaotom = {};
for row = 1:96
    subject = name(row,1);
    if strcmp(name(row,2),'NAEOTOM Alpha') == 1
        list_Neaotom =[list_Neaotom;subject];
    else
        list_Neaotom = [list_Neaotom;subject];
    end
end


list_Neaotom = [list_Neaotom,list_Neaotom_age];
list_Neaotom = [list_Neaotom,list_others_age];
%% 
for i = 1:length(list_Neaotom)
    age = list_Neaotom{i,2};
    if age >= 0 && age <= 1
        list_Neaotom{i,2} = '[0,1]';
    elseif age > 1 && age <= 2
        list_Neaotom{i,2} = '(1,2]';
    elseif age > 2 && age <= 4
        list_Neaotom{i,2} = '(2,4]';
    elseif age > 4 && age <= 6
        list_Neaotom{i,2} = '(4,6]';
    elseif age > 6 && age <= 8
        list_Neaotom{i,2} = '(6,8]';
    elseif age > 8 && age <= 10
        list_Neaotom{i,2} = '(8,10]';
    elseif age > 10 && age <= 12
        list_Neaotom{i,2} = '(10,12]';
    elseif age > 12 && age <= 14
        list_Neaotom{i,2} = '(12,14]';
    elseif age > 14 && age <= 16
        list_Neaotom{i,2} = '(14,16]';
    elseif age > 16 && age <= 18
        list_Neaotom{i,2} = '(16,18]';
    end
end

others_stdvalue = zeros(3,10);
others_meanvalue = zeros(3,10);

std_bonelist = {};
std_stlist = {};
std_airlist = {};
mean_bonelist = {};
mean_stlist = {};
mean_airlist = {};

for i = 63:length(list_others)
    ct_path = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/CT_Data';
    if length(list_others{i}) == 6
        number = list_others{i}(end-1:end);%%sb
        mk_path = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/MR2CT_old/3D_Dataset/SB_3D_Data/mask';
    else 
        number = list_others{i}(end-2:end);
        mk_path = '/data/anlab/TongyaoW/BlackBoneProject/Data/3D_Dataset/MR2CT_old/3D_Dataset/RSB_3D_Paul/mask';
    end
    data = niftiread(sprintf('%s/002_ct.nii.gz',ct_path));
    bone_mk1 = niftiread(sprintf('%s/002_mk.nii.gz',mk_path));
    bone_ct1 = data(bone_mk1 == 3);
    st_ct1 = data(bone_mk1 == 2);
    air_ct1 = data(bone_mk1 == 1);
    mean_bone = mean(bone_ct);
    mean_st = mean(st_ct);
    mean_air = mean(air_ct);
    std_bone = std(bone_ct);
    std_st = std(st_ct);
    std_air  = std(air_ct);
    mean_bonelist = [mean_bonelist;mean_bone];
    mean_stlist = [mean_stlist;mean_st];
    mean_airlist = [mean_airlist;mean_air];
    std_bonelist = [std_bonelist;std_bone];
    std_stlist = [std_stlist;std_st];
    std_airlist = [std_airlist;std_air];
end

flag = zeros(3,10);
for i = 1:length(list_others)
    agegroup = list_others{i,2};
    
    if strcmp(agegroup,'[0,1]')== 1
       flag(3,1) = flag(3,1) + 1;
        others_stdvalue(3,1) = others_stdvalue(3,1)+std_airlist{i};
        others_stdvalue(1,1) = others_stdvalue(1,1)+std_bonelist{i};
        others_stdvalue(2,1) = others_stdvalue(2,1) + std_stlist{i};
        others_meanvalue(3,1) = others_meanvalue(3,1)+mean_airlist{i};
        others_meanvalue(1,1) = others_meanvalue(1,1)+mean_bonelist{i};
        others_meanvalue(2,1) = others_meanvalue(2,1)+mean_stlist{i};
    elseif strcmp(agegroup, '(1,2]')==1
        flag(3,2) = flag(3,2) + 1;
        others_stdvalue(3,2) = others_stdvalue(3,2)+std_airlist{i};
        others_stdvalue(1,2) = others_stdvalue(1,2)+std_bonelist{i};
        others_stdvalue(2,2) = others_stdvalue(2,2) + std_stlist{i};
        others_meanvalue(3,2) = others_meanvalue(3,2)+mean_airlist{i};
        others_meanvalue(1,2) = others_meanvalue(1,2)+mean_bonelist{i};
        others_meanvalue(2,2) = others_meanvalue(2,2)+mean_stlist{i};
    elseif strcmp(agegroup,'(2,4]') ==1
        flag(3,3) = flag(3,3) + 1;
        others_stdvalue(3,3) = others_stdvalue(3,3)+std_airlist{i};
        others_stdvalue(1,3) = others_stdvalue(1,3)+std_bonelist{i};
        others_stdvalue(2,3) = others_stdvalue(2,3) + std_stlist{i};
        others_meanvalue(3,3) = others_meanvalue(3,3)+mean_airlist{i};
        others_meanvalue(1,3) = others_meanvalue(1,3)+mean_bonelist{i};
        others_meanvalue(2,3) = others_meanvalue(2,3)+mean_stlist{i};
    elseif strcmp(agegroup,'(4,6]') ==1
        flag(3,4) = flag(3,4) + 1;
        others_stdvalue(3,4) = others_stdvalue(3,4)+std_airlist{i};
        others_stdvalue(1,4) = others_stdvalue(1,4)+std_bonelist{i};
        others_stdvalue(2,4) = others_stdvalue(2,4) + std_stlist{i};
        others_meanvalue(3,4) = others_meanvalue(3,4)+mean_airlist{i};
        others_meanvalue(1,4) = others_meanvalue(1,4)+mean_bonelist{i};
        others_meanvalue(2,4) = others_meanvalue(2,4)+mean_stlist{i};
    elseif strcmp(agegroup,'(6,8]')==1
        flag(3,5) = flag(3,5) + 1;
        others_stdvalue(3,5) = others_stdvalue(3,5)+std_airlist{i};
        others_stdvalue(1,5) = others_stdvalue(1,5)+std_bonelist{i};
        others_stdvalue(2,5) = others_stdvalue(2,5) + std_stlist{i};
        others_meanvalue(3,5) = others_meanvalue(3,5)+mean_airlist{i};
        others_meanvalue(1,5) = others_meanvalue(1,5)+mean_bonelist{i};
        others_meanvalue(2,5) = others_meanvalue(2,5)+mean_stlist{i};
    elseif strcmp(agegroup,'(8,10]') == 1
        flag(3,6) = flag(3,6) + 1;
        others_stdvalue(3,6) = others_stdvalue(3,6)+std_airlist{i};
        others_stdvalue(1,6) = others_stdvalue(1,6)+std_bonelist{i};
        others_stdvalue(2,6) = others_stdvalue(2,6) + std_stlist{i};
        others_meanvalue(3,6) = others_meanvalue(3,6)+mean_airlist{i};
        others_meanvalue(1,6) = others_meanvalue(1,6)+mean_bonelist{i};
        others_meanvalue(2,6) = others_meanvalue(2,6)+mean_stlist{i};
    elseif strcmp(agegroup, '(10,12]') == 1
        flag(3,7) = flag(3,7) + 1;
        others_stdvalue(3,7) = others_stdvalue(3,7)+std_airlist{i};
        others_stdvalue(1,7) = others_stdvalue(1,7)+std_bonelist{i};
        others_stdvalue(2,7) = others_stdvalue(2,7) + std_stlist{i};
        others_meanvalue(3,7) = others_meanvalue(3,7)+mean_airlist{i};
        others_meanvalue(1,7) = others_meanvalue(1,7)+mean_bonelist{i};
        others_meanvalue(2,7) = others_meanvalue(2,7)+mean_stlist{i};
    elseif strcmp(agegroup, '(12,14]') == 1
        flag(3,8) = flag(3,8) + 1;
        others_stdvalue(3,8) = others_stdvalue(3,8)+std_airlist{i};
        others_stdvalue(1,8) = others_stdvalue(1,8)+std_bonelist{i};
        others_stdvalue(2,8) = others_stdvalue(2,8) + std_stlist{i};
        others_meanvalue(3,8) = others_meanvalue(3,8)+mean_airlist{i};
        others_meanvalue(1,8) = others_meanvalue(1,8)+mean_bonelist{i};
        others_meanvalue(2,8) = others_meanvalue(2,8)+mean_stlist{i};
    elseif strcmp(agegroup, '(14,16]') == 1
        flag(3,9) = flag(3,9) + 1;
         others_stdvalue(3,9) = others_stdvalue(3,9)+std_airlist{i};
        others_stdvalue(1,9) = others_stdvalue(1,9)+std_bonelist{i};
        others_stdvalue(2,9) = others_stdvalue(2,9) + std_stlist{i};
        others_meanvalue(3,9) = others_meanvalue(3,9)+mean_airlist{i};
        others_meanvalue(1,9) = others_meanvalue(1,9)+mean_bonelist{i};
        others_meanvalue(2,9) = others_meanvalue(2,9)+mean_stlist{i};
    elseif strcmp(agegroup, '(16,18]') == 1
        flag(3,10) = flag(3,10) + 1;
        others_stdvalue(3,10) = others_stdvalue(3,10)+std_airlist{i};
        others_stdvalue(1,10) = others_stdvalue(1,10)+std_bonelist{i};
        others_stdvalue(2,10) = others_stdvalue(2,10) + std_stlist{i};
        others_meanvalue(3,10) = others_meanvalue(3,10)+mean_airlist{i};
        others_meanvalue(1,10) = others_meanvalue(1,10)+mean_bonelist{i};
        others_meanvalue(2,10) = others_meanvalue(2,10)+mean_stlist{i};
    else
        continue
    end  
end

cate = ['(0,1]','(1,2]','(2,4]','(4,6]','(6,8]','(8,10]','(10,12]','(12,14]','(14,16]','(16,18]'];

    
    