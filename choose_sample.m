function patch = choose_sample(sample, costImg, patchsize, tol)
%take as input a cost image (each pixel's value is the cost of selecting 
%the patch centered at that pixel) and select a randomly sampled patch with low cost
    m = floor( patchsize/2 );
    costImg_valid = costImg( m+1:end-m, m+1:end-m );
    min_cost = min(min(costImg_valid));
    min_cost = max(min_cost, 0); 
    [y,x] = find(costImg_valid < min_cost*(1+tol)); 
    n = randi(size(y,1));
    a = y(n)+m;
    b = x(n)+m;
    patch = sample((a-m):(a+m), (b-m):(b+m),:);

end