%===========================================================
%======== Prog 4.12: FUNCTION 8.8 "uwb40501_IEEEuwb" =======
%===========================================================
% Generates the channel impulse response for a multipath
% channel according to the statistical model proposed by
% the IEEE 802.15.SG3a. 
%
% 'fc' is the sampling frequency
% 'TMG' is the total multipath gain
%
% The function returns:
% 1) the channel impulse response 'h0'
% 2) the equivalent discrete-time impulse response 'hf'
% 3) the value of the Observation Time 'OT'
% 4) the value of the resolution time 'ts'
% 5) the value of the total multipath gain 'X'


function [h0,hf,OT,ts,X] = uwb40501_IEEEuwb(fc,TMG,G,num_fig,sim_CM)


% ----------------------------
% Step Zero - Input parameters
% ----------------------------
if sim_CM==1 
    %============ Channel Modeling CM1 according to Table 4.6
    OT      = 200e-9;            % Observation Time [s]
    ts      = 1e-9;              % time resolution [s] i.e. the 'bin' duration
    LAMBDA  = 0.0233*1e9;        % Cluster Arrival Rate (1/s)
    lambda  = 2.5e9;             % Ray Arrival Rate (1/s)
    GAMMA   = 7.1e-9;            % Cluster decay factor
    gamma   = 4.3e-9;            % Ray decay factor  
    sigma1  = 10^(3.3941/10);    % Stdev of the cluster fading
    sigma2  = 10^(3.3941/10);    % Stdev of the ray fading
    sigmax  = 10^(3/10);         % Stdev of lognormal shadowing ray decay threshold
    rdt     = 0.001;             % rays are neglected when exp(-t/gamma)<rdt peak treshold [dB]
    PT      = 50;                % rays are considered if their amplitude is whithin the 
                                 % PT range with respect to the peak    
    
elseif sim_CM==2 
    %======== Channel Modeling CM2 according to Table 4.6
    OT      = 300e-9;            % Observation Time [s]
    ts      = 2e-9;              % time resolution [s] i.e. the 'bin' duration
    LAMBDA  = 0.4*1e9;           % Cluster Arrival Rate (1/s)
    lambda  = 0.5e9;             % Ray Arrival Rate (1/s)
    GAMMA   = 5.5e-9;            % Cluster decay factor
    gamma   = 6.7e-9;            % Ray decay factor  
    sigma1  = 10^(3.3941/10);    % Stdev of the cluster fading
    sigma2  = 10^(3.3941/10);    % Stdev of the ray fading
    sigmax  = 10^(3/10);         % Stdev of lognormal shadowing ray decay threshold
    rdt     = 0.001;             % rays are neglected when exp(-t/gamma)<rdt peak treshold [dB]
    PT      = 50;                % rays are considered if their amplitude is whithin the 
                                 % PT range with respect to the peak
elseif sim_CM==3 
    %=======Channel Modeling CM3 according to Table 4.6
    OT      = 200e-9;            % Observation Time [s]
    ts      = 1e-9;              % time resolution [s] i.e. the 'bin' duration
    LAMBDA  = 0.0667*1e9;        % Cluster Arrival Rate (1/s)
    lambda  = 2.1e9;             % Ray Arrival Rate (1/s)
    GAMMA   = 14e-9;             % Cluster decay factor
    gamma   = 7.9e-9;            % Ray decay factor  
    sigma1  = 10^(3.3941/10);    % Stdev of the cluster fading
    sigma2  = 10^(3.3941/10);    % Stdev of the ray fading
    sigmax  = 10^(3/10);         % Stdev of lognormal shadowing ray decay threshold
    rdt     = 0.001;             % rays are neglected when exp(-t/gamma)<rdt peak treshold [dB]
    PT      = 50;                % rays are considered if their amplitude is whithin the 
                                 % PT range with respect to the peak    
else
    %=======Channel Modeling CM4 according to Table 4.6
    OT      = 300e-9;            % Observation Time [s]
    ts      = 2e-9;              % time resolution [s] i.e. the 'bin' duration
    LAMBDA  = 0.0667*1e9;        % Cluster Arrival Rate (1/s)
    lambda  = 2.1e9;             % Ray Arrival Rate (1/s)
    GAMMA   = 24e-9;             % Cluster decay factor
    gamma   = 12e-9;             % Ray decay factor  
    sigma1  = 10^(3.3941/10);    % Stdev of the cluster fading
    sigma2  = 10^(3.3941/10);    % Stdev of the ray fading
    sigmax  = 10^(3/10);         % Stdev of lognormal shadowing ray decay threshold
    rdt     = 0.001;             % rays are neglected when exp(-t/gamma)<rdt peak treshold [dB]
    PT      = 50;                % rays are considered if their amplitude is whithin the 
                                 % PT range with respect to the peak    
