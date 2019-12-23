% 2019 Fall - Communications Lab. Project
% Prepared by Prof. Hyunggon Park
% Multiagent Communications and Networking Lab.
% Dept. of Electronic and Electrical Engineering
% Ewha Womans University

clear all
close all

% Generation of 10 PN sequences with different shifts
% 
PN_max=10;
tmp=[];
for kk=1:PN_max
    h = commsrc.pn('Shift',kk);
    set(h,'NumBitsOut',100);
    tmp=generate(h)*2-1;
    PN_seq(kk,:)=tmp';
end

% Parameters for oroginal data
row = 100;  % row size of image matrix
col = 100;  % column size of image matrix 

load('encoded_data.mat'); %variable name: mod_data

% Decoding - You should write your codes for decoding 
M= reshape(mod_data, [100,10000]);   %mod_data가 1000000개이므로 100개씩 나누면 10000개가 나옴

k=1;
% for k = 1:10
out=size(1,10000);
for i=1:10000
     mod_data_temp(1,i)=PN_seq(k,:)*M(:,i);
     out(1,i)=mod_data_temp(1,i);
end
outdata=reshape(out,[100,100]);
Xout=outdata';

    
figure; subplot(1,2,1)
imshow(Xout,[]);
str = sprintf('Before Threshold');
title(str) %imshow 명령어를 이용해 이미지를 나타냄

%% Q5
% threshold의 설정
for i=1:100
    for j=1:100
        if Xout(i,j)<0 %0보다 작으면 1
            Xout(i,j)=1;
        else %0보다 크면 0
            Xout(i,j)=0;
        end
    end
end

subplot(1,2,2)
imshow(Xout,[]);
str = sprintf('After Threshold');
title(str) % threshold를 설정후에 image

mod_data = zeros(1,1000000);
load('encoded_data.mat'); % variable name: mod_data

sigma = 1:10;
% x-axis signmais presented as log10(1/sigma)
sigma = log10(1./sigma);

%create 10 components to save ber data
ber = zeros(1,10);

for  x =1:10 %repeat for signma 1 through 10
   
    % Parameters for original data
    row = 100;  % row size of image matrix
    col = 100;  % column size of image matrix
   
    %mod_data = 1000000 -> division by 100 -> 10000
    mod_data = zeros(1,1000000);
    load('encoded_data.mat'); % variable name: mod_data
    mod_data = mod_data+normrnd(0, x, 1,length(mod_data)); % AWGN noise
    
    %mod_data가 1000000개이므로 100개씩 나누면 10000개가 나옴
    M= reshape(mod_data, [100,10000]);   

    out_awgn=size(1,10000);
    for i=1:10000
        mod_data_temp(1,i)=PN_seq(6,:)*M(:,i);
        out(1,i)=mod_data_temp(1,i);
    end
    outdata_awgn =reshape(out,[100,100]);
    Xout_awgn =outdata_awgn';

    % threshold
    for i=1:100
        for j=1:100
            if Xout_awgn(i,j)<0 % if less than 0, set output as 1
                Xout_awgn(i,j)=1;
            else
            Xout_awgn(i,j)=0; % if greater than 0, set output as 0
            end
        end
    end
   
    %Q7 with additive noise in matlab code where sigma = 4
    if x == 4
        figure;imshow(Xout_awgn,[]); title('sigma = 4')
    end
    
    %Q8 with additive noise in matlab code
    error2 =0;
    error = 0; %initialize error value 
    for p =1:100 %to increase accuracy error is calculated 100 times
        for i=1:100
            for j = 1:100
                if Xout_awgn(i,j) ~= Xout(i,j)  
                    error = error+1;
                    % check if there exists a difference between Xout with
                    % awgn and Xout without awgn. 
                    %in case of difference, error is counted.
                end
            end
        end
        error2 = error2  + error; %error is counted 100 times here
    end
    error2 = error2/100; %error is averaged out over 100 times
    ber(x) = error2/10000; %average number of errors over 100 cycles is divded by the total transmitted data
  
end

figure; semilogy(sigma, ber) %plot is made with sigma in log form
ylabel('BER')
xlabel('log10(1/\sigma)') 
str = sprintf('Relationship between BER & omega: k = %d', k);
title(str) 

