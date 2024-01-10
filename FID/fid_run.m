function[FID]=fid_run(name1,name2);
%Inputs are names of datastores
%outputs the Frechet Inception Distance

%load network
net = inceptionv3();


%%
%set up datastores

imds1=imageDatastore(name1);
imds2=imageDatastore(name2);



%%
%extract features
fvec1=get_net_features(imds1,net);
fvec2=get_net_features(imds2,net);

%calculate FID
FID=calc_fid(fvec1,fvec2)

