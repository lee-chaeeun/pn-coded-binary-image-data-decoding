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

%% Q4.
% Parameters for oroginal data
row = 100;  % row size of image matrix
col = 100;  % column size of image matrix 

load('encoded_data.mat'); %variable name: mod_data

% Decoding - You should write your codes for decoding 
M= reshape(mod_data, [100,10000]);   %mod_data�� 1000000���̹Ƿ� 100���� ������ 10000���� ����

k=6;
% for k = 1:10�� �׽�Ʈ�� ��� k=6�� ���� �����ϴٰ� �Ǵ���. �ڼ��� ������ ������ Q4��
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
title(str) %imshow ��ɾ �̿��� �̹����� ��Ÿ��

%% Q5
% threshold�� ����
for i=1:100
    for j=1:100
        if Xout(i,j)<0 %0���� ������ 1
            Xout(i,j)=1;
        else %0���� ũ�� 0
            Xout(i,j)=0;
        end
    end
end


%% Q6
    
subplot(1,2,2)
imshow(Xout,[]);
str = sprintf('After Threshold');
title(str) % threshold ���� �� image

