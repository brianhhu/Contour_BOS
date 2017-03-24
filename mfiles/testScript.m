function [results] = testScript(condorJobId, condition, contour_ori, contour_length, contour_posx, contour_posy, flag, nofb, att)
% Inputs:
% condorJobId: used to run the simulations on a HTCondor cluster
% condition: "contour", "background", "jitter", or "figure" corresponding to the experiments
% contour_ori: orientation of the contour (1-4, 1: horizontal, 3: vertical)
% contour_length: length of the contour (1-7, in increments of 2)
% contour_posx: shift in x-position of the contour in pixels
% contour_posy: shift in y-position of the contour in pixels
% nofb: flag for determining if feedback is used (0: feedback present, 1: feedback removed)
% att: flag for determining if attention is applied (0: no attention, 1: attention applied)
%
% Useful abbreviations:
% pop - population
% conn - connection
% ori - orientation
% inx - index/indicies
% val - value
%
% Useful Conventions:
% e - index over edge orientations (0 to pi), 0 = vertical
%     note: this is a departure from the Mihalas (2011) notation
% b - index over border ownership orientations (0 to 2pi)
%       0 = vertical edge with ownership preference right
% p - index over population
% ss - index over subpopulation
% o - index over orientation
%
% x,y - images are displayed with imagesc(im), so im(1,1) is actually the
%       upper left. Therefore when making a meshgrid, y must be decreasing
%       Example: [x y] = meshgrid(-8:8,8:-1:8)
%       The exception to this is the definition of X and Y for attention,
%       for ease of indexing with the input edges
%
% connections are organized like a matrix multiply of the form
% pop_out = conn*pop_in. In this sense, the connection from pop_in(in_inx)
% to pop_out(out_inx) is conn(out_inx,in_inx). The same holds when you
% narrow down to subpopulation connections.
%
% By Danny Jeck, November 2014
% Modified by Brian Hu

% % Some of this code was used to run simulations on a HTCondor cluster, but not needed here anymore
% fprintf('this will show up in the log: condorJobID = %d\n', condorJobId);
% 
% % condor job ids start at 0 so add 1
% modRunNumber = mod(condorJobId + 1, 10);
% 
% fprintf('modified runNumber = %d\n', modRunNumber);

%%%%%%%%%%%%%%%%%%%%%%%%%
% tic     % start the timer

rng(int32((condorJobId+1)*sum(100*clock))) % set random number generator based on condorJobId and system clock

% Network Definition parameters
Nori = 4; %Number of E cell orientations (B cell is twice this)
r_list = 8; %Radius of G cells
N = 64; M = N; %Number of pixels in X/Y direction for V1 (highest resolution)

% Simulation parameters
tmax = 0.5; %Length of simulation (s)
decay = 100; %Time constant (1/100 = 10 ms)

[Pop, Conn] = gen_mihalas_net1(M,N,Nori,r_list); %makes the network according to Mihalas et al.(2011)

Npop = length(Pop);

% Generate input
input = empty_conn(Npop,1);
for p = 1:Npop
    input(p).subpop_conn = empty_subpop_conn(length(Pop(p).subpops),1);
    input(p).sparseness = zeros(length(Pop(p).subpops),1);
end

% Knockout certain connections if needed
%Conn(1,1).sparseness = zeros(size(Conn(1,1).sparseness)); %E-E intracortical connections
%Conn(3,3).sparseness = zeros(size(Conn(3,3).sparseness)); %B-B intracortical connections
%Conn(5,3).sparseness = zeros(size(Conn(5,3).sparseness)); %B-G grouping cell input
%Conn(7,3).sparseness = zeros(size(Conn(7,3).sparseness)); %B-Gc contour grouping cell input
if nofb % whether or not to have feedback
    Conn(3,5).sparseness = zeros(size(Conn(3,5).sparseness)); %G-B feedback
    Conn(1,5).sparseness = zeros(size(Conn(1,5).sparseness)); %G-E feedback
    Conn(3,7).sparseness = zeros(size(Conn(3,7).sparseness)); %Gc-B feedback
    Conn(1,7).sparseness = zeros(size(Conn(1,7).sparseness)); %Gc-E feedback
end

% Initialize all E cell inputs to -1
input(1).name = 'INtoE';
input(1).sparseness = ones(size(input(1).sparseness));
for ss = 1:length(input(1).subpop_conn)
    input(1).subpop_conn(ss).weight = 1;
    input(1).subpop_conn(ss).scale = 1;
end

% input parameters
Eh = -1*ones(M,N);
E45 = -1*ones(M,N);
Ev = -1*ones(M,N);
E135 = -1*ones(M,N);

