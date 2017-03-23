function WGtoE = GtoEfunc(ori,r,sd_r,sd_t)
% WGtoE = GtoEfunc(ori,r,sd_r,sd_t)
% Generates the normalized weight matrices for G to E connections in the Mihalas (2011)
% network. 
% 
% ori     - angle of the  orientation subpopulation
% r       - radius of the size population
% sd_r    - Gaussian width of connections in the radial direction (default 0.25)
% sd_t    - Gaussian width of connections in the tangential direction (default 0.5) 
%
% By Danny Jeck, November 2014

if nargin<3
    sd_t = 0.5;
    sd_r = 0.25;
end

WGtoE = BtoGfunc(ori,2*r,sd_r,sd_t) + ...
    BtoGfunc(ori+pi,2*r,sd_r,sd_t);
