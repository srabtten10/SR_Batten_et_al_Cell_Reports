%% PURPOSE OF CODE 

%%Batten et al. (2025) 

%Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

%Run linear mixed-effects analysis (Model 4) and plots Figure S2A, S2B, and S2C

%Seth R. Batten srbatten10@vtc.vt.edu 2024

%% Clear memory 

clear;
close all; 

%% Set file paths 

BehaviorPath = fullfile('');

NTPath = ('');

FigPath = fullfile('');

WordsPath = fullfile('');

%Set Files 
Behavioral = string({'Random_VIM_Behavior.mat';'Random_VIM_Meta_Data.mat'});
NT = string({'Random_VIM_NT.mat'});
Word_Valences = string({'Word_Valences.mat'});
Word_Arousals = string({'Word_Arousals.mat'});

%% Import data: behavior & meta data 

for cc = 1:size(Behavioral,1)
    load(fullfile(BehaviorPath,Behavioral(cc))); 
end

%% Import data: NTs

for cc = 1:size(NT,1)
    load(fullfile(NTPath,NT(cc))); 
end

%% Import data: word ratings 

load(fullfile(WordsPath,Word_Valences)); 
load(fullfile(WordsPath,Word_Arousals)); 

%% Pick the subjects you want to analyze

PickSub = [1,2,3,4,5]; %makes analyzing different people modular 

%% Smooth data first...

%Set Window Size
winS= 5;

%Smooth
for cc = 1:size(PickSub,2)
    for rr = 1:length(NT_Final(PickSub(cc)).Trial_Start_DA(:,1))   
        for tt= winS:length(NT_Final(cc).Trial_Start_DA(1,:))
            Trial_Start_s{cc,1}(rr,tt)= mean(NT_Final(PickSub(cc)).Trial_Start_DA(rr,(tt+1-winS):tt),2);
            Trial_Start_s{cc,2}(rr,tt)= mean(NT_Final(PickSub(cc)).Trial_Start_SE(rr,(tt+1-winS):tt),2);
            Trial_Start_s{cc,3}(rr,tt)= mean(NT_Final(PickSub(cc)).Trial_Start_NE(rr,(tt+1-winS):tt),2);
        end
    end
end

%% Backward smoothing puts 'artificial' zeros in first four spots...

%Replace First 4 Trials With NaNs so zscoring is not artifiically affected 
for cc = 1:size(Trial_Start_s,1)
    for gg = 1:size(Trial_Start_s,2)
        Trial_Start_s{cc,gg}(:,1:4) = NaN;
    end
end

%% Zscore each trial 

%Get Mean
for cc = 1:size(Trial_Start_s,1)
    for gg = 1:size(Trial_Start_s,2)
        for rr = 1:length(Trial_Start_s{cc,1}(:,1))
        Trial_Start_mean{cc,gg}(rr,:) = mean(Trial_Start_s{cc,gg}(rr,:),'omitnan');
        end
    end
end

%Get std
for cc = 1:size(Trial_Start_s,1)
    for gg = 1:size(Trial_Start_s,2)
        for rr = 1:length(Trial_Start_s{cc,1}(:,1))
        Trial_Start_std{cc,gg}(rr,:) = std(Trial_Start_s{cc,gg}(rr,:),1,'omitnan');
        end
    end
end

%Get zscore
for cc = 1:size(Trial_Start_s,1)
    for gg = 1:size(Trial_Start_s,2)
        for rr = 1:length(Trial_Start_s{cc,1}(:,1))
            for ff = 1:length(Trial_Start_s{cc,1}(1,:))
        Trial_Start_sz{cc,gg}(rr,ff) = (Trial_Start_s{cc,gg}(rr,ff)-Trial_Start_mean{cc,gg}(rr,1))/(Trial_Start_std{cc,gg}(rr,1));
            end
        end
    end
end

                   
%% Break data into valences 

