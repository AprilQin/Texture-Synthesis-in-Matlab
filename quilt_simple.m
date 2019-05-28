function outputTexture = quilt_simple(sample, outsize, patchsize, overlap, tol)
%randomly samples square patches of size patchsize from sample in order to create an output image of size outsize. 
%Start by sampling a random patch for the upper-left corner. 
%Then sample new patches to overlap with existing ones. 
%For example, the second patch along the top row will overlap by patchsize pixels in the vertical direction and overlap pixels in the horizontal direction. 
%Patches in the first column will overlap by patchsize pixels in the horizontal direction and overlap pixels in the vertical direction. 
%Other patches will have two overlapping regions (on the top and left) which should both be taken into account. 
%Once the cost of each patch has been computed, randomly choose on patch whose cost is less 
%than a threshold determined by tol (see description of choose_sample below). 
    % Algorithm
    %1: Initialize Is
    %2: for each patch Pold in Is do
    %3:     Select a compatible patch Pin ?I0using the Patch Selection algorithm (see Algorithm 2)
    %4:     Compute minimum error boundary cut between Pold and Pin (see Algorithm 3)
    %5:     Construct the patch Pnew by blending Pold and Pin along the boundary cut (see Equation (4))
    %6:     Replace Pold with Pnew within Is
    %7:  end for 
    
    %1
    [height, width, depth] = size(sample);%get resolution os the input texture sample
    outputTexture = zeros(outsize, outsize, depth);%create an empty canvas as the outputTexture
    N = floor( outsize/ (patchsize - floor(overlap/2)) );%calculate how many horizontal patches(same number of vertical patches)
                                                   %two patches share an
                                                   %overlap region. so it's
                                                 
    x = randi(height - patchsize)-1; %randomly select the x index of first patch to start with
    y = randi(width - patchsize)-1;%randomly select the y index of first patch to start with
    
    %%create 3 types of masks
    maskLeft = zeros(patchsize, patchsize);
    maskTop = zeros(patchsize, patchsize);
    maskLShape = zeros(patchsize, patchsize);
    maskLeft(1:patchsize, 1:overlap) = 1;
    maskTop(1:overlap, 1:patchsize) = 1;
    maskLShape(1:patchsize, 1:overlap) = 1;
    maskLShape(1:overlap, 1:patchsize) = 1;
    
    diff = patchsize - overlap;
    row = 1;  %s is the starting index
    col = diff+1; 
    
    %%2
    for i = 1 : 1 : N
        for j = 1 : 1 : N
            
            if (i == 1 && j == 1)
                %copy the first patch over to the top left corner of the output texture
                for a = 1 : 1 : patchsize
                    for b = 1 : 1 :patchsize
                        outputTexture(a, b, :) = sample(x + a, y + b, :);
                    end
                end
                
            else
                %%select a mask
                if (i == 1)
                    mask = maskLeft;
                elseif (i ~= 1 && j == 1 )
                    mask = maskTop;
                else
                    mask = maskLShape;
                end
                %fill the current masked_template
                masked_template = outputTexture( row : row + patchsize -1, col: col + patchsize -1, :);
                %%calculate cost image for the overlapping region 
                costImg = ssd_patch( sample, masked_template, mask);
                patch_in = choose_sample(sample, costImg, patchsize, tol);
                %%copy the selected patch with low ssd over(fill the overlapping region completely)
                outputTexture(row : row + patchsize -1, col: col + patchsize -1, :) = patch_in;
                    
                %update index of the new patch to be filled
                col = col + diff;  
            end
            
        end
        row = row + diff;
        col = 1;
    end
    
end



