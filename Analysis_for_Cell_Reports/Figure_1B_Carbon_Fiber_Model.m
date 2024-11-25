%% PURPOSE OF CODE

%Batten et al. (2025) 

%Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

%Plots the carbon fiber model in Figure 1B

%Seth R. Batten srbatten10@vtc.vt.edu 2024


%% Clear Memory 

clear;
close all; 

%% Set file paths 

%Path for Predictions
Predictions_Path = fullfile(''); 

%Path for Prediction SEM
Predictions_SEM_Path = fullfile(''); 

%Path for real labels
Real_Labels_Path = fullfile(''); 

%Where you want to save your figures
Save_Path = fullfile(''); 

%% Load data

%Real Labels
load(Real_Labels_Path);

%Predictions
load(Predictions_Path);

%Predictions SEM
load(Predictions_SEM_Path);


%% Get R^2 and RMSE Values

DA_R = fitlm(Real_Labels{1,1},Predictions{1,1}(:,1));
SE_R = fitlm(Real_Labels{1,2},Predictions{1,2}(:,2));
NE_R = fitlm(Real_Labels{1,4},Predictions{1,4}(:,4));
pH_R = fitlm(Real_Labels{1,3},Predictions{1,3}(:,3));

%% Graph carbon fiber model (Figure 1B)

