function WBtoIB = BtoIBfunc(x,y,odiff,ori,sd)
% WBtoIB = BtoIBfunc(x,y,odiff,ori,sd)
% Generates the normalized weight matrices for B to IB connections in the Mihalas (2011)
% network. 
% 
% x and y - outputs of the meshgrid function definint the size and scale of the 
%           connection templates. 
% odiff   - difference in orientation between input and output subpopulations
% ori     - orientation of the input subpopulation
% sd      - standard deviation of the extent of lateral connections
%           (default 2 according to Mihalas 2011).
%
% By Danny Jeck, November 2014
% Modified by Brian Hu

if nargin<5
    sd = 2;
    if nargin<4
        ori = 0;
    end
end

odiff = mod(odiff,2*pi);

if odiff ==0 || odiff ==pi
    if ori == 0
        WBtoIB = exp(-(y.^2)/(2*sd^2)).*(x==0);
    elseif ori == pi/4
        WBtoIB = exp(-(y.^2)/(2*sd^2)).*(x==-y);
    elseif ori == pi/2
        WBtoIB = exp(-(x.^2)/(2*sd^2)).*(y==0);
    else
        WBtoIB = exp(-(y.^2)/(2*sd^2)).*(x==y);
    end
    WBtoIB = WBtoIB/sum(WBtoIB(:));
else
    WBtoIB = zeros(size(x));
end
