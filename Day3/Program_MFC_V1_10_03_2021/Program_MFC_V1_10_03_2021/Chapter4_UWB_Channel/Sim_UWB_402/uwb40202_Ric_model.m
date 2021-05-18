function H = uwb40202_Ric_model(K_dB,L)

% Pro 4.06

% Rician Channel Model
%   Input:
%       K_dB   : K factor [dB]
%       L      : # of channel realization
%   Output:
%       h      : channel vector



K=10^(K_dB/10);
H = sqrt(K/(K+1)) + sqrt(1/(K+1))*uwb40201_Ray_model(L);