function [y,sig_l_arr,sig_r_arr] = decode_mat2signal(M)
    M = M/255.0;
    [x,y] = size(M);
    for i = 1:x
        for j = 1:y
            M(i,j) = 1-(M(i,j) <  0.5);
        end
    end
    
    %decompose matrix
    sig_l_arr = zeros(64,1); sig_r_arr = zeros(64,1);
    sig_l_mat = M(1:32,:); sig_r_mat = M(33:end,:);
    for i = 1:32
        for j = 1:64
            if sig_l_mat(i,j)==1
                sig_l_arr(i) = j;
            end
            
            if sig_r_mat(i,j)==1
                sig_r_arr(i) = j;
            end
        end
    end
    y = zeros(64,2);
    
    y(:,1) = (sig_l_arr-mean(sig_l_arr)/255);y(:,2) = (sig_r_arr-mean(sig_r_arr)/255);
    Fs = 48000;
    sound(y/64,Fs);
    