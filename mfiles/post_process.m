function results_new = post_process(file_dir, file_prefix)

D = dir(file_dir);
Num = length(D(not([D.isdir])));
imgFiles = {D(~[D.isdir]).name};

% activity maps
E_temp = zeros(Num,64,64,4);
B_temp = zeros(Num,32,32,8);
Gc_temp = zeros(Num,8,8,4);
G_temp = zeros(Num,8,8);

% activity traces
E_trace1 = zeros(Num, 501);
Gc_trace = zeros(Num,501);

% E_trace2 = zeros(Num, 501); % double contours
% B_trace1 = zeros(Num, 501);
% B_trace2 = zeros(Num, 501);
% G_trace1 = zeros(Num, 501);
% G_trace2 = zeros(Num,501);

% %%%%%%%%%%%%%%%%%% New code addition %%%%%%%%%%%%%%%%%%%%%%%%%
% % Add for storing suppression
% E_supp_h = zeros(Num,9);
% E_supp_v = zeros(Num,9);
% 
% % Add E cells
% E_sum = zeros(Num,1);
% 
% % Add B cells
% B_sum = zeros(Num,1);
% 
% % Add Gc cells
% Gc_sum = zeros(Num,1);
% 
% % Add Go cells
% Go_sum = zeros(Num,1);

for i=1:Num
    load([file_dir '/' imgFiles{i}]);

    E_temp(i,:,:,:) = results.E; %max(results.E,[],3); % added
    B_temp(i,:,:,:) = results.B; %max(results.E,[],3); % added
    Gc_temp(i,:,:,:) = results.Gc; %results.Gc(:,:,3); % added
    G_temp(i,:,:) = results.G; % added
    state(i) = results.seed;
    
    E_trace1(i,:) = results.E_trace'; % single contour
    Gc_trace(i,:) = results.Gc_trace';
    
%     E_trace1(i,:) = results.E_trace1'; % double contour
%     E_trace2(i,:) = results.E_trace2';
        
%     B_trace1(i,:) = results.B_trace1';
%     B_trace2(i,:) = results.B_trace2';
%     G_trace1(i,:) = results.G_trace1';
%     G_trace2(i,:) = results.G_trace2';

    
%     %%%%%%%%%%%%%%%%%%% Added new code %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Suppression
%     E_temp = max(results.E,[],3); % E cell activity
%     E_h_temp = sum(E_temp(32-3:32+3,:)); % horizontal slice
%     E_supp_h(i,:) = [sum(E_h_temp(1:7)) sum(E_h_temp(8:14)) sum(E_h_temp(15:21)) sum(E_h_temp(22:28)) sum(E_h_temp(29:35)) sum(E_h_temp(36:42)) sum(E_h_temp(43:49)) sum(E_h_temp(50:56)) sum(E_h_temp(57:64))];
%     E_v_temp = sum(E_temp(:,32-3:32+3),2)'; % vertical slice
%     E_supp_v(i,:) = [sum(E_v_temp(1:7)) sum(E_v_temp(8:14)) sum(E_v_temp(15:21)) sum(E_v_temp(22:28)) sum(E_v_temp(29:35)) sum(E_v_temp(36:42)) sum(E_v_temp(43:49)) sum(E_v_temp(50:56)) sum(E_v_temp(57:64))];
%     
%     E_sum(i,:) = sum(E_temp(18:46,18))+sum(E_temp(18:46,46))+sum(E_temp(18,19:45))+sum(E_temp(46,19:45));
%     B_temp = sqrt((results.B(:,:,1)-results.B(:,:,5)).^2+(results.B(:,:,7)-results.B(:,:,3)).^2);
%     B_sum(i,:) = sum(B_temp(9:23,9))+sum(B_temp(9:23,23))+sum(B_temp(9,10:22))+sum(B_temp(23,10:22));
%     Gc_temp = max(results.Gc,[],3);
%     Gc_sum(i,:) = sum(Gc_temp(2:6,2))+sum(Gc_temp(2:6,6))+sum(Gc_temp(2,3:5))+sum(Gc_temp(6,3:5));
%     Go_sum(i,:) = results.G(4,4);
    
end

results_new.E_temp = E_temp; % added
results_new.B_temp = B_temp; % added
results_new.Gc_temp = Gc_temp; % added
results_new.G_temp = G_temp; % added
results_new.seed = state';

results_new.E_trace = E_trace1;
% results_new.E_trace2 = E_trace2; % double

% results_new.B_trace1_mean = mean(B_trace1,1);
% results_new.B_trace2_mean = mean(B_trace2,1);
results_new.Gc_trace = Gc_trace;

% %%%%%%%%%%%%%% Added new code %%%%%%%%%%%%%%%%%%%%%%
% % Suppression
% results_new.E_supp_h = E_supp_h;
% results_new.E_supp_v = E_supp_v;
% results_new.E_sum = E_sum;
% results_new.B_sum = B_sum;
% results_new.Gc_sum = Gc_sum;
% results_new.Go_sum = Go_sum;

save(['results/' file_prefix], 'results_new');

end
