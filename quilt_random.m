function outputTexture = quilt_random(sample, outsize, patchsize)
%randomly samples square patches of size patchsize from sample in order to create an output image of size outsize. 
%Start from the upper-left corner, and tile samples until the image is full. 
%If the patches don't fit evenly into the output image, you can leave black borders at the edges. 
%This is the simplest but least effective method. Save a result from a sample image to compare to the next two methods.
    
    [height, width, depth] = size(sample); %get the resolution of the sample texture image
    N = floor(outsize / patchsize);
    outputTexture = zeros(outsize, outsize, depth); %empty output texture to start with
    %outputTexture = zeros(patchsize, patchsize, 3);
    
    %%run a double for loop to fill the outputTexture canvas
    for i = 0 : 1: N
        for j = 0 : 1 : N
            %randomly select a patch from input texture
            %needs to select two values x, and y randomly as the most topleft pixel to
            %identify a unique patch (and remember x can't exceed the number of pixels veritically, which is 
            %height, and height needs to minus size of patch. same for y, so y <= width - patchsize)
            x = randi(height - patchsize)-1;
            y = randi(width - patchsize)-1;
            %copy the patch over to the output texture canavs
            for a = 1 : 1 : patchsize
                for b = 1 : 1 :patchsize
%                     sample_value = zeros(3);
%                     sample_value = sample(x + a, y + b, :);
                    outputTexture(i*patchsize + a, j*patchsize + b, :) = sample(x + a, y + b, :);
                    %outputTexture(a, b, :) = sample(x + a, y + b, :);
                    %outputTexture(1,1,:) = sample(x+a, y+b, :);
                end
            end
            
        end
    end
    %crop it to the output size
    outputTexture = outputTexture(1:outsize,1:outsize,:);
    
end

