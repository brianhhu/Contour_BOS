function dy = net_update(t,Y,Pop,Conn,input,sparse_list,sparse_list_input,decay)
% dy = net_update(t,Y,Pop,Conn,input,sparse_list,sparse_list_input,decay)
% performs a single iteration of a differential equation to be used in an ode solver. 
% 
% INPUTS:
% t - simulation time (unused)
% Y - current network rate vector
% Pop - Network population structure
% Conn - Network connection structure
% input - Network input structure
% sparse_list - An (Nconn x 4) list of connections between subpopulations
%               sparse_list(:,1) are the from populations
%               sparse_list(:,2) are the to populations
%               sparse_list(:,3) are the from subpopulations
%               sparse_list(:,4) are the to subpopulations
%               All unlisted connections are ignored
%
% sparse_list_input  - An (Ninput x 2) list of connections of inputs
%               sparse_list_input(:,1) are the to populations
%               sparse_list_input(:,2) are the to subpopulations
%               All unlisted inputs are ignored
% decay - inverse of the network time constant, used to scale dy
%
% PROCESSING:
% dy = decay*(-Y+W_plus), where W_plus is the rectified strength of both the external
% inputs and the network connections combined. Here rectification means
% setting negative values to 0. 
%
% W_plus is calculated by summing the input from each connection listed in
% sparse_list. Each input is determined by convolving the from population
% rate (given by Y) and the template matrix given by Conn. The result is
% then multiplied by a weight and scaled correctly if the number of neurons
% is not the same between populations. A similar procedure is done for the
% external inputs in sparse_list_input and finally the result is rectified.
%
% Note: an ODE solver wants a function of the form dy = odefun(t,y). To get
% this form use an anonymous function as follows:
%
% odefun = @(t,y) net_update(t,y,Pop,Conn,input,sparse_list,sparse_list_input,decay);
% [T,Y] = ode45(odefun,[0 tmax],Y0);
%
% By Danny Jeck, November 2014
% Brian Hu - Added circular convolution here

    
    W = zeros(size(Y));
    for c = 1:size(sparse_list,1)
        pfrom = sparse_list(c,1);
        pto = sparse_list(c,2);
        ssfrom = sparse_list(c,3);
        ssto= sparse_list(c,4);
        
        subcon = Conn(pto,pfrom).subpop_conn(ssto,ssfrom);
        subto = Pop(pto).subpops(ssto);
        subfrom = Pop(pfrom).subpops(ssfrom);
        
        inrate = Y(subfrom.inx);
        
        %% Note:
        % For most of the simulations, we used circular convolution. However, for results on the overlapping square figures,
        % we used zero-padded convolution. As a result, in order to reproduce our results, you must comment out the portions
        % of the code for circular convolution when running simulations on the overlapping square figures.
        %%
        
        % find pad size
        xLayer = floor(size(subcon.matrix)/2); % comment out if not using circular convolution
        % pad for circular convolution
        inrate_pad = padarray(inrate,[xLayer(1) xLayer(2)],'circular'); % comment out if not using circular convolution
        
        if subcon.scale==1
%             W(subto.inx) = W(subto.inx) + conv2(inrate,subcon.weight*subcon.matrix,'same'); % uncomment if not using circular convolution
            
            temp = conv2(inrate_pad,subcon.weight*subcon.matrix,'same'); % comment out if not using circular convolution
            W(subto.inx) = W(subto.inx) + temp(xLayer(1)+1:end-xLayer(1), xLayer(2)+1:end-xLayer(2)); % comment out if not using circular convolution
            
        elseif subcon.scale<1 %to population is coarser than from population (like B to G)
            scale = 1/subcon.scale;
%             temp = conv2(inrate,subcon.weight*subcon.matrix,'same'); % uncomment if not using circular convolution
            
            temp = conv2(inrate_pad,subcon.weight*subcon.matrix,'same'); % comment out if not using circular convolution
            temp = temp(xLayer(1)+1:end-xLayer(1), xLayer(2)+1:end-xLayer(2)); % comment out if not using circular convolution
            
            temp = temp(scale:scale:end,scale:scale:end);
            W(subto.inx) = W(subto.inx) + temp;
            
        elseif subcon.scale>1 %from population is coarser than to population (like G to B)
            scale = subcon.scale;
            inrate_pad = zeros(size(inrate)*scale);
            inrate_pad(scale:scale:end,scale:scale:end) = inrate;
%             W(subto.inx) = W(subto.inx) + conv2(inrate_pad,subcon.weight*subcon.matrix,'same'); % uncomment if not using circular convolution
            
            inrate_pad = padarray(inrate_pad,[xLayer(1) xLayer(2)],'circular'); % comment out if not using circular convolution
            temp = conv2(inrate_pad,subcon.weight*subcon.matrix,'same'); % comment out if not using circular convolution
            W(subto.inx) = W(subto.inx) + temp(xLayer(1)+1:end-xLayer(1), xLayer(2)+1:end-xLayer(2)); % comment out if not using circular convolution
        end
        
    end
    
    for c = 1:size(sparse_list_input)
        pto = sparse_list_input(c,1);
        ssto= sparse_list_input(c,2);
        
        subcon = input(pto).subpop_conn(ssto);
        subto = Pop(pto).subpops(ssto);
        W(subto.inx) = W(subto.inx) + subcon.weight*subcon.matrix;
    end

    W_plus = W; W_plus(W<0)=0; %rectify synaptic inputs
    dy = decay*(-Y+W_plus); %include time constant and leak
    
end
