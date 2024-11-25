%% PURPOSE OF CODE

%Batten et al. (2025) 

%Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

%Plots the cingulate depth electrode model in Figure 4B

%Seth R. Batten srbatten10@vtc.vt.edu 2024

%% Clear memory 

clear;
close all; 

%% Set file paths  

ModelPath = fullfile('');

FigPath = fullfile('');
      
%% Import model

fileList = dir(fullfile(ModelPath, '*.mat'));

for i = 1:numel(fileList)
    filePath = fullfile(ModelPath, fileList(i).name);
    load(filePath, '-mat');
end

%% Get R^2 

DA_R = fitlm(DA_Label_mean,DA_Prediction_mean(:,1));

SE_R = fitlm(SE_Label_mean,SE_Prediction_mean(:,2));

NE_R = fitlm(NE_Label_mean,NE_Prediction_mean(:,3));

pH_R = fitlm(pH_Label_mean,pH_Prediction_mean(:,4));


%% Plot ACC depth electrode model 

subplot(1,4,1)
hold on 
e4 = errorbar(DA_Label_mean,DA_Prediction_mean(:,4),DA_Prediction_SEM(:,4),'o','MarkerSize',12,'MarkerFaceColor',[0.5000    0.5000    1.0000],'MarkerEdgeColor','k','LineWidth',1);
e = errorbar(DA_Label_mean,DA_Prediction_mean(:,1),DA_Prediction_SEM(:,1),'o','MarkerSize',12,'MarkerFaceColor','k','MarkerEdgeColor','k','LineWidth',1);
e2 = errorbar(DA_Label_mean,DA_Prediction_mean(:,3),DA_Prediction_SEM(:,3),'o','MarkerSize',12,'MarkerFaceColor','c','MarkerEdgeColor','k','LineWidth',1);
e3 = errorbar(DA_Label_mean,DA_Prediction_mean(:,2),DA_Prediction_SEM(:,2),'o','MarkerSize',12,'MarkerFaceColor','m','MarkerEdgeColor','k','LineWidth',1);

plot(DA_Label_mean,DA_R.Fitted,'k', 'LineWidth', 4);
hold off 

ylim([-800 2800]); %carbon fiber scale
xlim([-300 2800]); %carbon fiber scale

xticks([0 500 1000 1500 2000 2500]);
yticks([0 500 1000 1500 2000 2500]);

e.Color = 'k';
e.CapSize = 0;

e2.Color = 'k';
e2.CapSize = 0;

e3.Color = 'k';
e3.CapSize = 0;

e4.Color = 'k';
e4.CapSize = 0;

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
e4 = errorbar(SE_Label_mean,SE_Prediction_mean(:,4),SE_Prediction_SEM(:,4),'o','MarkerSize',12,'MarkerFaceColor',[0.5000    0.5000    1.0000],'MarkerEdgeColor','k','LineWidth',1);
e = errorbar(SE_Label_mean,SE_Prediction_mean(:,2),SE_Prediction_SEM(:,2),'o','MarkerSize',12,'MarkerFaceColor','m','MarkerEdgeColor','k','LineWidth',1);
e3 = errorbar(SE_Label_mean,SE_Prediction_mean(:,3),SE_Prediction_SEM(:,3),'o','MarkerSize',12,'MarkerFaceColor','c','MarkerEdgeColor','k','LineWidth',1);
e2 = errorbar(SE_Label_mean,SE_Prediction_mean(:,1),SE_Prediction_SEM(:,1),'o','MarkerSize',12,'MarkerFaceColor','k','MarkerEdgeColor','k','LineWidth',1);

plot(SE_Label_mean,SE_R.Fitted,'k', 'LineWidth', 4);
hold off 
    
ylim([-800 2800]); %carbon fiber scale
xlim([-300 2800]); %carbon fiber scale

xticks([0 500 1000 1500 2000 2500]);
yticks([0 500 1000 1500 2000 2500]);

e.Color = 'k';
e.CapSize = 0;

e2.Color = 'k';
e2.CapSize = 0;

e3.Color = 'k';
e3.CapSize = 0;

e4.Color = 'k';
e4.CapSize = 0;

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
%analyte that line fits
e4 = errorbar(NE_Label_mean,NE_Prediction_mean(:,4),NE_Prediction_SEM(:,4),'o','MarkerSize',12,'MarkerFaceColor',[0.5000    0.5000    1.0000],'MarkerEdgeColor','k','LineWidth',1);
e = errorbar(NE_Label_mean,NE_Prediction_mean(:,3),NE_Prediction_SEM(:,3),'o','MarkerSize',12,'MarkerFaceColor','c','MarkerEdgeColor','k','LineWidth',1);
e2 = errorbar(NE_Label_mean,NE_Prediction_mean(:,1),NE_Prediction_SEM(:,1),'o','MarkerSize',12,'MarkerFaceColor','k','MarkerEdgeColor','k','LineWidth',1);
e3 = errorbar(NE_Label_mean,NE_Prediction_mean(:,2),NE_Prediction_SEM(:,2),'o','MarkerSize',12,'MarkerFaceColor','m','MarkerEdgeColor','k','LineWidth',1);


%Fit Line
plot(NE_Label_mean,NE_R.Fitted,'k', 'LineWidth', 4);
hold off 

ylim([-800 2800]); %carbon fiber scale
xlim([-300 2800]); %carbon fiber scale

xticks([0 500 1000 1500 2000 2500]);
yticks([0 500 1000 1500 2000 2500]);

e.Color = 'k';
e.CapSize = 0;

e2.Color = 'k';
e2.CapSize = 0;

e3.Color = 'k';
e3.CapSize = 0;

e4.Color = 'k';
e4.CapSize = 0;

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
e3 = errorbar(pH_Label_mean,pH_Prediction_mean(:,4),pH_Prediction_SEM(:,4),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', [0.5000    0.5000    1.0000],'MarkerSize',12, 'LineWidth', 1);
%Fit Line
plot(pH_Label_mean,pH_R.Fitted,'-k', 'LineWidth', 4);
hold off


e3.CapSize = 0;
e3.Color = 'k';


ax1 = gca;
ax1.YColor = 'k';

ylim([6.9 7.9]);
xlim([6.9 7.9]);
xlabel(sprintf('True [ DA or 5HT or NE or pH ] (nM)'));
ylabel(sprintf('Predicted [ pH ]'));
xtickangle(45);

hold on
yyaxis right
e4 = errorbar(pH_Label_mean,pH_Prediction_mean(:,3),pH_Prediction_SEM(:,3),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'c','MarkerSize',12, 'LineWidth', 1);
e1 = errorbar(pH_Label_mean,pH_Prediction_mean(:,1),pH_Prediction_SEM(:,1),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'k','MarkerSize',12, 'LineWidth', 1);
e2 = errorbar(pH_Label_mean,pH_Prediction_mean(:,2),pH_Prediction_SEM(:,2),'o', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'm','MarkerSize',12, 'LineWidth', 1);
hold off

e1.CapSize = 0;
e1.Color = 'k';

e2.CapSize = 0;
e2.Color = 'k';

e3.CapSize = 0;
e3.Color = 'k';

e4.CapSize = 0;
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

saveas(gcf,fullfile(FigPath,sprintf('Figure_4_Cingulate_Depth_Electrode_Model')),'jpeg');

