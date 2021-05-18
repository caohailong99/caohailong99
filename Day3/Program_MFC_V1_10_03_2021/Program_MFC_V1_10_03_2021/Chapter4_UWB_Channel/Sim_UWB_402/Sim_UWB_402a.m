% function Sim_UWB_402a
clc;
clear all;
close all;
N       = 200000; 
level   = 30; 
K_dB    = [-40 15];
Rayleigh_ch     = zeros(1,N); 
Rician_ch       = zeros(2,N);
color   = ['k']; 
line    = ['-']; 
marker  = ['s','o','^'];

% Rayleigh model
Rayleigh_ch     = uwb40201_Ray_model(N);                % Pro 4.05
[temp,x]        = hist(abs(Rayleigh_ch(1,:)),level);   
plot(x,temp,['k-' marker(2)],'linewidth',2,'color','b');
hold on;

% Rician model
for i=1:length(K_dB);
    Rician_ch(i,:)=uwb40202_Ric_model(K_dB(i),N);       % Pro 4.06
    [temp x]=hist(abs(Rician_ch(i,:)),level);
    plot(x,temp,['k-' marker(i+1)],'linewidth',1.5,'color','r');
end
xlabel('x','fontname','.vntime','fontsize',12);
ylabel('MËt ®é x¸c suÊt ','fontname','.vntime','fontsize',14);
PT = legend('Rayleigh','Rician, K=-40dB','Rician, K=15dB');
set(PT,'FontName','.VnTime','FontSize',14);
grid on;
title('Ph©n bè cña kªnh pha ®inh Rayleigh vµ kªnh pha ®inh Rician',...
    'fontname','.vntime','fontsize',14);