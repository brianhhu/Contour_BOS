function WBtoG = BtoGfunc(ori,r,sd_r,sd_t)
% WBtoG = BtoGfunc(ori,r,sd_r,sd_t)
% Generates the normalized weight matrices for B to G connections in the Mihalas (2011)
% network. 
% 
% ori     - angle of the  orientation subpopulation
% r       - radius of the size population
% sd_r    - Gaussian width of connections in the radial direction (default 0.25)
% sd_t    - Gaussian width of connections in the tangential direction (default 0.5) 
%
% By Danny Jeck, November 2014
% Modified by Brian Hu

if nargin<3
    sd_r = 0.25;
    sd_t = 0.5;
end

xmax = ceil(3/2*r);
[x,y] = meshgrid(-xmax:xmax,xmax:-1:-xmax);

WBtoG = exp(-(x-r).^2/(2*(r*sd_r)^2) -y.^2/(2*(r*sd_t)^2));
WBtoG = WBtoG/sum(WBtoG(x==r));

norm_const = sum(WBtoG(:)); % find normalization constant

WBtoG = imrotate(WBtoG,180/pi*ori,'bicubic','crop');
WBtoG(WBtoG<0) = 0;

WBtoG = norm_const/sum(WBtoG(:))*WBtoG; % re-normalize