end

% -----------------------------------
% Step One - Cluster characterization
% -----------------------------------

dt = 1 / fc;        % sampling time
T = 1 / LAMBDA;     % Average cluster inter-arrival time [s]
t = 1 / lambda;     % Average ray inter-arrival time [s]
i = 1;
CAT(i)  = 0;           % First Cluster Arrival Time
next    = 0;     
while next < OT
    i       = i + 1;
    next    = next + expinv(rand,T);
    if next < OT 
        CAT(i)= next;
    end
end % while remaining > 0

% --------------------------------
% Step Two - Path characterization
% --------------------------------

NC      = length(CAT);       % Number of observed clusters
logvar  = (1/20)*((sigma1^2)+(sigma2^2))*log(10);
omega   = 1;
pc      = 0;                 % path-counter

for i = 1 : NC
    
    pc  = pc + 1;    
    CT  = CAT(i);            % cluster time        
    HT(pc) = CT;       
    next    = 0;    
    mx      = 10*log(omega)-(10*CT/GAMMA);    
    mu      = (mx/log(10))-logvar;    
    a       = 10^((mu+(sigma1*randn)+(sigma2*randn))/20);        
    HA(pc) = ((rand>0.5)*2-1).*a;      
    ccoeff = sigma1*randn;  % fast fading on the cluster    
    
    while exp(-next/gamma)>rdt    
        pc = pc + 1;
        next = next + expinv(rand,t);
        HT(pc) = CT + next;
        mx = 10*log(omega)-(10*CT/GAMMA)-(10*next/GAMMA);
        mu = (mx/log(10))-logvar;
        a = 10^((mu+ccoeff+(sigma2*randn))/20);
        HA(pc) = ((rand>0.5)*2-1).*a;          
    end
    
end % for i = 1 : NC

% Weak peak filtering
peak    = abs(max(HA));
limit   = peak/10^(PT/10);
HA      = HA .* (abs(HA)>(limit.*ones(1,length(HA))));

for i = 1 : pc
    itk         = floor(HT(i)/dt);
    h(itk+1)    = HA(i);
end

% -------------------------------------------
% Step Three - Discrete time impulse response
% -------------------------------------------

N   = floor(ts/dt);
L   = N*ceil(length(h)/N);
h0  = zeros(1,L);
hf  = h0;
h0(1:length(h)) = h;
for i = 1 : (length(h0)/N)
    tmp     = 0;
    for j = 1 : N
        tmp = tmp + h0(j+(i-1)*N);
    end
    hf(1+(i-1)*N) = tmp;
end

% Energy normalization
E_tot   = sum(h.^2);
h0      = h0 / sqrt(E_tot);
E_tot   = sum(hf.^2);
hf      = hf / sqrt(E_tot);

% Log-normal shadowing
mux     = ((10*log(TMG))/log(10)) - (((sigmax^2)*log(10))/20);
X       = 10^((mux+(sigmax*randn))/20);
h0      = X.*h0;
hf      = X.*hf;

% save CIR_UWB.mat;

% -----------------------------
% Step Four - Graphical Output
% -----------------------------

if G==1
    
    Tmax    = dt*length(h0);
    time    = (0:dt:Tmax-dt);
    
    figure(num_fig(1))
        S1  = stem(time,h0);
        AX  = gca;
        set(AX,'FontSize',14);
        T   = title(['§¸p øng xung kim cña kªnh CIR, kÞch b¶n CM', num2str(sim_CM)],...
            'fontname','.vntime','color','b');        
        set(T,'FontSize',16);
        x   = xlabel('Thêi gian [s]','fontname','.vntime','fontsize',14);
        set(x,'FontSize',12);
        y   = ylabel('§é lîi biªn ®é','fontname','.vntime','fontsize',14);
        set(y,'FontSize',16);
    
    figure(num_fig(2))
        S2  = stairs(time,hf,'linewidth',[2]);
        AX  = gca;
        set(AX,'FontSize',14);
        T=title(['§¸p øng xung kim cña kªnh rêi r¹c, kÞch b¶n CM',...
            num2str(sim_CM)],'fontname','.vntime','color','b');
        set(T,'FontSize',16);
        x=xlabel('Thêi gian [s]','fontname','.vntime');
        set(x,'FontSize',12);
        y=ylabel('§é lîi biªn ®é','fontname','.vntime');
        set(y,'FontSize',16);
end