%% shuffle 

loop_thru_get_number('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/Interpolation','number.txt');
total_number = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/Interpolation/number.txt');
shuffled = total_number(randperm(length(total_number)));
group_ele = ceil(60/5);

for j = 1:4
    group = {};
    for i = 1:group_ele
        group(1:group_ele) = shuffled(((j-1)*group_ele+1):j*group_ele);
        fid = fopen(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/test_g%d.txt',j),'at');
        fprintf(fid,'%s\n',group{i});
        fclose(fid);
    end
end

group=shuffled((4*group_ele+1):end);

fid = fopen('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/test_g5.txt','at');
for i = 1:length(group)
    fprintf(fid,'%s\n',group{i});
end
fclose(fid);

%% save training and validation
t1 = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/test_g1.txt');
t2 = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/test_g2.txt');
t3 = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/test_g3.txt');
t4 = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/test_g4.txt');
t5 = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/test_g5.txt');

trend1 = [t2,t3,t4,t5];
trend1 = trend1(randperm(length(trend1)));
trend2 = [t1,t3,t4,t5];
trend2 = trend2(randperm(length(trend2)));
trend3 = [t1,t2,t4,t5];
trend3 = trend3(randperm(length(trend3)));
trend4 = [t1,t2,t3,t5];
trend4 = trend4(randperm(length(trend4)));
trend5 = [t1,t2,t3,t4];
trend5 = trend5(randperm(length(trend5)));


training = load_names('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/training_g1_.txt');
for j = 1:length(training)
    copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/normalization/%s_ct.nii.gz',training{j}),'/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_g1');
    copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/normalization/%s_mk.nii.gz',test{j}),'/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_g1');
end

for i = 1:5
    training = sprintf('training%d',i);
    trends = eval(sprintf('trend%d',i));
    training = trends(1:44);
    fid = fopen(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/training_g%d_.txt',i),'at');
    for a = 1:length(training)
        fprintf(fid,'%s\n',training{a});
    end
fclose(fid);
end

for i = 1:5
    valid = sprintf('validation%d',i);
    valid = {};
    trends = eval(sprintf('trend%d',i));
    valid = trends(45:end);
    fid = fopen(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/validation_g%d_.txt',i),'at');
    for a = 1:length(valid)
        fprintf(fid,'%s\n',valid{a});
    end
fclose(fid);
end
%% Move files from training_1 to a new folder

addpath('/data/anlab/TongyaoW/ParnaMR2CT prep');
for i = 1:5
    mkdir(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_training_g%d',i));
    training = load_names(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/training_g%d_.txt',i));
    for j = 1:length(training)
        copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/Interpolation/%s_mk.nii.gz',training{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_training_g%d',i));
        copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/Interpolation/%s_r1.nii.gz',training{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_training_g%d',i));
        copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/Interpolation/%s_ct.nii.gz',training{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_training_g%d',i));
    end
end 

training = load_names(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/group_number/training_g1_.txt'));

for j = 1:length(training)
%         copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/normalization/%s_r1.nii.gz',training{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/Final_Data_Group/training_g%d',2));
%         copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/normalization/%s_ct.nii.gz',training{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/Final_Data_Group/training_g%d',2));
        copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/MR_brain_mask/%s_mk.nii.gz',training{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/Final_Data_Group/BM_training_g%d',1));
end

for i = 1:5
    %mkdir(sprintf('/data/anlab/TongyaoW/BlackBoneProject/ReplicateParna/training_g%d',i));
    %training = load_names(sprintf('/data/anlab/TongyaoW/BlackBoneProject/ReplicateParna/training_g%d_.txt',i));
    for j = 1:length(training)
        copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/normalization/%s_r1.nii.gz',training{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/Final_Data_Group/training_g%d',i));
        copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/normalization/%s_ct.nii.gz',training{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/1mm_Bone/NewData/Final_Data_Group/training_g%d',i));

    end
end 

for i = 1:5
    mkdir(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_validation_g%d',i));
    validation = load_names(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/validation_g%d_.txt',i));
    for j = 1:length(validation)
        copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/Interpolation/%s_mk.nii.gz',validation{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_validation_g%d',i));
        copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/Interpolation/%s_r1.nii.gz',validation{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_validation_g%d',i));
        copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/Interpolation/%s_ct.nii.gz',validation{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_validation_g%d',i));
    end
end 




for i = 1:5
    %mkdir(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_test_g%d',i))
    test = load_names(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/test_g%d.txt',i));
    
    for j = 1:length(test)
        file = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/Interpolation_non_norm/%s_mk.nii.gz',test{j});
        if exist(file,'file')
            copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/Interpolation_non_norm/%s_mk.nii.gz',test{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_test_g%d',i));
        %copyfil
        %copyfile(sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/Interpolation/%s_r1.nii.gz',test{j}),sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/New_resol_test_g%d',i));
        
        else
            continue
        end
    end
   
end

%% 

subject = {'37','021','54','55'};
for i = 1:length(subject)
    mri = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/test_normalization/%s_r1.nii.gz',subject{i});
    mk = sprintf('/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/Whole_data_set/%s_mk.nii.gz',subject{i});
    out = '/data/anlab/TongyaoW/BlackBoneProject/Data/MR2CT/3D_Dataset/pCT_Old_resol_test_g1/';
    copyfile(mri,out)
    copyfile(mk,out)
end
