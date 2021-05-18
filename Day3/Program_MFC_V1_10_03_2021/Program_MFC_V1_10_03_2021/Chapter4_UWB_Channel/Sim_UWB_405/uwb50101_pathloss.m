%==========================================================================
% Prog 5.01, FUNCTION 8.1 : "uwb50101_pathloss"
% function [rx,attn] = uwb50101_pathloss(tx,c0,d,gamma)
%==========================================================================
    % Attenuates the input signal 'tx' according to
    % the distance 'd' [m], the decaying factor 'gamma'
    % and the constant term 'c0', which represents the
    % reference attenuation at 1 meter.
    %
    % The function returns the attenuated signal 'rx'
    % and the value of the channel gain 'attn'


function [rx,attn] = uwb50101_pathloss(tx,c0,d,gamma)

% -------------------------------
% Step One - Path loss evaluation
% -------------------------------

attn    = (c0/sqrt(d^gamma));
rx      = attn .* tx;
