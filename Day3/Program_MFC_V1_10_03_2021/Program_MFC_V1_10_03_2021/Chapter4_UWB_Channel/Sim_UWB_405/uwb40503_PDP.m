%==========================================================================
%%------- Prog 4.14,FUNCTION 8.10 -------------------
% --------[PDP] = uwb40503_PDP(h, fc)----------------
%==========================================================================
    % Evaluates the Power Delay Profile 'PDP'
    % of a channel impulse response 'h' sampled
    % at frequency 'fc'


function [PDP] = uwb40503_PDP(h,fc,G,num_fig,sim_CM)

% --------------------------------
% Step One - Evaluation of the PDP
% --------------------------------

dt = 1 / fc;        % sampling time

PDP = (abs(h).^2)./dt;   % PDP

% ----------------------------
% Step Two - Graphical Output
% ----------------------------

Tmax = dt*length(h);
time = (0:dt:Tmax-dt);

if G
figure(num_fig)
    S1=plot(time,PDP);
    AX=gca;
    set(AX,'FontSize',14);
    T=title(['Lý lÞch trÔ c«ng suÊt, PDP, kÞch b¶n kªnh CM',...
        num2str(sim_CM)],'fontname','.vntime','color','b');
    set(T,'FontSize',16);
    x=xlabel('Thêi gian [s]','fontname','.vntime');
    set(x,'FontSize',12);
    y=ylabel('C«ng suÊt [V^2]','fontname','.vntime');
    set(y,'FontSize',16);
end