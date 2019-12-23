% 2019 Fall - Communications Lab. Project
% Prepared by Prof. Hyunggon Park
% Multiagent Communications and Networking Lab.
% Dept. of Electronic and Electrical Engineering
% Ewha Womans University

clear all
close all

% Generation of 5 PN sequences with different shifts
% 
PN_max=5;
tmp=[];
for kk=1:PN_max
    h = commsrc.pn('Shift',kk);
    set(h,'NumBitsOut',100);
    tmp=generate(h)*2-1;
    PN_seq(kk,:)=tmp';
end


% You should write codes for Q1 and Q2
%% Q1
PN_max=1; %set shift parameter to 1 
tmp=[];
for kk=1:PN_max
    h = commsrc.pn('Shift',kk); 
    set(h,'NumBitsOut',100); %length of PN sequence is set to 100
    tmp=generate(h)*2-1;
    PN_seq1(kk,:)=tmp;
end
x=PN_seq1 %1x100 PN sequence matrix created
stairs(x); %plot PN using stairs function

%% Q2
%Generation of 5 PN sequences with different shifts

PN_max=5; %set max shift parameter to 1 
tmp=[];

for kk=1:PN_max
    h = commsrc.pn('Shift',kk);
    set(h,'NumBitsOut',100); %length of PN sequence is set to 100
    tmp=generate(h)*2-1;
 PN_seq(kk,:)=tmp'; %5x100 PN sequence matrix created
   
end
    
A = PN_seq
%from PN_seq calculated above, P_ij matrix is extracted
for i=1:size(A,1)
    for j=1:size(A,1)
        P_ij(i,j)=sum(A(i,:).*A(j,:));
    end
end

P_ij