%% PURPOSE OF CODE 

%%Batten et al. (2025) 

%Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

%Run linear mixed-effects analysis (Model 7) using valence as a categorical variable
%(for plots Figure 3C and 3D)

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
Behavioral = string({'Blocked_VIM_Behavior.mat';'Blocked_VIM_Meta_Data.mat'});
NT = string({'Blocked_VIM_NT.mat'});
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

PickSub = [1,2,3,4,5,6,7,8,9]; %makes analyzing different people modular 

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


%% Put Word Data in order for model

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

%% Get reaction times per Valence 

for cc = 1:size(PickSub,2)
    Rx_Time_Neutral{cc,1} = Behavior_Final(PickSub(cc)).Trial_Start(Neutral_idx{cc,1},10);
    Rx_Time_Positive{cc,1} = Behavior_Final(PickSub(cc)).Trial_Start(Positive_idx{cc,1},10);
    Rx_Time_Negative{cc,1} = Behavior_Final(PickSub(cc)).Trial_Start(Negative_idx{cc,1},10);
end

%% Z-score reaction times for model

%vertcat Rx_Times to prepare to zscore
for cc = 1:size(Rx_Time_Positive,1)
    Rx_Times_vert{cc,1} = vertcat(Rx_Time_Positive{cc,1},Rx_Time_Negative{cc,1});
end

%get mean and SD
for cc = 1:size(Rx_Times_vert,1)
    Rx_Times_mean(cc,1) = mean(Rx_Times_vert{cc,1},'omitnan');
    Rx_Times_SD(cc,1) = std(Rx_Times_vert{cc,1},1,'omitnan');
end

%zscore
for cc = 1:size(Rx_Times_vert,1)
    for rr = 1:size(Rx_Times_vert{cc,1}(:,1))
        Rx_Time_z{cc,1}(rr,1) = (Rx_Times_vert{cc,1}(rr,1)-Rx_Times_mean(cc,1))/(Rx_Times_SD(cc,1));
    end
end
    
Model_Rx_Time = vertcat(Rx_Time_z{:}); %Put in LME format

%% Make subject variable

for cc = 1:size(PickSub,2)
    Model_Subject = repelem(PickSub,88)'; %Put in LME format
end

%% Make valence identifiers 

for cc = 1:size(PickSub,2)
    pos{cc,1} = repelem(1,44)';
    neg{cc,1} = repelem(-1,44)';
    neut{cc,1} = repelem(0,88)';
end

for cc = 1:size(PickSub,2)
    valence_vert{cc,1} = vertcat(pos{cc,1},neg{cc,1});
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
    accuracy_vert{cc,1} = vertcat(pos_acc{cc,1},neg_acc{cc,1});
end

Model_Accuracy = vertcat(accuracy_vert{:}); %Put in LME format

%% Max change for positive words while word is on screen

%Get max and min
for cc = 1:size(Trial_Start_Positive_Final_zero,1)
    for gg = 1:size(Trial_Start_Positive_Final_zero,2)
        for rr = 1:size(Trial_Start_Positive_Final_zero{cc,gg}(:,1))
            [pos_max{cc,gg},pos_max_idx{cc,gg}] = max(Trial_Start_Positive_Final_zero{cc,gg}(:,31:44),[],2,'omitnan');
            [pos_min{cc,gg},pos_min_idx{cc,gg}] = min(Trial_Start_Positive_Final_zero{cc,gg}(:,31:44),[],2,'omitnan');
            pos_max_abs{cc,gg} = abs(max(Trial_Start_Positive_Final_zero{cc,gg}(:,31:44),[],2,'omitnan'));
            pos_min_abs{cc,gg} = abs(min(Trial_Start_Positive_Final_zero{cc,gg}(:,31:44),[],2,'omitnan'));
        end
    end
end

%Find actual max change
for cc = 1:size(Trial_Start_Positive_Final_zero,1)
    for gg = 1:size(Trial_Start_Positive_Final_zero,2)
        for rr = 1:size(Trial_Start_Positive_Final_zero{cc,gg}(:,1))
            if pos_max_abs{cc,gg}(rr,1) > pos_min_abs{cc,gg}(rr,1)
                pos_Peak_Change{cc,gg}(rr,1) = pos_max{cc,gg}(rr,1);
            else
                pos_Peak_Change{cc,gg}(rr,1) = pos_min{cc,gg}(rr,1);
            end
        end
    end
end


%% Max change for negative words while word is on screen

%Get max and min
for cc = 1:size(Trial_Start_Negative_Final_zero,1)
    for gg = 1:size(Trial_Start_Negative_Final_zero,2)
        for rr = 1:size(Trial_Start_Negative_Final_zero{cc,gg}(:,1))
            [neg_max{cc,gg},neg_max_idx{cc,gg}] = max(Trial_Start_Negative_Final_zero{cc,gg}(:,31:44),[],2,'omitnan');
            [neg_min{cc,gg},neg_min_idx{cc,gg}] = min(Trial_Start_Negative_Final_zero{cc,gg}(:,31:44),[],2,'omitnan');
            neg_max_abs{cc,gg} = abs(max(Trial_Start_Negative_Final_zero{cc,gg}(:,31:44),[],2,'omitnan'));
            neg_min_abs{cc,gg} = abs(min(Trial_Start_Negative_Final_zero{cc,gg}(:,31:44),[],2,'omitnan'));
        end
    end
