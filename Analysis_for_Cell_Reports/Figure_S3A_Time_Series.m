%% PURPOSE OF CODE 

%%Batten et al. (2025) 

%Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

%Plots the time series neuromodulator data in Figure S3A

%Seth R. Batten srbatten10@vtc.vt.edu 2024

%% Clear memory 

clear;
close all; 

%% Set file paths 

BehaviorPath = fullfile('');

NTPath = ('');

FigPath = fullfile('');

%Set Files 
Behavioral = string({'Random_VIM_Behavior.mat';'Random_VIM_Meta_Data.mat'});
NT = string({'Random_VIM_NT.mat'});

%% Import data: behavior & meta data 

for cc = 1:size(Behavioral,1)
    load(fullfile(BehaviorPath,Behavioral(cc))); 
end

%% Import data: NTs

for cc = 1:size(NT,1)
    load(fullfile(NTPath,NT(cc))); 
end

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
        Trial_Start_Positive_Final{cc,gg} = Trial_Start_sz{cc,gg}(Positive_idx{cc,1},:);
        Trial_Start_Neutral_Final{cc,gg} = Trial_Start_sz{cc,gg}(Neutral_idx{cc,1},:);
        Trial_Start_Negative_Final{cc,gg} = Trial_Start_sz{cc,gg}(Negative_idx{cc,1},:);
    end
end

%% Get average across trial types per person 

%Positive
for cc = 1:length(Trial_Start_Positive_Final)
    for gg = 1:size(Trial_Start_Positive_Final,2)
        Pos_Mean_Final{cc,gg} = mean(Trial_Start_Positive_Final{cc,gg},'omitnan');
    end
end

%Negative
for cc = 1:length(Trial_Start_Positive_Final)
    for gg = 1:size(Trial_Start_Positive_Final,2)
        Neg_Mean_Final{cc,gg} = mean(Trial_Start_Negative_Final{cc,gg},'omitnan');
    end
end

%Neutral
for cc = 1:length(Trial_Start_Positive_Final)
    for gg = 1:size(Trial_Start_Positive_Final,2)
        Neut_Mean_Final{cc,gg} = mean(Trial_Start_Neutral_Final{cc,gg},'omitnan');
    end
end

%% Get average and SEM across people 

%Positive Mean
for cc = 1:length(Pos_Mean_Final)
    for gg = 1:size(Pos_Mean_Final,2)
        Group_Mat_Pos{gg,1}(cc,:) = vertcat(Pos_Mean_Final{cc,gg});
    end
end

for cc = 1:length(Group_Mat_Pos)
    Goup_Mat_Pos_Avg(cc,:) = mean(Group_Mat_Pos{cc,1},'omitnan'); 
end

%Negative Mean
for cc = 1:length(Neg_Mean_Final)
    for gg = 1:size(Neg_Mean_Final,2)
        Group_Mat_Neg{gg,1}(cc,:) = vertcat(Neg_Mean_Final{cc,gg});
    end
end

for cc = 1:length(Group_Mat_Neg)
    Goup_Mat_Neg_Avg(cc,:) = mean(Group_Mat_Neg{cc,1},'omitnan'); 
end

%Neutral Mean
for cc = 1:length(Neut_Mean_Final)
    for gg = 1:size(Neut_Mean_Final,2)
        Group_Mat_Neut{gg,1}(cc,:) = vertcat(Neut_Mean_Final{cc,gg});
    end
end

for cc = 1:length(Group_Mat_Neut)
    Goup_Mat_Neut_Avg(cc,:) = mean(Group_Mat_Neut{cc,1},'omitnan'); 
end


%Positive SEM
for cc = 1:length(Group_Mat_Pos)
    for gg = 1:length(Group_Mat_Pos{cc,1}(1,:))
        Group_Mat_Pos_SEM(cc,gg) = std(Group_Mat_Pos{cc,1}(:,gg),1,'omitnan')/sqrt(length(find(~isnan(Group_Mat_Pos{cc,1}(:,gg)))));
    end
end

%Negative SEM
for cc = 1:length(Group_Mat_Neg)
    for gg = 1:length(Group_Mat_Neg{cc,1}(1,:))
        Group_Mat_Neg_SEM(cc,gg) = std(Group_Mat_Neg{cc,1}(:,gg),1,'omitnan')/sqrt(length(find(~isnan(Group_Mat_Neg{cc,1}(:,gg)))));
    end
end

%Neutral SEM
for cc = 1:length(Group_Mat_Neut)
    for gg = 1:length(Group_Mat_Neut{cc,1}(1,:))
        Group_Mat_Neut_SEM(cc,gg) = std(Group_Mat_Neut{cc,1}(:,gg),1,'omitnan')/sqrt(length(find(~isnan(Group_Mat_Neut{cc,1}(:,gg)))));
    end
end

%% Axis and font for graphs

Yaxis = 0.23;
dist_plot = 600;
font = 20; 

