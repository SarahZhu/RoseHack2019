function [arr_expanded] = expand_pad(arr,p)
    %input, 8*1
    [m,n] = size(arr);
    step = 1;
    
    x = 1:1:m;
    xi = 1:step/p:m;
    yi = interp1(x,arr, xi,'linear');
    arr_expanded = yi';%output, 22*1
end