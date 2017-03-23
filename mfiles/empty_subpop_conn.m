function subpop_conn = empty_subpop_conn(Nsub1,Nsub2)
% subpop_conn = empty_subpop_conn(Nsub1,Nsub2)
% creates a (Nsub1 x Nsub2) matrix (default 1x1) of subpopulation connection structures. 
% subpop_conn(m,n) is the connection structure from the n-th subpopulation
% to the m-th subpopulation of their respected populations
% 
% each structure contains the fields:
% subpop_conn.weight - connection weight applied after convolution
% subpop_conn.matrix - template for convolution between input and output
% subpop_conn.scale  - size scale of connection if the size of the two
%                      subpopulations is not identical
%
% By Danny Jeck November 2014

if nargin<2
    Nsub2 = 1;
    if nargin<1
        Nsub1 = 1;
    end
end

subpop_conn = struct('weight',[],'matrix',[],'scale',[]); %;
subpop_conn = repmat(subpop_conn,[Nsub1 Nsub2]);
