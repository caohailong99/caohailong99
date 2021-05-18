% function Sim_UWB_403


clc;
clear all;
close all;

scale   = 1e-9;                         % ns
Ts      = 10*scale;                     % Sampling time
t_rms   = 30*scale;                     % RMS delay spread
num_ch  = 10000;                        % # of channel

%===================% 2-ray model==========================================

pow_2       = [0.5 0.5];  
delay_2     = [0 t_rms*2]/scale;
H_2         = uwb40201_Ray_model(num_ch).'*sqrt(pow_2);         % Prog 4.05
avg_pow_h_2 = mean(H_2.*conj(H_2));

figure(414)
    subplot(121)
    stem(delay_2,pow_2,'linewidth',1.5);
    hold on;
    stem(delay_2,avg_pow_h_2,'r.','linewidth',2.5);
    
    xlabel('Tr� [ns]','fontname','.vntime','fontsize',12), 
    ylabel('C�ng su�t k�nh [tuy�n t�nh]','fontname','.vntime','fontsize',14);
    title('PDP l� t��ng v� PDP m� ph�ng c�a m� h�nh 2 tia',...
        'fontname','.vntime','color','b','fontsize',14);
    PT = legend('L� t��ng','M� ph�ng');
    set(PT,'fontname','.vntime','fontsize',12)
    axis([0 140 0 0.7]);
    
%===================Exponential model exp_PDP==============================
pow_e       = uwb40302_exp_PDP(t_rms,Ts);                   % programe 4.08  
delay_e     = (0:length(pow_e)-1)*Ts/scale;
H_e         = uwb40201_Ray_model(num_ch).'*sqrt(pow_e);     % programe 4.05
avg_pow_h_e = mean(H_e.*conj(H_e));

    subplot(122)
    stem(delay_e,pow_e);
    hold on;
    stem(delay_e,avg_pow_h_e,'r.');
    
    xlabel('Tr� [ns]','fontname','.vntime','fontsize',12);
    ylabel('C�ng su�t k�nh [tuy�n t�nh ]','fontname','.vntime','fontsize',14);
    title('PDP l� t��ng v� PDP m� ph�ng c�a m� h�nh h�m m�',...
        'fontname','.vntime','color','b','fontsize',14);
    PT = legend('L� t��ng','M� ph�ng');
    set(PT,'fontname','.vntime','fontsize',12)
    
    axis([0 140 0 0.7]);


%=========================IEEE80211_model.m================================

clc;
clear all
% close all;

scale   = 1e-9;             % nano
Ts      = 50*scale;         % Sampling time
t_rms   = 25*scale;         % RMS delay spread
num_ch  = 10000;            % Number of channels
N       = 128;              % FFT size

PDP     = uwb40301_ieee802_11_model(t_rms,Ts);          % Prog 4.09

for k=1:length(PDP)
    h(:,k) = uwb40201_Ray_model(num_ch).'*sqrt(PDP(k)); % Prog 4.05
    avg_pow_h(k)= mean(h(:,k).*conj(h(:,k)));
end
H=fft(h(1,:),N);
figure(415)
    subplot(121)
    stem([0:length(PDP)-1],PDP,'ko');
    hold on,
    stem([0:length(PDP)-1],avg_pow_h,'k.');    
    xlabel('Ch� s� nh�nh c�a k�nh , p','fontname','.vntime','fontsize',12);
    ylabel('C�ng su�t k�nh trung b�nh [tuy�n t�nh]','fontname','.vntime','fontsize',14);
    title('M� h�nh IEEE 802.11, \sigma_\tau=25ns, T_S=50ns',...
        'fontname','.vntime','color','b','fontsize',14);
    PT = legend('l� t��ng','m� ph�ng');  
    set(PT,'fontname','.vntime','fontsize',14)
    axis([-1 7 0 1]);
    
    subplot(122)
    plot([-N/2+1:N/2]/N/Ts/10^6,10*log10(H.*conj(H)),'k-');
    xlabel('T�n s� [MHz]','fontname','.vntime','fontsize',12);
    ylabel('C�ng su�t k�nh [dB]','fontname','.vntime','fontsize',14)
    title('��p �ng t�n s�, \sigma_\tau=25ns, T_S=50ns',...
        'fontname','.vntime','color','b','fontsize',14);