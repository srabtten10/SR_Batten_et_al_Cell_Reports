%% PURPOSE OF CODE 

%%Batten et al. (2025) 

%Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

%Plots the time series neuromodulator data in Figure 5B and 5C

%Seth R. Batten srbatten10@vtc.vt.edu 2024

%% Clear memory 

clear;
close all; 

%% Set file paths 

BehaviorPath = fullfile('');

NTPath = ('');

FigPath = fullfile('');

%Set Files 
Behavioral = string({'Blocked_ACC_Behavior.mat';'Blocked_ACC_Meta_Data_Participant_14_to_18.mat';'Blocked_ACC_Meta_Data_Participant_19.mat'});
NT = string({'Blocked_ACC_NT.mat'});

%% Import data: behavior & meta data 

for cc = 1:size(Behavioral,1)
    load(fullfile(BehaviorPath,Behavioral(cc))); 
end

%% Import data: NTs

for cc = 1:size(NT,1)
    load(fullfile(NTPath,NT(cc))); 
end

%% Pick the subjects you want to analyze

PickSub = [1,2,3,4,5,6]; %makes analyzing different people modular 

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
        Trial_Start_Positive_Final_z{cc,gg} = Trial_Start_sz{cc,gg}(Positive_idx{cc,1},:);
        Trial_Start_Neutral_Final_z{cc,gg} = Trial_Start_sz{cc,gg}(Neutral_idx{cc,1},:);
        Trial_Start_Negative_Final_z{cc,gg} = Trial_Start_sz{cc,gg}(Negative_idx{cc,1},:);
    end
end

%% Hemisphere 

Left = [1,2,5];

%% Get SEM per column for plotting 

%Positive
for cc = 1:size(Left,2)
    for rr = 1:length(Trial_Start_Positive_Final_z{Left(cc),1}(1,:))
        for gg = 1:size(Trial_Start_Positive_Final_z,2)
            Pos_SEM_Final_Left{cc,gg}(1,rr) = std(Trial_Start_Positive_Final_z{Left(cc),gg}(:,rr),1,'omitnan')/sqrt(length(find(~isnan(Trial_Start_Positive_Final_z{Left(cc),gg}(:,rr)))));
        end
    end
end

%Negative
for cc = 1:size(Left,2)
    for rr = 1:length(Trial_Start_Negative_Final_z{Left(cc),1}(1,:))
        for gg = 1:size(Trial_Start_Negative_Final_z,2)
            Neg_SEM_Final_Left{cc,gg}(1,rr) = std(Trial_Start_Negative_Final_z{Left(cc),gg}(:,rr),1,'omitnan')/sqrt(length(find(~isnan(Trial_Start_Negative_Final_z{Left(cc),gg}(:,rr)))));
        end
    end
end

%Neutral
for cc = 1:size(Left,2)
    for rr = 1:length(Trial_Start_Neutral_Final_z{Left(cc),1}(1,:))
        for gg = 1:size(Trial_Start_Neutral_Final_z,2)
            Neut_SEM_Final_Left{cc,gg}(1,rr) = std(Trial_Start_Neutral_Final_z{Left(cc),gg}(:,rr),1,'omitnan')/sqrt(length(find(~isnan(Trial_Start_Neutral_Final_z{Left(cc),gg}(:,rr)))));
        end
    end
end

%Positive
for cc = 1:size(Left,2)
    for gg = 1:size(Trial_Start_Positive_Final_z,2)
        Pos_Mean_Final_Left{cc,gg} = mean(Trial_Start_Positive_Final_z{Left(cc),gg},'omitnan');
    end
end

%Negative
for cc = 1:size(Left,2)
    for gg = 1:size(Trial_Start_Positive_Final_z,2)
        Neg_Mean_Final_Left{cc,gg} = mean(Trial_Start_Negative_Final_z{Left(cc),gg},'omitnan');
    end
end

