function [Pop, Conn] = gen_mihalas_net1(M,N,Nori,r_list)
% [Pop, Conn] = gen_mihalas_net1(M,N,Nori,r_list)
% Generates the Population (Pop) and Connection (Conn) structures for a
% network according to Mihalas (2011). This network is used to simulate
% border ownership and grouping cell firing rates when given simplified
% inputs. External inputs to the E cells (Pop(1)) are -1 or 1, 1 indicating
% an edge of an appropriate orientation. External inputs to G cells
% (Pop(4)) are the attentional modulation.
%
% INPUTS:
% M,N - the dimensions of the E cell layer. All other layers are scaled off
%       of this (mostly the same size)
% Nori - number of orientations of E cells (Mihalas used 2).
% r_list - list of radii of grouping cells
%
% References:
% Mihalas, S., von der Heydt, R., & Niebur, E. (2012). A network model 
% of multiplicative attentional modulation. In Information Sciences and
% Systems (CISS), 2012 46th Annual Conference on. IEEE.
%
% Mihalas, S., Dong, Y., von der Heydt, R., & Niebur, E. (2011). 
% Mechanisms of perceptual organization provide auto-zoom and auto-
% localization for attention to objects. Proceedings of the National 
% Academy of Sciences of the United States of America, 108(18), 7583–8.
% doi:10.1073/pnas.1014655108
% 
% By Danny Jeck, November 2014

Nr = length(r_list);
ori_list = 0:pi/Nori:pi-pi/Nori; %orientations for E cells
ori_list2X = [ori_list ori_list+pi]; %orientations for B cells

%Connection parameters
r0 = 2; %r0 = 2, unlike (Mihalas, 2011) where r0 = 4, so all G to other population weights are divided by 2. This doesn't change network properties though.
w_etob = 1;
w_btoib= 2;
w_ibtob = -2;
w_btob = 2/3;
w_btog = 1/8; %bh changed from 1/4 due to increased number of BOS orientations (4 vs. 8)
w_igtog = -1/8;
w_gtob = 2/3;
w_gtoig = 1/3;
w_gtoe = 8/3;
% w_ibtoib = -1; % no self-inhibition in this model, so not needed

offset_inx = 0;

% E cell Types
[E, offset_inx] = gen_ori_pop(ori_list,'E',N,M,offset_inx);

% IE cell Types
[IE, offset_inx] = gen_ori_pop(0,'IE',N,M,offset_inx); % bh added inhibitory E cells

% B cell Types
[B, offset_inx] = gen_ori_pop(ori_list2X,'B',N/2,M/2,offset_inx);

% IB cell types
[IB, offset_inx] = gen_ori_pop(0,'IB',N/2,M/2,offset_inx);

% G cell types
[G, offset_inx] = gen_size_pop(r_list,'G',N/2,M/2,r0,offset_inx);

% IG cell types
[IG, offset_inx] = gen_ori_pop(ori_list2X,'IG',N/8,M/8,offset_inx);

% Gc cell types
[Gc, ~] = gen_ori_pop(ori_list,'Gc',N/8,M/8,offset_inx);

Pop = [E IE B IB G IG Gc]';
Npop = length(Pop);


% onetoone = empty_subpop_conn(1,1); % original V1->V2 connection scheme
% onetoone.weight = w_etob;
% onetoone.matrix = 1;
% onetoone.scale = 1;
[x_ori_E, y_ori_E] = meshgrid(-24:24,24:-1:-24);
[x_ori_B, y_ori_B] = meshgrid(-12:12,12:-1:-12);
[x_ori_EtoB, y_ori_EtoB] = meshgrid(-3:3,3:-1:-3);


%E to E connections
EtoE = gen_ori_conn(E,E,@BtoIBfunc,x_ori_E,y_ori_E,8);
EtoE.name = 'EtoE';
EtoE.sparseness = eye(Nori);
for ss = 1:numel(EtoE.sparseness)
    if EtoE.sparseness(ss)==0
        EtoE.subpop_conn(ss).weight = 0;
    else
        EtoE.subpop_conn(ss).weight = w_btob;
    end
