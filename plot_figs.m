%% Reproduce subset of figures from paper

addpath('Results') % make sure Results folder is on path
addpath('mfiles') % make sure files folder is on path (needed for plotting functions

% Fig 3) Stimulus with population outputs

% contour
figure
cmap = [gray(64); jet(64)]; % new colormap
colormap(cmap)
ha = tight_subplot(3,5,[.01 .01],[.01 .075],[.075 .01]);
fontsize = 20;

cont_1 = load('contour_1.mat');
[c1,i1] = sort(cont_1.results_new.Gc_temp(:,4,4,3));
cont_3 = load('contour_3.mat');
[c3,i3] = sort(cont_3.results_new.Gc_temp(:,4,4,3));
cont_5 = load('contour_5.mat');
[c5,i5] = sort(cont_5.results_new.Gc_temp(:,4,4,3));
cont_7 = load('contour_7.mat');
[c7,i7] = sort(cont_7.results_new.Gc_temp(:,4,4,3));
cont_jit = load('contour_7_jitter.mat');
[cj,ij] = sort(cont_jit.results_new.Gc_temp(:,4,4,3));

axes(ha(1)); imagesc(squeeze(max(cont_1.results_new.E_temp(i1(2),1:63,1:63,:),[],4)>0)-1/64); title('1-bar','FontSize',fontsize); axis square; ylabel('Stimulus','FontSize',fontsize); caxis([0 2]);
axes(ha(2)); imagesc(squeeze(max(cont_3.results_new.E_temp(i3(2),1:63,1:63,:),[],4)>0)-1/64); title('3-bar','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(3)); imagesc(squeeze(max(cont_5.results_new.E_temp(i5(1),1:63,1:63,:),[],4)>0)-1/64); title('5-bar','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(4)); imagesc(squeeze(max(cont_7.results_new.E_temp(i7(end),1:63,1:63,:),[],4)>0)-1/64); title('7-bar','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(5)); imagesc(squeeze(max(cont_jit.results_new.E_temp(ij(1),1:63,1:63,:),[],4)>0)-1/64); title('Jitter','FontSize',fontsize); axis square; caxis([0 2]);

axes(ha(6)); imagesc(squeeze(max(cont_1.results_new.E_temp(i1(2),1:63,1:63,:),[],4))/max(max(cont_7.results_new.E_temp(i7(end-1),:,:)))+1); ylabel('V1','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(7)); imagesc(squeeze(max(cont_3.results_new.E_temp(i3(2),1:63,1:63,:),[],4))/max(max(cont_7.results_new.E_temp(i7(end-1),:,:)))+1); axis square; caxis([0 2]);
axes(ha(8)); imagesc(squeeze(max(cont_5.results_new.E_temp(i5(1),1:63,1:63,:),[],4))/max(max(cont_7.results_new.E_temp(i7(end-1),:,:)))+1); axis square; caxis([0 2]);
axes(ha(9)); imagesc(squeeze(max(cont_7.results_new.E_temp(i7(end),1:63,1:63,:),[],4))/max(max(cont_7.results_new.E_temp(i7(end-1),:,:)))+1); axis square; caxis([0 2]);
axes(ha(10)); imagesc(squeeze(max(cont_jit.results_new.E_temp(ij(1),1:63,1:63,:),[],4))/max(max(cont_7.results_new.E_temp(i7(end-1),:,:)))+1); axis square; caxis([0 2]);

axes(ha(11)); imagesc(squeeze(cont_1.results_new.Gc_temp(i1(2),1:7,1:7,3))/max(max(cont_7.results_new.Gc_temp(i7(end-1),:,:)))+1); ylabel('V4','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(12)); imagesc(squeeze(cont_3.results_new.Gc_temp(i3(2),1:7,1:7,3))/max(max(cont_7.results_new.Gc_temp(i7(end-1),:,:)))+1); axis square; caxis([0 2]);
axes(ha(13)); imagesc(squeeze(cont_5.results_new.Gc_temp(i5(1),1:7,1:7,3))/max(max(cont_7.results_new.Gc_temp(i7(end-1),:,:)))+1); axis square; caxis([0 2]);
axes(ha(14)); imagesc(squeeze(cont_7.results_new.Gc_temp(i7(end),1:7,1:7,3))/max(max(cont_7.results_new.Gc_temp(i7(end-1),:,:)))+1); axis square; caxis([0 2]);
axes(ha(15)); imagesc(squeeze(cont_jit.results_new.Gc_temp(ij(1),1:7,1:7,3))/max(max(cont_7.results_new.Gc_temp(i7(end-1),:,:)))+1); axis square; caxis([0 2]);

set(ha(1:15),'XTickLabel','')
set(ha(1:15),'YTickLabel','')
set(gcf, 'Color', 'w');

% background
figure
cmap = [gray(64); jet(64)]; % new colormap
colormap(cmap)
ha = tight_subplot(3,5,[.01 .01],[.01 .075],[.075 .01]);

back_1 = load('background_1.mat');
[b1,j1] = sort(back_1.results_new.Gc_temp(:,4,4,3));
back_3 = load('background_3.mat');
[b3,j3] = sort(back_3.results_new.Gc_temp(:,4,4,3));
back_5 = load('background_5.mat');
[b5,j5] = sort(back_5.results_new.Gc_temp(:,4,4,3));
back_7 = load('background_7.mat');
[b7,j7] = sort(back_7.results_new.Gc_temp(:,5,4,3));
back_jit = load('background_7_jitter.mat');
[bj,jj] = sort(back_jit.results_new.Gc_temp(:,4,4,3));

axes(ha(1)); imagesc(squeeze(max(back_1.results_new.E_temp(j1(10),1:63,1:63,:),[],4)>0)-1/64); title('1-bar','FontSize',fontsize); axis square; ylabel('Stimulus','FontSize',fontsize); caxis([0 2]);
axes(ha(2)); imagesc(squeeze(max(back_3.results_new.E_temp(j3(5),1:63,1:63,:),[],4)>0)-1/64); title('3-bar','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(3)); imagesc(squeeze(max(back_5.results_new.E_temp(j5(1),1:63,1:63,:),[],4)>0)-1/64); title('5-bar','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(4)); imagesc(squeeze(max(back_7.results_new.E_temp(j7(end),1:63,1:63,:),[],4)>0)-1/64); title('7-bar','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(5)); imagesc(squeeze(max(back_jit.results_new.E_temp(jj(6),1:63,1:63,:),[],4)>0)-1/64); title('Jitter','FontSize',fontsize); axis square; caxis([0 2]);

axes(ha(6)); imagesc(squeeze(max(back_1.results_new.E_temp(j1(10),1:63,1:63,:),[],4))/max(max(back_7.results_new.E_temp(j7(end),:,:)))+1); ylabel('V1','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(7)); imagesc(squeeze(max(back_3.results_new.E_temp(j3(5),1:63,1:63,:),[],4))/max(max(back_7.results_new.E_temp(j7(end),:,:)))+1); axis square; caxis([0 2]);
axes(ha(8)); imagesc(squeeze(max(back_5.results_new.E_temp(j5(1),1:63,1:63,:),[],4))/max(max(back_7.results_new.E_temp(j7(end),:,:)))+1); axis square; caxis([0 2]);
axes(ha(9)); imagesc(squeeze(max(back_7.results_new.E_temp(j7(end),1:63,1:63,:),[],4))/max(max(back_7.results_new.E_temp(j7(end),:,:)))+1); axis square; caxis([0 2]);
axes(ha(10)); imagesc(squeeze(max(back_jit.results_new.E_temp(jj(6),1:63,1:63,:),[],4))/max(max(back_7.results_new.E_temp(j7(end),:,:)))+1); axis square; caxis([0 2]);

axes(ha(11)); imagesc(squeeze(back_1.results_new.Gc_temp(j1(10),1:7,1:7,3))/max(max(back_7.results_new.Gc_temp(j7(end),:,:)))+1); ylabel('V4','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(12)); imagesc(squeeze(back_3.results_new.Gc_temp(j3(5),1:7,1:7,3))/max(max(back_7.results_new.Gc_temp(j7(end),:,:)))+1); axis square; caxis([0 2]);
axes(ha(13)); imagesc(squeeze(back_5.results_new.Gc_temp(j5(1),1:7,1:7,3))/max(max(back_7.results_new.Gc_temp(j7(end),:,:)))+1); axis square; caxis([0 2]);
axes(ha(14)); imagesc(squeeze(back_7.results_new.Gc_temp(j7(end),1:7,1:7,3))/max(max(back_7.results_new.Gc_temp(j7(end),:,:)))+1); axis square; caxis([0 2]);
axes(ha(15)); imagesc(squeeze(back_jit.results_new.Gc_temp(jj(6),1:7,1:7,3))/max(max(back_7.results_new.Gc_temp(j7(end),:,:)))+1); axis square; caxis([0 2]);

set(ha(1:15),'XTickLabel','')
set(ha(1:15),'YTickLabel','')
set(gcf, 'Color', 'w');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fig 4) Time traces

figure
ha = tight_subplot(3,1,[.05 .05],[.06 .06],[.01 .01]);
fontsize = 20;
fontsize_axes = 14;

axes(ha(1));
plot(0:1:500, mean(cont_1.results_new.E_trace)/max(mean(cont_7.results_new.E_trace)),'k','LineWidth',2); hold on; axis square
plot(0:1:500, mean(cont_3.results_new.E_trace)/max(mean(cont_7.results_new.E_trace)),'r','LineWidth',2);
plot(0:1:500, mean(cont_5.results_new.E_trace)/max(mean(cont_7.results_new.E_trace)),'g','LineWidth',2);
plot(0:1:500, mean(cont_7.results_new.E_trace)/max(mean(cont_7.results_new.E_trace)),'b','LineWidth',2);
plot(0:1:500, mean(cont_jit.results_new.E_trace)/max(mean(cont_7.results_new.E_trace)),'Color',[0.5 0.5 0.5],'LineWidth',2);
xlim([0 500])
ylim([0 1])
leg = legend('1','3','5','7','Jitter','Location','northeast','Orientation','vertical');
set(leg,'PlotBoxAspectRatio',[1 0.8 1]);
set(leg,'FontSize',14);
set(gca,'Ytick',0:0.2:1)
set(gca,'YTickLabel',0:0.2:1)
set(gca,'FontSize',fontsize_axes)
title('V1-C','FontSize',fontsize);

axes(ha(2));
plot(0:1:500, mean(back_1.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'k','LineWidth',2); hold on; axis square
plot(0:1:500, mean(back_3.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'r','LineWidth',2);
plot(0:1:500, mean(back_5.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'g','LineWidth',2);
plot(0:1:500, mean(back_7.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'b','LineWidth',2);
plot(0:1:500, mean(back_jit.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'Color',[0.5 0.5 0.5],'LineWidth',2);
xlim([0 500])
ylim([0 1])
set(gca,'Ytick',0:0.2:1)
set(gca,'YTickLabel',0:0.2:1)
set(gca,'FontSize',fontsize_axes)
title('V1-B','FontSize',fontsize); 
ylabel('Normalized activity','FontSize',fontsize)

axes(ha(3));
plot(0:1:500, mean(cont_1.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'k','LineWidth',2); hold on; axis square
plot(0:1:500, mean(cont_3.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'r','LineWidth',2);
plot(0:1:500, mean(cont_5.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'g','LineWidth',2);
plot(0:1:500, mean(cont_7.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'b','LineWidth',2);
plot(0:1:500, mean(cont_jit.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'Color',[0.5 0.5 0.5],'LineWidth',2);
xlim([0 500])
ylim([0 1.01])
xlabel('Time (ms)')
set(gca,'Ytick',0:0.2:1)
set(gca,'YTickLabel',0:0.2:1)
set(gca,'FontSize',fontsize_axes)
title('V4','FontSize',fontsize); 
xlabel('Time (ms)','FontSize',fontsize);

set(ha(1:2),'XTickLabel','')
set(gcf, 'Color', 'w');

% Adjust legend manually, then use:
legend boxoff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fig 4) Contour d'

figure
fontsize = 20;
fontsize_axes = 14;
x = [1 3 5 7 9];

% final results
v1_3=(mean(mean(cont_3.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_3.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));
v1_5=(mean(mean(cont_5.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_5.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));
v1_7=(mean(mean(cont_7.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_7.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));
v1_jit=(mean(mean(cont_jit.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_jit.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));

v4_3=(mean(mean(cont_3.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_3.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v4_5=(mean(mean(cont_5.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_5.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v4_7=(mean(mean(cont_7.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_7.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v4_jit=(mean(mean(cont_jit.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_jit.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));

vb_3=(mean(mean(back_3.results_new.E_trace,2))-mean(mean(back_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(back_3.results_new.E_trace,2))+var(mean(back_1.results_new.E_trace,2)))));
vb_5=(mean(mean(back_5.results_new.E_trace,2))-mean(mean(back_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(back_5.results_new.E_trace,2))+var(mean(back_1.results_new.E_trace,2)))));
vb_7=(mean(mean(back_7.results_new.E_trace,2))-mean(mean(back_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(back_7.results_new.E_trace,2))+var(mean(back_1.results_new.E_trace,2)))));
vb_jit=(mean(mean(back_jit.results_new.E_trace,2))-mean(mean(back_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(back_jit.results_new.E_trace,2))+var(mean(back_1.results_new.E_trace,2)))));

V1_c = [0 v1_3 v1_5 v1_7 v1_jit];
V4 = [0 v4_3 v4_5 v4_7 v4_jit];
V1_b = [0 vb_3 vb_5 vb_7 vb_jit];

plot(x(1:4),V1_c(1:4),'-r.',x(1:4),V1_b(1:4),'-g.',x(1:4),V4(1:4),'-b.','LineWidth',3,'MarkerSize',25)
hold on

plot(x(1),V1_b(1),'-g.','MarkerSize',25)

plot(x(5),V1_c(5),'r.',x(5),V1_b(5),'-g.',x(5),V4(5),'-b.','MarkerSize',25)

set(gca, 'Xtick', 1:2:9)
set(gca, 'XtickLabel',{'1','3','5','7','Jitter'})
xlim([0.5 9.5])
ylim([-2 10])
set(gca,'FontSize',fontsize_axes)
ylabel('d-prime','FontSize',fontsize)
xlabel('Collinear bars','FontSize',fontsize)
leg = legend('V1-C','V1-B','V4');
set(leg,'FontSize',fontsize_axes);
legend boxoff

% plot dashed zero line
l = plot([-1 10],[0 0], '--k');
uistack(l,'bottom')

tightfig;
set(gcf, 'Color', 'w');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fig 5) Contour d' (feedback, no feedback, att)
figure
fontsize_axes = 14;
fontsize = 20;
x = [1 3 5 7];

cont_1_nofb = load('contour_1_nofb.mat');
cont_3_nofb = load('contour_3_nofb.mat');
cont_5_nofb = load('contour_5_nofb.mat');
cont_7_nofb = load('contour_7_nofb.mat');

c1_nofb = (mean(mean(cont_1_nofb.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_1_nofb.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));
c3_nofb = (mean(mean(cont_3_nofb.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_3_nofb.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));
c5_nofb= (mean(mean(cont_5_nofb.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_5_nofb.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));
c7_nofb= (mean(mean(cont_7_nofb.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_7_nofb.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));

v1_nofb = (mean(mean(cont_1_nofb.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_1_nofb.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v3_nofb = (mean(mean(cont_3_nofb.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_3_nofb.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v5_nofb= (mean(mean(cont_5_nofb.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_5_nofb.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v7_nofb= (mean(mean(cont_7_nofb.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_7_nofb.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));

cont_1_att = load('contour_1_att_new.mat');
cont_3_att = load('contour_3_att_new.mat');
cont_5_att = load('contour_5_att_new.mat');
cont_7_att = load('contour_7_att_new.mat');

c1_att = (mean(mean(cont_1_att.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_1_att.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));
c3_att = (mean(mean(cont_3_att.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_3_att.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));
c5_att= (mean(mean(cont_5_att.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_5_att.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));
c7_att= (mean(mean(cont_7_att.results_new.E_trace,2))-mean(mean(cont_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_7_att.results_new.E_trace,2))+var(mean(cont_1.results_new.E_trace,2)))));

v1_att = (mean(mean(cont_1_att.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_1_att.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v3_att = (mean(mean(cont_3_att.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_3_att.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v5_att= (mean(mean(cont_5_att.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_5_att.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v7_att= (mean(mean(cont_7_att.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_7_att.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));

V1_nofb = [c1_nofb c3_nofb c5_nofb c7_nofb];
V1_att = [c1_att c3_att c5_att c7_att];

V4_nofb = [v1_nofb v3_nofb v5_nofb v7_nofb];
V4_att = [v1_att v3_att v5_att v7_att];

subplot(1,2,1)
plot(x(1:4),V1_c(1:4),'-k.',x(1:4),V1_nofb(1:4),'-r.',x(1:4),V1_att(1:4),'-g.','LineWidth',3,'MarkerSize',25); axis square
set(gca, 'Xtick', 1:2:7)
set(gca, 'XtickLabel',{'1','3','5','7'})
ylim([-2 12])
xlim([-0.0001 8])
set(gca,'FontSize',fontsize_axes)
ylabel('d-prime','FontSize',fontsize)
xlabel('Collinear bars','FontSize',fontsize)
title('V1','FontSize',fontsize)
leg = legend('FB','No FB','FB+Att');
set(leg,'FontSize',fontsize_axes);

subplot(1,2,2)
plot(x(1:4),V4(1:4),'-k.',x(1:4),V4_nofb(1:4),'-r.',x(1:4),V4_att(1:4),'-g.','LineWidth',3,'MarkerSize',25); axis square
set(gca, 'Xtick', 1:2:7)
set(gca, 'XtickLabel',{'1','3','5','7'})
ylim([-2 12])
xlim([-0.0001 8])
set(gca,'FontSize',fontsize_axes)
xlabel('Collinear bars','FontSize',fontsize)
title('V4','FontSize',fontsize)

set(gcf, 'Color', 'w');
tightfig;

legend boxoff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fig 6) Recovery of figure stimulus with attention
fontsize = 20;
square = load('figure_no_noise.mat');
noisy_square = load('figure_noise.mat');
noisy_square_att = load('figure_noise_att.mat');

[g,i] = sort(noisy_square.results_new.G_temp(:,4,4));

figure
cmap = [gray(64); jet(64)]; % new colormap
colormap(cmap)
ha = tight_subplot(2,6,[.01 .01],[.01 .05],[.05 .01]);

M = 64;
N = M;
[plotX,plotY] = meshgrid(1:M/2,1:N/2);
scale_factor = 15;

idx_noisy = i(end);

axes(ha(1)); imagesc(squeeze(max(square.results_new.E_temp(:,1:63,1:63,:),[],4)>0)-1/64); title('Stimulus','FontSize',fontsize); axis square; ylabel('Square','FontSize',fontsize); caxis([0 2]);
axes(ha(7)); imagesc(squeeze(max(noisy_square.results_new.E_temp(idx_noisy,1:63,1:63,:),[],4)>0)-1/64); axis square; ylabel('Noise','FontSize',fontsize); caxis([0 2]);

axes(ha(2)); 
E = squeeze(max(square.results_new.E_temp,[],4)./max(max(max(square.results_new.E_temp,[],4)))+1);
imagesc(E(1:63,1:63)); title('E','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(3));

%% added to threshold activity for B cells
square.results_new.B_temp = squeeze(square.results_new.B_temp);

square.results_new.B_temp(square.results_new.B_temp<0.15)=0;

% normalized
U = ((square.results_new.B_temp(:,:,1)+cos(pi/4)*(square.results_new.B_temp(:,:,2)+square.results_new.B_temp(:,:,8)))-(square.results_new.B_temp(:,:,5)+cos(pi/4)*(square.results_new.B_temp(:,:,4)+square.results_new.B_temp(:,:,6))))./((square.results_new.B_temp(:,:,1)+cos(pi/4)*(square.results_new.B_temp(:,:,2)+square.results_new.B_temp(:,:,8)))+(square.results_new.B_temp(:,:,5)+cos(pi/4)*(square.results_new.B_temp(:,:,4)+square.results_new.B_temp(:,:,6))));
V = ((square.results_new.B_temp(:,:,7)+cos(pi/4)*(square.results_new.B_temp(:,:,6)+square.results_new.B_temp(:,:,8)))-(square.results_new.B_temp(:,:,3)+cos(pi/4)*(square.results_new.B_temp(:,:,2)+square.results_new.B_temp(:,:,4))))./((square.results_new.B_temp(:,:,7)+cos(pi/4)*(square.results_new.B_temp(:,:,6)+square.results_new.B_temp(:,:,8)))+(square.results_new.B_temp(:,:,3)+cos(pi/4)*(square.results_new.B_temp(:,:,2)+square.results_new.B_temp(:,:,4))));

U = U(1:31,1:31);
V = V(1:31,1:31);
plotX = plotX(1:31,1:31);
plotY = plotY(1:31,1:31);

%% added removal of nans
U(isnan(U)) = 0;
V(isnan(V)) = 0;

idx = (abs(U) > 0.004) | (abs(V) > 0.004);

q1 = quiver(plotX(idx),plotY(idx),U(idx)*scale_factor,V(idx)*scale_factor,0);
set(q1,'LineWidth',1.5)
axis square;set(gca,'Ydir','reverse');title('$$\vec{\mathbf{v}}$$','Interpreter','Latex','FontSize',fontsize); xlim([1 31]); ylim([1 31])

axes(ha(4)); imagesc(squeeze(square.results_new.G_temp(:,1:7,1:7))./max(max(squeeze(square.results_new.G_temp)))+1); title('Go','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(5)); imagesc(squeeze(max(square.results_new.Gc_temp(:,1:7,1:7,:),[],4))./max(max(max(square.results_new.Gc_temp,[],4)))+1); title('Gc','FontSize',fontsize); axis square; caxis([0 2]);

axes(ha(8));

E = squeeze(max(noisy_square.results_new.E_temp(idx_noisy,:,:,:),[],4)./max(max(max(noisy_square.results_new.E_temp(idx_noisy,:,:,:),[],4)))+1);
imagesc(E(1:63,1:63)); axis square; caxis([0 2]);
axes(ha(9));
scale_factor = 30; 

%% added to threshold activity for B cells
B_temp = squeeze(noisy_square.results_new.B_temp(idx_noisy,:,:,:));

B_temp(B_temp<0.15)=0;

% normalized
U = ((B_temp(:,:,1)+cos(pi/4)*(B_temp(:,:,2)+B_temp(:,:,8)))-(B_temp(:,:,5)+cos(pi/4)*(B_temp(:,:,4)+B_temp(:,:,6))))./((B_temp(:,:,1)+cos(pi/4)*(B_temp(:,:,2)+B_temp(:,:,8)))+(B_temp(:,:,5)+cos(pi/4)*(B_temp(:,:,4)+B_temp(:,:,6))));
V = ((B_temp(:,:,7)+cos(pi/4)*(B_temp(:,:,6)+B_temp(:,:,8)))-(B_temp(:,:,3)+cos(pi/4)*(B_temp(:,:,2)+B_temp(:,:,4))))./((B_temp(:,:,7)+cos(pi/4)*(B_temp(:,:,6)+B_temp(:,:,8)))+(B_temp(:,:,3)+cos(pi/4)*(B_temp(:,:,2)+B_temp(:,:,4))));

U = U(1:31,1:31);
V = V(1:31,1:31);

%% added removal of nans
U(isnan(U) | abs(U)==1) = 0;
V(isnan(V) | abs(V)==1) = 0;

U(abs(B_temp(1:31,1:31,1)-B_temp(1:31,1:31,5))<eps & abs(B_temp(1:31,1:31,2)-B_temp(1:31,1:31,6))<eps & abs(B_temp(1:31,1:31,3)-B_temp(1:31,1:31,7))<eps & abs(B_temp(1:31,1:31,4)-B_temp(1:31,1:31,8))<eps)=0;
V(abs(B_temp(1:31,1:31,1)-B_temp(1:31,1:31,5))<eps & abs(B_temp(1:31,1:31,2)-B_temp(1:31,1:31,6))<eps & abs(B_temp(1:31,1:31,3)-B_temp(1:31,1:31,7))<eps & abs(B_temp(1:31,1:31,4)-B_temp(1:31,1:31,8))<eps)=0;

idx = (abs(U) > 0.004) | (abs(V) > 0.004);

q2 = quiver(plotX(idx),plotY(idx),U(idx)*scale_factor,V(idx)*scale_factor,0);
set(q2,'LineWidth',1.5)
axis square;set(gca,'Ydir','reverse'); xlim([1 31]); ylim([1 31])

axes(ha(10)); imagesc(squeeze(noisy_square.results_new.G_temp(idx_noisy,1:7,1:7))./max(max(squeeze(noisy_square.results_new.G_temp(idx_noisy,:,:))))+1); axis square; caxis([0 2]);
axes(ha(11)); imagesc(squeeze(max(noisy_square.results_new.Gc_temp(idx_noisy,1:7,1:7,:),[],4))./max(max(max(noisy_square.results_new.Gc_temp(idx_noisy,:,:,:),[],4)))+1); axis square; caxis([0 2]);

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fig S1) V4 Orientation/Position

figure
subplot(2,2,1)
fontsize = 20;
fontsize_axes = 14;

cont_1_ori2 = load('contour_1_ori2.mat');
cont_1_ori3 = load('contour_1_ori3.mat');
cont_7_ori2 = load('contour_7_ori2.mat');
cont_7_ori3 = load('contour_7_ori3.mat');

% orientation
plot(0:1:500, mean(cont_7.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'k','LineWidth',2); hold on; axis square;
plot(0:1:500, mean(cont_7_ori2.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'g','LineWidth',2);
plot(0:1:500, mean(cont_7_ori3.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'b','LineWidth',2); % original
plot(0:1:500, mean(cont_1.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'k--','LineWidth',2);
plot(0:1:500, mean(cont_1_ori2.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'g--','LineWidth',2);
plot(0:1:500, mean(cont_1_ori3.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'b--','LineWidth',2);
xlim([0 500])
ylim([0 1.01])
set(gca,'Ytick',0:0.2:1)
set(gca,'YTickLabel',0:0.2:1)
set(gca,'FontSize',fontsize_axes)
xlabel('Time (ms)','FontSize',fontsize)
ylabel('Normalized activity','FontSize',fontsize)

cont_1_pos2 = load('contour_1_pos1.mat');
cont_1_pos3 = load('contour_1_pos2.mat');
cont_7_pos2 = load('contour_7_pos1.mat');
cont_7_pos3 = load('contour_7_pos2.mat');

% position
subplot(2,2,2)
plot(0:1:500, mean(cont_7.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'k','LineWidth',2); hold on; axis square;
plot(0:1:500, mean(cont_7_pos2.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'r','LineWidth',2);
plot(0:1:500, mean(cont_7_pos3.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'g','LineWidth',2);
plot(0:1:500, mean(cont_1.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'k--','LineWidth',2);
plot(0:1:500, mean(cont_1_pos2.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'r--','LineWidth',2);
plot(0:1:500, mean(cont_1_pos3.results_new.Gc_trace)/max(mean(cont_7.results_new.Gc_trace)),'g--','LineWidth',2);
xlim([0 500])
ylim([0 1.01])
set(gca,'Ytick',0:0.2:1)
set(gca,'YTickLabel',0:0.2:1)
set(gca,'FontSize',fontsize_axes)
xlabel('Time (ms)','FontSize',fontsize)
ylabel('Normalized activity','FontSize',fontsize)

% orientation
subplot(2,2,3)
v4_ori1=(mean(mean(cont_7.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_7.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v4_ori2=(mean(mean(cont_7_ori2.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_7_ori2.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v4_ori3=(mean(mean(cont_7_ori3.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_7_ori3.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));

V4_ori = [v4_ori1 v4_ori2 v4_ori3];
bar(0.01,V4_ori(1),0.01,'k'); axis square; hold on;
bar(0.02,V4_ori(2),0.01,'g');
bar(0.03,V4_ori(3),0.01,'b');
ylim([0 8])
xlim([0 0.1])
set(gca,'XTick',1:3)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',20)
ylabel('d-prime','FontSize',28)
box off

% position
subplot(2,2,4)

v4_pos1=(mean(mean(cont_7.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_7.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v4_pos2=(mean(mean(cont_7_pos2.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_7_pos2.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));
v4_pos3=(mean(mean(cont_7_pos3.results_new.Gc_trace,2))-mean(mean(cont_1.results_new.Gc_trace,2)))./(sqrt(1/2*(var(mean(cont_7_pos3.results_new.Gc_trace,2))+var(mean(cont_1.results_new.Gc_trace,2)))));

V4_pos = [v4_pos1 v4_pos2 v4_pos3];
bar(0.01,V4_pos(1),0.01,'k'); axis square; hold on;
bar(0.02,V4_pos(2),0.01,'r');
bar(0.03,V4_pos(3),0.01,'g');
ylim([0 8])
xlim([0 0.1])
set(gca,'XTick',1:3)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',20)
ylabel('d-prime','FontSize',28)
box off

tightfig;
set(gcf, 'Color', 'w');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fig S2) V1 Orientation/Position

figure
subplot(2,3,1)
fontsize = 20;
fontsize_axes = 14;

back_1_ori2 = load('background_1_ori2.mat');
back_1_ori3 = load('background_1_ori3.mat');
back_7_ori2 = load('background_7_ori2.mat');
back_7_ori3 = load('background_7_ori3.mat');

plot(0:1:500, mean(back_7.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'k','LineWidth',2); hold on; axis square;
plot(0:1:500, mean(back_7_ori2.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'g','LineWidth',2);
plot(0:1:500, mean(back_7_ori3.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'b','LineWidth',2);
plot(0:1:500, mean(back_1.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'k--','LineWidth',2);
plot(0:1:500, mean(back_1_ori2.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'g--','LineWidth',2);
plot(0:1:500, mean(back_1_ori3.results_new.E_trace)/max(mean(back_1.results_new.E_trace)),'b--','LineWidth',2);
xlim([0 500])
ylim([0 1])
set(gca,'Ytick',0:0.2:1)
set(gca,'YTickLabel',0:0.2:1)
set(gca,'FontSize',fontsize_axes)
xlabel('Time (ms)','FontSize',fontsize);
ylabel('Normalized activity','FontSize',fontsize)

subplot(2,3,2)

cont_end_1 = load('contour_1_end.mat');
cont_end_3 = load('contour_3_end.mat');
cont_end_5 = load('contour_5_end.mat');
cont_end_7 = load('contour_7_end.mat');

plot(0:1:500, mean(cont_end_1.results_new.E_trace)/max(mean(cont_end_7.results_new.E_trace)),'k','LineWidth',2); hold on; axis square;
plot(0:1:500, mean(cont_end_3.results_new.E_trace)/max(mean(cont_end_7.results_new.E_trace)),'r','LineWidth',2);
plot(0:1:500, mean(cont_end_5.results_new.E_trace)/max(mean(cont_end_7.results_new.E_trace)),'g','LineWidth',2);
plot(0:1:500, mean(cont_end_7.results_new.E_trace)/max(mean(cont_end_7.results_new.E_trace)),'b','LineWidth',2);
xlim([0 500])
set(gca,'Ytick',0:0.2:1)
set(gca,'YTickLabel',0:0.2:1)
set(gca,'FontSize',fontsize_axes)
xlabel('Time (ms)','FontSize',fontsize);

subplot(2,3,3)

back_7_pos2 = load('background_7_pos1.mat');
back_7_pos3 = load('background_7_pos2.mat');

plot(0:1:500, mean(cont_1.results_new.E_trace)/max(mean(cont_1.results_new.E_trace)),'k','LineWidth',2); hold on; axis square; % noise condition comparison
plot(0:1:500, mean(back_7.results_new.E_trace)/max(mean(cont_1.results_new.E_trace)),'r','LineWidth',2);
plot(0:1:500, mean(back_7_pos2.results_new.E_trace)/max(mean(cont_1.results_new.E_trace)),'g','LineWidth',2);
plot(0:1:500, mean(back_7_pos3.results_new.E_trace)/max(mean(cont_1.results_new.E_trace)),'b','LineWidth',2);
xlim([0 500])
ylim([0 1])
set(gca,'Ytick',0:0.2:1)
set(gca,'YTickLabel',0:0.2:1)
set(gca,'FontSize',fontsize_axes)
xlabel('Time (ms)','FontSize',fontsize);

x = [1 3 5];

% final results
b_ori1 = (mean(mean(back_7.results_new.E_trace,2))-mean(mean(back_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(back_7.results_new.E_trace,2))+var(mean(back_1.results_new.E_trace,2)))));
b_ori2 = (mean(mean(back_7_ori2.results_new.E_trace,2))-mean(mean(back_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(back_7_ori2.results_new.E_trace,2))+var(mean(back_1.results_new.E_trace,2)))));
b_ori3 = (mean(mean(back_7_ori3.results_new.E_trace,2))-mean(mean(back_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(back_7_ori3.results_new.E_trace,2))+var(mean(back_1.results_new.E_trace,2)))));

c_end3 = (mean(mean(cont_end_3.results_new.E_trace,2))-mean(mean(cont_end_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_end_3.results_new.E_trace,2))+var(mean(cont_end_1.results_new.E_trace,2)))));
c_end5 = (mean(mean(cont_end_5.results_new.E_trace,2))-mean(mean(cont_end_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_end_5.results_new.E_trace,2))+var(mean(cont_end_1.results_new.E_trace,2)))));
c_end7 = (mean(mean(cont_end_7.results_new.E_trace,2))-mean(mean(cont_end_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(cont_end_7.results_new.E_trace,2))+var(mean(cont_end_1.results_new.E_trace,2)))));

b_pos1 = (mean(mean(back_7.results_new.E_trace,2))-mean(mean(back_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(back_7.results_new.E_trace,2))+var(mean(back_1.results_new.E_trace,2)))));
b_pos2 = (mean(mean(back_7_pos2.results_new.E_trace,2))-mean(mean(back_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(back_7_pos2.results_new.E_trace,2))+var(mean(back_1.results_new.E_trace,2)))));
b_pos3 = (mean(mean(back_7_pos3.results_new.E_trace,2))-mean(mean(back_1.results_new.E_trace,2)))./(sqrt(1/2*(var(mean(back_7_pos3.results_new.E_trace,2))+var(mean(back_1.results_new.E_trace,2)))));

b_ori = [b_ori1 b_ori2 b_ori3];
c_end = [c_end3 c_end5 c_end7];
b_pos = [b_pos1 b_pos2 b_pos3];

subplot(2,3,4); axis square
plot(x(1:3),b_ori(1:3),'-k.','LineWidth',3,'MarkerSize',25)
set(gca, 'Xtick', 1:2:5)
set(gca, 'XtickLabel',{'0','45','90'})
set(gca,'Ytick',-3:1:0)
set(gca,'YtickLabel',{'-3','-2','-1','0'})
xlim([0.5 5.5])
ylim([-3 0])
set(gca,'FontSize',fontsize_axes)
ylabel('d-prime','FontSize',fontsize)
xlabel('Orientation (deg)','FontSize',fontsize)

subplot(2,3,5); axis square
plot(x(1:3),c_end(1:3),'-k.','LineWidth',3,'MarkerSize',25)
set(gca, 'Xtick', 1:2:5)
set(gca, 'XtickLabel',{'3','5','7'})
xlim([0.5 5.5])
ylim([0 4])
set(gca,'FontSize',fontsize_axes)
xlabel('Collinear bars','FontSize',fontsize)

subplot(2,3,6); axis square
plot(x(1:3),b_pos(1:3),'-k.','LineWidth',3,'MarkerSize',25)
set(gca, 'Xtick', 1:2:5)
set(gca, 'XtickLabel',{'1','2','3'})
set(gca,'Ytick',-3:1:0)
set(gca,'YtickLabel',{'-3','-2','-1','0'})
xlim([0.5 5.5])
ylim([-3 0])
set(gca,'FontSize',fontsize_axes)
xlabel('Distance (deg)','FontSize',fontsize)

tightfig;
set(gcf, 'Color', 'w');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fig S3) Plot overlapping figures
fontsize = 20;
square = load('figure_overlap.mat');
square_front = load('figure_overlap_front.mat');
square_back = load('figure_overlap_back.mat');

figure
cmap = [gray(64); jet(64)]; % new colormap
colormap(cmap)
ha = tight_subplot(3,6,[.01 .01],[.01 .05],[.05 .01]);

M = 64;
N = M;
[plotX,plotY] = meshgrid(1:M/2,1:N/2);
scale_factor = 10;

axes(ha(1)); imagesc(squeeze(max(square.results_new.E_temp(:,1:63,1:63,:),[],4)>0)-1/64); title('Stimulus','FontSize',fontsize); axis square; caxis([0 2]);

axes(ha(2)); 
E = squeeze(max(square.results_new.E_temp,[],4)./max(max(max(square.results_new.E_temp,[],4)))+1);
imagesc(E(1:63,1:63)); title('E','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(3));

%% added to threshold activity for B cells
square.results_new.B_temp = squeeze(square.results_new.B_temp);

% normalized
U = ((square.results_new.B_temp(:,:,1)+cos(pi/4)*(square.results_new.B_temp(:,:,2)+square.results_new.B_temp(:,:,8)))-(square.results_new.B_temp(:,:,5)+cos(pi/4)*(square.results_new.B_temp(:,:,4)+square.results_new.B_temp(:,:,6))))./((square.results_new.B_temp(:,:,1)+cos(pi/4)*(square.results_new.B_temp(:,:,2)+square.results_new.B_temp(:,:,8)))+(square.results_new.B_temp(:,:,5)+cos(pi/4)*(square.results_new.B_temp(:,:,4)+square.results_new.B_temp(:,:,6))));
V = ((square.results_new.B_temp(:,:,7)+cos(pi/4)*(square.results_new.B_temp(:,:,6)+square.results_new.B_temp(:,:,8)))-(square.results_new.B_temp(:,:,3)+cos(pi/4)*(square.results_new.B_temp(:,:,2)+square.results_new.B_temp(:,:,4))))./((square.results_new.B_temp(:,:,7)+cos(pi/4)*(square.results_new.B_temp(:,:,6)+square.results_new.B_temp(:,:,8)))+(square.results_new.B_temp(:,:,3)+cos(pi/4)*(square.results_new.B_temp(:,:,2)+square.results_new.B_temp(:,:,4))));

U = U(1:31,1:31);
V = V(1:31,1:31);
plotX=plotX(1:31,1:31);
plotY=plotY(1:31,1:31);

%% added removal of nans
U(isnan(U) | abs(U) > 0.5) = 0;
V(isnan(V) | abs(V) > 0.5) = 0;

U(abs(square.results_new.B_temp(1:31,1:31,1)-square.results_new.B_temp(1:31,1:31,5))<eps)=0;
V(abs(square.results_new.B_temp(1:31,1:31,7)-square.results_new.B_temp(1:31,1:31,3))<eps)=0;

idx = (abs(U) > 0) | (abs(V) > 0);

q1 = quiver(plotX(idx),plotY(idx),U(idx)*scale_factor,V(idx)*scale_factor,0);
set(q1,'LineWidth',1.5)
axis square;set(gca,'Ydir','reverse');title('$$\vec{\mathbf{v}}$$','Interpreter','Latex','FontSize',fontsize); xlim([1 31]); ylim([1 31])

axes(ha(4)); imagesc(squeeze(square.results_new.G_temp(:,1:7,1:7))./max(max(squeeze(square.results_new.G_temp)))+1); title('Go','FontSize',fontsize); axis square; caxis([0 2]);
axes(ha(5)); imagesc(squeeze(max(square.results_new.Gc_temp(:,1:7,1:7,:),[],4))./max(max(max(square.results_new.Gc_temp,[],4)))+1); title('Gc','FontSize',fontsize); axis square; caxis([0 2]);

axes(ha(7)); imagesc(squeeze(max(square_front.results_new.E_temp(:,1:63,1:63,:),[],4)>0)-1/64); axis square; caxis([0 2]);
hold on;
plot(20,36,'y*','LineWidth',2);

axes(ha(8)); 
E = squeeze(max(square_front.results_new.E_temp,[],4)./max(max(max(square_front.results_new.E_temp,[],4)))+1);
imagesc(E(1:63,1:63)); axis square; caxis([0 2]);
axes(ha(9));

%% added to threshold activity for B cells
square_front.results_new.B_temp = squeeze(square_front.results_new.B_temp);

% normalized
U = ((square_front.results_new.B_temp(:,:,1)+cos(pi/4)*(square_front.results_new.B_temp(:,:,2)+square_front.results_new.B_temp(:,:,8)))-(square_front.results_new.B_temp(:,:,5)+cos(pi/4)*(square_front.results_new.B_temp(:,:,4)+square_front.results_new.B_temp(:,:,6))))./((square_front.results_new.B_temp(:,:,1)+cos(pi/4)*(square_front.results_new.B_temp(:,:,2)+square_front.results_new.B_temp(:,:,8)))+(square_front.results_new.B_temp(:,:,5)+cos(pi/4)*(square_front.results_new.B_temp(:,:,4)+square_front.results_new.B_temp(:,:,6))));
V = ((square_front.results_new.B_temp(:,:,7)+cos(pi/4)*(square_front.results_new.B_temp(:,:,6)+square_front.results_new.B_temp(:,:,8)))-(square_front.results_new.B_temp(:,:,3)+cos(pi/4)*(square_front.results_new.B_temp(:,:,2)+square_front.results_new.B_temp(:,:,4))))./((square_front.results_new.B_temp(:,:,7)+cos(pi/4)*(square_front.results_new.B_temp(:,:,6)+square_front.results_new.B_temp(:,:,8)))+(square_front.results_new.B_temp(:,:,3)+cos(pi/4)*(square_front.results_new.B_temp(:,:,2)+square_front.results_new.B_temp(:,:,4))));

U = U(1:31,1:31);
V = V(1:31,1:31);

%% added removal of nans
U(isnan(U) | abs(U) > 0.5) = 0;
V(isnan(V) | abs(V) > 0.5) = 0;

U(abs(square_front.results_new.B_temp(1:31,1:31,1)-square_front.results_new.B_temp(1:31,1:31,5))<eps)=0;
V(abs(square_front.results_new.B_temp(1:31,1:31,7)-square_front.results_new.B_temp(1:31,1:31,3))<eps)=0;

idx = (abs(U) > 0) | (abs(V) > 0);


q1 = quiver(plotX(idx),plotY(idx),U(idx)*scale_factor,V(idx)*scale_factor,0);
set(q1,'LineWidth',1.5)
axis square;set(gca,'Ydir','reverse'); xlim([1 31]); ylim([1 31])

axes(ha(10)); imagesc(squeeze(square_front.results_new.G_temp(:,1:7,1:7))./max(max(squeeze(square_front.results_new.G_temp)))+1); axis square; caxis([0 2]);
axes(ha(11)); imagesc(squeeze(max(square_front.results_new.Gc_temp(:,1:7,1:7,:),[],4))./max(max(max(square_front.results_new.Gc_temp,[],4)))+1); axis square; caxis([0 2]);

axes(ha(13)); imagesc(squeeze(max(square_back.results_new.E_temp(:,1:63,1:63,:),[],4)>0)-1/64); axis square; caxis([0 2]);
hold on;
plot(44,28,'y*','LineWidth',2);

axes(ha(14)); 
E = squeeze(max(square_back.results_new.E_temp,[],4)./max(max(max(square_back.results_new.E_temp,[],4)))+1);
imagesc(E(1:63,1:63)); axis square; caxis([0 2]);
axes(ha(15));

%% added to threshold activity for B cells
square_back.results_new.B_temp = squeeze(square_back.results_new.B_temp);

% normalized
U = ((square_back.results_new.B_temp(:,:,1)+cos(pi/4)*(square_back.results_new.B_temp(:,:,2)+square_back.results_new.B_temp(:,:,8)))-(square_back.results_new.B_temp(:,:,5)+cos(pi/4)*(square_back.results_new.B_temp(:,:,4)+square_back.results_new.B_temp(:,:,6))))./((square_back.results_new.B_temp(:,:,1)+cos(pi/4)*(square_back.results_new.B_temp(:,:,2)+square_back.results_new.B_temp(:,:,8)))+(square_back.results_new.B_temp(:,:,5)+cos(pi/4)*(square_back.results_new.B_temp(:,:,4)+square_back.results_new.B_temp(:,:,6))));
V = ((square_back.results_new.B_temp(:,:,7)+cos(pi/4)*(square_back.results_new.B_temp(:,:,6)+square_back.results_new.B_temp(:,:,8)))-(square_back.results_new.B_temp(:,:,3)+cos(pi/4)*(square_back.results_new.B_temp(:,:,2)+square_back.results_new.B_temp(:,:,4))))./((square_back.results_new.B_temp(:,:,7)+cos(pi/4)*(square_back.results_new.B_temp(:,:,6)+square_back.results_new.B_temp(:,:,8)))+(square_back.results_new.B_temp(:,:,3)+cos(pi/4)*(square_back.results_new.B_temp(:,:,2)+square_back.results_new.B_temp(:,:,4))));

U = U(1:31,1:31);
V = V(1:31,1:31);

%% added removal of nans
U(isnan(U) | abs(U) > 0.5) = 0;
V(isnan(V) | abs(V) > 0.5) = 0;

U(abs(square_back.results_new.B_temp(1:31,1:31,1)-square_back.results_new.B_temp(1:31,1:31,5))<eps)=0;
V(abs(square_back.results_new.B_temp(1:31,1:31,7)-square_back.results_new.B_temp(1:31,1:31,3))<eps)=0;

idx = (abs(U) > 0) | (abs(V) > 0);


q1 = quiver(plotX(idx),plotY(idx),U(idx)*scale_factor,V(idx)*scale_factor,0);
set(q1,'LineWidth',0.1)
axis square;set(gca,'Ydir','reverse'); xlim([1 32]); ylim([1 32])

axes(ha(16)); imagesc(squeeze(square_back.results_new.G_temp(:,1:7,1:7))./max(max(squeeze(square_back.results_new.G_temp)))+1); axis square; caxis([0 2]);
axes(ha(17)); imagesc(squeeze(max(square_back.results_new.Gc_temp(:,1:7,1:7,:),[],4))./max(max(max(square_back.results_new.Gc_temp,[],4)))+1); axis square; caxis([0 2]);


set(ha(1:18),'XTickLabel','')
set(ha(1:18),'YTickLabel','')
set(ha(1:18),'XTick',[])
set(ha(1:18),'YTick',[])
set(gcf, 'Color', 'w');

%%% added to get colorbar
h = colorbar;
set(h,'YLim',[1.01 2])
set(h,'YTick',linspace(1.01,2,6))
set(h,'YTickLabel',{'0','0.2','0.4','0.6','0.8','1'})
set(h, 'Position', [.875 .08 .02 .8150])

%%%
pos = get(ha(6),'Position');
set(ha(6), 'Position', [0 0 pos(3) pos(4)]);
axis(ha(6), 'off')

pos = get(ha(12),'Position');
set(ha(12), 'Position', [0 0 pos(3) pos(4)]);
axis(ha(12), 'off')

pos = get(ha(18),'Position');
set(ha(18), 'Position', [0 0 pos(3) pos(4)]);
axis(ha(18), 'off')
