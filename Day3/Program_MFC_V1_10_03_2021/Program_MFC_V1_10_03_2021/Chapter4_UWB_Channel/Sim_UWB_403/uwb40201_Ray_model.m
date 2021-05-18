function H = uwb40201_Ray_model(L)
% programe 4.05

% Rayleigh Channel Model
%  Input : L  : # of channel realization
%  Output: H  : Channel vector

H = (randn(1,L)+j*randn(1,L))/sqrt(2);
