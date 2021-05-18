%==========================================================================
%%------- Prog 4.13,FUNCTION 8.9 --------------------
% [rmsds] = uwb40501_rmsds(h, fc)
%==========================================================================
% Evaluates the root mean square dealy spread 'rmsds'
% of a channel impulse response 'h' sampled
% at frequency 'fc'


function [rmsds] = uwb40502_rmsds(h,fc)

% ---------------------------------------------
% Step One - Evaluation of the rms Delay Spread
% ---------------------------------------------

dt = 1 / fc;        % sampling time

ns = length(h);     % number of samples representing
                    % the channel impulse response
                    
time    = (0 : dt : (ns-1)*dt);

den     = sum(h.^2);

num1    = sum(time.*(h.^2));

num2    = sum((time.^2).*(h.^2));

rmsds   = sqrt((num2/den)-(num1/den)^2);
