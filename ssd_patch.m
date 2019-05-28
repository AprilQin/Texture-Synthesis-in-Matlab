function costImg = ssd_patch( sample, maskedTemplate, mask )
% computing the cost of sampling each patch, 
% based on the sum of squared differences (SSD) of the 
% overlapping regions of the existing and sampled patch.
    b = maskedTemplate;
    b_square = sum(sum(b.^2));
    ssd = zeros(size(sample,1),size(sample,2),3);
    
    for i = 1:3
        %(a - b)^2 = a ^ 2 - 2ab + b ^2
        a_square =  imfilter( sample(:, :, i).^2, mask);
        twoab = 2 * imfilter( sample(:, :, i), b(:, :, i) );
        ssd(:,:,i) = a_square - twoab + b_square(:,:,i);
    end
    costImg = sum(ssd,3);
        
end

