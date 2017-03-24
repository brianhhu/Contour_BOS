function WGctoIG = GctoIGfunc_mod(x,y,odiff,ori,r,sd_r,sd_t)
% WGctoIG = GctoIGfunc_mod(ori,r,sd_r,sd_t)
% Generates the normalized weight matrices for Gc to IG connections.
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

if nargin<5
    r = 2;
end
if nargin<6
    sd_r = 0.25*2;
    sd_t = 0.5*2;
end

WGctoIG = exp(-x.^2/(2*(r*sd_r)^2) -y.^2/(2*(r*sd_t)^2));
WGctoIG = WGctoIG/sum(WGctoIG(x==0));

norm_const = sum(WGctoIG(:)); % find normalization constant

WGctoIG = imrotate(WGctoIG,180/pi*ori,'bicubic','crop');
WGctoIG(WGctoIG<0) = 0;

WGctoIG = norm_const/sum(WGctoIG(:))*WGctoIG; % re-normalize
