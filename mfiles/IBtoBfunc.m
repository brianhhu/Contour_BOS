function WIBtoB = IBtoBfunc(x,y,odiff,ori,sd)
% WIEtoB = IEtoBfunc(x,y,odiff,ori,sd)
% Generates the normalized weight matrices for IE to B connections in the Mihalas (2011)
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

if nargin<5
    sd = 2;
    if nargin<4
        ori = 0;
    end
end

WIBtoB = exp(-(x.^2+y.^2)/(2*sd^2));
WIBtoB = WIBtoB/sum(WIBtoB(:));