%Neutral
for cc = 1:size(Left,2)
    for gg = 1:size(Trial_Start_Positive_Final_z,2)
        Neut_Mean_Final_Left{cc,gg} = mean(Trial_Start_Neutral_Final_z{Left(cc),gg},'omitnan');
    end
end

%% Average across people 


%Pos Mean
for cc = 1:size(Pos_Mean_Final_Left,1)
    for gg = 1:size(Pos_Mean_Final_Left,2)
        Group_Mat_Pos_Left{gg,1}(cc,:) = vertcat(Pos_Mean_Final_Left{cc,gg});
    end
end

for cc = 1:size(Group_Mat_Pos_Left,1)
    Goup_Mat_Pos_Avg_Left(cc,:) = mean(Group_Mat_Pos_Left{cc,1},'omitnan'); 
end

%Neg Mean
for cc = 1:size(Neg_Mean_Final_Left,1)
    for gg = 1:size(Neg_Mean_Final_Left,2)
        Group_Mat_Neg_Left{gg,1}(cc,:) = vertcat(Neg_Mean_Final_Left{cc,gg});
    end
end

for cc = 1:size(Group_Mat_Neg_Left,1)
    Goup_Mat_Neg_Avg_Left(cc,:) = mean(Group_Mat_Neg_Left{cc,1},'omitnan'); 
end

%Neut Mean
for cc = 1:size(Neut_Mean_Final_Left,1)
    for gg = 1:size(Neut_Mean_Final_Left,2)
        Group_Mat_Neut_Left{gg,1}(cc,:) = vertcat(Neut_Mean_Final_Left{cc,gg});
    end
end

for cc = 1:length(Group_Mat_Neut_Left)
    Goup_Mat_Neut_Avg_Left(cc,:) = mean(Group_Mat_Neut_Left{cc,1},'omitnan'); 
end


%Pos SEM
for cc = 1:length(Group_Mat_Pos_Left)
    for gg = 1:length(Group_Mat_Pos_Left{cc,1}(1,:))
        Group_Mat_Pos_SEM_Left(cc,gg) = std(Group_Mat_Pos_Left{cc,1}(:,gg),1,'omitnan')/sqrt(length(find(~isnan(Group_Mat_Pos_Left{cc,1}(:,gg)))));
    end
end

%Neg SEM
for cc = 1:length(Group_Mat_Neg_Left)
    for gg = 1:length(Group_Mat_Neg_Left{cc,1}(1,:))
        Group_Mat_Neg_SEM_Left(cc,gg) = std(Group_Mat_Neg_Left{cc,1}(:,gg),1,'omitnan')/sqrt(length(find(~isnan(Group_Mat_Neg_Left{cc,1}(:,gg)))));
    end
end

%Neut SEM
for cc = 1:length(Group_Mat_Neut_Left)
    for gg = 1:length(Group_Mat_Neut_Left{cc,1}(1,:))
        Group_Mat_Neut_SEM_Left(cc,gg) = std(Group_Mat_Neut_Left{cc,1}(:,gg),1,'omitnan')/sqrt(length(find(~isnan(Group_Mat_Neut_Left{cc,1}(:,gg)))));
    end
end
%% Hemisphere 

Right = [3,4,6];

%% Get SEM per column for plotting 

%Positive
for cc = 1:size(Right,2)
    for rr = 1:length(Trial_Start_Positive_Final_z{Right(cc),1}(1,:))
        for gg = 1:size(Trial_Start_Positive_Final_z,2)
            Pos_SEM_Final_Right{cc,gg}(1,rr) = std(Trial_Start_Positive_Final_z{Right(cc),gg}(:,rr),1,'omitnan')/sqrt(length(find(~isnan(Trial_Start_Positive_Final_z{Right(cc),gg}(:,rr)))));
        end
    end
end

%Negative
for cc = 1:size(Right,2)
    for rr = 1:length(Trial_Start_Negative_Final_z{Right(cc),1}(1,:))
        for gg = 1:size(Trial_Start_Negative_Final_z,2)
            Neg_SEM_Final_Right{cc,gg}(1,rr) = std(Trial_Start_Negative_Final_z{Right(cc),gg}(:,rr),1,'omitnan')/sqrt(length(find(~isnan(Trial_Start_Negative_Final_z{Right(cc),gg}(:,rr)))));
        end
    end
