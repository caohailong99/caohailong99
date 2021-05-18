% function Sim_UWB_404

clc;
clear all;
close all;

b002    = 1;            % Power of 1st ray of 1st cluster 
N       = 1000 ;        % Number of channels
Lam     = 0.0233; 
lambda  = 2.5;
Gam     = 7.4; 
gamma   = 4.3;
sigma_x = 3;            % Standard deviation of log-normal shadowing

figure(417)

subplot(221)
    t1          = 0:300; 
    p_cluster   = Lam*exp(-Lam*t1);                 % ideal exponential pdf
    h_cluster   = exprnd(1/Lam,1,N);                % # of random number are generated
    [n_cluster x_cluster]   = hist(h_cluster,25);   % gets distribution
    plot(t1,p_cluster,'k','LineWidth',[2],'color','b');
    hold on
    plot(x_cluster,n_cluster*p_cluster(1)/n_cluster(1),'k:',...
        'LineWidth',[2],'color','r');               %plotting 
    PT = legend('L� t��ng','M� ph�ng');
    set(PT,'FontName','.VnTime','FontSize',11);
    title(['Ph�n b� th�i �i�m ��n c�a C�m , \Lambda=', num2str(Lam)],...
        'FontName','.VnTime','color','b','FontSize',14);
    xlabel('T_m-T_{m-1} [ns]','FontName','.VnTime','FontSize',12);
    ylabel('p(T_m|T_{m-1})','FontName','.VnTime','FontSize',14);

subplot(222)
    t2      = 0:0.01:5; 
    p_ray   = lambda*exp(-lambda*t2);           % ideal exponential pdf
    h_ray   = exprnd(1/lambda,1,1000);          % # of random number are generated
    [n_ray,x_ray]=hist(h_ray,25);               % gets distribution
    plot(t2,p_ray,'k','LineWidth',[2],'color','b');
    hold on;
    plot(x_ray,n_ray*p_ray(1)/n_ray(1),'k:','LineWidth',[2],'color','r');   % plotting graph
    PT = legend('L� t��ng','M� ph�ng ');
    set(PT,'FontName','.VnTime','FontSize',11);
    title(['Ph�n b� th�i �i�m ��n c�a Tia, \lambda=', num2str(lambda)],...
        'FontName','.VnTime','color','b','FontSize',14);
    xlabel('\tau_{r,m}-\tau_{(r-1),m} [ns]','FontName','.VnTime','FontSize',12);
    ylabel('p(\tau_{r,m}|\tau_{(r-1),m})','FontName','.VnTime','FontSize',14);
    
subplot(223)
    [h,t,t0,np]= uwb40401_SV_model(Lam,lambda,Gam,gamma,N,b002,sigma_x);    % Program 4.11
    stem(t(1:np(1),1),abs(h(1:np(1),1)),'ko');
    title('��p �ng xung kim c�a k�nh S-V','FontName','.VnTime','color','b','FontSize',14);
    xlabel('Tr� [ns]','FontName','.VnTime','FontSize',12);
    ylabel('Bi�n ��','FontName','.VnTime','FontSize',14);
    
subplot(224)
    X=10.^(sigma_x*randn(1,N)./20);
    [temp,x]=hist(20*log10(X),25);
    plot(x,temp,'k-','LineWidth',[2],'color','b');
    axis([-10 10 0 120]);
    title(['Ph�n b� Log-normal, \sigma_X=',num2str(sigma_x),'dB'],...
        'FontName','.VnTime','color','b','FontSize',14);
    xlabel('20*log_1_0(X)[dB]','FontName','.VnTime','FontSize',12);
    ylabel('Xu�t hi�n ','FontName','.VnTime','FontSize',14); 
    