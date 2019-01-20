function [y,y_o,sig_l_arr,sig_r_arr] = decode_mat2signal2(M,h)
%     M = M/255.0;
%     [x,y] = size(M);
%     for i = 1:x
%         for j = 1:y
%             M(i,j) = 1-(M(i,j) <  0.5);
%         end
%     end
%     
    %decompose matrix
    M = M';
    sig_l_arr = zeros(h,1); sig_r_arr = zeros(h,1);
    sig_l_mat = M(1:h/2,:); sig_r_mat = M(h/2+1:end,:);
    for i = 1:h
        [~,idx_l] = max(sig_l_mat(:,i));sig_l_arr(i)=idx_l; 
        [~,idx_r] = max(sig_r_mat(:,i));sig_r_arr(i)=idx_r; 
    end
    y = zeros(h,2);
    
    %y(:,1) = (sig_l_arr-mean(sig_l_arr)/255);y(:,2) = (sig_r_arr-mean(sig_r_arr)/255);
    %y(:,1) = sig_l_arr/(255.0/2); y(:,2) = sig_r_arr/(255.0/2);
    y(:,1) = normalize(sig_l_arr,'range', [-1 1]);
    y(:,2) = normalize(sig_r_arr,'range', [-1 1]);
    Fs = 48000;
    
    p = 120;
    y_o1 = expand_pad(y(:,1),p); y_o2 = expand_pad(y(:,2),p); 
    disp(size(y_o1));
    y_o1=[y_o1',y_o1',y_o1']; y_o2=[y_o2',y_o2',y_o2'];
    y_o = [y_o1',y_o2'];
    sound(y_o,Fs);
    

    
end