end

%Neutral
for cc = 1:size(Right,2)
    for rr = 1:length(Trial_Start_Neutral_Final_z{Right(cc),1}(1,:))
        for gg = 1:size(Trial_Start_Neutral_Final_z,2)
            Neut_SEM_Final_Right{cc,gg}(1,rr) = std(Trial_Start_Neutral_Final_z{Right(cc),gg}(:,rr),1,'omitnan')/sqrt(length(find(~isnan(Trial_Start_Neutral_Final_z{Right(cc),gg}(:,rr)))));
        end
    end
end

%Positive
for cc = 1:size(Right,2)
    for gg = 1:size(Trial_Start_Positive_Final_z,2)
        Pos_Mean_Final_Right{cc,gg} = mean(Trial_Start_Positive_Final_z{Right(cc),gg},'omitnan');
    end
end

%Negative
for cc = 1:size(Right,2)
    for gg = 1:size(Trial_Start_Positive_Final_z,2)
        Neg_Mean_Final_Right{cc,gg} = mean(Trial_Start_Negative_Final_z{Right(cc),gg},'omitnan');
    end
end

%Neutral
for cc = 1:size(Right,2)
    for gg = 1:size(Trial_Start_Positive_Final_z,2)
        Neut_Mean_Final_Right{cc,gg} = mean(Trial_Start_Neutral_Final_z{Right(cc),gg},'omitnan');
    end
end        

%% Average across people 


%Pos Mean
for cc = 1:size(Pos_Mean_Final_Right,1)
    for gg = 1:size(Pos_Mean_Final_Right,2)
        Group_Mat_Pos_Right{gg,1}(cc,:) = vertcat(Pos_Mean_Final_Right{cc,gg});
    end
end

for cc = 1:size(Group_Mat_Pos_Right,1)
    Goup_Mat_Pos_Avg_Right(cc,:) = mean(Group_Mat_Pos_Right{cc,1},'omitnan'); 
end

%Neg Mean
for cc = 1:size(Neg_Mean_Final_Right,1)
    for gg = 1:size(Neg_Mean_Final_Right,2)
        Group_Mat_Neg_Right{gg,1}(cc,:) = vertcat(Neg_Mean_Final_Right{cc,gg});
    end
end

for cc = 1:size(Group_Mat_Neg_Right,1)
    Goup_Mat_Neg_Avg_Right(cc,:) = mean(Group_Mat_Neg_Right{cc,1},'omitnan'); 
end

%Neut Mean
for cc = 1:size(Neut_Mean_Final_Right,1)
    for gg = 1:size(Neut_Mean_Final_Right,2)
        Group_Mat_Neut_Right{gg,1}(cc,:) = vertcat(Neut_Mean_Final_Right{cc,gg});
    end
end

for cc = 1:length(Group_Mat_Neut_Right)
    Goup_Mat_Neut_Avg_Right(cc,:) = mean(Group_Mat_Neut_Right{cc,1},'omitnan'); 
end


%Pos SEM
for cc = 1:length(Group_Mat_Pos_Right)
    for gg = 1:length(Group_Mat_Pos_Right{cc,1}(1,:))
        Group_Mat_Pos_SEM_Right(cc,gg) = std(Group_Mat_Pos_Right{cc,1}(:,gg),1,'omitnan')/sqrt(length(find(~isnan(Group_Mat_Pos_Right{cc,1}(:,gg)))));
    end
end

%Neg SEM
for cc = 1:length(Group_Mat_Neg_Right)
    for gg = 1:length(Group_Mat_Neg_Right{cc,1}(1,:))
        Group_Mat_Neg_SEM_Right(cc,gg) = std(Group_Mat_Neg_Right{cc,1}(:,gg),1,'omitnan')/sqrt(length(find(~isnan(Group_Mat_Neg_Right{cc,1}(:,gg)))));
    end
