% % % %====================================================================
% % % %===================== Sim_UWB_401:==================================
% % % %====================================================================

% %------------------------------------------------------------------------
% % % % Prog 4.01
% [PL] = uwb40101_PL_free(fc, dist, Gt, Gr)

% %------------------------------------------------------------------------
% % % % Prog 4.02
% [PL] = uwb40102_PL_logdist_or_norm(fc, d, d0, n, sigma)

% %------------------------------------------------------------------------
% % % % Prog 4.03
% [PL] = uwb40104_PL_Hata(fc, d, htx, hrx, Etype)

% %------------------------------------------------------------------------
% % % % Prog 4.04
% [PL] = uwb40105_PL_IEEE80216d(fc, d, type, htx, hrx, corr_fact, mod)

%==========================================================================
clc;
clear all;
close all;

fc      =1.5e9;  
d0      =100;  
sigma   =3;
distance    = [1:2:31].^2;
Gt          = [1 1 0.5]; 
Gr          = [1 0.5 0.5]; 
Exp         = [2 3 6]; 

for k=1:3
   y_Free(k,:)      = uwb40101_PL_free(fc,distance,Gt(k),Gr(k));                % Pro 4.01
   y_logdist(k,:)   = uwb40102_PL_logdist_or_norm(fc,distance,d0,Exp(k));       % Pro 4.02
   y_lognorm(k,:)   = uwb40102_PL_logdist_or_norm(fc,distance,d0,Exp(1),sigma); % 
end

figure(4345)
    subplot(141)
    semilogx(distance,y_Free(1,:),'k-o',distance,y_Free(2,:),'b-^',distance,y_Free(3,:),'r-s');
    grid on;
    axis([1 1000 40 110]);
    title(['các mô hình suy hao không gian t? do, f_c=',num2str(fc/1e6),'MHz'],'fontname','.vntime','fontsize',10);
    xlabel('Kh?ang cách [m]','fontname','.vntime','fontsize',12);
    ylabel('Suy hao [dB]','fontname','.vntime','fontsize',12);
    legend('G_t=1, G_r=1','G_t=1, G_r=0.5','G_t=0.5, G_r=0.5');
    
    subplot(142)
    semilogx(distance,y_logdist(1,:),'k-o',distance,y_logdist(2,:),'b-^',distance,y_logdist(3,:),'r-s');
    grid on;
    axis([1 1000 40 110]);
    title(['Mô hình PL Log-kho?ng cách, f_c=',num2str(fc/1e6),'MHz'],'fontname','.vntime','fontsize',10);
    xlabel('Kho?ng cách [m]','fontname','.vntime','fontsize',12);
    ylabel('Suy hao [dB]','fontname','.vntime','fontsize',12);
    legend('n=2','n=3','n=6')
    
    subplot(143)
    semilogx(distance,y_lognorm(1,:),'k-o',distance,y_lognorm(2,:),'b-^',distance,y_lognorm(3,:),'r-s');
    grid on;
    axis([1 1000 40 110]);
    title(['Mô hình PL Log-normal, f_c=',num2str(fc/1e6),'MHz, ','\sigma=', num2str(sigma), 'dB',...
        ],'fontname','.vntime','fontsize',10);    
    xlabel('Kho?ng cách[m]','fontname','.vntime','fontsize',12);
    ylabel('Suy hao[dB]','fontname','.vntime','fontsize',12);
    legend('path 1','path 2','path 2');
    
%%%%%%=================Hata PL model=======================================
    clear; clc;
    fc      =1.5e9; 
    htx     =30; 
    hrx     =2;
    distance    = [1:2:31].^2; 
    y_urban     = uwb40104_PL_Hata(fc,distance,htx,hrx,'urban');        % Pro 4.03
    y_suburban  = uwb40104_PL_Hata(fc,distance,htx,hrx,'suburban');
    y_open      = uwb40104_PL_Hata(fc,distance,htx,hrx,'open');

    subplot(144)
    semilogx(distance,y_urban,'k-s', distance,y_suburban,'k-o', distance,y_open,'k-^');
    grid on;
    axis([1 1000 40 110]);
    title(['Mô hình PL Hata, f_c=',num2str(fc/1e6),'MHz'],'fontname','.vntime','fontsize',10);
    xlabel('Kho?ng c¸ch[m]','fontname','.vntime','fontsize',12);
    ylabel('Suy hao [dB]','fontname','.vntime','fontsize',12);
    legend('urban','suburban','open area');

    
%%%=============== IEEE 802.16d Path loss Models===========================
clc;
clear all;
fc=2e9; htx=[30 30]; hrx=[2 10]; distance=[1:1000];
for k=1:2    
  y_IEEE16d(k,:)    = uwb40105_PL_IEEE80216d(fc,distance,'A',htx(k),hrx(k),'atnt'); % Pro 4.04
  y_MIEEE16d(k,:)   = uwb40105_PL_IEEE80216d(fc,distance,'A',htx(k),hrx(k),'atnt','mod');
end

figure(44)
subplot(121)
    semilogx(distance,y_IEEE16d(1,:),'k:','linewidth',1.5), hold on
    semilogx(distance,y_IEEE16d(2,:),'k-','linewidth',1.5), grid on 
    title(['Mô hình t?n hao IEEE 802.16d , f_c=',num2str(fc/1e6),'MHz'],'fontname','.vntime','fontsize',10);
    axis([1 1000 10 150]);r
    xlabel('Kho?ng cách [m]','fontname','.vn8e','fontsize',12);
    legend('h_{Tx}=30m, h_{Rx}=2m','h_{Tx}=30m, h_{Rx}=10m')
    
subplot(122)
    semilogx(distance,y_MIEEE16d(1,:),'k:','linewidth',1.5), hold on
    semilogx(distance,y_MIEEE16d(2,:),'k-','linewidth',1.5), grid on 
    title(['Mô hình t?n bao IEEE 802.16d biÕn ®æi, f_c=', num2str(fc/1e6), 'MHz'],...
        'fontname','.vntime','fontsize',10);
    axis([1 1000 10 150]);
    xlabel('Kho?ng cách [m]','fontname','.vntime','fontsize',12);
    ylabel('T?n hao [dB]','fontname','.vntime','fontsize',12);
    legend('h_{Tx}=30m, h_{Rx}=2m','h_{Tx}=30m, h_{Rx}=10m')  