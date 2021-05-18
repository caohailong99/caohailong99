% % % %====================================================================
% % % %===================== Sim_UWB_402b:=================================
% % % %====================================================================

% %------------------------------------------------------------------------
% % % % Prog 4.07
% [C1,F1,TH1,C2,F2,TH2,F01,F02,RHO,F_RHO,q_l,T,tau_l]=uwb40203_F_S_K_pcal2(N_1,...
%     AREA,f_max,T_s)
% 
% % %------------------------------------------------------------------------
% % % % % Prog 4.08
% [f1,f2,c1,c2,th1,th2,rho,f_rho,f01,f02] = uwb40204_pCOST207(D_S_T,N_i)

%==========================================================================
clc;
clear all;
close all;
T_s         = 0.1E-5;
T_sim       = 0.5E-1;
t           = 0:T_s:T_sim;
m_s         = 10;
B           = 1E+6;
f_s         = 2E+3;
f           = f_s:f_s:B;
AREA = 'bu'; 
% input('Seclect area for simulation : [ra;tu;bu;ht]=   '); %['ra';'tu';'bu';'ht'];
f_max   = 90;
t_0     = 0.01;
N_1     = 10;

%==========================================================================
%===== Generate & plot time-domain input signal of the channel simulator 
%==========================================================================
x_t = ones(1,length(t));
[C1,F1,TH1,C2,F2,TH2,F01,F02,RHO,F_RHO,q_l,T,tau_l] = uwb40203_F_S_K_pcal2(N_1,AREA,f_max,T_s);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Initialization; %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu_1=zeros(size(q_l));
e_l = zeros(size(q_l));
h_t = zeros(1,length(t));
for n =0:length(t)-1,
    if (n/m_s) == fix(n/m_s),
        mu_l = sum((C1.*cos(2*pi*F1*f_max*(n*T_s + t_0) + TH1)).').*...
            exp(-j*2*pi*F01*f_max*(n*T_s + t_0)) + j*...
            (sum((C2.*cos(2*pi*F2*f_max*(n*T_s + t_0) + TH2)).').*...
            exp(-j*2*pi*F02*f_max*(n*T_s + t_0))) + ...
            RHO.*exp(j*2*pi*F_RHO*f_max*(n*T_s + t_0));
    end
    h_t(n+1) = sum(mu_l);
end

H_t = abs(h_t);

save Sim_UWB_402b.mat;

figure(49)
subplot(2,2,1);
    H_t = H_t/max(H_t);
    plot(t,20*log10(H_t));
    grid on;
    xlabel('Thêi gian [s]','FontName','.VnTime','FontSize',12);
    ylabel(' Biªn ®é [dB]','FontName','.VnTime','FontSize',14);
    title('§¸p øng kªnh CIR trong miÒn thêi gian ',...
        'FontName','.VnTime','color','b','FontSize',16);
    
subplot(2,2,3);
    s_f = zeros(1,length(f));% 
    th1 = rand(size(tau_l))*2*pi;
    for k=1:length(f),
        e_l=exp(-j*(2*pi*k*f_s*tau_l + th1 ));
        s_f(k) = sum(e_l);%
    end
    s_f = abs(s_f);   
    S_f = abs(s_f);
    S_f = S_f/max(S_f);
    plot(f,20*log10(S_f),'r');
    grid on;    
    xlabel('TÇn sè [Hz]','FontName','.VnTime','FontSize',12)
    ylabel('Biªn ®é [dB]','FontName','.VnTime','FontSize',14);
    title('§¸p øng kªnh trong miÒn tÇn sè',...
        'FontName','.VnTime','color','b','FontSize',16);
    
subplot(2,2,[2,4]);
    size(H_t)
    size(S_f)
    [H,S] = meshgrid(H_t,S_f);
    H_ft = H.*S;
    [x,y] = size(H_ft);
    t=linspace(0,T_sim,y);
    f=linspace(0,B,x);
    mesh(t,f,20*log10(H_ft));
    xlabel('Thêi gian [s]','FontName','.VnTime','FontSize',12);
    ylabel('TÇn sè [Hz]','FontName','.VnTime','FontSize',12)
    zlabel('Biªn ®é [dB]','FontName','.VnTime','FontSize',14);
    title('§¸p øng kªnh trong miÒn thêi gian vµ tÇn sè ',...
        'FontName','.VnTimeh','color','b','FontSize',16);
    