end

%Neut SEM
for cc = 1:length(Group_Mat_Neut_Right)
    for gg = 1:length(Group_Mat_Neut_Right{cc,1}(1,:))
        Group_Mat_Neut_SEM_Right(cc,gg) = std(Group_Mat_Neut_Right{cc,1}(:,gg),1,'omitnan')/sqrt(length(find(~isnan(Group_Mat_Neut_Right{cc,1}(:,gg)))));
    end
end
%% Axis for global NT graphs 

Yaxis = 0.35;
dist_plot = 600;
font = 30; 

%% Plot neurmodulator time series
    
%Make Data for line
Line2 = repelem(Yaxis,length(31:44));
    
    subplot(1,3,2)
    hold on
    plot(31:44, Line2, 'LineWidth', 5, 'Color', 'k');
    
    shadedErrorBar(1:length(Goup_Mat_Pos_Avg_Left),Goup_Mat_Pos_Avg_Left(1,:),Group_Mat_Pos_SEM_Left(1,:),'lineProps','b');
    plot(1:length(Goup_Mat_Pos_Avg_Left(1,:)),Goup_Mat_Pos_Avg_Left(1,:),'LineWidth',2,'Color','b');

    shadedErrorBar(1:length(Goup_Mat_Pos_Avg_Right),Goup_Mat_Pos_Avg_Right(1,:),Group_Mat_Pos_SEM_Right(1,:),'lineProps','y');
    plot(1:length(Goup_Mat_Pos_Avg_Right(1,:)),Goup_Mat_Pos_Avg_Right(1,:),'LineWidth',2,'Color',[0.9290 0.6940 0.1250]);
    hold off
    
    xlim([26 56]);
    ylim([-Yaxis  Yaxis]);
    xticks([31 41 51]);
    xticklabels({'0' '1' '2'});
    xtickangle(0);
    xline(31,'--','LineWidth',2);
    xline(44,'--','LineWidth',2);
    yline(0,'LineWidth',1);
    ylabel('Dopamine [z]');
    xlabel('Time (s)');
    ax = gca;
    ax.FontSize = font;
    axis square

    Line = repelem(Yaxis,length(49:56));
    Line2 = repelem(Yaxis,length(31:44));
    
    subplot(1,3,1)
    hold on
    plot(31:44, Line2, 'LineWidth', 5, 'Color', 'k');
    
    shadedErrorBar(1:length(Goup_Mat_Neg_Avg_Left),Goup_Mat_Neg_Avg_Left(1,:),Group_Mat_Neg_SEM_Left(1,:),'lineProps','b');
    plot(1:length(Goup_Mat_Neg_Avg_Left(1,:)),Goup_Mat_Neg_Avg_Left(1,:),'LineWidth',2,'Color','b');

    shadedErrorBar(1:length(Goup_Mat_Neg_Avg_Right),Goup_Mat_Neg_Avg_Right(1,:),Group_Mat_Neg_SEM_Right(1,:),'lineProps','y');
    plot(1:length(Goup_Mat_Neg_Avg_Right(1,:)),Goup_Mat_Neg_Avg_Right(1,:),'LineWidth',2,'Color',[0.9290 0.6940 0.1250]);
    hold off
    
    xlim([26 56]);
    ylim([-Yaxis  Yaxis]);
    xticks([31 41 51]);
    xticklabels({'0' '1' '2'});
    xtickangle(0);
    xline(31,'--','LineWidth',2);
    xline(44,'--','LineWidth',2);
    yline(0,'LineWidth',1);
    ylabel('Dopamine [z]');
    xlabel('Time (s)');
    ax = gca;
    ax.FontSize = font;
    axis square

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 1]);
set(gcf,'InvertHardCopy','off');
set(gcf, 'Color', [1 1 1]); 

saveas(gcf,fullfile(FigPath,'Figure_5B_5C_Pos_Neg_DA_Hemisphere'),'jpeg');