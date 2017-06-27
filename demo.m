%{
Basic demo of a recurrent neural network that performs contour integration and border-ownership
assignment. Simply run demo.m to start. This code was inspired by the code for the paper "Mechanisms
of perceptual organization provide auto-zoom and auto-localization for attention to objects," which
was written by Stefan Mihalas (Johns Hopkins University, 2011). Parts of this code are also borrowed
with permission from Danny Jeck, who rewrote Stefan's original code. If you have questions about the
code, feel free to contact me at: bhu6 (AT) jhmi (DOT) edu.
%}

clc
addpath('mfiles');

%% 1) Contour integration

% Run the model on a 1-bar contour pattern (i.e. noise pattern)
cont_1 = testScript(0,'contour',1,1,0,0,0,0,0);

% Run the model on a 7-bar contour pattern
cont_7 = testScript(0,'contour',1,7,0,0,0,0,0);

% Run the model on a jittered contour pattern
cont_jit = testScript(0,'jitter',1,7,0,0,0,0,0);




% Display results
% a) Show population activity across the input image
figure
cmap = [gray(64); jet(64)]; % new colormap
colormap(cmap)
ha = tight_subplot(3,3,[.01 .01],[.01 .075],[.075 .01]);
fontsize = 20;

% Show the input stimulus
axes(ha(1)); imagesc((max(cont_1.E(1:63,1:63,:),[],3)>0)-1/64); title('Stimulus','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(4)); imagesc((max(cont_7.E(1:63,1:63,:),[],3)>0)-1/64); axis square; caxis([0 2]);
axes(ha(7)); imagesc((max(cont_jit.E(1:63,1:63,:),[],3)>0)-1/64); axis square; caxis([0 2]);

% Show V1 activity
axes(ha(2)); imagesc(max(cont_1.E(1:63,1:63,:),[],3)/max(cont_7.E(:))+1); title('V1 Activity','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(5)); imagesc(max(cont_7.E(1:63,1:63,:),[],3)/max(cont_7.E(:))+1); axis square; caxis([0 2]);
axes(ha(8)); imagesc(max(cont_jit.E(1:63,1:63,:),[],3)/max(cont_7.E(:))+1); axis square; caxis([0 2]);

% Show V4 contour grouping cell activity
axes(ha(3)); imagesc(max(cont_1.Gc(1:7,1:7,:),[],3)/max(cont_7.Gc(:))+1); title('V4 Activity','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(6)); imagesc(max(cont_7.Gc(1:7,1:7,:),[],3)/max(cont_7.Gc(:))+1); axis square; caxis([0 2]);
axes(ha(9)); imagesc(max(cont_jit.Gc(1:7,1:7,:),[],3)/max(cont_7.Gc(:))+1); axis square; caxis([0 2]);

set(ha(1:9),'XTickLabel','')
set(ha(1:9),'YTickLabel','')
set(gcf, 'Color', 'w');

% b) Plot time traces of V1 and V4 activity centered on the contour
figure
ha = tight_subplot(1,2,[.1 .1],[.1 .1],[.1 .1]);

% Plot V1 activity time trace
axes(ha(1)); plot(0:1:500, cont_1.E_trace/max(cont_7.E_trace(:)),'k','LineWidth',2); hold on;
plot(0:1:500, cont_7.E_trace/max(cont_7.E_trace(:)),'b','LineWidth',2);
plot(0:1:500, cont_jit.E_trace/max(cont_7.E_trace(:)),'Color',[0.5 0.5 0.5],'LineWidth',2);
xlim([0 500])
ylim([0 1])
title('V1 Activity','FontSize',fontsize)
legend('1-bar','7-bar','Jitter')
xlabel('Time (ms)','FontSize',fontsize);
ylabel('Normalized activity','FontSize',fontsize)

% Plot V4 activity time trace
axes(ha(2)); plot(0:1:500, cont_1.Gc_trace/max(cont_7.Gc_trace(:)),'k','LineWidth',2); hold on;
plot(0:1:500, cont_7.Gc_trace/max(cont_7.Gc_trace(:)),'b','LineWidth',2);
plot(0:1:500, cont_jit.Gc_trace/max(cont_7.Gc_trace(:)),'Color',[0.5 0.5 0.5],'LineWidth',2);
xlim([0 500])
ylim([0 1.01]) % Slightly above 1 to show the saturation of the 7-bar contour V4 time trace
title('V4 Activity','FontSize',fontsize)
legend('1-bar','7-bar','Jitter')
xlabel('Time (ms)','FontSize',fontsize);

set(gcf, 'Color', 'w');

%% 2) Border ownership assignment

% Run the model on a square image without attention
square = testScript(0,'figure',0,0,0,0,0,0,0);

% Run the model on a noisy square image with attention
noisy_square_att = testScript(0,'figure',0,0,0,0,1,0,1);




% Display results
figure
cmap = [gray(64); jet(64)]; % new colormap
colormap(cmap)
ha = tight_subplot(2,6,[.01 .01],[.01 .05],[.05 .01]);
fontsize = 20;

M = 64;
N = M;
[plotX,plotY] = meshgrid(1:M/2,1:N/2);
scale_factor = 15;

% Show the input stimulus
axes(ha(1)); imagesc((max(square.E(1:63,1:63,:),[],3)>0)-1/64); title('Stimulus','FontSize',fontsize); axis square; ylabel('Square','FontSize',fontsize); caxis([0 2]);
axes(ha(7)); imagesc((max(noisy_square_att.E(1:63,1:63,:),[],3)>0)-1/64); axis square; ylabel('Noise','FontSize',fontsize); caxis([0 2]);

% Show V1 edge activity
axes(ha(2)); 
E = max(square.E,[],3)./max(square.E(:))+1;
imagesc(E(1:63,1:63)); title('E','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(8));
E = max(noisy_square_att.E,[],3)./max(noisy_square_att.E(:))+1;
imagesc(E(1:63,1:63)); axis square; caxis([0 2]);

% Show V2 BOS activity
%% Square
% added to threshold activity for B cells
axes(ha(3));
square.B(square.B<0.15)=0;

% normalized
U = ((square.B(:,:,1)+cos(pi/4)*(square.B(:,:,2)+square.B(:,:,8)))-(square.B(:,:,5)+cos(pi/4)*(square.B(:,:,4)+square.B(:,:,6))))./((square.B(:,:,1)+cos(pi/4)*(square.B(:,:,2)+square.B(:,:,8)))+(square.B(:,:,5)+cos(pi/4)*(square.B(:,:,4)+square.B(:,:,6))));
V = ((square.B(:,:,7)+cos(pi/4)*(square.B(:,:,6)+square.B(:,:,8)))-(square.B(:,:,3)+cos(pi/4)*(square.B(:,:,2)+square.B(:,:,4))))./((square.B(:,:,7)+cos(pi/4)*(square.B(:,:,6)+square.B(:,:,8)))+(square.B(:,:,3)+cos(pi/4)*(square.B(:,:,2)+square.B(:,:,4))));

U = U(1:31,1:31);
V = V(1:31,1:31);
plotX=plotX(1:31,1:31);
plotY=plotY(1:31,1:31);

% added removal of nans
U(isnan(U)) = 0;
V(isnan(V)) = 0;

idx = (abs(U) > 0.004) | (abs(V) > 0.004);
q1 = quiver(plotX(idx),plotY(idx),U(idx)*scale_factor,V(idx)*scale_factor,0);
set(q1,'LineWidth',1.5)
axis square;set(gca,'Ydir','reverse');title('$$\vec{\mathbf{v}}$$','Interpreter','Latex','FontSize',fontsize); xlim([1 31]); ylim([1 31])


%% Noisy square with attention
axes(ha(9));
% added to threshold activity for B cells
B_temp = noisy_square_att.B;
B_temp(B_temp<0.15)=0;

% normalized
U = ((B_temp(:,:,1)+cos(pi/4)*(B_temp(:,:,2)+B_temp(:,:,8)))-(B_temp(:,:,5)+cos(pi/4)*(B_temp(:,:,4)+B_temp(:,:,6))))./((B_temp(:,:,1)+cos(pi/4)*(B_temp(:,:,2)+B_temp(:,:,8)))+(B_temp(:,:,5)+cos(pi/4)*(B_temp(:,:,4)+B_temp(:,:,6))));
V = ((B_temp(:,:,7)+cos(pi/4)*(B_temp(:,:,6)+B_temp(:,:,8)))-(B_temp(:,:,3)+cos(pi/4)*(B_temp(:,:,2)+B_temp(:,:,4))))./((B_temp(:,:,7)+cos(pi/4)*(B_temp(:,:,6)+B_temp(:,:,8)))+(B_temp(:,:,3)+cos(pi/4)*(B_temp(:,:,2)+B_temp(:,:,4))));

U = U(1:31,1:31);
V = V(1:31,1:31);
plotX=plotX(1:31,1:31);
plotY=plotY(1:31,1:31);

% added removal of nans
U(isnan(U) | abs(U)==1) = 0; % remove spurious large BOS
V(isnan(V) | abs(V)==1) = 0;
% add some additional thresholding to remove noise from plot
U(abs(B_temp(1:31,1:31,1)-B_temp(1:31,1:31,5))<eps & abs(B_temp(1:31,1:31,2)-B_temp(1:31,1:31,6))<eps & abs(B_temp(1:31,1:31,3)-B_temp(1:31,1:31,7))<eps & abs(B_temp(1:31,1:31,4)-B_temp(1:31,1:31,8))<eps)=0;
V(abs(B_temp(1:31,1:31,1)-B_temp(1:31,1:31,5))<eps & abs(B_temp(1:31,1:31,2)-B_temp(1:31,1:31,6))<eps & abs(B_temp(1:31,1:31,3)-B_temp(1:31,1:31,7))<eps & abs(B_temp(1:31,1:31,4)-B_temp(1:31,1:31,8))<eps)=0;

idx = (abs(U) > 0.004) | (abs(V) > 0.004);
q2 = quiver(plotX(idx),plotY(idx),U(idx)*scale_factor,V(idx)*scale_factor,0);
set(q2,'LineWidth',1.5)
axis square;set(gca,'Ydir','reverse'); xlim([1 31]); ylim([1 31])

% Show object grouping cell activity
axes(ha(4)); imagesc(square.G(1:7,1:7)./max(square.G(:))+1); title('Go','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(10)); imagesc(noisy_square_att.G(1:7,1:7)./max(noisy_square_att.G(:))+1); axis square; caxis([0 2]);

% Show contour grouping cell activity
axes(ha(5)); imagesc(max(square.Gc(1:7,1:7,:),[],3)./max(square.Gc(:))+1); title('Gc','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(11)); imagesc(max(noisy_square_att.Gc(1:7,1:7,:),[],3)./max(noisy_square_att.Gc(:))+1); axis square; caxis([0 2]);

%% remove tick marks
set(ha(1),'XTick',[]);
set(ha(1),'YTick',[]);
set(ha(2),'XTick',[]);
set(ha(2),'YTick',[]);
set(ha(3),'XTick',[]);
set(ha(3),'YTick',[]);
set(ha(4),'XTick',[]);
set(ha(4),'YTick',[]);
set(ha(5),'XTick',[]);
set(ha(5),'YTick',[]);
set(ha(7),'XTick',[]);
set(ha(7),'YTick',[]);
set(ha(8),'XTick',[]);
set(ha(8),'YTick',[]);
set(ha(9),'XTick',[]);
set(ha(9),'YTick',[]);
set(ha(10),'XTick',[]);
set(ha(10),'YTick',[]);
set(ha(11),'XTick',[]);
set(ha(11),'YTick',[]);

%%% added to get colorbar
h = colorbar;
set(h,'YLim',[1.01 2])
set(h,'YTick',linspace(1.01,2,6))
set(h,'YTickLabel',{'0','0.2','0.4','0.6','0.8','1'})
set(h, 'Position', [.85 .1 .02 .8150])

%%%
pos = get(ha(6),'Position');
set(ha(6), 'Position', [0 0 pos(3) pos(4)]);
axis(ha(6), 'off')

pos = get(ha(12),'Position');
set(ha(12), 'Position', [0 0 pos(3) pos(4)]);
axis(ha(12), 'off')

set(gcf,'Color','w');