%Get Valence IDX
for cc = 1:size(PickSub,2)
    Neutral_idx{cc,1} = find(Behavior_Final(PickSub(cc)).Trial_Start(:,5) == 3);
    Positive_idx{cc,1} = find(Behavior_Final(PickSub(cc)).Trial_Start(:,5) == 2);
    Negative_idx{cc,1} = find(Behavior_Final(PickSub(cc)).Trial_Start(:,5) == 4);
end

%Get NT by Valence 
for cc = 1:size(Trial_Start_sz,1)
    for gg = 1:size(Trial_Start_sz,2)
        Trial_Start_Positive{cc,gg} = Trial_Start_sz{cc,gg}(Positive_idx{cc,1},:);
        Trial_Start_Neutral{cc,gg} = Trial_Start_sz{cc,gg}(Neutral_idx{cc,1},:);
        Trial_Start_Negative{cc,gg} = Trial_Start_sz{cc,gg}(Negative_idx{cc,1},:);
    end
end

%% Subtract pre-word baseline: this is to assess max change from baseline (done below)

%Do Final Scaling by pre-word baseline: Positive 
for cc = 1:size(Trial_Start_Positive,1)
    for gg = 1:size(Trial_Start_Positive,2)
        for ff = 1:length(Trial_Start_Positive{cc,gg}(:,1))
            for rr = 1:length(Trial_Start_Positive{cc,gg}(1,:))
        Trial_Start_Positive_Final_zero{cc,gg}(ff,rr) = Trial_Start_Positive{cc,gg}(ff,rr)-mean(Trial_Start_Positive{cc,gg}(ff,26:30),'omitnan');
            end
        end
    end
end

%Do Final Scaling by pre-word baseline: Negative   
for cc = 1:size(Trial_Start_Negative,1)
    for gg = 1:size(Trial_Start_Negative,2)
        for ff = 1:length(Trial_Start_Negative{cc,gg}(:,1))
            for rr = 1:length(Trial_Start_Negative{cc,gg}(1,:))
        Trial_Start_Negative_Final_zero{cc,gg}(ff,rr) = Trial_Start_Negative{cc,gg}(ff,rr)-mean(Trial_Start_Negative{cc,gg}(ff,26:30),'omitnan');
            end
        end
    end
end

%Do Final Scaling by pre-word baseline: Neutral
for cc = 1:size(Trial_Start_Neutral,1)
    for gg = 1:size(Trial_Start_Neutral,2)
        for ff = 1:length(Trial_Start_Neutral{cc,gg}(:,1))
            for rr = 1:length(Trial_Start_Neutral{cc,gg}(1,:))
        Trial_Start_Neutral_Final_zero{cc,gg}(ff,rr) =  Trial_Start_Neutral{cc,gg}(ff,rr)-mean(Trial_Start_Neutral{cc,gg}(ff,26:30),'omitnan');
            end
        end
    end
end

%% ** GET VARIABLES READ FOR LINEAR MIXED-EFFECTS (LME) MODELING** %%


%% Put word data in order for model

%Break into valence/arousal 
for cc = 1:size(PickSub,2)
Word_Valence_Pos{cc,1} = Word_Valence_Ratings{cc,1}(Positive_idx{cc,1},1);
Word_Valence_Neut{cc,1} = Word_Valence_Ratings{cc,1}(Neutral_idx{cc,1},1);
Word_Valence_Neg{cc,1} = Word_Valence_Ratings{cc,1}(Negative_idx{cc,1},1);

Word_Arousal_Pos{cc,1} = Word_Arousal_Ratings{cc,1}(Positive_idx{cc,1},1);
Word_Arousal_Neut{cc,1} = Word_Arousal_Ratings{cc,1}(Neutral_idx{cc,1},1);
Word_Arousal_Neg{cc,1} = Word_Arousal_Ratings{cc,1}(Negative_idx{cc,1},1);
end

%Concatenate by valence/arousal
for cc = 1:size(PickSub,2)
    Word_All_Valence{cc,1} = vertcat(Word_Valence_Pos{cc,1},Word_Valence_Neg{cc,1},Word_Valence_Neut{cc,1});
    Word_All_Arousal{cc,1} = vertcat(Word_Arousal_Pos{cc,1},Word_Arousal_Neg{cc,1},Word_Arousal_Neut{cc,1});
