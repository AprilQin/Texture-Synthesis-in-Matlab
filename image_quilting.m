clear; close all;


%why need to convert to double???? I get a white image if I don't, but
%why???rgb values are just integers, why need to convert to double??

inputTexture = im2single ( imread('./samples/texture3.jpg') );
figure(3), hold off, imshow(inputTexture);

output1 = quilt_random(inputTexture, 700, 150);
figure(4), hold off, imshow(output1);

%output2 = quilt_simple(inputTexture, 700, 91, 25, 0.2);
%figure(5), hold off, imshow(output2);