subplot(1,4,1)
hold on
e3 = errorbar(Real_Labels{1,1},Predictions{1,1}(:,3),Predictions_SEM{1,1}(:,3),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor',  [0.5000    0.5000    1.0000] ,'MarkerSize',12, 'LineWidth', 1);
e4 = errorbar(Real_Labels{1,1},Predictions{1,1}(:,4),Predictions_SEM{1,1}(:,4),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'c','MarkerSize',12, 'LineWidth', 1);
e1 = errorbar(Real_Labels{1,1},Predictions{1,1}(:,1),Predictions_SEM{1,1}(:,1),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'k','MarkerSize',12, 'LineWidth', 1);
e2 = errorbar(Real_Labels{1,1},Predictions{1,1}(:,2),Predictions_SEM{1,1}(:,2),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'm','MarkerSize',12, 'LineWidth', 1);

%Fit Line
plot(Real_Labels{1,1},DA_R.Fitted,'k', 'LineWidth', 4);
hold off 

e1.CapSize = 15;
e1.Color = 'k';

e2.CapSize = 15;
e2.Color = 'k';

e3.CapSize = 15;
e3.Color = 'k';

e4.CapSize = 15;
e4.Color = 'k';

e5.CapSize = 15;
e5.Color = 'k';

e6.CapSize = 15;
e6.Color = 'k';

e7.CapSize = 15;
e7.Color = 'k';

ylim([-800 2800]);
xlim([-300 2800]);
xticks([0 500 1000 1500 2000 2500]);
yticks([0 500 1000 1500 2000 2500]);
xlabel(sprintf('True [ DA or 5HT or NE or pH ] (nM)'));
ylabel(sprintf('Predicted [ DA ] (nM)'));

ax = gca;
ax.FontSize = 18;
axis square
box on
boxLineWidth = 3;
set(gca, 'LineWidth', boxLineWidth);

subplot(1,4,2)
hold on
hold on
e3 = errorbar(Real_Labels{1,2},Predictions{1,2}(:,3),Predictions_SEM{1,2}(:,3),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor',  [0.5000    0.5000    1.0000],'MarkerSize',12, 'LineWidth', 1);
e4 = errorbar(Real_Labels{1,2},Predictions{1,2}(:,4),Predictions_SEM{1,2}(:,4),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'c','MarkerSize',12, 'LineWidth', 1);
e1 = errorbar(Real_Labels{1,2},Predictions{1,2}(:,1),Predictions_SEM{1,2}(:,1),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'k','MarkerSize',12, 'LineWidth', 1);
e2 = errorbar(Real_Labels{1,2},Predictions{1,2}(:,2),Predictions_SEM{1,2}(:,2),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'm','MarkerSize',12, 'LineWidth', 1);

%Fit Line
plot(Real_Labels{1,2},SE_R.Fitted,'k', 'LineWidth', 4);
hold off 

e1.CapSize = 15;
e1.Color = 'k';

e2.CapSize = 15;
e2.Color = 'k';

e3.CapSize = 15;
e3.Color = 'k';

e4.CapSize = 15;
e4.Color = 'k';

e5.CapSize = 15;
e5.Color = 'k';

e6.CapSize = 15;
e6.Color = 'k';

e7.CapSize = 15;
e7.Color = 'k';

ylim([-800 2800]);
xlim([-300 2800]);
xticks([0 500 1000 1500 2000 2500]);
yticks([0 500 1000 1500 2000 2500]);
xlabel(sprintf('True [ DA or 5HT or NE or pH ] (nM)'));
ylabel(sprintf('Predicted [ 5HT ] (nM)'));

ax = gca;
ax.FontSize = 18;
axis square
box on
boxLineWidth = 3;
set(gca, 'LineWidth', boxLineWidth);

subplot(1,4,3)
hold on
e3 = errorbar(Real_Labels{1,4},Predictions{1,4}(:,3),Predictions_SEM{1,4}(:,3),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor',  [0.5000    0.5000    1.0000],'MarkerSize',12, 'LineWidth', 1);
e4 = errorbar(Real_Labels{1,4},Predictions{1,4}(:,1),Predictions_SEM{1,4}(:,1),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'k','MarkerSize',12, 'LineWidth', 1);
e1 = errorbar(Real_Labels{1,4},Predictions{1,4}(:,2),Predictions_SEM{1,4}(:,2),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'm','MarkerSize',12, 'LineWidth', 1);
e2 = errorbar(Real_Labels{1,4},Predictions{1,4}(:,4),Predictions_SEM{1,4}(:,4),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'c','MarkerSize',12, 'LineWidth', 1);

%Fit Line
plot(Real_Labels{1,4},NE_R.Fitted,'k', 'LineWidth', 4);
hold off 

e1.CapSize = 15;
e1.Color = 'k';

e2.CapSize = 15;
e2.Color = 'k';

e3.CapSize = 15;
e3.Color = 'k';

e4.CapSize = 15;
e4.Color = 'k';

e5.CapSize = 15;
e5.Color = 'k';

e6.CapSize = 15;
e6.Color = 'k';

e7.CapSize = 15;
e7.Color = 'k';

ylim([-800 2800]);
xlim([-300 2800]);
xticks([0 500 1000 1500 2000 2500]);
yticks([0 500 1000 1500 2000 2500]);
xlabel(sprintf('True [ DA or 5HT or NE or pH ] (nM)'));
ylabel(sprintf('Predicted [ NE ] (nM)'));


ax = gca;
ax.FontSize = 18;
axis square
box on
boxLineWidth = 3;
set(gca, 'LineWidth', boxLineWidth);

subplot(1,4,4)
hold on
yyaxis left
e3 = errorbar(Real_Labels{1,3},Predictions{1,3}(:,3),Predictions_SEM{1,3}(:,3),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', [0.5000    0.5000    1.0000],'MarkerSize',12, 'LineWidth', 1);

%Fit Line
plot(Real_Labels{1,3},pH_R.Fitted,'-k', 'LineWidth', 4);
hold off

e1.CapSize = 15;
e1.Color = 'k';

e2.CapSize = 15;
e2.Color = 'k';

e3.CapSize = 15;
e3.Color = 'k';

e4.CapSize = 15;
e4.Color = 'k';

ax1 = gca;
ax1.YColor = 'k';

ylim([6.5 8.2]);
xlim([6.5 8.2]);
xlabel(sprintf('True [ DA or 5HT or NE or pH ] (nM)'));
ylabel(sprintf('Predicted [ pH ]'));
xtickangle(45);

hold on
yyaxis right
e4 = errorbar(Real_Labels{1,3},Predictions{1,3}(:,4),Predictions_SEM{1,3}(:,4),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'c','MarkerSize',12, 'LineWidth', 1);
e1 = errorbar(Real_Labels{1,3},Predictions{1,3}(:,1),Predictions_SEM{1,3}(:,1),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'k','MarkerSize',12, 'LineWidth', 1);
e2 = errorbar(Real_Labels{1,3},Predictions{1,3}(:,2),Predictions_SEM{1,3}(:,2),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'm','MarkerSize',12, 'LineWidth', 1);
hold off



e1.CapSize = 15;
e1.Color = 'k';

e2.CapSize = 15;
e2.Color = 'k';

e3.CapSize = 15;
e3.Color = 'k';

e4.CapSize = 15;
e4.Color = 'k';

ax2 = gca;
ax2.YColor = 'k';

ylim([-800 2800]);
yticks([0 500 1000 1500 2000 2500]);
ylabel(sprintf('Predicted [ DA or 5HT or NE ] (nM)'));
ax = gca;
ax.FontSize = 18;
axis square
box on
boxLineWidth = 3;
set(gca, 'LineWidth', boxLineWidth);

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 1]);

saveas(gcf,fullfile(Save_Path,sprintf('Figure_1B_70_6_Carbon_Fiber_Model')),'jpeg');

