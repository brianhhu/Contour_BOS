function [pop, offset_inx] = gen_ori_pop(ori_list,name,N,M,offset_inx)
% [pop, offset_inx] = gen_ori_pop(ori_list,name,N,M,offset_inx)
% Generate a population of neurons with various orientations
% 
% ori_list - list of orientations (one subpopulation per orientation)
% name     - population name
% N,M      - dimensions of each subpopulation
% offset_inx - amount to offset indices by (because other populations hold
%              those indices). Updated to include new population.
% pop - output population
%
% By Danny Jeck, October 2014

if nargin <5
    offset_inx = 0;
end
Nori = length(ori_list);

pop = empty_pop;
pop.name = name;
pop.Nsubpops = Nori;
pop.subpops = empty_subpop(Nori);
Nneur = 0;
for s = 1:Nori
    pop.subpops(s).type = 'orientation';
    pop.subpops(s).val = ori_list(s);
    pop.subpops(s).dim = [M N];
    pop.subpops(s).inx = offset_inx+(s-1)*M*N+1:offset_inx+s*N*M;
    pop.subpops(s).inx = reshape(pop.subpops(s).inx,[M N]);
    pop.subpops(s).rate = zeros(M,N);
    Nneur = Nneur+numel(pop.subpops(s).inx);
end
pop.Nneur = Nneur;

if nargout >1
    offset_inx = offset_inx + pop.Nneur;
end