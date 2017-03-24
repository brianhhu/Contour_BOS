function WIGtoG = IGtoGcfunc_mod(x,y,odiff,ori,r,sd_r,sd_t)
% WIGtoG = IGtoGfunc(ori,r,sd_r,sd_t)
% Generates the normalized weight matrices for IB to G connections in the Mihalas (2011)
% network. 
% 
% x       - grid of x-values
% y       - grid of y-values
% odiff   - orientation difference
% ori     - angle of the  orientation subpopulation
% r       - radius of the size population
% sd_r    - Gaussian width of connections in the radial direction (default 0.25)
% sd_t    - Gaussian width of connections in the tangential direction (default 0.5) 
%
% By Danny Jeck, November 2014
% Modified by Brian Hu

if nargin<6
    sd_t = 0.5;
    sd_r = 0.25;
end

r = r/4;

WIGtoG = BtoGfunc(ori   ,r,sd_r,sd_t); % only one subunit (original)

% isotropic inhibition
%WIGtoG = exp(-(x.^2+y.^2)/(2*(r*sd_t)^2));
%WIGtoG = WIGtoG/sum(WIGtoG(:));
