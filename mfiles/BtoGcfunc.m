function WBtoGc = BtoGcfunc(x,y,odiff,ori,r,sd_r,sd_t)
% WBtoGc = BtoGcfunc(x,y,odiff,ori,r,sd_r,sd_t)
% Generates the normalized weight matrices for B to Gc connections.
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
% Created by Brian Hu to account for contour grouping cells

if nargin<5
    r = 4;
end
if nargin<6
    sd_r = 0.75/8;%0.25;
    sd_t = 0.5;
end

odiff = mod(odiff,pi); % added for multiple orientations

WBtoGc = exp(-x.^2/(2*(r*sd_r)^2) -y.^2/(2*(r*sd_t)^2));
WBtoGc = WBtoGc/sum(WBtoGc(x==0));

norm_const = sum(WBtoGc(:)); % find normalization constant

WBtoGc = imrotate(WBtoGc,180/pi*ori,'bicubic','crop'); % original
WBtoGc(WBtoGc<0) = 0;

WBtoGc = norm_const/sum(WBtoGc(:))*WBtoGc; % re-normalize

if odiff == pi/4 || odiff == 3*pi/4 % weight other orientations
    WBtoGc = 3/4*WBtoGc;
elseif odiff == pi/2
    WBtoGc = 1/4*WBtoGc;
end