end

%Find actual max change
for cc = 1:size(Trial_Start_Negative_Final_zero,1)
    for gg = 1:size(Trial_Start_Negative_Final_zero,2)
        for rr = 1:size(Trial_Start_Negative_Final_zero{cc,gg}(:,1))
            if neg_max_abs{cc,gg}(rr,1) > neg_min_abs{cc,gg}(rr,1)
                neg_Peak_Change{cc,gg}(rr,1) = neg_max{cc,gg}(rr,1);
            else
                neg_Peak_Change{cc,gg}(rr,1) = neg_min{cc,gg}(rr,1);
            end
        end
    end
end

%% Max change for neutral words while word is on screen

%Get max and min
for cc = 1:size(Trial_Start_Neutral_Final_zero,1)
    for gg = 1:size(Trial_Start_Neutral_Final_zero,2)
        for rr = 1:size(Trial_Start_Neutral_Final_zero{cc,gg}(:,1))
            [neut_max{cc,gg},neut_max_idx{cc,gg}] = max(Trial_Start_Neutral_Final_zero{cc,gg}(:,31:44),[],2,'omitnan');
            [neut_min{cc,gg},neut_min_idx{cc,gg}] = min(Trial_Start_Neutral_Final_zero{cc,gg}(:,31:44),[],2,'omitnan');
            neut_max_abs{cc,gg} = abs(max(Trial_Start_Neutral_Final_zero{cc,gg}(:,31:44),[],2,'omitnan'));
            neut_min_abs{cc,gg} = abs(min(Trial_Start_Neutral_Final_zero{cc,gg}(:,31:44),[],2,'omitnan'));
        end
    end
end

%Find actual max change
for cc = 1:size(Trial_Start_Neutral_Final_zero,1)
    for gg = 1:size(Trial_Start_Neutral_Final_zero,2)
        for rr = 1:size(Trial_Start_Neutral_Final_zero{cc,gg}(:,1))
            if neut_max_abs{cc,gg}(rr,1) > neut_min_abs{cc,gg}(rr,1)
                neut_Peak_Change{cc,gg}(rr,1) = neut_max{cc,gg}(rr,1);
            else
                neut_Peak_Change{cc,gg}(rr,1) = neut_min{cc,gg}(rr,1);
            end
        end
    end
end

%% Put max change in model form

%Note columm 1 = DA
%Note columm 2 = 5HT
%Note columm 3 = NE

%Vercat By Subject
for cc = 1:size(pos_Peak_Change,1)
    for gg = 1:size(pos_Peak_Change,2)
    Peak_Subject{cc,gg} = vertcat(pos_Peak_Change{cc,gg},neg_Peak_Change{cc,gg});
    end
end

for cc = 1:size(Peak_Subject,2)
    Model_Peak_Change(:,cc) = vertcat(Peak_Subject{:,cc});
end

%% Run LME per neurmodulator...

datanames   = {'Subject','Valence','RxTime',...
               'Peak'};
for cc = 1:size(Model_Peak_Change,2)    
    Model_Table = table(categorical(Model_Subject),categorical(Model_Valence),...
                    Model_Rx_Time,Model_Peak_Change(:,cc),'VariableNames',datanames);


%With Random Effects for intercept and slope
formulaz = 'Peak ~ 1 + Valence * RxTime + (1 + Valence * RxTime|Subject)';
lme_Relative_AUC = fitglme(Model_Table,formulaz,'distribution','normal','Link','identity','FitMethod','Laplace');
%With Random Effects for just slope
formulaz = 'Peak ~ 1 + Valence * RxTime + (1|Subject)';
lme_Relative_NoRand_AUC = fitglme(Model_Table,formulaz,'distribution','normal','Link','identity','FitMethod','Laplace');

AIC_1 = dataset2cell(lme_Relative_AUC.ModelCriterion(1,1));
AIC_2 = dataset2cell(lme_Relative_NoRand_AUC.ModelCriterion(1,1));

Results_Relative_AUC{1,cc} = lme_Relative_AUC;
Results_Relative_AIC{1,cc} = AIC_1{2,1};

Results_Relative_No_Rand_AUC{1,cc} = lme_Relative_NoRand_AUC;
Results_Relative_No_Rand_AIC{1,cc} = AIC_2{2,1};
end

%% Final house keeping: organize models 

Relative_Model_Names = cell({'Peak ~ 1 + Valence * RxTime + (1 + Valence * RxTime|Subject)'});
                         
Relative_NoRand_Model_Names = cell({'Peak ~ 1 + Valence * RxTime + (1|Subject)'});
                                    

Final_Peak_Models = horzcat(Relative_Model_Names,Results_Relative_AUC);
Final_Peak_AIC_Models = horzcat(Relative_Model_Names,Results_Relative_AIC);

Final_Peak_NoRand_Models = horzcat(Relative_NoRand_Model_Names,Results_Relative_No_Rand_AUC);
Final_Peak_NoRand_AIC_Models = horzcat(Relative_NoRand_Model_Names,Results_Relative_No_Rand_AIC);

%% Compare models via AIC

Vect_Model = [2:4];

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
