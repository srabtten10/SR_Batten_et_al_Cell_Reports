%% PURPOSE OF CODE 

%%Batten et al. (2025) 

%Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

%To take animal in vivo data and plot predictions with optogenetic
%stimulations for serotonin for figure S1R-S1U

%Alec Hartle and Seth R. Batten srbatten10@vtc.vt.edu 2024

%% Clear memory 

clear;
close all; 

%% Set file paths 

NTPath = ('');

FigPath = fullfile('');

%Set Files 
NT = string({'Figure_S1R_to_S1U_emostroop_rodent_5HT.mat'});

%% Import data: NTs

for cc = 1:size(NT,1)
    load(fullfile(NTPath,NT(cc))); 
end
%% Smooth Data First...

columns = 4:7; 

%Set Window Size
winS= 5;

%Smooth
for cc = 1:length(Predictions_1)
    for rr = 1:length(Predictions_1{cc,1}.data(1,4:7))   
        for tt= winS:length(Predictions_1{cc,1}.data(:,1))
            Predictions_1_s{cc,1}(tt,rr)= mean(Predictions_1{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end

for cc = 1:length(Predictions_1)
Predictions_1_s{cc,1}(1:5,:) = NaN;
end

%% zscore data 


for cc = 1:length(Predictions_1_s)
    for gg = 1:length(Predictions_1_s{cc,1}(1,:)) 
        Pred_1_mean(cc,gg) = mean(Predictions_1_s{cc,1}(1:50,gg),'omitnan');
end
end

%Get SD
for cc = 1:length(Predictions_1_s)
    for gg = 1:length(Predictions_1_s{cc,1}(1,:))  
        Pred_1_SD(cc,gg) = std(Predictions_1_s{cc,1}(1:50,gg),'omitnan');
    end
end

%zscore
for cc = 1:length(Predictions_1_s)
    for gg = 1:length(Predictions_1_s{cc,1}(:,1))
        for rr = 1:length(Predictions_1_s{cc,1}(1,:))
            Pred_1_z{cc,1}(gg,rr) = ((Predictions_1_s{cc,1}(gg,rr) - Pred_1_mean(cc,rr))/(Pred_1_SD(cc,rr)));
        end
    end
end

%% Smooth Data First...

columns = 4:7; 

%Set Window Size
winS= 5;

%Smooth
for cc = 1:length(Predictions_2)
    for rr = 1:length(Predictions_2{cc,1}.data(1,4:7))   
        for tt= winS:length(Predictions_2{cc,1}.data(:,1))
            Predictions_2_s{cc,1}(tt,rr)= mean(Predictions_2{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end

for cc = 1:length(Predictions_2)
Predictions_2_s{cc,1}(1:5,:) = NaN;
end


%% zscore data 

for cc = 1:length(Predictions_2_s)
    for gg = 1:length(Predictions_2_s{cc,1}(1,:)) 
        Pred_2_mean(cc,gg) = mean(Predictions_2_s{cc,1}(1:50,gg),'omitnan');
end
end

%Get zscore
for cc = 1:length(Predictions_2_s)
    for gg = 1:length(Predictions_2_s{cc,1}(1,:))  
        Pred_2_SD(cc,gg) = std(Predictions_2_s{cc,1}(1:50,gg),'omitnan');
    end
end

%zscore
for cc = 1:length(Predictions_2_s)
    for gg = 1:length(Predictions_2_s{cc,1}(:,1))
        for rr = 1:length(Predictions_2_s{cc,1}(1,:))
            Pred_2_z{cc,1}(gg,rr) = ((Predictions_2_s{cc,1}(gg,rr) - Pred_2_mean(cc,rr))/(Pred_2_SD(cc,rr)));
        end
    end
end

%% Smooth Data First...

columns = 4:7; 

%Set Window Size
winS= 5;

%Smooth
for cc = 1:length(Predictions_3)
    for rr = 1:length(Predictions_3{cc,1}.data(1,4:7))   
        for tt= winS:length(Predictions_3{cc,1}.data(:,1))
            Predictions_3_s{cc,1}(tt,rr)= mean(Predictions_3{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end

for cc = 1:length(Predictions_3)
Predictions_3_s{cc,1}(1:5,:) = NaN;
end

%% zscore data 

for cc = 1:length(Predictions_3_s)
    for gg = 1:length(Predictions_3_s{cc,1}(1,:)) 
        Pred_3_mean(cc,gg) = mean(Predictions_3_s{cc,1}(1:50,gg),'omitnan');
end
end

%Get zscore
for cc = 1:length(Predictions_3_s)
    for gg = 1:length(Predictions_3_s{cc,1}(1,:))  
        Pred_3_SD(cc,gg) = std(Predictions_3_s{cc,1}(1:50,gg),'omitnan');
    end
end

%zscore
for cc = 1:length(Predictions_3_s)
    for gg = 1:length(Predictions_3_s{cc,1}(:,1))
        for rr = 1:length(Predictions_3_s{cc,1}(1,:))
            Pred_3_z{cc,1}(gg,rr) = ((Predictions_3_s{cc,1}(gg,rr) - Pred_3_mean(cc,rr))/(Pred_3_SD(cc,rr)));
        end
    end
end



%% %% find stim and null locations
stims_1 = find(cellfun(@(x) strcmp(x, 'stim'), Predictions_1(:, 2)));
stims_2 = find(cellfun(@(x) strcmp(x, 'stim'), Predictions_2(:, 2)));
stims_3 = find(cellfun(@(x) strcmp(x, 'stim'), Predictions_3(:, 2)));


nulls_1 = find(cellfun(@(x) strcmp(x, 'null'), Predictions_1(:, 2)));
nulls_2 = find(cellfun(@(x) strcmp(x, 'null'), Predictions_2(:, 2)));
nulls_3 = find(cellfun(@(x) strcmp(x, 'null'), Predictions_3(:, 2)));


%% separate stims and nulls

%Activation
Stim_Predictions{1,1}(:,1) = Pred_1_z{stims_1(1),1}(:,1);
Stim_Predictions{1,1}(:,2) = Pred_1_z{stims_1(2),1}(:,1);
Stim_Predictions{1,1}(:,3) = Pred_1_z{stims_1(3),1}(:,1);

Stim_Predictions{2,1}(:,1) = Pred_2_z{stims_2(1),1}(:,1);
Stim_Predictions{2,1}(:,2) = Pred_2_z{stims_2(2),1}(:,1);
Stim_Predictions{2,1}(:,3) = Pred_2_z{stims_2(3),1}(:,1);

Stim_Predictions{3,1}(:,1) = Pred_3_z{stims_3(1),1}(:,1);
Stim_Predictions{3,1}(:,2) = Pred_3_z{stims_3(2),1}(:,1);
Stim_Predictions{3,1}(:,3) = Pred_3_z{stims_3(3),1}(:,1);


%Null
Null_Predictions{1,1}(:,1) = Pred_1_z{nulls_1(1),1}(:,1); 
Null_Predictions{1,1}(:,2) = Pred_1_z{nulls_1(2),1}(:,1);
Null_Predictions{1,1}(:,3) = Pred_1_z{nulls_1(3),1}(:,1);

Null_Predictions{2,1}(:,1) = Pred_2_z{nulls_2(1),1}(:,1);
Null_Predictions{2,1}(:,2) = Pred_2_z{nulls_2(2),1}(:,1);
Null_Predictions{2,1}(:,3) = Pred_2_z{nulls_2(3),1}(:,1);

Null_Predictions{3,1}(:,1) = Pred_3_z{nulls_3(1),1}(:,1);



%% Make a new spread sheet with the data you want: SE

%Activation
Stim_Predictions_SE{1,1}(:,1) = Pred_1_z{stims_1(1),1}(:,2);
Stim_Predictions_SE{1,1}(:,2) = Pred_1_z{stims_1(2),1}(:,2);
Stim_Predictions_SE{1,1}(:,3) = Pred_1_z{stims_1(3),1}(:,2);

Stim_Predictions_SE{2,1}(:,1) = Pred_2_z{stims_2(1),1}(:,2);
Stim_Predictions_SE{2,1}(:,2) = Pred_2_z{stims_2(2),1}(:,2);
Stim_Predictions_SE{2,1}(:,3) = Pred_2_z{stims_2(3),1}(:,2);

Stim_Predictions_SE{3,1}(:,1) = Pred_3_z{stims_3(1),1}(:,2);
Stim_Predictions_SE{3,1}(:,2) = Pred_3_z{stims_3(2),1}(:,2);
Stim_Predictions_SE{3,1}(:,3) = Pred_3_z{stims_3(3),1}(:,2);


%Null
Null_Predictions_SE{1,1}(:,1) = Pred_1_z{nulls_1(1),1}(:,2);
Null_Predictions_SE{1,1}(:,2) = Pred_1_z{nulls_1(2),1}(:,2);
Null_Predictions_SE{1,1}(:,3) = Pred_1_z{nulls_1(3),1}(:,2);

Null_Predictions_SE{2,1}(:,1) = Pred_2_z{nulls_2(1),1}(:,2);
Null_Predictions_SE{2,1}(:,2) = Pred_2_z{nulls_2(2),1}(:,2);
Null_Predictions_SE{2,1}(:,3) = Pred_2_z{nulls_2(3),1}(:,2);

Null_Predictions_SE{3,1}(:,1) = Pred_3_z{nulls_3(1),1}(:,2);



%% Make a new spread sheet with the data you want: NE

%Activation
Stim_Predictions_NE{1,1}(:,1) = Pred_1_z{stims_1(1),1}(:,4);
Stim_Predictions_NE{1,1}(:,2) = Pred_1_z{stims_1(2),1}(:,4);
Stim_Predictions_NE{1,1}(:,3) = Pred_1_z{stims_1(3),1}(:,4);

Stim_Predictions_NE{2,1}(:,1) = Pred_2_z{stims_2(1),1}(:,4);
Stim_Predictions_NE{2,1}(:,2) = Pred_2_z{stims_2(2),1}(:,4);
Stim_Predictions_NE{2,1}(:,3) = Pred_2_z{stims_2(3),1}(:,4);

Stim_Predictions_NE{3,1}(:,1) = Pred_3_z{stims_3(1),1}(:,4);
Stim_Predictions_NE{3,1}(:,2) = Pred_3_z{stims_3(2),1}(:,4);
Stim_Predictions_NE{3,1}(:,3) = Pred_3_z{stims_3(3),1}(:,4);



%Null
Null_Predictions_NE{1,1}(:,1) = Pred_1_z{nulls_1(1),1}(:,4);
Null_Predictions_NE{1,1}(:,2) = Pred_1_z{nulls_1(2),1}(:,4);
Null_Predictions_NE{1,1}(:,3) = Pred_1_z{nulls_1(3),1}(:,4);

Null_Predictions_NE{2,1}(:,1) = Pred_2_z{nulls_2(1),1}(:,4);
Null_Predictions_NE{2,1}(:,2) = Pred_2_z{nulls_2(2),1}(:,4);
Null_Predictions_NE{2,1}(:,3) = Pred_2_z{nulls_2(3),1}(:,4);

Null_Predictions_NE{3,1}(:,1) = Pred_3_z{nulls_3(1),1}(:,4);


%% Get Mean and SEM of Trials 

%Within Animal
for cc = 1:length(Stim_Predictions)
    Stim_Mean_z{cc,1} = mean(Stim_Predictions{cc,1},2,'omitnan');
    Null_Mean_z{cc,1} = mean(Null_Predictions{cc,1},2,'omitnan');

    Stim_Mean_z_SE{cc,1} = mean(Stim_Predictions_SE{cc,1},2,'omitnan');
    Null_Mean_z_SE{cc,1} = mean(Null_Predictions_SE{cc,1},2,'omitnan');

    Stim_Mean_z_NE{cc,1} = mean(Stim_Predictions_NE{cc,1},2,'omitnan');
    Null_Mean_z_NE{cc,1} = mean(Null_Predictions_NE{cc,1},2,'omitnan');
end

%Across Animal
for cc = 1:length(Stim_Mean_z)
    Across_Stim_Mean_z(:,cc) = Stim_Mean_z{cc,1};
    Across_Null_Mean_z(:,cc) = Null_Mean_z{cc,1};

    Across_Stim_Mean_z_SE(:,cc) = Stim_Mean_z_SE{cc,1};
    Across_Null_Mean_z_SE(:,cc) = Null_Mean_z_SE{cc,1};

    Across_Stim_Mean_z_NE(:,cc) = Stim_Mean_z_NE{cc,1};
    Across_Null_Mean_z_NE(:,cc) = Null_Mean_z_NE{cc,1};
end

%Across Animal Final
Across_Stim_Final_z = mean(Across_Stim_Mean_z,2,'omitnan');
Across_Null_Final_z = mean(Across_Null_Mean_z,2,'omitnan');

Across_Stim_Final_z_SE = mean(Across_Stim_Mean_z_SE,2,'omitnan');
Across_Null_Final_z_SE = mean(Across_Null_Mean_z_SE,2,'omitnan');

Across_Stim_Final_z_NE = mean(Across_Stim_Mean_z_NE,2,'omitnan');
Across_Null_Final_z_NE = mean(Across_Null_Mean_z_NE,2,'omitnan');

%Witin SD 
for cc = 1:length(Stim_Predictions)
    for rr = 1:length(Stim_Predictions{cc,1}(:,1))
         Stim_SEM_z{cc,1}(rr,1) = (std(Stim_Predictions{cc,1}(rr,:),1,'omitnan'))/(sqrt(length(find(~isnan(Stim_Predictions{cc,1}(rr,:))))));
         Null_SEM_z{cc,1}(rr,1) = (std(Null_Predictions{cc,1}(rr,:),1,'omitnan'))/(sqrt(length(find(~isnan(Null_Predictions{cc,1}(rr,:))))));

         Stim_SEM_z_SE{cc,1}(rr,1) = (std(Stim_Predictions_SE{cc,1}(rr,:),1,'omitnan'))/(sqrt(length(find(~isnan(Stim_Predictions_SE{cc,1}(rr,:))))));
         Null_SEM_z_SE{cc,1}(rr,1) = (std(Null_Predictions_SE{cc,1}(rr,:),1,'omitnan'))/(sqrt(length(find(~isnan(Null_Predictions_SE{cc,1}(rr,:))))));

         Stim_SEM_z_NE{cc,1}(rr,1) = (std(Stim_Predictions_NE{cc,1}(rr,:),1,'omitnan'))/(sqrt(length(find(~isnan(Stim_Predictions_NE{cc,1}(rr,:))))));
         Null_SEM_z_NE{cc,1}(rr,1) = (std(Null_Predictions_NE{cc,1}(rr,:),1,'omitnan'))/(sqrt(length(find(~isnan(Null_Predictions_NE{cc,1}(rr,:))))));
    end
end

%Across Animal
for cc = 1:length(Across_Stim_Mean_z)
    Animals_Stim_SEM_z(cc,1) = (std(Across_Stim_Mean_z(cc,:),1,'omitnan'))/(sqrt(length(find(~isnan(Across_Stim_Mean_z(cc,:))))));
    Animal_Null_SEM_z(cc,1) = (std(Across_Null_Mean_z(cc,:),1,'omitnan'))/(sqrt(length(find(~isnan(Across_Null_Mean_z(cc,:))))));

    Animals_Stim_SEM_z_SE(cc,1) = (std(Across_Stim_Mean_z_SE(cc,:),1,'omitnan'))/(sqrt(length(find(~isnan(Across_Stim_Mean_z_SE(cc,:))))));
    Animal_Null_SEM_z_SE(cc,1) = (std(Across_Null_Mean_z_SE(cc,:),1,'omitnan'))/(sqrt(length(find(~isnan(Across_Null_Mean_z_SE(cc,:))))));

    Animals_Stim_SEM_z_NE(cc,1) = (std(Across_Stim_Mean_z_NE(cc,:),1,'omitnan'))/(sqrt(length(find(~isnan(Across_Stim_Mean_z_NE(cc,:))))));
    Animal_Null_SEM_z_NE(cc,1) = (std(Across_Null_Mean_z_NE(cc,:),1,'omitnan'))/(sqrt(length(find(~isnan(Across_Null_Mean_z_NE(cc,:))))));
end

%% Figure S1R

fs = 10
x = [5 12];
y = [-3.7 -3.7];

x2 = [5 12];
y2 = [6 6];
fig = figure

    hold on

    plot((1:length(Across_Stim_Final_z_SE))/fs,Across_Stim_Final_z_SE,'LineWidth',1,'Color','m');    
    plot((1:length(Across_Null_Final_z_SE))/fs,Across_Null_Final_z_SE,'LineWidth',1,'Color',"#8A2BE2"); 

    shadedErrorBar((1:length(Across_Stim_Final_z_SE))/fs,Across_Stim_Final_z_SE,Animals_Stim_SEM_z_SE,'lineProps','m');
    shadedErrorBar((1:length(Across_Null_Final_z_SE))/fs,Across_Null_Final_z_SE,Animal_Null_SEM_z_SE,'lineProps',{'-','markerfacecolor',	"#8A2BE2",'color',	"#8A2BE2"} );
        a = area(x,y,'FaceColor','b');
    b = area(x2,y2,'FaceColor','b');  
    hold off
    ylabel('5HT [z]');
    xlabel('Time (s)');
        xline(5,'--b','LineWidth',1);
    xline(12,'--b','LineWidth',1);
    xticklabels({'-5', '0', '5', '10', '15', '20'})
ylim([-2 4])
yticks([-3:1:5])

xlim([0 22])
    ax = gca;
    ax.FontSize = 25;
        a.FaceAlpha = 0.1;
    b.FaceAlpha = 0.1;
    axis square 
  set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 

  saveas(gcf,fullfile(FigPath,'Figure_S1R'),'jpeg');

%% Figure S1S
x = [5 12];
y = [-3.7 -3.7];

x2 = [5 12];
y2 = [5 5];
fig = figure
    hold on

    plot((1:length(Across_Stim_Final_z_NE))/fs,Across_Stim_Final_z_NE,'LineWidth',1,'Color','c');    
    plot((1:length(Across_Stim_Final_z_SE))/fs,Across_Stim_Final_z_SE,'LineWidth',1,'Color','m');    
    plot((1:length(Across_Stim_Final_z))/fs,Across_Stim_Final_z,'LineWidth',1,'Color','k');    

    shadedErrorBar((1:length(Across_Stim_Final_z_NE))/fs,Across_Stim_Final_z_NE,Animals_Stim_SEM_z_NE,'lineProps','c');
    shadedErrorBar((1:length(Across_Stim_Final_z_SE))/fs,Across_Stim_Final_z_SE,Animals_Stim_SEM_z_SE,'lineProps','m');
    shadedErrorBar((1:length(Across_Stim_Final_z))/fs,Across_Stim_Final_z,Animals_Stim_SEM_z,'lineProps','k');

       a = area(x,y,'FaceColor','b');
    b = area(x2,y2,'FaceColor','b');   
    ylabel('NT [z]');
    xlabel('Time (s)');

    xline(5,'--b','LineWidth',1);
    xline(12,'--b','LineWidth',1);
xticklabels({'-5', '0', '5', '10', '15', '20'})
ylim([-2 4])
yticks([-3:1:5])
xlim([0 22])
    ax = gca;
    ax.FontSize = 25;
    a.FaceAlpha = 0.1;
    b.FaceAlpha = 0.1;
axis square
  set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 

 saveas(gcf,fullfile(FigPath,'Figure_S1s'),'jpeg');

%% Get AUC
fs= 10;
auc_end = 14; %% seconds after 
auc_start = 5; %%%5 seconds is time of stimulation onset
Window = [(auc_start*fs)+1:(auc_start+auc_end)*fs+1];

for cc = 1:size(Stim_Predictions,1)
    for rr = 1:size(Stim_Predictions{cc,1},2)
    AUC{cc,1}(1,rr) = trapz(Window,Stim_Predictions{cc,1}(Window,rr));
    end
end

for cc = 1:size(Stim_Predictions_SE,1)
    for rr = 1:size(Stim_Predictions_SE{cc,1},2)
    AUC_SE{cc,1}(1,rr) = trapz(Window,Stim_Predictions_SE{cc,1}(Window,rr));
    end
end

for cc = 1:size(Stim_Predictions_NE,1)
    for rr = 1:size(Stim_Predictions_NE{cc,1},2)
    AUC_NE{cc,1}(1,rr) = trapz(Window,Stim_Predictions_NE{cc,1}(Window,rr));
    end
end

AUC = reshape([AUC{:}], [], 1);
AUC_SE = reshape([AUC_SE{:}], [], 1);
AUC_NE = reshape([AUC_NE{:}], [], 1);

%% Get AUC and SEM across animals 

Graph_AUC(1,1) = mean(AUC(:,1),'omitnan');
Graph_AUC(1,2) = mean(AUC_SE(:,1),'omitnan');
Graph_AUC(1,3) = mean(AUC_NE(:,1),'omitnan');

Graph_AUC_SEM(1,1) = (std(AUC(:,1),1,'omitnan'))/(sqrt(length(find(~isnan(AUC(:,1))))));
Graph_AUC_SEM(1,2) = (std(AUC_SE(:,1),1,'omitnan'))/(sqrt(length(find(~isnan(AUC_SE(:,1))))));
Graph_AUC_SEM(1,3) = (std(AUC_NE(:,1),1,'omitnan'))/(sqrt(length(find(~isnan(AUC_NE(:,1))))));

%% Get AUC: Null


for cc = 1:size(Null_Predictions,1)
    for rr = 1:size(Null_Predictions{cc,1},2)
    AUC_null{cc,1}(1,rr) = trapz(Window,Null_Predictions{cc,1}(Window,rr));
    end
end

for cc = 1:size(Null_Predictions_SE,1)
    for rr = 1:size(Null_Predictions_SE{cc,1},2)
    AUC_SE_null{cc,1}(1,rr) = trapz(Window,Null_Predictions_SE{cc,1}(Window,rr));
    end
end

for cc = 1:size(Null_Predictions_NE,1)
    for rr = 1:size(Null_Predictions_NE{cc,1},2)
    AUC_NE_null{cc,1}(1,rr) = trapz(Window,Null_Predictions_NE{cc,1}(Window,rr));
    end
end

AUC_null = reshape([AUC_null{:}], [], 1);
AUC_SE_null = reshape([AUC_SE_null{:}], [], 1);
AUC_NE_null = reshape([AUC_NE_null{:}], [], 1);


%% Get AUC and SEM across animals 

Graph_AUC_svn(1,1) = mean(AUC_SE(:,1),'omitnan');
Graph_AUC_svn(1,2) = mean(AUC_SE_null(:,1),'omitnan');


Graph_AUC_SEM_svn(1,1) = (std(AUC_SE(:,1),1,'omitnan'))/(sqrt(length(find(~isnan(AUC_SE(:,1))))));
Graph_AUC_SEM_svn(1,2) = (std(AUC_SE_null(:,1),1,'omitnan'))/(sqrt(length(find(~isnan(AUC_SE_null(:,1))))));


%% Figure S1T

x = [1:2];


SE_num = size(AUC_SE,1);
SE_num_null = size(AUC_SE_null,1);

x2 = ones(1,SE_num);
x3 = ones(1,SE_num_null)*2;
figure
hold on
b = bar(x,Graph_AUC_svn,'facecolor','flat');
er = errorbar(x, Graph_AUC_svn,Graph_AUC_SEM_svn,Graph_AUC_SEM_svn);
er.Color = 'k';
er.CapSize = 0;
er.LineStyle = 'none';
markersize = 10;

scatter(x2,AUC_SE,markersize, 'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x3,AUC_SE_null,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);



b.CData(1,:) = [1 0 1];	%%magenta	
b.CData(2,:) = [138, 43, 226] / 255; %%null color
%b.CData(3,:) = [0 1 1]; cyan

    xlim([0 3]);
    ylim([-200  500]);
        yticks([-200:200:400])

%     yticks([0, 100, 200, 300, 400])
    xticks([1 2]);
    xticklabels({'Stim' 'Null'});
    %yticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5]);
    %title(sprintf('%0.0f',stim(cc)),'Interpreter', 'none');
    ylabel('5HT AUC [z]','Color','k');
    %xlabel('Time (s)');
    ax = gca;
    ax.FontSize = 25;
    axis square 
     set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 

      saveas(gcf,fullfile(FigPath,'Figure_S1T'),'jpeg');

%% Figure S1U 

x = [1:3];

DA_num = size(AUC,2);
SE_num = size(AUC_SE,2);
NE_num = size(AUC_NE,2);

x2 = ones(1,DA_num);
x3 = ones(1,SE_num)*2;
x4 = ones(1,NE_num)*3;
figure
hold on
b = bar(x,Graph_AUC,'facecolor','flat');
er = errorbar(x, Graph_AUC,Graph_AUC_SEM,Graph_AUC_SEM);
er.Color = 'k';
er.CapSize = 0;
er.LineStyle = 'none';
markersize = 10;

scatter(x2,AUC,markersize, 'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x3,AUC_SE,markersize, 'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x4,AUC_NE,markersize, 'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
hold off


b.CData(1,:) = [0 0 0];
b.CData(2,:) = [1 0 1];
b.CData(3,:) = [0 1 1];

    xlim([0 4]);
    ylim([-200  500]);
    xticks([1 2 3]);
    xticklabels({'DA' '5HT' 'NE' });
    ylabel('AUC [z]');
    ax = gca;
    ax.FontSize = 25;
    axis square 
    set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 );

     saveas(gcf,fullfile(FigPath,'Figure_S1U'),'jpeg');