end

%E to IE connections
EtoIE = gen_ori_conn(E,IE,@IBtoBfunc,x_ori_E,y_ori_E,8); % bh changed from BtoIB
EtoIE.name = 'EtoIE';
EtoIE.sparseness = ones(1,Nori);
for ss = 1:numel(EtoIE.sparseness)
    EtoIE.subpop_conn(ss).weight = 4*w_btoib;
end

%IE to E connections
IEtoE = gen_ori_conn(IE,E,@IBtoBfunc,x_ori_E,y_ori_E,8);
IEtoE.name = 'IEtoE';
IEtoE.sparseness = ones(Nori,1);
for ss = 1:numel(IEtoE.sparseness)
    IEtoE.subpop_conn(ss).weight = 4*w_ibtob; % to generate transient response
end

% %E to B connections (one-to-one)
% EtoB = empty_conn;
% EtoB.subpop_conn = repmat(onetoone,[2*Nori Nori]);
% EtoB.name = 'EtoB';
% EtoB.sparseness = [eye(Nori); eye(Nori)];
% for ss = 1:numel(EtoB.sparseness) % redundant, but makes the structure easier to understand
%     if EtoB.sparseness(ss)==0
%         EtoB.subpop_conn(ss).weight = w_etob;
%     end
% end

%E to B connections
EtoB = gen_ori_conn(E,B,@EtoBfunc,x_ori_EtoB,y_ori_EtoB,1); % bh changed to Gaussian instead of one-to-one
EtoB.name = 'EtoB';
EtoB.sparseness = [eye(Nori); eye(Nori)];
for ss = 1:numel(EtoB.sparseness)
    EtoB.subpop_conn(ss).scale = 1/2;
    if EtoB.sparseness(ss)==0
        EtoB.subpop_conn(ss).weight = 0;
    else
        EtoB.subpop_conn(ss).weight = w_etob;
    end
end

%B to IB connections
BtoIB = gen_ori_conn(B,IB,@IBtoBfunc,x_ori_B,y_ori_B,4); % bh changed from BtoIB
BtoIB.name = 'BtoIB';
BtoIB.sparseness = ones(1,2*Nori);
for ss = 1:numel(BtoIB.sparseness)
    BtoIB.subpop_conn(ss).weight = w_btoib;
end

%IB to B connections
IBtoB = gen_ori_conn(IB,B,@IBtoBfunc,x_ori_B,y_ori_B,4);
IBtoB.name = 'IBtoB';
IBtoB.sparseness = ones(2*Nori,1);
for ss = 1:numel(IBtoB.sparseness)
    IBtoB.subpop_conn(ss).weight = w_ibtob;
end

%B to B connections
BtoB = gen_ori_conn(B,B,@BtoBfunc,x_ori_B,y_ori_B,4);
BtoB.sparseness = ones(2*Nori,2*Nori);
BtoB.name = 'BtoB';
for ss = 1:numel(BtoB.subpop_conn)
    if all(BtoB.subpop_conn(ss).matrix(:)==0)
        BtoB.subpop_conn(ss).weight=0;
        BtoB.sparseness(ss)=0;
    else
        BtoB.subpop_conn(ss).weight = w_btob;
    end
end

%B to G connections
BtoG = gen_ori_size_conn(B,G,@BtoGfunc,r0);
BtoG.name = 'BtoG';
BtoG.sparseness = ones(Nr,2*Nori);
for ss = 1:numel(BtoG.sparseness)
    BtoG.subpop_conn(ss).weight = w_btog;
end

%IG to G connections
IGtoG = gen_ori_size_conn(IG,G,@IGtoGfunc_mod,8);
IGtoG.name = 'IGtoG';
IGtoG.sparseness = ones(Nr,2*Nori);
for ss = 1:numel(IGtoG.sparseness)
    IGtoG.subpop_conn(ss).weight = w_igtog;
end

