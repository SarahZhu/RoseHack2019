% Read it in with wavread()
dir = "/Users/Sarah/RoseHack2019/wav/";
%[signal,fs] = wavread([dir,'403233__klankbeeld__cowmoo-horsesneight-170917-1223.wav']);
h=1000;
% [signal1,fs1] = audioread('403233__klankbeeld__cowmoo-horsesneight-170917-1223.wav');
% [signal2,fs2] = audioread('397069__klankbeeld__bees-and-birds-170601-1190.wav');
% [signal3,fs3] = audioread('352711__klankbeeld__bat-15-khz-10-percent.wav');
% [signal4,fs4] = audioread('346658__klankbeeld__city-hum-night-160505-00.wav');
% [signal5,fs5] = audioread('412084__klankbeeld__coast-7am-nl-dishoek-05-170505-1129.wav');

[signal1,fs1] = audioread('birds/416529__inspectorj__bird-whistling-single-robin-a.wav');
[signal2,fs2] = audioread('birds/397069__klankbeeld__bees-and-birds-170601-1190.wav');
[signal3,fs3] = audioread('birds/424138__straget__cranes-3.wav');

% If signal is Nx2 (two columns), extract one of them
% signal2 = signal(:,1);
% If you have the Signal Processing Toolbox, enter
% spct = spectrum.periodogram;
% figure; 
% plot(psd(spct,signal,'Fs',fs,'NFFT',length(signal)));
signal1_44100 = signal1(1:480/441:end,:);
signal3_44100 = signal3(1:2:end,:);

[sig_l1,sig_r1] = preprocess_signal(signal1,h,h);
figure;
plot(sig_l1);hold on;plot(sig_r1);hold off;
M = zeros(h,h);
M1 = encode_sig2matrix(sig_l1,sig_r1,M,h);

%%
function [sig_left,sig_right] = preprocess_signal(signal,input_height,input_width)
    %input_height = 108; input_width = 108;
    sig_left = signal(:,1); sig_right = signal(:,2); %left & right channel deposition
    [sig_x, ~] = size(signal);
    ratio_x = sig_x/input_width;
    sig_left = sig_left(1:round(ratio_x):end);% scale on x axis
    sig_right = sig_right(1:round(ratio_x):end);
    diff_left = 0 - min(sig_left); diff_right = 0 - min(sig_right);
    sig_left = sig_left + diff_left;
    sig_right = sig_right + diff_right;
    sort_l = sort(sig_left);
    sort_r = sort(sig_right);
    ratio_y_left = (input_height/2-1) / (sort_l(end)-sort_l(1));
    ratio_y_right = (input_height/2-1) / (sort_r(end)-sort_r(1));
    sig_left = sig_left * ratio_y_left;
    sig_right = sig_right * ratio_y_right;

end

function [M] = encode_sig2matrix(sig_left,sig_right,M,h)
    for i = 1:length(sig_left)
        y_idx_l = sig_left(i)+h/2;
        y_idx_r = sig_right(i)+1;
%         disp([round(y_idx_l),round(y_idx_r)]);
        M(i,round(y_idx_l)) = 1; M(i,round(y_idx_r)) = 1;

    end
       
end