end


Model_Valence_Rating = vertcat(Word_All_Valence{:}); %Put in LME format
Model_Arousal_Rating = vertcat(Word_All_Arousal{:}); %Put in LME format

%% Get reaction times per valence 

for cc = 1:size(PickSub,2)
    Rx_Time_Neutral{cc,1} = Behavior_Final(PickSub(cc)).Trial_Start(Neutral_idx{cc,1},10);
    Rx_Time_Positive{cc,1} = Behavior_Final(PickSub(cc)).Trial_Start(Positive_idx{cc,1},10);
    Rx_Time_Negative{cc,1} = Behavior_Final(PickSub(cc)).Trial_Start(Negative_idx{cc,1},10);
end

%% Reaction times for model

%vertcat Rx_Times to prepare to zscore
for cc = 1:size(Rx_Time_Positive,1)
    Rx_Times_vert{cc,1} = vertcat(Rx_Time_Positive{cc,1},Rx_Time_Negative{cc,1},Rx_Time_Neutral{cc,1});
end

    
Model_Rx_Time = vertcat(Rx_Times_vert{:}); %Put in LME format

%% Make subject variable

for cc = 1:size(PickSub,2)
    Model_Subject = repelem(PickSub,176)'; %Put in LME format
end

%% Make valence identifiers 

for cc = 1:size(PickSub,2)
    pos{cc,1} = repelem(1,44)';
    neg{cc,1} = repelem(-1,44)';
    neut{cc,1} = repelem(0,88)';
end

for cc = 1:size(PickSub,2)
    valence_vert{cc,1} = vertcat(pos{cc,1},neg{cc,1},neut{cc,1});
end

Model_Valence = vertcat(valence_vert{:}); %Put in LME format

%% Make salience identifiers 

for cc = 1:size(PickSub,2)
    sal_1{cc,1} = repelem(1,44)';
    sal_2{cc,1} = repelem(1,44)';
    neut{cc,1} = repelem(-1,88)';
end

for cc = 1:size(PickSub,2)
    salience_vert{cc,1} = vertcat(sal_1{cc,1},sal_2{cc,1},neut{cc,1});
end

Model_Salience = vertcat(salience_vert{:}); %Put in LME format


%% Get accuracies 

for cc = 1:size(PickSub,2)
    pos_acc{cc,1} = Behavior_Final(PickSub(cc)).Trial_Start(Positive_idx{cc,1},9);
    neg_acc{cc,1} = Behavior_Final(PickSub(cc)).Trial_Start(Negative_idx{cc,1},9);
    neut_acc{cc,1} = Behavior_Final(PickSub(cc)).Trial_Start(Neutral_idx{cc,1},9);
end

for cc = 1:size(PickSub,2)
    accuracy_vert{cc,1} = vertcat(pos_acc{cc,1},neg_acc{cc,1},neut_acc{cc,1});
end

Model_Accuracy = vertcat(accuracy_vert{:}); %Put in LME format

%% Run LME for reaction times

datanames   = {'Subject','RxTime','Valence_Num','Arousal_Num'};
   
Model_Table = table(categorical(Model_Subject),Model_Rx_Time,...
                        Model_Valence_Rating,Model_Arousal_Rating,'VariableNames',datanames);

%With Random Effects for both intercept and slope
formulaz = 'RxTime ~ 1 + Valence_Num + Arousal_Num + (1 + Valence_Num + Arousal_Num|Subject)';
lme_Relative_AUC = fitglme(Model_Table,formulaz,'distribution','normal','Link','identity','FitMethod','Laplace');
%Random Effects for intercept only
formulaz = 'RxTime ~ 1 + Valence_Num + Arousal_Num + (1|Subject)';
lme_Relative_NoRand_AUC = fitglme(Model_Table,formulaz,'distribution','normal','Link','identity','FitMethod','Laplace');

