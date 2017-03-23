function [pop, offset_inx] = gen_size_pop(r_list,name,N,M,r0,offset_inx)
% [pop, offset_inx] = gen_size_pop(r_list,name,N,M,r0,offset_inx)
% Generate a population of neurons with various sizes
% 
% r_list - list of radii (one subpopulation per radius)
% name   - population name
% N,M    - dimensions of each subpopulation at the standard radius (scaled for
%          other radii)
% r0     - standard radius, usually r_list(1). Cells with radius r0 will be in
%          an NxM grid. Cells with larger radii will be in an 
%          (N*r0/r_list(l) x M*r0/r_list(l)) grid.
%      
% offset_inx - amount to offset indices by (because other populations hold
%              those indices). This value is updated generating the new
%              population. 
%
% pop - output population
%
% By Danny Jeck, October 2014



if nargin <5
    offset_inx = 0;
end

Nr = length(r_list);

pop = empty_pop;
pop.name = name;
pop.Nsubpops = Nr;
pop.subpops = empty_subpop(Nr);
Nneur = 0; %number of neurons in the population
for s = 1:Nr
    pop.subpops(s).type = 'size';
    pop.subpops(s).val = r_list(s);
    
    scale = r0/r_list(s);
    pop.subpops(s).dim = [M N]*scale;
    pop.subpops(s).rate = zeros([M N]*scale);
    Nneur_sub = prod(pop.subpops(s).dim); %number of neurons in the subpopulation
   
    pop.subpops(s).inx = offset_inx+1:offset_inx+Nneur_sub;
    pop.subpops(s).inx = reshape(pop.subpops(s).inx,[M N]*scale);
    offset_inx = pop.subpops(s).inx(end);
    Nneur = Nneur + Nneur_sub;
end
pop.Nneur = Nneur;
