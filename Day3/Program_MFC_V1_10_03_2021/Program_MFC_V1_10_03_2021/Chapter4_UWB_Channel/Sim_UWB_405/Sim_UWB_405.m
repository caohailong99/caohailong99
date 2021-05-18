% %%=========================================
% %%=========== Sim_UWB_405 =================
% %%=========================================

%%------- Prog 4.12 --------------------
% [h0, hf, OT, ts, X] = uwb40501_IEEEuwb(fc, TMG,G,num_fig,sim_CM);
    % Generates the channel impulse response for a multipath channel 
    % according to the statistical model proposed by the IEEE 802.15.SG3a. 

%%------- Prog 4.13 --------------------
% [rmsds] = uwb40502_rmsds(h, fc)
    % Evaluates the root mean square dealy spread 'rmsds'
    % of a channel impulse response 'h' sampled at frequency 'fc'

%%------- Prog 4.14 -------------------
% [PDP]   = uwb40503_PDP(h0,fc,num_fig);
    % Evaluates the Power Delay Profile 'PDP' of a channel impulse response 'h' 
    % sampled at frequency 'fc'

%%------- Prog 5.01 -------------------
% [rx, attn] = uwb50101_pathloss(tx, c0, d, gamma)
    % Attenuates the input signal 'tx' according to
    % the distance 'd' [m], the decaying factor 'gamma'
    % and the constant term 'c0', which represents the
    % reference attenuation at 1 meter.

%%=========================================================================

clc;
clear all;
close all;

sim_CM = 1;   % Chose Channel Modeling CM (CM1 to CM4)
              % according to Table 4.5 and Table 4.6

if sim_CM == 1
    %%============ Sumulation 1: CM1 ===================
    tx      = 1;
    c0      = 10^(-47/20);
    d       = 2;
    gamma   = 1.7;
    [rx,ag] = uwb50101_pathloss(tx,c0,d,gamma);
    TMG     = ag^2;
    % ---------------
    fc  = 50e9;
    G   = 1;
    num_fig = [418 419];
    [h0, hf, OT, ts, X] = uwb40501_IEEEuwb(fc,TMG,G,num_fig,sim_CM);
    % -----------
    [rmsds] = uwb40502_rmsds(h0,fc);
    rmsds   = 8.8711e-9;
    num_fig = 420;
    [PDP]   = uwb40503_PDP(h0,fc,G,num_fig,sim_CM);
    % ---------------
    for j = 1:2000
        G = 0;
        [h0, hf, OT, ts, X] = uwb40501_IEEEuwb(fc,TMG,G,num_fig,sim_CM);
        Gh(j) = X;    
    end
    save sim_UWB_405_CM1.mat;
    figure(421)
    hist(Gh, 30);    
    AX  = gca;
    set(AX,'FontSize',14);
    T   = title(['Hoµnh ®å vÒ sù xuÊt hiÖn cña ®é lîi biªn ®é, kÞch b¶n kªnh CM',...
        num2str(sim_CM)],'fontname','.vntime','color','b');
    set(T,'FontSize',14);
    x=xlabel('§é lîi biªn ®é','fontname','.vntime');
    set(x,'FontSize',12);
    y=ylabel('Sù xuÊt hiÖn','fontname','.vntime');
    set(y,'FontSize',16);
    
elseif sim_CM == 2
    %============ Sumulation 2: CM1 ======================
    tx      = 1;
    c0      = 10^(-51/20);
    d       = 2;
    gamma   = 3.5;
    [rx, ag]    = uwb50101_pathloss(tx,c0,d,gamma);
    TMG         = ag^2;
    % ---------------
    fc  = 50e9;
    G           = 1;
    num_fig     = [422 423];
    [h0, hf, OT, ts, X] = uwb40501_IEEEuwb(fc,TMG,G,num_fig,sim_CM);
    % ---------------
    [rmsds]     = uwb40502_rmsds(h0, fc);
    rmsds       = 8.8711e-9;
    num_fig     = 424;
    [PDP]       = uwb40503_PDP(h0,fc,G,num_fig,sim_CM);
    save sim_UWB_405_CM2.mat;
    
elseif sim_CM == 3
    %============ Sumulation 3: CM3  ===============
    tx  = 1;
    c0  = 10^(-51/20);
    d   = 8;
    gamma       = 3.5;
    [rx,ag]     = uwb50101_pathloss(tx,c0,d,gamma);
    TMG         = ag^2;
    % ---------------
    fc  = 50e9;
    G       = 1;
    num_fig = [425 426];
    [h0, hf, OT, ts, X] = uwb40501_IEEEuwb(fc,TMG,G,num_fig,sim_CM);
    % --------------------
    [rmsds] = uwb40502_rmsds(h0,fc);
    rmsds   = 8.8711e-9;
    num_fig = 427;
    [PDP]   = uwb40503_PDP(h0,fc,G,num_fig,sim_CM);
    save sim_UWB_405_CM3.mat;
    
elseif sim_CM == 4
    %============ Sumulation 3: CM4   ==============
    tx  = 1;
    c0  = 10^(-51/20);
    d   = 8;
    gamma       = 3.5;
    [rx,ag]     = uwb50101_pathloss(tx,c0,d,gamma);
    TMG         = ag^2;
    % ---------------
    fc  = 50e9;
    G   = 1;
    num_fig = [428 429];
    [h0, hf, OT, ts, X] = uwb40501_IEEEuwb(fc,TMG,G,num_fig,sim_CM);
    % ---------------
    [rmsds] = uwb40502_rmsds(h0,fc);
    rmsds   = 8.8711e-9;
    num_fig = 430;
    [PDP]   = uwb40503_PDP(h0,fc,G,num_fig,sim_CM);
    save sim_UWB_405_CM4.mat;
end 