AIC_1 = dataset2cell(lme_Relative_AUC.ModelCriterion(1,1));
AIC_2 = dataset2cell(lme_Relative_NoRand_AUC.ModelCriterion(1,1));

Results_Relative_AUC{1,1} = lme_Relative_AUC;
Results_Relative_AIC{1,1} = AIC_1{2,1};

Results_Relative_No_Rand_AUC{1,1} = lme_Relative_NoRand_AUC;
Results_Relative_No_Rand_AIC{1,1} = AIC_2{2,1};



%% Final House Keeping: organize models 

Relative_Model_Names = cell({'RxTime ~ 1 + Valence_Num + Arousal_Num + (1 + Valence_Num + Arousal_Num|Subject)'});

Relative_NoRand_Model_Names = cell({'RxTime ~ 1 + Valence_Num + Arousal_Num + (1|Subject)'});
                                    
                                    
Final_Peak_Models = horzcat(Relative_Model_Names,Results_Relative_AUC);
Final_Peak_AIC_Models = horzcat(Relative_Model_Names,Results_Relative_AIC);

Final_Peak_NoRand_Models = horzcat(Relative_NoRand_Model_Names,Results_Relative_No_Rand_AUC);
Final_Peak_NoRand_AIC_Models = horzcat(Relative_NoRand_Model_Names,Results_Relative_No_Rand_AIC);

%% Compare models via AIC

Vect_Model = [2];

for cc = 1:size(Final_Peak_NoRand_Models,1)
    for gg = 1:size(Vect_Model,2)
    Model_Compare{cc,gg} = compare(Final_Peak_NoRand_Models{cc,Vect_Model(gg)},Final_Peak_Models{cc,Vect_Model(gg)},'CheckNesting',true);
    end
end

%% Run ANOVA over lower AIC model parameters and put in more easy to deal with format

for cc = 1:size(Final_Peak_NoRand_Models,1)
    for gg = 2:size(Final_Peak_NoRand_Models,2)
        Model_Outputs{cc,gg} = anova(Final_Peak_NoRand_Models{cc,gg});
    end
end


for cc = 1:size(Model_Outputs,1)
    for ff = 1:size(Model_Outputs,2)
        for rr = 1:size(Model_Outputs{cc,ff},1)
            for gg = 1:size(Model_Outputs{cc,ff},2)
                Model_Outputs_Refined{cc,ff}{rr,gg} = Model_Outputs{cc,ff}{rr,gg};
            end
        end
    end
end
        

for cc = 1:size(Model_Outputs_Refined,1)
    for gg = 2:size(Model_Outputs_Refined,2)
        Model_Outputs_Table{cc,gg} = cell2table(Model_Outputs_Refined{cc,gg});
    end
end

%% ** PLOT THE RESULTS ** %%


%% Set Y axis 

Yaxis = 1.5;

%% Reaction time per valence; Figure S2D

%Get indexes 
for cc = 1:size(PickSub,2)
    Pos_Rx(cc,1) = mean(Rx_Times_vert{cc,1}(valence_vert{cc,1} == 1,1),'omitnan');
    Neg_Rx(cc,1) = mean(Rx_Times_vert{cc,1}(valence_vert{cc,1} == -1,1),'omitnan');
    Neut_Rx(cc,1) = mean(Rx_Times_vert{cc,1}(valence_vert{cc,1} == 0 ,1),'omitnan');
end

scatterX1 = repelem(1,length(Neg_Rx(:,1)));
scatterX2 = repelem(2,length(Neut_Rx(:,1)));
scatterX3 = repelem(3,length(Pos_Rx(:,1)));

%DA Mean
mean_Rx(3,1) = mean(Pos_Rx(:,1),'omitnan');
mean_Rx(1,1) = mean(Neg_Rx(:,1),'omitnan');
mean_Rx(2,1) = mean(Neut_Rx(:,1),'omitnan');
%Group SEM:DA
SEM_Rx(3,1) = std(Pos_Rx(:,1),1,'omitnan')/(sqrt(length(find(~isnan(Pos_Rx(:,1))))));
SEM_Rx(1,1) = std(Neg_Rx(:,1),1,'omitnan')/(sqrt(length(find(~isnan(Neg_Rx(:,1))))));
SEM_Rx(2,1) = std(Neut_Rx(:,1),1,'omitnan')/(sqrt(length(find(~isnan(Neut_Rx(:,1))))));