% Brian's contour stimulus (large figure)
if strcmp(condition,'contour')
    [results.seed,stim] = gen_contstim([64 64], [9 9], 4, 9, 3, [5 5], contour_ori, contour_length, contour_posx, contour_posy, flag); % contour stim (oris: 1, 2, 3)
elseif strcmp(condition,'background')
    [results.seed,stim]= gen_backstim([64 64], [9 9], 4, 9, 3, [6 5], contour_ori, contour_length, contour_posx, contour_posy, flag); % background suppression (pos/ori) [6 5] 1 [6 6] 2 [5 6] 3
elseif strcmp(condition,'jitter')
    [results.seed,stim] = gen_jitterstim([64 64], [9 9], 4, 9, 3, [5 5], contour_ori, 7); % jitter stim
elseif strcmp(condition,'figure')
    if flag == 1
    	[results.seed,stim] = gen_figstim([64 64], [9 9], 4, 9, 3, [5 5], 5); % square figure stim with noise
    else
        results.seed.Seed = 1; % not a random seed
        stim = zeros(Nori,M,N);
        
%         standard square
        stim(1,[32-14 32+14], (32-14):(32+14)) = 1; % edge length = 14 (fits on grid)
        stim(3,(32-14):(32+14), [32-14 32+14]) = 1;
        
%         % overlapping squares
%         stim(1,[36-14 36+14], (20-14):(20+14)) = 1; % edge length = 14
%         stim(3,(36-14):(36+14), [20-14 20+14]) = 1;
%         stim(1,28-14, (44-14):(44+14)) = 1; % edge length = 14
%         stim(3,(28-14):(28+14), 44+14) = 1;
%         stim(1,28+14, 34:(44+14)) = 1; % edge length = 14
%         stim(3,(28-14):22, 44-14) = 1;
    end
else
    disp('Not a valid condition!')
end


Eh(squeeze(stim(1,:,:))>0) = 1;
E45(squeeze(stim(2,:,:))>0) = 1;
Ev(squeeze(stim(3,:,:))>0) = 1;
E135(squeeze(stim(4,:,:))>0) = 1;


% Add Attention
if att
    % Attention parameters
    Xatt = 32; Yatt = 32; %Center of attention (square and contour stimuli)
    
    %Xatt = 24; Yatt = 32; % Front in figure overlap
    %Xatt = 40; Yatt = 32; % Back in figure overlap
    
    sdatt = 8; %SD of attention
    w_att = 0.07; %Weight of attention

    if strcmp(condition,'figure') % add to figure grouping cells
        input(5).name = 'INtoG'; % BOS network
        input(5).sparseness = 1;
        input = add_mihalas_attention(input,Pop,w_att,Xatt,Yatt,sdatt,condition) ;
    else % add to contour grouping cells
    	w_att = w_att/4; % divide by 4 due to 4 orientations of contour grouping cells
        input(7).name = 'INtoG'; % Contour Grouping network
        input(7).sparseness = [1 1 1 1]';
        input = add_mihalas_attention(input,Pop,w_att,Xatt,Yatt,sdatt,condition) ;
    end
end

% Run the simulation
[~, Y, Pop_out, ~] = run_network_parallel(Pop,Conn,input,cat(3,Ev,E135,Eh,E45),tmax,decay);

results.E = cat(3,Pop_out(1).subpops(:).rate); % population code
results.B = cat(3,Pop_out(3).subpops(:).rate); % BOS neurons
results.G = Pop_out(5).subpops(1).rate; % object grouping
results.Gc = cat(3,Pop_out(7).subpops(:).rate); % contour grouping

if strcmp(condition,'contour') && flag > 0
    results.E_trace = [zeros(40,1); Y(:,8864)]; % on end
else
    results.E_trace = [zeros(40,1); Y(:,10208)]; % save activity traces (centered)
end

results.B_trace1 = [zeros(40,1); Y(:,23024)];
results.B_trace2 = [zeros(40,1); Y(:,27120)];

if strcmp(condition,'figure')
    results.G_trace1 = [zeros(40,1); Y(:,29724)]; % for figure (center)
else
    results.G_trace1 = [zeros(40,1); Y(:,29722)];
    results.G_trace2 = [zeros(40,1); Y(:,29726)];
end

results.Gc_trace = [zeros(40,1); Y(:,30428)];

% toc     % stop the timer 
%%%%%%%%%%%%%%%%%%%%%%%%

% system('hostname') 

% save the result to a mat file - using the real condor job id
% save(['output/' condition '__length__' num2str(contour_length) '__ori__' num2str(contour_ori) '__pos__' num2str(contour_posy) '__flag__' num2str(flag) '__id__' num2str(condorJobId)], 'results');

end
