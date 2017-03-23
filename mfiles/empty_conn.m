function Conn = empty_conn(Npop,Npop2)
% Conn = empty_conn(Npop,Npop2)
% Generates an empty (Npop,Npop2) matrix of connection structures (default 1x1).
% Conn(m,n) is the connection structure from the n-th population to the 
% m-th population. Conn(m,n) has the following fields (all initially empty):
%
% Conn.name - connection name for user use only
% Conn.subpop_conn - a PxQ matrix of subpopulation connection structures
%                    where P is the number of to subpopulations and Q is
%                    the number of from subpopulations
% Conn.sparseness - a PxQ matrix of ones and zeros with one indicating that
%                   the associated connection is presen
% 
% By Danny Jeck, November 2014

if nargin<1
    Npop = 1;

end

if nargin<2
    Npop2 = Npop;
end

Conn = struct('name',[],'sparseness',[],'subpop_conn',[]); %;
Conn = repmat(Conn,[Npop Npop2]);