subplot(1,4,1)

b = bar(1:3,mean_Rx, 'FaceColor', 'flat');
hold on
er = errorbar(1:3,mean_Rx, SEM_Rx, 'LineStyle', 'none');
scatter(scatterX1,Neg_Rx(:,1),100,'MarkerEdgeColor', 'k','MarkerFaceColor',[0.7 0.7 0.7]);
scatter(scatterX2,Neut_Rx(:,1),100,'MarkerEdgeColor', 'k','MarkerFaceColor',[0.7 0.7 0.7]);
scatter(scatterX3,Pos_Rx(:,1),100,'MarkerEdgeColor', 'k','MarkerFaceColor',[0.7 0.7 0.7]);
hold off

b.CData(1,:) = [1 0 0];
b.CData(2,:) = [0 0 0];
b.CData(3,:) = [0 1 0];

er.Color = 'k';
er.CapSize = 0;

    xlim([0 4])
    ylim([0 Yaxis]);
    xticks([1 2 3]);
    xticklabels({'Neg' 'Neut' 'Pos'});
    ylabel('Reaction Time (s)');
    ax = gca;
    ax.FontSize = 20;
    axis square 
    box off


set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 1]);
set(gcf,'InvertHardCopy','off');
set(gcf, 'Color', [1 1 1]); 

saveas(gcf,fullfile(FigPath,'Figure_S2A_Random_VIM_Reaction_Time'),'jpeg');


%% Set Y axis 

Yaxis = 100;

%% Trials with responses per valence; Figure S2E


%Get indexes 
for cc = 1:size(PickSub,2)
    Pos_Resp(cc,1) = sum(length(find(~isnan(Rx_Times_vert{cc,1}(valence_vert{cc,1} == 1,1)))));
    Neg_Resp(cc,1) = sum(length(find(~isnan(Rx_Times_vert{cc,1}(valence_vert{cc,1} == -1,1)))));
    Neut_Resp(cc,1) = sum(length(find(~isnan(Rx_Times_vert{cc,1}(valence_vert{cc,1} == 0,1)))));
end


%DA Mean
mean_Resp(3,1) = mean((Pos_Resp(:,1)/44)*100,'omitnan');
mean_Resp(1,1) = mean((Neg_Resp(:,1)/44)*100,'omitnan');
mean_Resp(2,1) = mean((Neut_Resp(:,1)/88)*100,'omitnan');
%Group SEM:DA
SEM_Resp(3,1) = std((Pos_Resp(:,1)/44)*100,1,'omitnan')/(sqrt(length(find(~isnan(Pos_Resp(:,1))))));
SEM_Resp(1,1) = std((Neg_Resp(:,1)/44)*100,1,'omitnan')/(sqrt(length(find(~isnan(Neg_Resp(:,1))))));
SEM_Resp(2,1) = std((Neut_Resp(:,1)/88)*100,1,'omitnan')/(sqrt(length(find(~isnan(Neut_Resp(:,1))))));

scatterX1 = repelem(1,length(Neg_Resp(:,1)));
scatterX2 = repelem(2,length(Neut_Resp(:,1)));
scatterX3 = repelem(3,length(Pos_Resp(:,1)));

subplot(1,4,1)
b = bar(1:3,mean_Resp, 'FaceColor', 'flat');
hold on
er = errorbar(1:3,mean_Resp, SEM_Resp, 'LineStyle', 'none');
scatter(scatterX1,(Neg_Resp(:,1)/44)*100,100,'MarkerEdgeColor', 'k','MarkerFaceColor',[0.7 0.7 0.7]);
scatter(scatterX2,(Neut_Resp(:,1)/88)*100,100,'MarkerEdgeColor', 'k','MarkerFaceColor',[0.7 0.7 0.7]);
scatter(scatterX3,(Pos_Resp(:,1)/44)*100,100,'MarkerEdgeColor', 'k','MarkerFaceColor',[0.7 0.7 0.7]);
hold off