%% Plot neuromodulator time series
   
    Line = repelem(Yaxis,length(49:56));
    Line2 = repelem(Yaxis,length(31:44));

    subplot(1,5,1)
    hold on
    plot(31:44, Line2, 'LineWidth', 5, 'Color', 'k');

    shadedErrorBar(1:length(Goup_Mat_Neg_Avg),Goup_Mat_Neg_Avg(3,:),Group_Mat_Neg_SEM(3,:),'lineProps','c');
    plot(1:length(Goup_Mat_Neg_Avg(3,:)),Goup_Mat_Neg_Avg(3,:),'LineWidth',2,'Color','c');
    
    shadedErrorBar(1:length(Goup_Mat_Neg_Avg),Goup_Mat_Neg_Avg(1,:),Group_Mat_Neg_SEM(1,:),'lineProps','k');
    plot(1:length(Goup_Mat_Neg_Avg(1,:)),Goup_Mat_Neg_Avg(1,:),'LineWidth',2,'Color','k');

    shadedErrorBar(1:length(Goup_Mat_Neg_Avg),Goup_Mat_Neg_Avg(2,:),Group_Mat_Neg_SEM(2,:),'lineProps','m');
    plot(1:length(Goup_Mat_Neg_Avg(2,:)),Goup_Mat_Neg_Avg(2,:),'LineWidth',2,'Color','m');
    hold off
    
    xlim([26 56]);
    ylim([-Yaxis  Yaxis]);
    xticks([31 41 51]);
    xticklabels({'0' '1' '2'});
    xtickangle(0);
    xline(31,'--','LineWidth',2);
    xline(44,'--','LineWidth',2);
    yline(0,'LineWidth',1);
    ylabel('Neuromodulator [z]');
    xlabel('Time (s)');
    ax = gca;
    ax.FontSize = font;
    axis square

    subplot(1,5,2)
    hold on
    plot(31:44, Line2, 'LineWidth', 5, 'Color', 'k');

    shadedErrorBar(1:length(Goup_Mat_Neut_Avg),Goup_Mat_Neut_Avg(3,:),Group_Mat_Neut_SEM(3,:),'lineProps','c');
    plot(1:length(Goup_Mat_Neut_Avg(3,:)),Goup_Mat_Neut_Avg(3,:),'LineWidth',2,'Color','c');
    
    shadedErrorBar(1:length(Goup_Mat_Neut_Avg),Goup_Mat_Neut_Avg(1,:),Group_Mat_Neut_SEM(1,:),'lineProps','k');
    plot(1:length(Goup_Mat_Neut_Avg(1,:)),Goup_Mat_Neut_Avg(1,:),'LineWidth',2,'Color','k');

    shadedErrorBar(1:length(Goup_Mat_Neut_Avg),Goup_Mat_Neut_Avg(2,:),Group_Mat_Neut_SEM(2,:),'lineProps','m');
    plot(1:length(Goup_Mat_Neut_Avg(2,:)),Goup_Mat_Neut_Avg(2,:),'LineWidth',2,'Color','m');
    hold off
    
    xlim([26 56]);
    ylim([-Yaxis  Yaxis]);
    xticks([31 41 51]);
    xticklabels({'0' '1' '2'});
    xtickangle(0);
    xline(31,'--','LineWidth',2);
    xline(44,'--','LineWidth',2);
    yline(0,'LineWidth',1);
    ylabel('Neuromodulator [z]');
    xlabel('Time (s)');
    ax = gca;
    ax.FontSize = font;
    axis square

    
    subplot(1,5,3)
    hold on
    plot(31:44, Line2, 'LineWidth', 5, 'Color', 'k');

    shadedErrorBar(1:length(Goup_Mat_Pos_Avg),Goup_Mat_Pos_Avg(3,:),Group_Mat_Pos_SEM(3,:),'lineProps','c');
    plot(1:length(Goup_Mat_Pos_Avg(3,:)),Goup_Mat_Pos_Avg(3,:),'LineWidth',2,'Color','c');
    
    shadedErrorBar(1:length(Goup_Mat_Pos_Avg),Goup_Mat_Pos_Avg(1,:),Group_Mat_Pos_SEM(1,:),'lineProps','k');
    plot(1:length(Goup_Mat_Pos_Avg(1,:)),Goup_Mat_Pos_Avg(1,:),'LineWidth',2,'Color','k');

    shadedErrorBar(1:length(Goup_Mat_Pos_Avg),Goup_Mat_Pos_Avg(2,:),Group_Mat_Pos_SEM(2,:),'lineProps','m');
    plot(1:length(Goup_Mat_Pos_Avg(2,:)),Goup_Mat_Pos_Avg(2,:),'LineWidth',2,'Color','m');
    hold off
    
    xlim([26 56]);
    ylim([-Yaxis  Yaxis]);
    xticks([31 41 51]);
    xticklabels({'0' '1' '2'});
    xtickangle(0);
    xline(31,'--','LineWidth',2);
    xline(44,'--','LineWidth',2);
    yline(0,'LineWidth',1);
    ylabel('Neuromodulator [z]');
    xlabel('Time (s)');
    ax = gca;
    ax.FontSize = font;
    axis square

    
    
    
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 1]);
set(gcf,'InvertHardCopy','off');
set(gcf, 'Color', [1 1 1]); 

saveas(gcf,fullfile(FigPath,'Figure_S3A_Time_Series'),'jpeg');
