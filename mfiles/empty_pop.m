function Pop = empty_pop(Npop)
% Pop = empty_pop(Npop)
% Creates an (Npop x 1) array of empty population structures with the 
% following fields:
%
% Pop.name - title for user use only
% Pop.Nsubpops - number of subpopulations
% Pop.Nneur - number of neurons in this population
% Pop.subpops - array of subpopulations in the population
%
% By Danny Jeck, November 2014

if nargin<1
    Npop=1;
end


Pop = []; %structure containing all neuron populations
Pop.name = [];
Pop.Nsubpops = [];
Pop.Nneur = [];
Pop.subpops = empty_subpop();

Pop = repmat(Pop,[Npop 1]);
