%% PURPOSE OF CODE 

%%Batten et al. (2025) 

%Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

%To take animal in vivo data and plot predictions with optogenetic
%stimulations for serotonin for figure S1C-S1F

%Alec Hartle and Seth R. Batten srbatten10@vtc.vt.edu 2024

%% Clear memory 

clear;
close all; 

%% Set file paths 

NTPath = ('');

FigPath = fullfile('');

%Set Files 
NT = string({'Figure_S1C_to_F_emostroop_rodent_DA.mat'});

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
Predictions_1_s{cc,1}(1:4,:) = NaN;
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
Predictions_2_s{cc,1}(1:4,:) = NaN;
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
Predictions_3_s{cc,1}(1:4,:) = NaN;
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

%% Smooth Data First...

columns = 4:7; 

%Set Window Size
winS= 5;

%Smooth
for cc = 1:length(Predictions_4)
    for rr = 1:length(Predictions_4{cc,1}.data(1,4:7))   
        for tt= winS:length(Predictions_4{cc,1}.data(:,1))
            Predictions_4_s{cc,1}(tt,rr)= mean(Predictions_4{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end

for cc = 1:length(Predictions_4)
Predictions_4_s{cc,1}(1:4,:) = NaN;
end

%% zscore data 

for cc = 1:length(Predictions_4_s)
    for gg = 1:length(Predictions_4_s{cc,1}(1,:)) 
        Pred_4_mean(cc,gg) = mean(Predictions_4_s{cc,1}(1:50,gg),'omitnan');
end
end

%Get zscore
for cc = 1:length(Predictions_4_s)
    for gg = 1:length(Predictions_4_s{cc,1}(1,:))  
        Pred_4_SD(cc,gg) = std(Predictions_4_s{cc,1}(1:50,gg),'omitnan');
    end
end

%zscore
for cc = 1:length(Predictions_4_s)
    for gg = 1:length(Predictions_4_s{cc,1}(:,1))
        for rr = 1:length(Predictions_4_s{cc,1}(1,:))
            Pred_4_z{cc,1}(gg,rr) = ((Predictions_4_s{cc,1}(gg,rr) - Pred_4_mean(cc,rr))/(Pred_4_SD(cc,rr)));
        end
    end
end
%% Smooth Data First...54

columns = 4:7; 

%Set Window Size
winS= 5;

%Smooth
for cc = 1:length(Predictions_5)
    for rr = 1:length(Predictions_5{cc,1}.data(1,4:7))   
        for tt= winS:length(Predictions_5{cc,1}.data(:,1))
            Predictions_5_s{cc,1}(tt,rr)= mean(Predictions_5{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end

for cc = 1:length(Predictions_5)
Predictions_5_s{cc,1}(1:4,:) = NaN;
end

%% zscore data 

for cc = 1:length(Predictions_5_s)
    for gg = 1:length(Predictions_5_s{cc,1}(1,:)) 
        Pred_5_mean(cc,gg) = mean(Predictions_5_s{cc,1}(1:50,gg),'omitnan');
end
end

%Get zscore
for cc = 1:length(Predictions_5_s)
    for gg = 1:length(Predictions_5_s{cc,1}(1,:))  
        Pred_5_SD(cc,gg) = std(Predictions_5_s{cc,1}(1:50,gg),'omitnan');
    end
end

%zscore
for cc = 1:length(Predictions_5_s)
    for gg = 1:length(Predictions_5_s{cc,1}(:,1))
        for rr = 1:length(Predictions_5_s{cc,1}(1,:))
            Pred_5_z{cc,1}(gg,rr) = ((Predictions_5_s{cc,1}(gg,rr) - Pred_5_mean(cc,rr))/(Pred_5_SD(cc,rr)));
        end
    end
end

%% Smooth Data First...55

columns = 4:7; 

%Set Window Size
winS= 5;

%Smooth
for cc = 1:length(Predictions_6)
    for rr = 1:length(Predictions_6{cc,1}.data(1,4:7))   
        for tt= winS:length(Predictions_6{cc,1}.data(:,1))
            Predictions_6_s{cc,1}(tt,rr)= mean(Predictions_6{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end

for cc = 1:length(Predictions_6)
Predictions_6_s{cc,1}(1:4,:) = NaN;
end

%% zscore data 

for cc = 1:length(Predictions_6_s)
    for gg = 1:length(Predictions_6_s{cc,1}(1,:)) 
        Pred_6_mean(cc,gg) = mean(Predictions_6_s{cc,1}(1:50,gg),'omitnan');
end
end

%Get zscore
for cc = 1:length(Predictions_6_s)
    for gg = 1:length(Predictions_6_s{cc,1}(1,:))  
        Pred_6_SD(cc,gg) = std(Predictions_6_s{cc,1}(1:50,gg),'omitnan');
    end
end

%zscore
for cc = 1:length(Predictions_6_s)
    for gg = 1:length(Predictions_6_s{cc,1}(:,1))
        for rr = 1:length(Predictions_6_s{cc,1}(1,:))
            Pred_6_z{cc,1}(gg,rr) = ((Predictions_6_s{cc,1}(gg,rr) - Pred_6_mean(cc,rr))/(Pred_6_SD(cc,rr)));
        end
    end
end

%% Smooth Data First...56

columns = 4:7; 

%Set Window Size
winS= 5;

%Smooth
for cc = 1:length(Predictions_7)
    for rr = 1:length(Predictions_7{cc,1}.data(1,4:7))   
        for tt= winS:length(Predictions_7{cc,1}.data(:,1))
            Predictions_7_s{cc,1}(tt,rr)= mean(Predictions_7{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end

for cc = 1:length(Predictions_7)
Predictions_7_s{cc,1}(1:4,:) = NaN;
end

%% zscore data 

for cc = 1:length(Predictions_7_s)
    for gg = 1:length(Predictions_7_s{cc,1}(1,:)) 
        Pred_7_mean(cc,gg) = mean(Predictions_7_s{cc,1}(1:50,gg),'omitnan');
end
end

%Get zscore
for cc = 1:length(Predictions_7_s)
    for gg = 1:length(Predictions_7_s{cc,1}(1,:))  
        Pred_7_SD(cc,gg) = std(Predictions_7_s{cc,1}(1:50,gg),'omitnan');
    end
end

%zscore
for cc = 1:length(Predictions_7_s)
    for gg = 1:length(Predictions_7_s{cc,1}(:,1))
        for rr = 1:length(Predictions_7_s{cc,1}(1,:))
            Pred_7_z{cc,1}(gg,rr) = ((Predictions_7_s{cc,1}(gg,rr) - Pred_7_mean(cc,rr))/(Pred_7_SD(cc,rr)));
        end
    end
end


%% %% find stim and null locations
stims_1 = find(cellfun(@(x) strcmp(x, 'stim'), Predictions_1(:, 2)));
stims_2 = find(cellfun(@(x) strcmp(x, 'stim'), Predictions_2(:, 2)));
stims_3 = find(cellfun(@(x) strcmp(x, 'stim'), Predictions_3(:, 2)));
stims_4 = find(cellfun(@(x) strcmp(x, 'stim'), Predictions_4(:, 2)));
stims_5 = find(cellfun(@(x) strcmp(x, 'stim'), Predictions_5(:, 2)));
stims_6 = find(cellfun(@(x) strcmp(x, 'stim'), Predictions_6(:, 2)));
stims_7 = find(cellfun(@(x) strcmp(x, 'stim'), Predictions_7(:, 2)));

nulls_1 = find(cellfun(@(x) strcmp(x, 'null'), Predictions_1(:, 2)));
nulls_2 = find(cellfun(@(x) strcmp(x, 'null'), Predictions_2(:, 2)));
nulls_3 = find(cellfun(@(x) strcmp(x, 'null'), Predictions_3(:, 2)));
nulls_4 = find(cellfun(@(x) strcmp(x, 'null'), Predictions_4(:, 2)));
nulls_5 = find(cellfun(@(x) strcmp(x, 'null'), Predictions_5(:, 2)));
nulls_6 = find(cellfun(@(x) strcmp(x, 'null'), Predictions_6(:, 2)));
nulls_7 = find(cellfun(@(x) strcmp(x, 'null'), Predictions_7(:, 2)));

%% separate stims and nulls

%Activation
Stim_Predictions{1,1}(:,1) = Pred_1_z{stims_1(1),1}(1:291,1);
Stim_Predictions{1,1}(:,2) = Pred_1_z{stims_1(2),1}(1:291,1);
Stim_Predictions{1,1}(:,3) = Pred_1_z{stims_1(3),1}(1:291,1);

Stim_Predictions{2,1}(:,1) = Pred_2_z{stims_2(1),1}(1:291,1);
Stim_Predictions{2,1}(:,2) = Pred_2_z{stims_2(2),1}(1:291,1);
Stim_Predictions{2,1}(:,3) = Pred_2_z{stims_2(3),1}(1:291,1);

Stim_Predictions{3,1}(:,1) = Pred_3_z{stims_3(1),1}(1:291,1);
Stim_Predictions{3,1}(:,2) = Pred_3_z{stims_3(2),1}(1:291,1);
Stim_Predictions{3,1}(:,3) = Pred_3_z{stims_3(3),1}(1:291,1);

Stim_Predictions{4,1}(:,1) = Pred_4_z{stims_4(1),1}(1:291,1);
Stim_Predictions{4,1}(:,2) = Pred_4_z{stims_4(2),1}(1:291,1);
Stim_Predictions{4,1}(:,3) = Pred_4_z{stims_4(3),1}(1:291,1);

Stim_Predictions{5,1}(:,1) = Pred_5_z{stims_5(1),1}(1:291,1);
Stim_Predictions{5,1}(:,2) = Pred_5_z{stims_5(2),1}(1:291,1);
Stim_Predictions{5,1}(:,3) = Pred_5_z{stims_5(3),1}(1:291,1);

Stim_Predictions{6,1}(:,1) = Pred_6_z{stims_6(1),1}(1:291,1);
Stim_Predictions{6,1}(:,2) = Pred_6_z{stims_6(2),1}(1:291,1);
Stim_Predictions{6,1}(:,3) = Pred_6_z{stims_6(3),1}(1:291,1);

Stim_Predictions{7,1}(:,1) = Pred_7_z{stims_7(1),1}(1:291,1);
Stim_Predictions{7,1}(:,2) = Pred_7_z{stims_7(2),1}(1:291,1);
Stim_Predictions{7,1}(:,3) = Pred_7_z{stims_7(3),1}(1:291,1);

%Null
Null_Predictions{1,1}(:,1) = Pred_1_z{nulls_1(1),1}(1:291,1); 
Null_Predictions{1,1}(:,2) = Pred_1_z{nulls_1(2),1}(1:291,1);
Null_Predictions{1,1}(:,3) = Pred_1_z{nulls_1(3),1}(1:291,1);

Null_Predictions{2,1}(:,1) = Pred_2_z{nulls_2(1),1}(1:291,1);
Null_Predictions{2,1}(:,2) = Pred_2_z{nulls_2(2),1}(1:291,1);
Null_Predictions{2,1}(:,3) = Pred_2_z{nulls_2(3),1}(1:291,1);

Null_Predictions{3,1}(:,1) = Pred_3_z{nulls_3(1),1}(1:291,1);
Null_Predictions{3,1}(:,2) = Pred_3_z{nulls_3(2),1}(1:291,1);
Null_Predictions{3,1}(:,3) = Pred_3_z{nulls_3(3),1}(1:291,1);

Null_Predictions{4,1}(:,1) = Pred_4_z{nulls_4(1),1}(1:291,1);
Null_Predictions{4,1}(:,2) = Pred_4_z{nulls_4(2),1}(1:291,1);
Null_Predictions{4,1}(:,3) = Pred_4_z{nulls_4(3),1}(1:291,1);

Null_Predictions{5,1}(:,1) = Pred_5_z{nulls_5(1),1}(1:291,1);
Null_Predictions{5,1}(:,2) = Pred_5_z{nulls_5(2),1}(1:291,1);
Null_Predictions{5,1}(:,3) = Pred_5_z{nulls_5(3),1}(1:291,1);

Null_Predictions{6,1}(:,1) = Pred_6_z{nulls_6(1),1}(1:291,1);
Null_Predictions{6,1}(:,2) = Pred_6_z{nulls_6(2),1}(1:291,1);
Null_Predictions{6,1}(:,3) = Pred_6_z{nulls_6(3),1}(1:291,1);

Null_Predictions{7,1}(:,1) = Pred_7_z{nulls_7(1),1}(1:291,1);
Null_Predictions{7,1}(:,2) = Pred_7_z{nulls_7(2),1}(1:291,1);
Null_Predictions{7,1}(:,3) = Pred_7_z{nulls_7(3),1}(1:291,1);

%% Make a new spread sheet with the data you want: SE

%Activation
Stim_Predictions_SE{1,1}(:,1) = Pred_1_z{stims_1(1),1}(1:291,2);
Stim_Predictions_SE{1,1}(:,2) = Pred_1_z{stims_1(2),1}(1:291,2);
Stim_Predictions_SE{1,1}(:,3) = Pred_1_z{stims_1(3),1}(1:291,2);

Stim_Predictions_SE{2,1}(:,1) = Pred_2_z{stims_2(1),1}(1:291,2);
Stim_Predictions_SE{2,1}(:,2) = Pred_2_z{stims_2(2),1}(1:291,2);
Stim_Predictions_SE{2,1}(:,3) = Pred_2_z{stims_2(3),1}(1:291,2);

Stim_Predictions_SE{3,1}(:,1) = Pred_3_z{stims_3(1),1}(1:291,2);
Stim_Predictions_SE{3,1}(:,2) = Pred_3_z{stims_3(2),1}(1:291,2);
Stim_Predictions_SE{3,1}(:,3) = Pred_3_z{stims_3(3),1}(1:291,2);

Stim_Predictions_SE{4,1}(:,1) = Pred_4_z{stims_4(1),1}(1:291,2);
Stim_Predictions_SE{4,1}(:,2) = Pred_4_z{stims_4(2),1}(1:291,2);
Stim_Predictions_SE{4,1}(:,3) = Pred_4_z{stims_4(3),1}(1:291,2);

Stim_Predictions_SE{5,1}(:,1) = Pred_5_z{stims_5(1),1}(1:291,2);
Stim_Predictions_SE{5,1}(:,2) = Pred_5_z{stims_5(2),1}(1:291,2);
Stim_Predictions_SE{5,1}(:,3) = Pred_5_z{stims_5(3),1}(1:291,2);

Stim_Predictions_SE{6,1}(:,1) = Pred_6_z{stims_6(1),1}(1:291,2);
Stim_Predictions_SE{6,1}(:,2) = Pred_6_z{stims_6(2),1}(1:291,2);
Stim_Predictions_SE{6,1}(:,3) = Pred_6_z{stims_6(3),1}(1:291,2);

Stim_Predictions_SE{7,1}(:,1) = Pred_7_z{stims_7(1),1}(1:291,2);
Stim_Predictions_SE{7,1}(:,2) = Pred_7_z{stims_7(2),1}(1:291,2);
Stim_Predictions_SE{7,1}(:,3) = Pred_7_z{stims_7(3),1}(1:291,2);

%Null
Null_Predictions_SE{1,1}(:,1) = Pred_1_z{nulls_1(1),1}(1:291,2);
Null_Predictions_SE{1,1}(:,2) = Pred_1_z{nulls_1(2),1}(1:291,2);
Null_Predictions_SE{1,1}(:,3) = Pred_1_z{nulls_1(3),1}(1:291,2);

Null_Predictions_SE{2,1}(:,1) = Pred_2_z{nulls_2(1),1}(1:291,2);
Null_Predictions_SE{2,1}(:,2) = Pred_2_z{nulls_2(2),1}(1:291,2);
Null_Predictions_SE{2,1}(:,3) = Pred_2_z{nulls_2(3),1}(1:291,2);

Null_Predictions_SE{3,1}(:,1) = Pred_3_z{nulls_3(1),1}(1:291,2);
Null_Predictions_SE{3,1}(:,2) = Pred_3_z{nulls_3(2),1}(1:291,2);
Null_Predictions_SE{3,1}(:,3) = Pred_3_z{nulls_3(3),1}(1:291,2);

Null_Predictions_SE{4,1}(:,1) = Pred_4_z{nulls_4(1),1}(1:291,2);
Null_Predictions_SE{4,1}(:,2) = Pred_4_z{nulls_4(2),1}(1:291,2);
Null_Predictions_SE{4,1}(:,3) = Pred_4_z{nulls_4(3),1}(1:291,2);

Null_Predictions_SE{5,1}(:,1) = Pred_5_z{nulls_5(1),1}(1:291,2); 
Null_Predictions_SE{5,1}(:,2) = Pred_5_z{nulls_5(2),1}(1:291,2);
Null_Predictions_SE{5,1}(:,3) = Pred_5_z{nulls_5(3),1}(1:291,2);

Null_Predictions_SE{6,1}(:,1) = Pred_6_z{nulls_6(1),1}(1:291,2);
Null_Predictions_SE{6,1}(:,2) = Pred_6_z{nulls_6(2),1}(1:291,2);
Null_Predictions_SE{6,1}(:,3) = Pred_6_z{nulls_6(3),1}(1:291,2);

Null_Predictions_SE{7,1}(:,1) = Pred_7_z{nulls_7(1),1}(1:291,2);
Null_Predictions_SE{7,1}(:,2) = Pred_7_z{nulls_7(2),1}(1:291,2);
Null_Predictions_SE{7,1}(:,3) = Pred_7_z{nulls_7(3),1}(1:291,2);

%% Make a new spread sheet with the data you want: NE

%Activation
Stim_Predictions_NE{1,1}(:,1) = Pred_1_z{stims_1(1),1}(1:291,4);
Stim_Predictions_NE{1,1}(:,2) = Pred_1_z{stims_1(2),1}(1:291,4);
Stim_Predictions_NE{1,1}(:,3) = Pred_1_z{stims_1(3),1}(1:291,4);

Stim_Predictions_NE{2,1}(:,1) = Pred_2_z{stims_2(1),1}(1:291,4);
Stim_Predictions_NE{2,1}(:,2) = Pred_2_z{stims_2(2),1}(1:291,4);
Stim_Predictions_NE{2,1}(:,3) = Pred_2_z{stims_2(3),1}(1:291,4);

Stim_Predictions_NE{3,1}(:,1) = Pred_3_z{stims_3(1),1}(1:291,4);
Stim_Predictions_NE{3,1}(:,2) = Pred_3_z{stims_3(2),1}(1:291,4);
Stim_Predictions_NE{3,1}(:,3) = Pred_3_z{stims_3(3),1}(1:291,4);

Stim_Predictions_NE{4,1}(:,1) = Pred_4_z{stims_4(1),1}(1:291,4);
Stim_Predictions_NE{4,1}(:,2) = Pred_4_z{stims_4(2),1}(1:291,4);
Stim_Predictions_NE{4,1}(:,3) = Pred_4_z{stims_4(3),1}(1:291,4);

Stim_Predictions_NE{5,1}(:,1) = Pred_5_z{stims_5(1),1}(1:291,4);
Stim_Predictions_NE{5,1}(:,2) = Pred_5_z{stims_5(2),1}(1:291,4);
Stim_Predictions_NE{5,1}(:,3) = Pred_5_z{stims_5(3),1}(1:291,4);

Stim_Predictions_NE{6,1}(:,1) = Pred_6_z{stims_6(1),1}(1:291,4);
Stim_Predictions_NE{6,1}(:,2) = Pred_6_z{stims_6(2),1}(1:291,4);
Stim_Predictions_NE{6,1}(:,3) = Pred_6_z{stims_6(3),1}(1:291,4);

Stim_Predictions_NE{7,1}(:,1) = Pred_7_z{stims_7(1),1}(1:291,4);
Stim_Predictions_NE{7,1}(:,2) = Pred_7_z{stims_7(2),1}(1:291,4);
Stim_Predictions_NE{7,1}(:,3) = Pred_7_z{stims_7(3),1}(1:291,4);


%Null
Null_Predictions_NE{1,1}(:,1) = Pred_1_z{nulls_1(1),1}(1:291,4);
Null_Predictions_NE{1,1}(:,2) = Pred_1_z{nulls_1(2),1}(1:291,4);
Null_Predictions_NE{1,1}(:,3) = Pred_1_z{nulls_1(3),1}(1:291,4);

Null_Predictions_NE{2,1}(:,1) = Pred_2_z{nulls_2(1),1}(1:291,4);
Null_Predictions_NE{2,1}(:,2) = Pred_2_z{nulls_2(2),1}(1:291,4);
Null_Predictions_NE{2,1}(:,3) = Pred_2_z{nulls_2(3),1}(1:291,4);

Null_Predictions_NE{3,1}(:,1) = Pred_3_z{nulls_3(1),1}(1:291,4);
Null_Predictions_NE{3,1}(:,2) = Pred_3_z{nulls_3(2),1}(1:291,4);
Null_Predictions_NE{3,1}(:,3) = Pred_3_z{nulls_3(3),1}(1:291,4);

Null_Predictions_NE{4,1}(:,1) = Pred_4_z{nulls_4(1),1}(1:291,4);
Null_Predictions_NE{4,1}(:,2) = Pred_4_z{nulls_4(2),1}(1:291,4);
Null_Predictions_NE{4,1}(:,3) = Pred_4_z{nulls_4(3),1}(1:291,4);

Null_Predictions_NE{5,1}(:,1) = Pred_5_z{nulls_5(1),1}(1:291,4);
Null_Predictions_NE{5,1}(:,2) = Pred_5_z{nulls_5(2),1}(1:291,4);
Null_Predictions_NE{5,1}(:,3) = Pred_5_z{nulls_5(3),1}(1:291,4);

Null_Predictions_NE{6,1}(:,1) = Pred_6_z{nulls_6(1),1}(1:291,4);
Null_Predictions_NE{6,1}(:,2) = Pred_6_z{nulls_6(2),1}(1:291,4);
Null_Predictions_NE{6,1}(:,3) = Pred_6_z{nulls_6(3),1}(1:291,4);

Null_Predictions_NE{7,1}(:,1) = Pred_7_z{nulls_7(1),1}(1:291,4);
Null_Predictions_NE{7,1}(:,2) = Pred_7_z{nulls_7(2),1}(1:291,4);
Null_Predictions_NE{7,1}(:,3) = Pred_7_z{nulls_7(3),1}(1:291,4);
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

%% Figure S1C


x = [51 61];
y = [-6 -6];

x2 = [51 61];
y2 = [35 35];
figure

    hold on
    shadedErrorBar(1:length(Across_Stim_Final_z),Across_Stim_Final_z,Animals_Stim_SEM_z,'lineProps','k');
    plot(1:length(Across_Stim_Final_z),Across_Stim_Final_z,'LineWidth',1,'Color','k'); 
    
    shadedErrorBar(1:length(Across_Null_Final_z),Across_Null_Final_z,Animal_Null_SEM_z,'lineProps',{'-','markerfacecolor',	"#7E2F8E",'color',	"#7E2F8E"}) ;
    plot(1:length(Across_Null_Final_z),Across_Null_Final_z,'LineWidth',1,'color',	"#7E2F8E");     
    
    a = area(x,y,'FaceColor','b');
    b = area(x2,y2,'FaceColor','b');
    hold off
   yticks([0, 5, 10, 15, 20, 25, 30])
    xlim([21 163]);
    ylim([-4  30]);
    xticks([51 101 151 201 251]);
    xticklabels({'0' '5' '10' '15' '20'});
    xline(51,'--b','LineWidth',1);
    xline(61,'--b','LineWidth',1);
    ylabel('DA [z]');
    xlabel('Time (s)');
    ax = gca;
    ax.FontSize = 8;
    a.FaceAlpha = 0.1;
    b.FaceAlpha = 0.1;
    axis square 
% Define the position and size of the figure to be 1.5" x 1.5"
  set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 
  saveas(gcf,fullfile(FigPath,'Figure_S1C'),'jpeg');

%% Figure S1D


x = [51 61];
y = [-6 -6];

x2 = [51 61];
y2 = [35 35];

figure
    hold on
    shadedErrorBar(1:length(Across_Stim_Final_z),Across_Stim_Final_z,Animals_Stim_SEM_z,'lineProps','k');
    plot(1:length(Across_Stim_Final_z),Across_Stim_Final_z,'LineWidth',1,'Color','k'); 
    shadedErrorBar(1:length(Across_Stim_Final_z_SE),Across_Stim_Final_z_SE,Animals_Stim_SEM_z_SE,'lineProps','m');
    plot(1:length(Across_Stim_Final_z_SE),Across_Stim_Final_z_SE,'LineWidth',1,'Color','m'); 
    shadedErrorBar(1:length(Across_Stim_Final_z_NE),Across_Stim_Final_z_NE,Animals_Stim_SEM_z_NE,'lineProps','c');
    plot(1:length(Across_Stim_Final_z_NE),Across_Stim_Final_z_NE,'LineWidth',1,'Color','c'); 
    
    a = area(x,y,'FaceColor','b');
    b = area(x2,y2,'FaceColor','b');
    hold off
      yticks([0, 5, 10, 15, 20, 25, 30])
    xlim([21 163]);
    ylim([-4  30]);
    xticks([51 101 151 201 251]);
    xticklabels({'0' '5' '10' '15' '20'});
    xline(51,'--b','LineWidth',1);
    xline(61,'--b','LineWidth',1);
    ylabel('NT [z]');
    xlabel('Time (s)');
    ax = gca;
    a.FaceAlpha = 0.1;
    b.FaceAlpha = 0.1;
    axis square 
  set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 
  saveas(gcf,fullfile(FigPath,'Figure_S1D'),'jpeg');  

%% Get AUC
window_t = 4;
Window = [51:(window_t*10)+51];

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

%% Get Mean AUC per Animals


for cc = 1:size(AUC,1)
    AUC_mean(cc,1) = mean(AUC{cc,1}(1,:),'omitnan');
end

for cc = 1:size(AUC,1)
    AUC_mean_SE(cc,1) = mean(AUC_SE{cc,1}(1,:),'omitnan');
end

for cc = 1:size(AUC,1)
    AUC_mean_NE(cc,1) = mean(AUC_NE{cc,1}(1,:),'omitnan');
end

%% Get AUC and SEM across animals 

Graph_AUC(1,1) = mean(AUC_mean(:,1),'omitnan');
Graph_AUC(1,2) = mean(AUC_mean_SE(:,1),'omitnan');
Graph_AUC(1,3) = mean(AUC_mean_NE(:,1),'omitnan');

Graph_AUC_SEM(1,1) = (std(AUC_mean(:,1),1,'omitnan'))/(sqrt(length(find(~isnan(AUC_mean(:,1))))));
Graph_AUC_SEM(1,2) = (std(AUC_mean_SE(:,1),1,'omitnan'))/(sqrt(length(find(~isnan(AUC_mean_SE(:,1))))));
Graph_AUC_SEM(1,3) = (std(AUC_mean_NE(:,1),1,'omitnan'))/(sqrt(length(find(~isnan(AUC_mean_NE(:,1))))));

%% Get AUC: Null

Window = [51:(window_t*10)+51];

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

%% Get Mean AUC per Animals


for cc = 1:size(AUC,1)
    AUC_mean_null(cc,1) = mean(AUC_null{cc,1}(1,:),'omitnan');
end

for cc = 1:size(AUC,1)
    AUC_mean_SE_null(cc,1) = mean(AUC_SE_null{cc,1}(1,:),'omitnan');
end

for cc = 1:size(AUC,1)
    AUC_mean_NE_null(cc,1) = mean(AUC_NE_null{cc,1}(1,:),'omitnan');
end

%% Get AUC and SEM across animals 

Graph_AUC_svn(1,1) = mean(AUC_mean(:,1),'omitnan');
Graph_AUC_svn(1,2) = mean(AUC_mean_null(:,1),'omitnan');


Graph_AUC_SEM_svn(1,1) = (std(AUC_mean(:,1),1,'omitnan'))/(sqrt(length(find(~isnan(AUC_mean(:,1))))));
Graph_AUC_SEM_svn(1,2) = (std(AUC_mean_null(:,1),1,'omitnan'))/(sqrt(length(find(~isnan(AUC_mean_null(:,1))))));


%% Figure S1E

x = [1:2];
stim_num = size(AUC_mean,1);
null_num = size(AUC_mean_null,1);

x2 = ones(1,stim_num);
x3 = ones(1,null_num)*2;

figure
hold on
b = bar(x,Graph_AUC_svn,'facecolor','flat');

er = errorbar(x, Graph_AUC_svn,Graph_AUC_SEM_svn,Graph_AUC_SEM_svn);
er.Color = 'k';
er.CapSize = 0;
er.LineStyle = 'none';
markersize = 10;

scatter(x2,AUC_mean,markersize, 'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x3,AUC_mean_null,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);



b.CData(1,:) = [0 0 0];
b.CData(2,:) = [0.4940 0.1840 0.5560];

    xlim([0 3]);
    ylim([-50  800]);
    xticks([1 2]);
    xticklabels({'Stim' 'Null'});
    ylabel('AUC [z]');
    ax = gca;
    ax.FontSize = 8;
    axis square 

  set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 
  saveas(gcf,fullfile(FigPath,'Figure_S1E'),'jpeg');

%% Figure S1F

x = [1:3];

x2 = [1;1;1;1;1;1;1];
x3 = [2;2;2;2;2;2;2];
x4 = [3;3;3;3;3;3;3];

figure
% subplot(1,4,1)
hold on
b = bar(x,Graph_AUC,'facecolor','flat');
er = errorbar(x, Graph_AUC,Graph_AUC_SEM,Graph_AUC_SEM);
er.Color = 'k';
er.CapSize = 0;
er.LineStyle = 'none';
markersize = 10;
scatter(x2,AUC_mean,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x3,AUC_mean_SE,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x4,AUC_mean_NE,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
hold off

b.CData(1,:) = [0 0 0];
b.CData(2,:) = [1 0 1];
b.CData(3,:) = [0 1 1];
ymin = min(ylim);
    xlim([0 4]);
    ylim([-50  800]);
    xticks([1 2 3]);
    xticklabels({'DA' '5HT' 'NE'});
    ylabel('AUC [z]');
    ax = gca;
    ax.FontSize = 25;
    axis square 
  
  set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 
  saveas(gcf,fullfile(FigPath,'Figure_S1F'),'jpeg');


