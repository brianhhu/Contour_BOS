function [seed, stim] = gen_figstim( Ni, Ng, num_ori, num_pos, b_len, f_cen, f_len, clutter, saved_seed )

% Code written by Brian Hu, 2014

%% Input
% Ni: size of input image, Ni(1)xNi(2)
% Ng: number of grid points along an axis (in the image), Ng(1)xNg(2)
% num_ori: number of orientations (max 4)
% num_pos: number of jitter positions (max 9 - hardcoded for now)
% b_len: length of bar (pixels)
% f_cen: center of figure/square, not image axes - (c_cen(1), c_cen(2))
% f_len: length of side (number of bars) - minimum of 3

%% Output
% stim: output matrix (num_orixNixNi) with the generated input stimulus
% seed: random generator seed

% Note: assume we are working with square images, i.e. Nx = Ny = N

if nargin<8
    clutter = 1;
end

if nargin<9
    seed = rng; % save random seed state
else
    rng(saved_seed); % use saved seed
    seed = saved_seed;
end

% Create orixNi(1)xNi(2) matrices (zeros)
stim = zeros(num_ori, Ni(1), Ni(2));

% Find indices of grid points (subscript)
Ng_ind_x = floor((Ni(2)-(Ng(2)-1)*floor(Ni(2)/Ng(2)))/2):floor(Ni(2)/Ng(2)):Ni(2);
Ng_ind_y = floor((Ni(1)-(Ng(1)-1)*floor(Ni(1)/Ng(1)))/2):floor(Ni(1)/Ng(1)):Ni(1);
    
[Ng_x, Ng_y] = meshgrid(Ng_ind_x, Ng_ind_y);

% Convert subscript to linear index
Ng_lin_ind = sub2ind([Ni(1) Ni(2)], Ng_y(:), Ng_x(:));

% Define orientation and position vectors (background and figure)
G_ori = zeros(1, Ng(1)*Ng(2));
G_pos = zeros(1, Ng(1)*Ng(2));

% Define oriented convolution kernels using strel elements and imdilation
ori_se = cell(num_ori);
for i = 1:num_ori
    ori = (i-1)*180/num_ori; % strel 'line' uses degrees, not radians
    ori_se{i} = strel('line', b_len, ori);
end

% Define manually or automatic way to define?
trans_mat = [0 0; 1 0; -1 0; 0 1; 0 -1; 1 1; 1 -1; -1 1; -1 -1]; % 9 positions

x_mult = 1; % x multiplier (grid indices)
y_mult = 1; % y multiplier (grid indices)

% Insert figure into noisy background
fig_x = (f_cen(2)-x_mult*((f_len-1)/2):x_mult:f_cen(2)+x_mult*((f_len-1)/2));
fig_y = (f_cen(1)-y_mult*((f_len-1)/2):y_mult:f_cen(1)+y_mult*((f_len-1)/2));

h_x_ind = repmat(fig_x, 1, 2);
h_y_ind = [repmat(fig_y(1), 1, f_len) repmat(fig_y(end), 1, f_len)];

v_x_ind = [repmat(fig_x(1), 1, f_len) repmat(fig_x(end), 1, f_len)];
v_y_ind = repmat(fig_y, 1, 2);

% Find linear indices of figure within image and replace with new
% % orientation/position
h_lin_ind = sub2ind([Ng(1) Ng(2)], h_y_ind, h_x_ind);
v_lin_ind = sub2ind([Ng(1) Ng(2)], v_y_ind, v_x_ind);

% % horizontal (oriented corners)
% G_ori(1, h_lin_ind) = 1;
% G_ori(1, h_lin_ind([1 end])) = 2;
% G_ori(1, h_lin_ind(f_len:f_len+1)) = 4;
% G_pos(1, h_lin_ind) = 1;
% 
% % vertical
% G_ori(2, v_lin_ind) = ceil((1+num_ori)/2);
% G_ori(2, v_lin_ind([1 end])) = 2;
% G_ori(2, v_lin_ind(f_len:f_len+1)) = 4;
% G_pos(2, v_lin_ind) = 1;

% horizontal (L-corners)
G_ori(1, h_lin_ind) = 1;
G_pos(1, h_lin_ind) = 1;
G_pos(1, h_lin_ind([1 f_len+1])) = 4;
G_pos(1, h_lin_ind([f_len end])) = 5;

% vertical
G_ori(2, v_lin_ind) = ceil((1+num_ori)/2);
G_pos(2, v_lin_ind) = 1;
G_pos(2, h_lin_ind([1 f_len])) = 2;
G_pos(2, h_lin_ind([f_len+1 end])) = 3;

% Background (generate random orientations with jitter)
G_ori_rand = randi([1 num_ori], 1, Ng(1)*Ng(2));
G_pos_rand = randi([1 num_pos], 1, Ng(1)*Ng(2));
G_clut = rand(1, Ng(1)*Ng(2)); % determine clutter threshold
G_ori(1, (sum(G_ori)==0) & (G_clut<=clutter)) = G_ori_rand((sum(G_ori)==0) & (G_clut<=clutter)); % random orientations
G_pos(1, (sum(G_pos)==0) & (G_clut<=clutter)) = G_pos_rand((sum(G_pos)==0) & (G_clut<=clutter)); % random positions

% Create stimulus by looping over orientations and positions
% Set all pixels corresponding to bar equal to one
stim_ori = zeros(Ni(1), Ni(2));

for i = 1:num_ori % orientation
    stim_tot = zeros(Ni(1),Ni(2));
    for j = 1:num_pos % position
        for k = 1:2
            stim_ori(Ng_lin_ind(G_ori(k,:)==i & G_pos(k,:)==j)) = 1;
            stim_tot = stim_tot+imdilate(stim_ori, translate(ori_se{i}, trans_mat(j,:)));
            stim_ori(:) = 0; % reset for next iteration
        end
    end
    stim_tot(isinf(stim_tot)) = 0; % get rid of Inf border values
    stim(i,:,:) = stim_tot;
end

end