%G to E connections
GtoE = gen_ori_size_conn(G,E,@GtoEfunc,r0);
GtoE.name = 'GtoE';
GtoE.sparseness = ones(Nori,Nr);
for ss = 1:numel(GtoE.sparseness)
    GtoE.subpop_conn(ss).scale = GtoE.subpop_conn(ss).scale*2;
    GtoE.subpop_conn(ss).weight = w_gtoe;
end

%G to B connections
GtoB = gen_ori_size_conn(G,B,@GtoBfunc,r0);
GtoB.name = 'GtoB';
GtoB.sparseness = ones(2*Nori,Nr);
for ss = 1:numel(GtoB.sparseness)
    GtoB.subpop_conn(ss).weight = w_gtob;
end

%G to IG connections
GtoIG = gen_ori_size_conn(G,IG,@GtoIGfunc_mod,8);
GtoIG.name = 'GtoIG';
GtoIG.sparseness = ones(2*Nori,Nr);
for ss = 1:numel(GtoIG.sparseness)
    GtoIG.subpop_conn(ss).weight = w_gtoig; % to account for lack of BtoIG connections
end

%B to Gc connections
BtoGc = gen_ori_conn(B,Gc,@BtoGcfunc,x_ori_B,y_ori_B,8);
BtoGc.name = 'BtoGc';
BtoGc.sparseness = ones(Nori,2*Nori); % multiple orientations
for ss = 1:numel(BtoGc.sparseness)
    BtoGc.subpop_conn(ss).scale = 1/4;
    BtoGc.subpop_conn(ss).weight = w_btog;
end

%IG to Gc connections
IGtoGc = gen_ori_conn(IG,Gc,@IGtoGcfunc_mod,x_ori_EtoB,y_ori_EtoB,8);
IGtoGc.name = 'IGtoGc';
IGtoGc.sparseness = ones(Nori,2*Nori);
for ss = 1:numel(IGtoGc.sparseness)
    IGtoGc.subpop_conn(ss).weight = w_igtog;
end

%Gc to E connections
GctoE = gen_ori_conn_fb(Gc,E,@BtoGcfunc,x_ori_E,y_ori_E,16);
GctoE.name = 'GctoE';
GctoE.sparseness = eye(Nori);
for ss = 1:numel(GctoE.sparseness)
    GctoE.subpop_conn(ss).scale = 8;
    if GctoE.sparseness(ss)==0
        GctoE.subpop_conn(ss).weight = 0;
    else
    	GctoE.subpop_conn(ss).weight = w_gtoe;
    end
end

%Gc to B connections
GctoB = gen_ori_conn_fb(Gc,B,@BtoGcfunc,x_ori_B,y_ori_B,8);
GctoB.name = 'GctoB';
GctoB.sparseness = [eye(Nori); eye(Nori)];
for ss = 1:numel(GctoB.sparseness)
    GctoB.subpop_conn(ss).scale = 4;
    if GctoB.sparseness(ss)==0
        GctoB.subpop_conn(ss).weight = 0;
    else
    	GctoB.subpop_conn(ss).weight = w_gtob;
    end
end

%Gc to IG connections
GctoIG = gen_ori_conn(Gc,IG,@GctoIGfunc_mod,x_ori_EtoB,y_ori_EtoB,2);
GctoIG.name = 'GctoIG';
GctoIG.sparseness = [eye(Nori); eye(Nori)];
for ss = 1:numel(GctoIG.sparseness)
    if GctoIG.sparseness(ss)==0
        GctoIG.subpop_conn(ss).weight = 0;
    else
        GctoIG.subpop_conn(ss).weight = w_gtoig;
    end
end

Conn = empty_conn(Npop); %matrix containing all connectivity information
Conn(1:3,1) = [EtoE; EtoIE; EtoB];
Conn(1,2) = IEtoE;
Conn([3:5 7],3) = [BtoB; BtoIB; BtoG; BtoGc];
Conn(3,4) = IBtoB;
Conn([1 3 6],5) = [GtoE; GtoB; GtoIG];
Conn([5 7],6) = [IGtoG; IGtoGc];
Conn([1 3 6],7) = [GctoE; GctoB; GctoIG];

end
