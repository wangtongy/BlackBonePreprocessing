function[fvec]=get_net_features(imds1,net);

%augment to match network size
au1=augmentedImageDatastore([299,299],imds1);


features1 = activations(net,au1,'avg_pool');
fvec=squeeze(features1)';