b.CData(1,:) = [1 0 0];
b.CData(2,:) = [0 0 0];
b.CData(3,:) = [0 1 0];

er.Color = 'k';
er.CapSize = 0;

    xlim([0 4])
    ylim([0  Yaxis]);
    xticks([1 2 3]);
    xticklabels({'Neg' 'Neut' 'Pos'});
    ylabel('% Trials with Responses');
    ax = gca;
    ax.FontSize = 20;
    axis square 
    box off


set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 1]);
set(gcf,'InvertHardCopy','off');
set(gcf, 'Color', [1 1 1]); 

saveas(gcf,fullfile(FigPath,'Figure_S2B_Random_VIM_Responses'),'jpeg');

%% Set Y axis 

Yaxis = 1;

%% Accuracy per valence; Figure S2F


%Get indexes 
for cc = 1:size(PickSub,2)
    Pos_Acc(cc,1) = mean(accuracy_vert{cc,1}(valence_vert{cc,1} == 1,1),'omitnan');
    Neg_Acc(cc,1) = mean(accuracy_vert{cc,1}(valence_vert{cc,1} == -1,1),'omitnan');
    Neut_Acc(cc,1) = mean(accuracy_vert{cc,1}(valence_vert{cc,1} == 0 ,1),'omitnan');
end

scatterX1 = repelem(1,length(Neg_Acc(:,1)));
scatterX2 = repelem(2,length(Neut_Acc(:,1)));
scatterX3 = repelem(3,length(Pos_Acc(:,1)));

%DA Mean
mean_Acc(3,1) = mean(Pos_Acc(:,1),'omitnan');
mean_Acc(1,1) = mean(Neg_Acc(:,1),'omitnan');
mean_Acc(2,1) = mean(Neut_Acc(:,1),'omitnan');
%Group SEM:DA
SEM_Acc(3,1) = std(Pos_Acc(:,1),1,'omitnan')/(sqrt(length(find(~isnan(Pos_Acc(:,1))))));
SEM_Acc(1,1) = std(Neg_Acc(:,1),1,'omitnan')/(sqrt(length(find(~isnan(Neg_Acc(:,1))))));
SEM_Acc(2,1) = std(Neut_Acc(:,1),1,'omitnan')/(sqrt(length(find(~isnan(Neut_Acc(:,1))))));


subplot(1,4,1)

b = bar(1:3,mean_Acc, 'FaceColor', 'flat');
hold on
er = errorbar(1:3,mean_Acc, SEM_Acc, 'LineStyle', 'none');
scatter(scatterX1,Neg_Acc(:,1),100,'MarkerEdgeColor', 'k','MarkerFaceColor',[0.7 0.7 0.7]);
scatter(scatterX2,Neut_Acc(:,1),100,'MarkerEdgeColor', 'k','MarkerFaceColor',[0.7 0.7 0.7]);
scatter(scatterX3,Pos_Acc(:,1),100,'MarkerEdgeColor', 'k','MarkerFaceColor',[0.7 0.7 0.7]);
hold off

b.CData(1,:) = [1 0 0];
b.CData(2,:) = [0 0 0];
b.CData(3,:) = [0 1 0];

er.Color = 'k';
er.CapSize = 0;

    xlim([0 4])
    ylim([0  Yaxis]);
    xticks([1 2 3]);
    xticklabels({'Neg' 'Neut' 'Pos'});
    ylabel('Proportion Correct');
    ax = gca;
    ax.FontSize = 20;
    axis square 
    box off


set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 1]);
set(gcf,'InvertHardCopy','off');
set(gcf, 'Color', [1 1 1]); 

saveas(gcf,fullfile(FigPath,'Figure_S2C_Random_VIM_Accuracy'),'jpeg');
