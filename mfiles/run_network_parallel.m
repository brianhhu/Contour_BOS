function [T, Y, Pop, Conn] = run_network_parallel(Pop,Conn,input,E,tmax,decay)
% [T, Y, Pop, Conn] = run_network(Pop,Conn,input,tmax,decay)
% Runs the network with the associated population, connection structure,
% and input for tmax seconds with a given decay constant.
% 
% PROCESSING:
% First, the (Nneurons x 1) network rate vector Y0 is generated based on the
% total number of neurons in Pop. Each value in Y0 has a corresponding
% neuron in a subpopulation within Pop defined by the subpopulation.inx 
% field. The initial values of Y0 are set accoring to subpopulation.rate
%
% Next the set connections between subpopulations are compiled to speed up 
% the ode solver (sparse_list). The same is done with the inputs (sparse_list_input).
% 
% Then the network is run using.
% odefun = @(t,y) net_update(t,y,Pop,Conn,input,sparse_list,sparse_list_input,decay);
% [T,Y] = ode45(odefun,[0 tmax],Y0);
%
% Finally, the end value of Y is replaced in each subpopulation.rate
% variable for the output Pop
%
% OUTPUT:
% T,Y - output of the ode solver (times where odefun was called, and
%       associated Y values
% Pop - updated population structure with a new set of weights
% Conn - unchanged connection structure
%
% By Danny Jeck, November 2014


% Initialize all E cell inputs to -1
for ss = 1:length(input(1).subpop_conn)
    input(1).subpop_conn(ss).matrix = squeeze(E(:,:,ss));
end

Nneur = sum([Pop(:).Nneur]);
Y0 = zeros(Nneur,1);

%initialize rate based on the rates in the population structure
offset_inx = 0;
for p = 1:length(Pop)
    for ss = 1:length(Pop(p).subpops)
        Nneur_ss = prod(Pop(p).subpops(ss).dim);
        Y0(offset_inx+1:offset_inx+Nneur_ss) = Pop(p).subpops(ss).rate(:);
        offset_inx = offset_inx+Nneur_ss;
    end
end

%pull out the list of populations/subpopulations that are connected
sparse_list = zeros(0,4);
offset_inx = 0;
for pfrom = 1:length(Pop)
    for pto = 1:length(Pop)
        [ssto,ssfrom] = find(Conn(pto,pfrom).sparseness);
        ssto = ssto(:);ssfrom = ssfrom(:);
        Nconn = size(ssto,1);
        if Nconn>0
            sparse_list(offset_inx+1:offset_inx+Nconn,:) = [repmat([pfrom pto],Nconn,1) ssfrom ssto];
            offset_inx = offset_inx+Nconn;
        end
    end
end

%pull out the list of populations/subpopulations that receive external input
sparse_list_input = zeros(0,2);
offset_inx = 0;
for pto = 1:length(Pop)
    ssto = find(input(pto).sparseness);
    Nconn = size(ssto,1);
    if Nconn>0
        sparse_list_input(offset_inx+1:offset_inx+Nconn,:) = [repmat(pto,Nconn,1) ssto];
        offset_inx = offset_inx+Nconn;
    end
end


%run the ODE
odefun = @(t,y) net_update(t,y,Pop,Conn,input,sparse_list,sparse_list_input,decay);
[T,Y] = ode45(odefun,0.04:0.001:tmax,Y0); % interpolated time step, starting at 40 ms (delay from input to V1)
Y_eq = Y(end,:);


%Extract rates back into the population structure
offset_inx = 0;
for p = 1:length(Pop)
    for ss = 1:length(Pop(p).subpops)
        Nneur_ss = prod(Pop(p).subpops(ss).dim);
        Pop(p).subpops(ss).rate(:) = Y_eq(offset_inx+1:offset_inx+Nneur_ss);
        offset_inx = offset_inx+Nneur_ss;
    end
end


end