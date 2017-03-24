function WBtoB = BtoBfunc(x,y,odiff,ori,sd,c)
% WBtoB = BtoBfunc(x,y,odiff,ori,sd,c)
% Generates the normalized weight matrices for B to B connections in the Mihalas (2011)
% network.
% 
% x and y - outputs of the meshgrid function definint the size and scale of the 
%           connection templates. 
% odiff   - difference in orientation between input and output subpopulations
% ori     - orientation of the input subpopulation
% sd      - standard deviation of the extent of lateral connections
%           (default 2 according to Mihalas 2011).
% c       - weight of corner connection cells
%
% By Danny Jeck, November 2014
% Modified by Brian Hu


if nargin<5
    sd = 2;
    if nargin<4
        ori = 0;
    end
end

if nargin<6
    c = 2/3;
end

odiff = mod(odiff,2*pi);

if any(size(y)~=size(x))
    error('x and y must be the same size');
end
if y(1,1)<y(end,1)
    warning('y may be defined improperly');
end

%note: if looking at Stefan's orthogonal weight matrices (equation S8), here c =0
if odiff==0
    if ori == 0 || ori == pi
        WBtoB = exp(-(y.^2)/(2*sd^2)).*(x==0);
    elseif ori == pi/4 || ori == 5*pi/4
        WBtoB = exp(-(y.^2)/(2*sd^2)).*(x==-y);
    elseif ori == pi/2 || ori == 3*pi/2
        WBtoB = exp(-(x.^2)/(2*sd^2)).*(y==0);
    else
        WBtoB = exp(-(y.^2)/(2*sd^2)).*(x==y);
    end
    WBtoB = WBtoB/sum(WBtoB(:));
elseif odiff>0 && odiff<pi
    WBtoB = exp(-(x.^2+y.^2)/(2*sd^2)).*(x>=0 & y<0);
    WBtoB = imrotate(WBtoB,(ori+odiff-pi/2)*180/pi,'crop');
    WBtoB = WBtoB/sum(WBtoB(:));
    WBtoB = WBtoB+c*imrotate(WBtoB,180);
elseif odiff>pi
    WBtoB = exp(-(x.^2+y.^2)/(2*sd^2)).*(x>=0 & y>0);
    WBtoB = imrotate(WBtoB,(ori+odiff-3*pi/2)*180/pi,'crop');
    WBtoB = WBtoB/sum(WBtoB(:));
    WBtoB = WBtoB+c*imrotate(WBtoB,180); % bh added
else
    WBtoB = zeros(size(x));
end
