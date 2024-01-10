function difference_plot(folder,subject,slices)
    for j = 1:length(subject)
        pct = sprintf('%s/%s_pCT.nii.gz',folder,subject{j});
        pct_img = niftiread(pct);
        mk = sprintf('%s/%s_mk.nii.gz',folder,subject{j});
        mk_img = niftiread(mk);
        ct = sprintf('%s/%s_ct.nii.gz',folder,subject{j});
        ct_img = niftiread(ct);
        difference = pct_img.*mk_img-ct_img.*mk_img;
        for i = 1:length(slices)
            filename = sprintf('%s/%s_%d.png',folder,subject{j},slices(i));
            imagesc(rot90(difference(:,:,slices(i))));
            colormap(bluewhitered);colorbar();
            saveas(gcf,filename);
        end
    end
end