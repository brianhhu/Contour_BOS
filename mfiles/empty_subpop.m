function subpop = empty_subpop(Nsub)
% subpop = empty_subpop(Nsub)
% Generates an (Nsub x 1) array of empty subpopulations. (defualt Nsub = 1)
% Each subpopulation structure has the following fields:
%
% subpop.type - the type of subpopulation ('size' or 'orientation')
% subpop.val  - value of the variable associated with type (radius or angle)
% subpop.inx  - subpopulation indices in the network population vector
% subpop.rate - initial firing rate of each model neuron in the
%               subpopulation
%
% By Danny Jeck, November 2014

if nargin<1
    Nsub = 1;
end

subpop = struct('type',[],'val',[],'inx',[],'rate',[]);
subpop = repmat(subpop,[Nsub 1]);
