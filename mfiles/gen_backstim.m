function [seed, stim] = gen_backstim( Ni, Ng, num_ori, num_pos, b_len, c_cen, c_ori, c_len, pos_x, pos_y, flag, saved_seed )

% Creates background stimulus for contour integration experiments
% Code written by Brian Hu, 2014

%% Input
% Ni: size of input image, Ni(1)xNi(2)
% Ng: number of grid points along an axis (in the image), Ng(1)xNg(2)
% num_ori: number of orientations (max 4)
% num_pos: number of jitter positions (max 9 - hardcoded for now)
% b_len: length of bar (pixels)
% c_cen: center of contour on grid, not image axes - (c_cen(1), c_cen(2))
% c_ori: orientation of contour (0=1, 45=2, 90=3, or 135=4 supported)
% c_len: length of contour (number of collinear bars)

%% Output
% stim: output matrix (num_orixNi(1)xNi(2)) with the generated input stimulus
% seed: random generator seed

if nargin<12
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
trans_mat = [0 0; 1 0; -1 0; 0 1; 0 -1; 1 1; 1 -1; -1 1; -1 -1; 2 0; -2 0]; % 9 positions (+2 jitter positions)

% Insert contour into noisy background
x_mult = round(cosd((c_ori-1)*180/num_ori)); % x multiplier (grid indices)
y_mult = round(sind((c_ori-1)*180/num_ori)); % y multiplier (grid indices)

c_cen = c_cen + [pos_y pos_x]; % added by bh

cont_ind_x = fliplr((c_cen(2)-x_mult*(c_len-ceil(c_len/2))):x_mult:(c_cen(2)+x_mult*(c_len-ceil(c_len/2))));
cont_ind_y = (c_cen(1)-y_mult*(c_len-ceil(c_len/2))):y_mult:(c_cen(1)+y_mult*(c_len-ceil(c_len/2)));

% repmat for empty matrices - repeat along midline
if isempty(cont_ind_x)
    cont_ind_x = repmat(c_cen(2), 1, c_len);
end
if isempty(cont_ind_y)
    cont_ind_y = repmat(c_cen(1), 1, c_len);
end

% Find linear indices of contour within image and replace with new
% orientation/position
cont_lin_ind = sub2ind([Ng(1) Ng(2)], [cont_ind_y 5], [cont_ind_x 5]); % contour w/ center

G_ori(cont_lin_ind) = c_ori;
G_pos(cont_lin_ind) = 1;
if flag==1 % background suppression
    G_ori(cont_lin_ind(end)) = 1; % if testing orientation background suppression
elseif flag==2 % jitter
    G_pos(cont_lin_ind(1:2:7)) = 10; % if jitter
    G_pos(cont_lin_ind([4 end])) = 1;
    G_pos(cont_lin_ind([2 6])) = 11;
else
    G_ori(cont_lin_ind) = 1; % horizontal orientation (default)
end

% Background (generate random orientations with jitter)
% % % % Comment out for just pure stimulus (no noise)
G_ori_rand = randi([1 num_ori], 1, Ng(1)*Ng(2));
G_pos_rand = randi([1 num_pos], 1, Ng(1)*Ng(2));
G_ori(G_ori==0) = G_ori_rand(G_ori==0); % random orientations
G_pos(G_pos==0) = G_pos_rand(G_pos==0); % random positions

% Create stimulus by looping over orientations and positions
% Set all pixels corresponding to bar equal to one
stim_ori = zeros(Ni(1), Ni(2));

for i = 1:num_ori % orientation
    stim_tot = zeros(Ni(1),Ni(2));
    for j = 1:num_pos+2 % position
        stim_ori(Ng_lin_ind(G_ori==i & G_pos==j)) = 1;
        stim_tot = stim_tot+imdilate(stim_ori, translate(ori_se{i}, trans_mat(j,:)));
        stim_ori(:) = 0; % reset for next iteration
    end
    stim_tot(isinf(stim_tot)) = 0; % get rid of Inf border values
    stim(i,:,:) = stim_tot;
end

end
