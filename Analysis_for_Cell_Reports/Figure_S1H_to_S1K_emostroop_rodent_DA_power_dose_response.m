%% PURPOSE OF CODE 

%%Batten et al. (2025) 

%Emotional words evoke region and valence-specific patterns of concurrent neuromodulator release in human thalamus and cortex

%To take animal in vivo data and plot predictions with optogenetic
%stimulations for serotonin for figure S1H-S1K

%Alec Hartle and Seth R. Batten srbatten10@vtc.vt.edu 2024

%% Clear memory 

clear;
close all; 

%% Set file paths 

NTPath = ('');

FigPath = fullfile('');

%Set Files 
NT = string({'Figure_S1H_to_K_emostroop_rodent_DA_power_dose_response.mat'});

%% Import data: NTs

for cc = 1:size(NT,1)
    load(fullfile(NTPath,NT(cc))); 
end

%% Smooth Data First...

columns = 4:7; 
fs = 10;
%Set Window Size
winS= round(fs/2);

%Smooth
for cc = 1:length(Predictions_1)
    for rr = 1:length(Predictions_1{cc,1}.data(1,columns))   
        for tt= winS:length(Predictions_1{cc,1}.data(:,1))
            Predictions_1_s{cc,1}(tt,rr)= mean(Predictions_1{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end

for cc = 1:length(Predictions_1)
Predictions_1_s{cc,1}(1:winS,:) = NaN;
end
%% zscore data
baseline = 5*fs;

for cc = 1:length(Predictions_1_s)
    for gg = 1:length(Predictions_1_s{cc,1}(1,:)) 
        Pred_1_mean(cc,gg) = mean(Predictions_1_s{cc,1}(1:baseline,gg),'omitnan');
end
end

%Get zscore
for cc = 1:length(Predictions_1_s)
    for gg = 1:length(Predictions_1_s{cc,1}(1,:))  
        Pred_1_SD(cc,gg) = std(Predictions_1_s{cc,1}(1:baseline,gg),'omitnan');
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
fs = 10;
%Set Window Sizenger
winS= round(fs/2);
    
%Smooth
for cc = 1:length(Predictions_2)
    for rr = 1:length(Predictions_2{cc,1}.data(1,columns))   
        for tt= winS:length(Predictions_2{cc,1}.data(:,1))
            Predictions_2_s{cc,1}(tt,rr)= mean(Predictions_2{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end


for cc = 1:length(Predictions_2)
Predictions_2_s{cc,1}(1:winS,:) = NaN;
end

%% zscore data 
baseline = 5*fs;

for cc = 1:length(Predictions_2_s)
    for gg = 1:length(Predictions_2_s{cc,1}(1,:)) 
        Pred_2_mean(cc,gg) = mean(Predictions_2_s{cc,1}(1:baseline,gg),'omitnan');
end
end

%Get zscore
for cc = 1:length(Predictions_2_s)
    for gg = 1:length(Predictions_2_s{cc,1}(1,:))  
        Pred_2_SD(cc,gg) = std(Predictions_2_s{cc,1}(1:baseline,gg),'omitnan');
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
fs = 10;
%Set Window Size
winS= round(fs/2);
    
%Smooth
for cc = 1:length(Predictions_3)
    for rr = 1:length(Predictions_3{cc,1}.data(1,columns))   
        for tt= winS:length(Predictions_3{cc,1}.data(:,1))
            Predictions_3_s{cc,1}(tt,rr)= mean(Predictions_3{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end

for cc = 1:length(Predictions_3)
Predictions_3_s{cc,1}(1:winS,:) = NaN;
end

%% zscore data 
baseline = 5*fs;

for cc = 1:length(Predictions_3_s)
    for gg = 1:length(Predictions_3_s{cc,1}(1,:)) 
        Pred_3_mean(cc,gg) = mean(Predictions_3_s{cc,1}(1:baseline,gg),'omitnan');
end
end

%Get zscore
for cc = 1:length(Predictions_3_s)
    for gg = 1:length(Predictions_3_s{cc,1}(1,:))  
        Pred_3_SD(cc,gg) = std(Predictions_3_s{cc,1}(1:baseline,gg),'omitnan');
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
fs = 10;
%Set Window Size
winS= round(fs/2);

%Smooth
for cc = 1:length(Predictions_4)
    for rr = 1:length(Predictions_4{cc,1}.data(1,columns))   
        for tt= winS:length(Predictions_4{cc,1}.data(:,1))
            Predictions_4_s{cc,1}(tt,rr)= mean(Predictions_4{cc,1}.data((tt+1-winS):tt,columns(rr)));
        end
    end
end

for cc = 1:length(Predictions_4)
Predictions_4_s{cc,1}(1:winS,:) = NaN;
end

%% zscore data 
baseline = 5*fs;

for cc = 1:length(Predictions_4_s)
    for gg = 1:length(Predictions_4_s{cc,1}(1,:)) 
        Pred_4_mean(cc,gg) = mean(Predictions_4_s{cc,1}(1:baseline,gg),'omitnan');
end
end

%Get zscore
for cc = 1:length(Predictions_4_s)
    for gg = 1:length(Predictions_4_s{cc,1}(1,:))  
        Pred_4_SD(cc,gg) = std(Predictions_4_s{cc,1}(1:baseline,gg),'omitnan');
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

%% find stim and null locations
% 15mW
Pred_1_15mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '15mW'), Predictions_1(:, 2), Predictions_1(:, 3)));
Pred_1_15mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '15mW'), Predictions_1(:, 2), Predictions_1(:, 3)));

Pred_2_15mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '15mW'), Predictions_2(:, 2), Predictions_2(:, 3)));
Pred_2_15mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '15mW'), Predictions_2(:, 2), Predictions_2(:, 3)));

Pred_3_15mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '15mW'), Predictions_3(:, 2), Predictions_3(:, 3)));
Pred_3_15mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '15mW'), Predictions_3(:, 2), Predictions_3(:, 3)));

Pred_4_15mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '15mW'), Predictions_4(:, 2), Predictions_4(:, 3)));
Pred_4_15mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '15mW'), Predictions_4(:, 2), Predictions_4(:, 3)));

% 10mW
Pred_1_10mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '10mW'), Predictions_1(:, 2), Predictions_1(:, 3)));
Pred_1_10mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '10mW'), Predictions_1(:, 2), Predictions_1(:, 3)));

Pred_2_10mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '10mW'), Predictions_2(:, 2), Predictions_2(:, 3)));
Pred_2_10mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '10mW'), Predictions_2(:, 2), Predictions_2(:, 3)));

Pred_3_10mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '10mW'), Predictions_3(:, 2), Predictions_3(:, 3)));
Pred_3_10mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '10mW'), Predictions_3(:, 2), Predictions_3(:, 3)));

Pred_4_10mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '10mW'), Predictions_4(:, 2), Predictions_4(:, 3)));
Pred_4_10mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '10mW'), Predictions_4(:, 2), Predictions_4(:, 3)));

% 5mW
Pred_1_5mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '5mW'), Predictions_1(:, 2), Predictions_1(:, 3)));
Pred_1_5mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '5mW'), Predictions_1(:, 2), Predictions_1(:, 3)));

Pred_2_5mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '5mW'), Predictions_2(:, 2), Predictions_2(:, 3)));
Pred_2_5mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '5mW'), Predictions_2(:, 2), Predictions_2(:, 3)));

Pred_3_5mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '5mW'), Predictions_3(:, 2), Predictions_3(:, 3)));
Pred_3_5mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '5mW'), Predictions_3(:, 2), Predictions_3(:, 3)));

Pred_4_5mW_stims = find(cellfun(@(x, y) strcmp(x, 'stim') && strcmp(y, '5mW'), Predictions_4(:, 2), Predictions_4(:, 3)));
Pred_4_5mW_nulls = find(cellfun(@(x, y) strcmp(x, 'null') && strcmp(y, '5mW'), Predictions_4(:, 2), Predictions_4(:, 3)));


%% predictions 1
%Activation

for ii = 1:length(Pred_1_15mW_stims)
Stim_Predictions_DA_Pred_1_15mW{1,1}(:,ii) = Pred_1_z{Pred_1_15mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_1_15mW{1,1}(:,ii) = Pred_1_z{Pred_1_15mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_1_15mW{1,1}(:,ii) = Pred_1_z{Pred_1_15mW_stims(ii),1}(:,4);
Stim_Predictions_DA_Pred_1_10mW{1,1}(:,ii) = Pred_1_z{Pred_1_10mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_1_10mW{1,1}(:,ii) = Pred_1_z{Pred_1_10mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_1_10mW{1,1}(:,ii) = Pred_1_z{Pred_1_10mW_stims(ii),1}(:,4);
Stim_Predictions_DA_Pred_1_5mW{1,1}(:,ii) = Pred_1_z{Pred_1_5mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_1_5mW{1,1}(:,ii) = Pred_1_z{Pred_1_5mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_1_5mW{1,1}(:,ii) = Pred_1_z{Pred_1_5mW_stims(ii),1}(:,4);
end


%Null
for ii = length(Pred_1_15mW_nulls)
Null_Predictions_DA_Pred_1_15mW{1,1}(:,ii) = Pred_1_z{Pred_1_15mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_1_15mW{1,1}(:,ii) = Pred_1_z{Pred_1_15mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_1_15mW{1,1}(:,ii) = Pred_1_z{Pred_1_15mW_nulls(ii),1}(:,4);
Null_Predictions_DA_Pred_1_10mW{1,1}(:,ii) = Pred_1_z{Pred_1_10mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_1_10mW{1,1}(:,ii) = Pred_1_z{Pred_1_10mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_1_10mW{1,1}(:,ii) = Pred_1_z{Pred_1_10mW_nulls(ii),1}(:,4);
Null_Predictions_DA_Pred_1_5mW{1,1}(:,ii) = Pred_1_z{Pred_1_5mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_1_5mW{1,1}(:,ii) = Pred_1_z{Pred_1_5mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_1_5mW{1,1}(:,ii) = Pred_1_z{Pred_1_5mW_nulls(ii),1}(:,4);
end


%% predictions 2
for ii = 1:length(Pred_2_15mW_stims)
Stim_Predictions_DA_Pred_2_15mW{1,1}(:,ii) = Pred_2_z{Pred_2_15mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_2_15mW{1,1}(:,ii) = Pred_2_z{Pred_2_15mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_2_15mW{1,1}(:,ii) = Pred_2_z{Pred_2_15mW_stims(ii),1}(:,4);
Stim_Predictions_DA_Pred_2_10mW{1,1}(:,ii) = Pred_2_z{Pred_2_10mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_2_10mW{1,1}(:,ii) = Pred_2_z{Pred_2_10mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_2_10mW{1,1}(:,ii) = Pred_2_z{Pred_2_10mW_stims(ii),1}(:,4);
Stim_Predictions_DA_Pred_2_5mW{1,1}(:,ii) = Pred_2_z{Pred_2_5mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_2_5mW{1,1}(:,ii) = Pred_2_z{Pred_2_5mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_2_5mW{1,1}(:,ii) = Pred_2_z{Pred_2_5mW_stims(ii),1}(:,4);
end
%Null
for ii = length(Pred_2_15mW_nulls)
Null_Predictions_DA_Pred_2_15mW{1,1}(:,ii) = Pred_2_z{Pred_2_15mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_2_15mW{1,1}(:,ii) = Pred_2_z{Pred_2_15mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_2_15mW{1,1}(:,ii) = Pred_2_z{Pred_2_15mW_nulls(ii),1}(:,4);
Null_Predictions_DA_Pred_2_10mW{1,1}(:,ii) = Pred_2_z{Pred_2_10mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_2_10mW{1,1}(:,ii) = Pred_2_z{Pred_2_10mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_2_10mW{1,1}(:,ii) = Pred_2_z{Pred_2_10mW_nulls(ii),1}(:,4);
Null_Predictions_DA_Pred_2_5mW{1,1}(:,ii) = Pred_2_z{Pred_2_5mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_2_5mW{1,1}(:,ii) = Pred_2_z{Pred_2_5mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_2_5mW{1,1}(:,ii) = Pred_2_z{Pred_2_5mW_nulls(ii),1}(:,4);
end
%% %% predictions 3
for ii = 1:length(Pred_3_15mW_stims)
Stim_Predictions_DA_Pred_3_15mW{1,1}(:,ii) = Pred_3_z{Pred_3_15mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_3_15mW{1,1}(:,ii) = Pred_3_z{Pred_3_15mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_3_15mW{1,1}(:,ii) = Pred_3_z{Pred_3_15mW_stims(ii),1}(:,4);
Stim_Predictions_DA_Pred_3_10mW{1,1}(:,ii) = Pred_3_z{Pred_3_10mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_3_10mW{1,1}(:,ii) = Pred_3_z{Pred_3_10mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_3_10mW{1,1}(:,ii) = Pred_3_z{Pred_3_10mW_stims(ii),1}(:,4);
Stim_Predictions_DA_Pred_3_5mW{1,1}(:,ii) = Pred_3_z{Pred_3_5mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_3_5mW{1,1}(:,ii) = Pred_3_z{Pred_3_5mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_3_5mW{1,1}(:,ii) = Pred_3_z{Pred_3_5mW_stims(ii),1}(:,4);
end
%Null
for ii = length(Pred_3_15mW_nulls)
Null_Predictions_DA_Pred_3_15mW{1,1}(:,ii) = Pred_3_z{Pred_3_15mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_3_15mW{1,1}(:,ii) = Pred_3_z{Pred_3_15mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_3_15mW{1,1}(:,ii) = Pred_3_z{Pred_3_15mW_nulls(ii),1}(:,4);
Null_Predictions_DA_Pred_3_10mW{1,1}(:,ii) = Pred_3_z{Pred_3_10mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_3_10mW{1,1}(:,ii) = Pred_3_z{Pred_3_10mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_3_10mW{1,1}(:,ii) = Pred_3_z{Pred_3_10mW_nulls(ii),1}(:,4);
Null_Predictions_DA_Pred_3_5mW{1,1}(:,ii) = Pred_3_z{Pred_3_5mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_3_5mW{1,1}(:,ii) = Pred_3_z{Pred_3_5mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_3_5mW{1,1}(:,ii) = Pred_3_z{Pred_3_5mW_nulls(ii),1}(:,4);
end
%% predictions 4
for ii = 1:length(Pred_4_15mW_stims)
Stim_Predictions_DA_Pred_4_15mW{1,1}(:,ii) = Pred_4_z{Pred_4_15mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_4_15mW{1,1}(:,ii) = Pred_4_z{Pred_4_15mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_4_15mW{1,1}(:,ii) = Pred_4_z{Pred_4_15mW_stims(ii),1}(:,4);
Stim_Predictions_DA_Pred_4_10mW{1,1}(:,ii) = Pred_4_z{Pred_4_10mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_4_10mW{1,1}(:,ii) = Pred_4_z{Pred_4_10mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_4_10mW{1,1}(:,ii) = Pred_4_z{Pred_4_10mW_stims(ii),1}(:,4);
Stim_Predictions_DA_Pred_4_5mW{1,1}(:,ii) = Pred_4_z{Pred_4_5mW_stims(ii),1}(:,1);
Stim_Predictions_SE_Pred_4_5mW{1,1}(:,ii) = Pred_4_z{Pred_4_5mW_stims(ii),1}(:,2);
Stim_Predictions_NE_Pred_4_5mW{1,1}(:,ii) = Pred_4_z{Pred_4_5mW_stims(ii),1}(:,4);
end
%Null
for ii = length(Pred_4_15mW_nulls)
Null_Predictions_DA_Pred_4_15mW{1,1}(:,ii) = Pred_4_z{Pred_4_15mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_4_15mW{1,1}(:,ii) = Pred_4_z{Pred_4_15mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_4_15mW{1,1}(:,ii) = Pred_4_z{Pred_4_15mW_nulls(ii),1}(:,4);
Null_Predictions_DA_Pred_4_10mW{1,1}(:,ii) = Pred_4_z{Pred_4_10mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_4_10mW{1,1}(:,ii) = Pred_4_z{Pred_4_10mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_4_10mW{1,1}(:,ii) = Pred_4_z{Pred_4_10mW_nulls(ii),1}(:,4);
Null_Predictions_DA_Pred_4_5mW{1,1}(:,ii) = Pred_4_z{Pred_4_5mW_nulls(ii),1}(:,1);
Null_Predictions_SE_Pred_4_5mW{1,1}(:,ii) = Pred_4_z{Pred_4_5mW_nulls(ii),1}(:,2);
Null_Predictions_NE_Pred_4_5mW{1,1}(:,ii) = Pred_4_z{Pred_4_5mW_nulls(ii),1}(:,4);
end

%% Get Mean and SEM of Trials 

for cc = 1:length(Stim_Predictions_DA_Pred_1_15mW)
    Stim_Predictions_DA_Pred_1_15mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_1_15mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_1_15mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_1_15mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_1_15mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_1_15mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_1_15mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_1_15mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_1_15mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_1_15mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_1_15mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_1_15mW{cc,1},2,'omitnan');
   
    Stim_Predictions_DA_Pred_1_10mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_1_10mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_1_10mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_1_10mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_1_10mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_1_10mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_1_10mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_1_10mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_1_10mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_1_10mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_1_10mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_1_10mW{cc,1},2,'omitnan');
   
    Stim_Predictions_DA_Pred_1_5mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_1_5mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_1_5mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_1_5mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_1_5mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_1_5mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_1_5mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_1_5mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_1_5mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_1_5mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_1_5mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_1_5mW{cc,1},2,'omitnan');
end

for cc = 1:length(Stim_Predictions_DA_Pred_2_15mW)
    Stim_Predictions_DA_Pred_2_15mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_2_15mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_2_15mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_2_15mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_2_15mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_2_15mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_2_15mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_2_15mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_2_15mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_2_15mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_2_15mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_2_15mW{cc,1},2,'omitnan');
   
    Stim_Predictions_DA_Pred_2_10mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_2_10mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_2_10mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_2_10mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_2_10mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_2_10mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_2_10mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_2_10mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_2_10mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_2_10mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_2_10mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_2_10mW{cc,1},2,'omitnan');
   
    Stim_Predictions_DA_Pred_2_5mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_2_5mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_2_5mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_2_5mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_2_5mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_2_5mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_2_5mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_2_5mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_2_5mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_2_5mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_2_5mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_2_5mW{cc,1},2,'omitnan');
end

for cc = 1:length(Stim_Predictions_DA_Pred_3_15mW)
    Stim_Predictions_DA_Pred_3_15mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_3_15mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_3_15mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_3_15mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_3_15mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_3_15mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_3_15mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_3_15mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_3_15mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_3_15mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_3_15mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_3_15mW{cc,1},2,'omitnan');
   
    Stim_Predictions_DA_Pred_3_10mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_3_10mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_3_10mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_3_10mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_3_10mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_3_10mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_3_10mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_3_10mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_3_10mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_3_10mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_3_10mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_3_10mW{cc,1},2,'omitnan');
   
    Stim_Predictions_DA_Pred_3_5mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_3_5mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_3_5mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_3_5mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_3_5mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_3_5mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_3_5mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_3_5mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_3_5mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_3_5mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_3_5mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_3_5mW{cc,1},2,'omitnan');
end

for cc = 1:length(Stim_Predictions_DA_Pred_4_15mW)
    Stim_Predictions_DA_Pred_4_15mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_4_15mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_4_15mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_4_15mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_4_15mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_4_15mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_4_15mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_4_15mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_4_15mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_4_15mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_4_15mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_4_15mW{cc,1},2,'omitnan');
   
    Stim_Predictions_DA_Pred_4_10mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_4_10mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_4_10mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_4_10mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_4_10mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_4_10mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_4_10mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_4_10mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_4_10mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_4_10mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_4_10mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_4_10mW{cc,1},2,'omitnan');
   
    Stim_Predictions_DA_Pred_4_5mW_mu{cc,1} = mean(Stim_Predictions_DA_Pred_4_5mW{cc,1},2,'omitnan');
    Stim_Predictions_SE_Pred_4_5mW_mu{cc,1} = mean(Stim_Predictions_SE_Pred_4_5mW{cc,1},2,'omitnan');
    Stim_Predictions_NE_Pred_4_5mW_mu{cc,1} = mean(Stim_Predictions_NE_Pred_4_5mW{cc,1},2,'omitnan');
    Null_Predictions_DA_Pred_4_5mW_mu{cc,1} = mean(Null_Predictions_DA_Pred_4_5mW{cc,1},2,'omitnan');
    Null_Predictions_SE_Pred_4_5mW_mu{cc,1} = mean(Null_Predictions_SE_Pred_4_5mW{cc,1},2,'omitnan');
    Null_Predictions_NE_Pred_4_5mW_mu{cc,1} = mean(Null_Predictions_NE_Pred_4_5mW{cc,1},2,'omitnan');
end

all_mice_stim_DA_15mW = [Stim_Predictions_DA_Pred_1_15mW_mu, Stim_Predictions_DA_Pred_2_15mW_mu, Stim_Predictions_DA_Pred_3_15mW_mu, Stim_Predictions_DA_Pred_4_15mW_mu];
all_mice_stim_SE_15mW = [Stim_Predictions_SE_Pred_1_15mW_mu, Stim_Predictions_SE_Pred_2_15mW_mu, Stim_Predictions_SE_Pred_3_15mW_mu, Stim_Predictions_SE_Pred_4_15mW_mu];
all_mice_stim_NE_15mW = [Stim_Predictions_NE_Pred_1_15mW_mu, Stim_Predictions_NE_Pred_2_15mW_mu, Stim_Predictions_NE_Pred_3_15mW_mu, Stim_Predictions_NE_Pred_4_15mW_mu];
all_mice_null_DA_15mW = [Null_Predictions_DA_Pred_1_15mW_mu, Null_Predictions_DA_Pred_2_15mW_mu, Null_Predictions_DA_Pred_3_15mW_mu, Null_Predictions_DA_Pred_4_15mW_mu];
all_mice_null_SE_15mW = [Null_Predictions_SE_Pred_1_15mW_mu, Null_Predictions_SE_Pred_2_15mW_mu, Null_Predictions_SE_Pred_3_15mW_mu, Null_Predictions_SE_Pred_4_15mW_mu];
all_mice_null_NE_15mW = [Null_Predictions_NE_Pred_1_15mW_mu, Null_Predictions_NE_Pred_2_15mW_mu, Null_Predictions_NE_Pred_3_15mW_mu, Null_Predictions_NE_Pred_4_15mW_mu];

all_mice_stim_DA_10mW = [Stim_Predictions_DA_Pred_1_10mW_mu, Stim_Predictions_DA_Pred_2_10mW_mu, Stim_Predictions_DA_Pred_3_10mW_mu, Stim_Predictions_DA_Pred_4_10mW_mu];
all_mice_stim_SE_10mW = [Stim_Predictions_SE_Pred_1_10mW_mu, Stim_Predictions_SE_Pred_2_10mW_mu, Stim_Predictions_SE_Pred_3_10mW_mu, Stim_Predictions_SE_Pred_4_10mW_mu];
all_mice_stim_NE_10mW = [Stim_Predictions_NE_Pred_1_10mW_mu, Stim_Predictions_NE_Pred_2_10mW_mu, Stim_Predictions_NE_Pred_3_10mW_mu, Stim_Predictions_NE_Pred_4_10mW_mu];
all_mice_null_DA_10mW = [Null_Predictions_DA_Pred_1_10mW_mu, Null_Predictions_DA_Pred_2_10mW_mu, Null_Predictions_DA_Pred_3_10mW_mu, Null_Predictions_DA_Pred_4_10mW_mu];
all_mice_null_SE_10mW = [Null_Predictions_SE_Pred_1_10mW_mu, Null_Predictions_SE_Pred_2_10mW_mu, Null_Predictions_SE_Pred_3_10mW_mu, Null_Predictions_SE_Pred_4_10mW_mu];
all_mice_null_NE_10mW = [Null_Predictions_NE_Pred_1_10mW_mu, Null_Predictions_NE_Pred_2_10mW_mu, Null_Predictions_NE_Pred_3_10mW_mu, Null_Predictions_NE_Pred_4_10mW_mu];

all_mice_stim_DA_5mW = [Stim_Predictions_DA_Pred_1_5mW_mu, Stim_Predictions_DA_Pred_2_5mW_mu, Stim_Predictions_DA_Pred_3_5mW_mu, Stim_Predictions_DA_Pred_4_5mW_mu];
all_mice_stim_SE_5mW = [Stim_Predictions_SE_Pred_1_5mW_mu, Stim_Predictions_SE_Pred_2_5mW_mu, Stim_Predictions_SE_Pred_3_5mW_mu, Stim_Predictions_SE_Pred_4_5mW_mu];
all_mice_stim_NE_5mW = [Stim_Predictions_NE_Pred_1_5mW_mu, Stim_Predictions_NE_Pred_2_5mW_mu, Stim_Predictions_NE_Pred_3_5mW_mu, Stim_Predictions_NE_Pred_4_5mW_mu];
all_mice_null_DA_5mW = [Null_Predictions_DA_Pred_1_5mW_mu, Null_Predictions_DA_Pred_2_5mW_mu, Null_Predictions_DA_Pred_3_5mW_mu, Null_Predictions_DA_Pred_4_5mW_mu];
all_mice_null_SE_5mW = [Null_Predictions_SE_Pred_1_5mW_mu, Null_Predictions_SE_Pred_2_5mW_mu, Null_Predictions_SE_Pred_3_5mW_mu, Null_Predictions_SE_Pred_4_5mW_mu];
all_mice_null_NE_5mW = [Null_Predictions_NE_Pred_1_5mW_mu, Null_Predictions_NE_Pred_2_5mW_mu, Null_Predictions_NE_Pred_3_5mW_mu, Null_Predictions_NE_Pred_4_5mW_mu];

%% average across mice
%Across Animal Final
Across_Stim_Final_DA_mu_15mW = mean(cell2mat(all_mice_stim_DA_15mW),2,'omitnan');
Across_Null_Final_DA_mu_15mW = mean(cell2mat(all_mice_null_DA_15mW),2,'omitnan');
Across_Stim_Final_SE_mu_15mW = mean(cell2mat(all_mice_stim_SE_15mW),2,'omitnan');
Across_Null_Final_SE_mu_15mW = mean(cell2mat(all_mice_null_SE_15mW),2,'omitnan');
Across_Stim_Final_NE_mu_15mW = mean(cell2mat(all_mice_stim_NE_15mW),2,'omitnan');
Across_Null_Final_NE_mu_15mW = mean(cell2mat(all_mice_null_NE_15mW),2,'omitnan');

Across_Stim_Final_DA_mu_10mW = mean(cell2mat(all_mice_stim_DA_10mW),2,'omitnan');
Across_Null_Final_DA_mu_10mW = mean(cell2mat(all_mice_null_DA_10mW),2,'omitnan');
Across_Stim_Final_SE_mu_10mW = mean(cell2mat(all_mice_stim_SE_10mW),2,'omitnan');
Across_Null_Final_SE_mu_10mW = mean(cell2mat(all_mice_null_SE_10mW),2,'omitnan');
Across_Stim_Final_NE_mu_10mW = mean(cell2mat(all_mice_stim_NE_10mW),2,'omitnan');
Across_Null_Final_NE_mu_10mW = mean(cell2mat(all_mice_null_NE_10mW),2,'omitnan');

Across_Stim_Final_DA_mu_5mW = mean(cell2mat(all_mice_stim_DA_5mW),2,'omitnan');
Across_Null_Final_DA_mu_5mW = mean(cell2mat(all_mice_null_DA_5mW),2,'omitnan');
Across_Stim_Final_SE_mu_5mW = mean(cell2mat(all_mice_stim_SE_5mW),2,'omitnan');
Across_Null_Final_SE_mu_5mW = mean(cell2mat(all_mice_null_SE_5mW),2,'omitnan');
Across_Stim_Final_NE_mu_5mW = mean(cell2mat(all_mice_stim_NE_5mW),2,'omitnan');
Across_Null_Final_NE_mu_5mW = mean(cell2mat(all_mice_null_NE_5mW),2,'omitnan');

%%%SEM
    Across_Stim_Final_DA_SEM_15mW = (std(cell2mat(all_mice_stim_DA_15mW),1,2,'omitnan'))/(sqrt(length(all_mice_stim_DA_15mW)));
    Across_Stim_Final_SE_SEM_15mW = (std(cell2mat(all_mice_stim_SE_15mW),1,2,'omitnan'))/(sqrt(length(all_mice_stim_SE_15mW)));
    Across_Stim_Final_NE_SEM_15mW = (std(cell2mat(all_mice_stim_NE_15mW),1,2,'omitnan'))/(sqrt(length(all_mice_stim_NE_15mW)));

    Across_Null_Final_DA_SEM_15mW = (std(cell2mat(all_mice_null_DA_15mW),1,2,'omitnan'))/(sqrt(length(all_mice_null_DA_15mW)));
    Across_Null_Final_SE_SEM_15mW = (std(cell2mat(all_mice_null_SE_15mW),1,2,'omitnan'))/(sqrt(length(all_mice_null_SE_15mW)));
    Across_Null_Final_NE_SEM_15mW = (std(cell2mat(all_mice_null_NE_15mW),1,2,'omitnan'))/(sqrt(length(all_mice_null_NE_15mW)));

    Across_Stim_Final_DA_SEM_10mW = (std(cell2mat(all_mice_stim_DA_10mW),1,2,'omitnan'))/(sqrt(length(all_mice_stim_DA_10mW)));
    Across_Stim_Final_SE_SEM_10mW = (std(cell2mat(all_mice_stim_SE_10mW),1,2,'omitnan'))/(sqrt(length(all_mice_stim_SE_10mW)));
    Across_Stim_Final_NE_SEM_10mW = (std(cell2mat(all_mice_stim_NE_10mW),1,2,'omitnan'))/(sqrt(length(all_mice_stim_NE_10mW)));

    Across_Null_Final_DA_SEM_10mW = (std(cell2mat(all_mice_null_DA_10mW),1,2,'omitnan'))/(sqrt(length(all_mice_null_DA_10mW)));
    Across_Null_Final_SE_SEM_10mW = (std(cell2mat(all_mice_null_SE_10mW),1,2,'omitnan'))/(sqrt(length(all_mice_null_SE_10mW)));
    Across_Null_Final_NE_SEM_10mW = (std(cell2mat(all_mice_null_NE_10mW),1,2,'omitnan'))/(sqrt(length(all_mice_null_NE_10mW)));

    Across_Stim_Final_DA_SEM_5mW = (std(cell2mat(all_mice_stim_DA_5mW),1,2,'omitnan'))/(sqrt(length(all_mice_stim_DA_5mW)));
    Across_Stim_Final_SE_SEM_5mW = (std(cell2mat(all_mice_stim_SE_5mW),1,2,'omitnan'))/(sqrt(length(all_mice_stim_SE_5mW)));
    Across_Stim_Final_NE_SEM_5mW = (std(cell2mat(all_mice_stim_NE_5mW),1,2,'omitnan'))/(sqrt(length(all_mice_stim_NE_5mW)));

    Across_Null_Final_DA_SEM_5mW = (std(cell2mat(all_mice_null_DA_5mW),1,2,'omitnan'))/(sqrt(length(all_mice_null_DA_5mW)));
    Across_Null_Final_SE_SEM_5mW = (std(cell2mat(all_mice_null_SE_5mW),1,2,'omitnan'))/(sqrt(length(all_mice_null_SE_5mW)));
    Across_Null_Final_NE_SEM_5mW = (std(cell2mat(all_mice_null_NE_5mW),1,2,'omitnan'))/(sqrt(length(all_mice_null_NE_5mW)));

%% Figure S1H

x = [5 6];
y = [-6 -6];

x2 = [5 6];
y2 = [35 35];

save_filename = 'All_NTs_5mW_comparison_Pred_3_alternative';
fig_window = [1: 17*fs]
time = (1:length(Across_Stim_Final_DA_mu_15mW(fig_window)))/fs
fig = figure
hold on
    plot(time,Across_Stim_Final_DA_mu_5mW(fig_window),'LineWidth',1,'color',"black");    
    plot(time,Across_Stim_Final_SE_mu_5mW(fig_window),'LineWidth',1,'color',"m"); 
    plot(time,Across_Stim_Final_NE_mu_5mW(fig_window),'LineWidth',1,'color',"c"); 

    shadedErrorBar(time,Across_Stim_Final_DA_mu_5mW(fig_window),Across_Stim_Final_DA_SEM_5mW(fig_window),'lineProps',{'-k', 'markerfacecolor', "black"});
    shadedErrorBar(time,Across_Stim_Final_SE_mu_5mW(fig_window),Across_Stim_Final_SE_SEM_5mW(fig_window),'lineProps',{'-m', 'markerfacecolor', "m"});
    shadedErrorBar(time,Across_Stim_Final_NE_mu_5mW(fig_window),Across_Stim_Final_NE_SEM_5mW(fig_window),'lineProps',{'-c','markerfacecolor', "c"});

    a = area(x,y,'FaceColor','b');
    b = area(x2,y2,'FaceColor','b');
hold off

ttl_onset = 5;
ttl_offset = 6;
x = [ttl_onset ttl_offset ttl_offset ttl_onset];

   yticks([0, 5, 10, 15, 20, 25, 30])
       xlim([2 16]);
    ylim([-4  30]);
    xticks([5 10 15 200 250]);
    xticklabels({'0' '5' '10' '15' '20'});
    xline(5,'--b','LineWidth',1);
    xline(6,'--b','LineWidth',1);
    
    ylabel('5mW [z]');
    xlabel('Time (s)');
    ax = gca;
    ax.FontSize = 25;
    a.FaceAlpha = 0.1;
    b.FaceAlpha = 0.1;
    axis square 
      set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 

saveas(gcf,fullfile(FigPath,'Figure_S1H'),'jpeg');

%% Figure S1I

x = [5 6];
y = [-6 -6];

x2 = [5 6];
y2 = [35 35];

fig_window = [1: 17*fs]
time = (1:length(Across_Stim_Final_DA_mu_15mW(fig_window)))/fs
fig = figure
hold on
    plot(time,Across_Stim_Final_DA_mu_10mW(fig_window),'LineWidth',1,'color',"black");    
    plot(time,Across_Stim_Final_SE_mu_10mW(fig_window),'LineWidth',1,'color',"m"); 
    plot(time,Across_Stim_Final_NE_mu_10mW(fig_window),'LineWidth',1,'color',"c"); 

    shadedErrorBar(time,Across_Stim_Final_DA_mu_10mW(fig_window),Across_Stim_Final_DA_SEM_10mW(fig_window),'lineProps',{'-k', 'markerfacecolor', "black"});
    shadedErrorBar(time,Across_Stim_Final_SE_mu_10mW(fig_window),Across_Stim_Final_SE_SEM_10mW(fig_window),'lineProps',{'-m', 'markerfacecolor', "m"});
    shadedErrorBar(time,Across_Stim_Final_NE_mu_10mW(fig_window),Across_Stim_Final_NE_SEM_10mW(fig_window),'lineProps',{'-c','markerfacecolor', "c"});

    a = area(x,y,'FaceColor','b');
    b = area(x2,y2,'FaceColor','b');
hold off
ttl_onset = 5;
ttl_offset = 6;
x = [ttl_onset ttl_offset ttl_offset ttl_onset];

   yticks([0, 5, 10, 15, 20, 25, 30])
       xlim([2 16]);
    ylim([-4  30]);
    xticks([5 10 15 200 250]);
    xticklabels({'0' '5' '10' '15' '20'});
    xline(5,'--b','LineWidth',1);
    xline(6,'--b','LineWidth',1);
    
    ylabel('10mW [z]');
    xlabel('Time (s)');
    ax = gca;
    ax.FontSize = 25;
    a.FaceAlpha = 0.1;
    b.FaceAlpha = 0.1;
    axis square 
      set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 

      saveas(gcf,fullfile(FigPath,'Figure_S1I'),'jpeg');

%% Figure S1J

x = [5 6];
y = [-6 -6];

x2 = [5 6];
y2 = [35 35];

fig_window = [1: 17*fs]
time = (1:length(Across_Stim_Final_DA_mu_15mW(fig_window)))/fs
fig = figure
hold on
    plot(time,Across_Stim_Final_DA_mu_15mW(fig_window),'LineWidth',1,'color',"black");    
    plot(time,Across_Stim_Final_SE_mu_15mW(fig_window),'LineWidth',1,'color',"m"); 
    plot(time,Across_Stim_Final_NE_mu_15mW(fig_window),'LineWidth',1,'color',"c"); 

    shadedErrorBar(time,Across_Stim_Final_DA_mu_15mW(fig_window),Across_Stim_Final_DA_SEM_15mW(fig_window),'lineProps',{'-k', 'markerfacecolor', "black"});
    shadedErrorBar(time,Across_Stim_Final_SE_mu_15mW(fig_window),Across_Stim_Final_SE_SEM_15mW(fig_window),'lineProps',{'-m', 'markerfacecolor', "m"});
    shadedErrorBar(time,Across_Stim_Final_NE_mu_15mW(fig_window),Across_Stim_Final_NE_SEM_15mW(fig_window),'lineProps',{'-c','markerfacecolor', "c"});

    a = area(x,y,'FaceColor','b');
    b = area(x2,y2,'FaceColor','b');
hold off

ttl_onset = 5;
ttl_offset = 6;
x = [ttl_onset ttl_offset ttl_offset ttl_onset];

   yticks([0, 5, 10, 15, 20, 25, 30])
       xlim([2 16]);
    ylim([-4  30]);
    xticks([5 10 15 200 250]);
    xticklabels({'0' '5' '10' '15' '20'});
    xline(5,'--b','LineWidth',1);
    xline(6,'--b','LineWidth',1);
    
    ylabel('15mW [z]');
    xlabel('Time (s)');
    ax = gca;
    ax.FontSize = 25;
    a.FaceAlpha = 0.1;
    b.FaceAlpha = 0.1;
    axis square 
      set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 

      saveas(gcf,fullfile(FigPath,'Figure_S1J'),'jpeg');


%% Get AUC DA
Window = [51:91];

%%%first get all individual AUCs for each NT and power

AUC_DA_all_stims_Pred_1_15mW = trapz(Window,Stim_Predictions_DA_Pred_1_15mW{1,1}(Window, :), 1);
AUC_DA_all_stims_Pred_1_10mW = trapz(Window,Stim_Predictions_DA_Pred_1_10mW{1,1}(Window, :), 1);
AUC_DA_all_stims_Pred_1_5mW = trapz(Window,Stim_Predictions_DA_Pred_1_5mW{1,1}(Window, :), 1);

AUC_SE_all_stims_Pred_1_15mW = trapz(Window,Stim_Predictions_SE_Pred_1_15mW{1,1}(Window, :), 1);
AUC_SE_all_stims_Pred_1_10mW = trapz(Window,Stim_Predictions_SE_Pred_1_10mW{1,1}(Window, :), 1);
AUC_SE_all_stims_Pred_1_5mW = trapz(Window,Stim_Predictions_SE_Pred_1_5mW{1,1}(Window, :), 1);

AUC_NE_all_stims_Pred_1_15mW = trapz(Window,Stim_Predictions_NE_Pred_1_15mW{1,1}(Window, :), 1);
AUC_NE_all_stims_Pred_1_10mW = trapz(Window,Stim_Predictions_NE_Pred_1_10mW{1,1}(Window, :), 1);
AUC_NE_all_stims_Pred_1_5mW = trapz(Window,Stim_Predictions_NE_Pred_1_5mW{1,1}(Window, :), 1);

AUC_DA_all_stims_Pred_2_15mW = trapz(Window,Stim_Predictions_DA_Pred_2_15mW{1,1}(Window, :), 1);
AUC_DA_all_stims_Pred_2_10mW = trapz(Window,Stim_Predictions_DA_Pred_2_10mW{1,1}(Window, :), 1);
AUC_DA_all_stims_Pred_2_5mW = trapz(Window,Stim_Predictions_DA_Pred_2_5mW{1,1}(Window, :), 1);

AUC_SE_all_stims_Pred_2_15mW = trapz(Window,Stim_Predictions_SE_Pred_2_15mW{1,1}(Window, :), 1);
AUC_SE_all_stims_Pred_2_10mW = trapz(Window,Stim_Predictions_SE_Pred_2_10mW{1,1}(Window, :), 1);
AUC_SE_all_stims_Pred_2_5mW = trapz(Window,Stim_Predictions_SE_Pred_2_5mW{1,1}(Window, :), 1);

AUC_NE_all_stims_Pred_2_15mW = trapz(Window,Stim_Predictions_NE_Pred_2_15mW{1,1}(Window, :), 1);
AUC_NE_all_stims_Pred_2_10mW = trapz(Window,Stim_Predictions_NE_Pred_2_10mW{1,1}(Window, :), 1);
AUC_NE_all_stims_Pred_2_5mW = trapz(Window,Stim_Predictions_NE_Pred_2_5mW{1,1}(Window, :), 1);

AUC_DA_all_stims_Pred_3_15mW = trapz(Window,Stim_Predictions_DA_Pred_3_15mW{1,1}(Window, :), 1);
AUC_DA_all_stims_Pred_3_10mW = trapz(Window,Stim_Predictions_DA_Pred_3_10mW{1,1}(Window, :), 1);
AUC_DA_all_stims_Pred_3_5mW = trapz(Window,Stim_Predictions_DA_Pred_3_5mW{1,1}(Window, :), 1);

AUC_SE_all_stims_Pred_3_15mW = trapz(Window,Stim_Predictions_SE_Pred_3_15mW{1,1}(Window, :), 1);
AUC_SE_all_stims_Pred_3_10mW = trapz(Window,Stim_Predictions_SE_Pred_3_10mW{1,1}(Window, :), 1);
AUC_SE_all_stims_Pred_3_5mW = trapz(Window,Stim_Predictions_SE_Pred_3_5mW{1,1}(Window, :), 1);

AUC_NE_all_stims_Pred_3_15mW = trapz(Window,Stim_Predictions_NE_Pred_3_15mW{1,1}(Window, :), 1);
AUC_NE_all_stims_Pred_3_10mW = trapz(Window,Stim_Predictions_NE_Pred_3_10mW{1,1}(Window, :), 1);
AUC_NE_all_stims_Pred_3_5mW = trapz(Window,Stim_Predictions_NE_Pred_3_5mW{1,1}(Window, :), 1);

AUC_DA_all_stims_Pred_4_15mW = trapz(Window,Stim_Predictions_DA_Pred_4_15mW{1,1}(Window, :), 1);
AUC_DA_all_stims_Pred_4_10mW = trapz(Window,Stim_Predictions_DA_Pred_4_10mW{1,1}(Window, :), 1);
AUC_DA_all_stims_Pred_4_5mW = trapz(Window,Stim_Predictions_DA_Pred_4_5mW{1,1}(Window, :), 1);

AUC_SE_all_stims_Pred_4_15mW = trapz(Window,Stim_Predictions_SE_Pred_4_15mW{1,1}(Window, :), 1);
AUC_SE_all_stims_Pred_4_10mW = trapz(Window,Stim_Predictions_SE_Pred_4_10mW{1,1}(Window, :), 1);
AUC_SE_all_stims_Pred_4_5mW = trapz(Window,Stim_Predictions_SE_Pred_4_5mW{1,1}(Window, :), 1);

AUC_NE_all_stims_Pred_4_15mW = trapz(Window,Stim_Predictions_NE_Pred_4_15mW{1,1}(Window, :), 1);
AUC_NE_all_stims_Pred_4_10mW = trapz(Window,Stim_Predictions_NE_Pred_4_10mW{1,1}(Window, :), 1);
AUC_NE_all_stims_Pred_4_5mW = trapz(Window,Stim_Predictions_NE_Pred_4_5mW{1,1}(Window, :), 1);

%%%means of AUCs for each NT and power
mean_stim_per_mouse_15mW_DA  = cell2mat(all_mice_stim_DA_15mW);
AUC_stim_per_mouse_15mW_DA = trapz(Window,mean_stim_per_mouse_15mW_DA(Window, :), 1);
AUC_stim_across_mice_15mW_DA = mean(AUC_stim_per_mouse_15mW_DA);
mean_null_per_mouse_15mW_DA  = cell2mat(all_mice_null_DA_15mW);
AUC_null_per_mouse_15mW_DA = trapz(Window,mean_null_per_mouse_15mW_DA(Window, :), 1);
AUC_null_across_mice_15mW_DA = mean(AUC_null_per_mouse_15mW_DA);

mean_stim_per_mouse_10mW_DA  = cell2mat(all_mice_stim_DA_10mW);
AUC_stim_per_mouse_10mW_DA = trapz(Window,mean_stim_per_mouse_10mW_DA(Window, :), 1);
AUC_stim_across_mice_10mW_DA = mean(AUC_stim_per_mouse_10mW_DA);
mean_null_per_mouse_10mW_DA  = cell2mat(all_mice_null_DA_10mW);
AUC_null_per_mouse_10mW_DA = trapz(Window,mean_null_per_mouse_10mW_DA(Window, :), 1);
AUC_null_across_mice_10mW_DA = mean(AUC_null_per_mouse_10mW_DA);

mean_stim_per_mouse_5mW_DA  = cell2mat(all_mice_stim_DA_5mW);
AUC_stim_per_mouse_5mW_DA = trapz(Window,mean_stim_per_mouse_5mW_DA(Window, :), 1);
AUC_stim_across_mice_5mW_DA = mean(AUC_stim_per_mouse_5mW_DA);
mean_null_per_mouse_5mW_DA  = cell2mat(all_mice_null_DA_5mW);
AUC_null_per_mouse_5mW_DA = trapz(Window,mean_null_per_mouse_5mW_DA(Window, :), 1);
AUC_null_across_mice_5mW_DA = mean(AUC_null_per_mouse_5mW_DA);

Graph_AUC_stim_15mW_DA_SEM(1,1) = (std(AUC_stim_per_mouse_15mW_DA,0,2,'omitnan'))/(sqrt(length(AUC_stim_per_mouse_15mW_DA)));
Graph_AUC_stim_10mW_DA_SEM(1,1) = (std(AUC_stim_per_mouse_10mW_DA,0,2,'omitnan'))/(sqrt(length(AUC_stim_per_mouse_10mW_DA)));
Graph_AUC_stim_5mW_DA_SEM(1,1) = (std(AUC_stim_per_mouse_5mW_DA,0,2,'omitnan'))/(sqrt(length(AUC_stim_per_mouse_5mW_DA)));

AUC_15mW_10mW_5mW_DA = [AUC_stim_across_mice_15mW_DA, AUC_stim_across_mice_10mW_DA, AUC_stim_across_mice_5mW_DA]
AUC_15mW_error_DA = [Graph_AUC_stim_15mW_DA_SEM,Graph_AUC_stim_10mW_DA_SEM,Graph_AUC_stim_5mW_DA_SEM];



%% Get AUC SE

Window = [51:91];
mean_stim_per_mouse_15mW_SE  = cell2mat(all_mice_stim_SE_15mW);
AUC_stim_per_mouse_15mW_SE = trapz(Window,mean_stim_per_mouse_15mW_SE(Window, :), 1);
AUC_stim_across_mice_15mW_SE = mean(AUC_stim_per_mouse_15mW_SE);
mean_null_per_mouse_15mW_SE  = cell2mat(all_mice_null_SE_15mW);
AUC_null_per_mouse_15mW_SE = trapz(Window,mean_null_per_mouse_15mW_SE(Window, :), 1);
AUC_null_across_mice_15mW_SE = mean(AUC_null_per_mouse_15mW_SE);

mean_stim_per_mouse_10mW_SE  = cell2mat(all_mice_stim_SE_10mW);
AUC_stim_per_mouse_10mW_SE = trapz(Window,mean_stim_per_mouse_10mW_SE(Window, :), 1);
AUC_stim_across_mice_10mW_SE = mean(AUC_stim_per_mouse_10mW_SE);
mean_null_per_mouse_10mW_SE  = cell2mat(all_mice_null_SE_10mW);
AUC_null_per_mouse_10mW_SE = trapz(Window,mean_null_per_mouse_10mW_SE(Window, :), 1);
AUC_null_across_mice_10mW_SE = mean(AUC_null_per_mouse_10mW_SE);

mean_stim_per_mouse_5mW_SE  = cell2mat(all_mice_stim_SE_5mW);
AUC_stim_per_mouse_5mW_SE = trapz(Window,mean_stim_per_mouse_5mW_SE(Window, :), 1);
AUC_stim_across_mice_5mW_SE = mean(AUC_stim_per_mouse_5mW_SE);
mean_null_per_mouse_5mW_SE  = cell2mat(all_mice_null_SE_5mW);
AUC_null_per_mouse_5mW_SE = trapz(Window,mean_null_per_mouse_5mW_SE(Window, :), 1);
AUC_null_across_mice_5mW_SE = mean(AUC_null_per_mouse_5mW_SE);

Graph_AUC_stim_15mW_SE_SEM(1,1) = (std(AUC_stim_per_mouse_15mW_SE,0,2,'omitnan'))/(sqrt(length(AUC_stim_per_mouse_15mW_SE)));
Graph_AUC_stim_10mW_SE_SEM(1,1) = (std(AUC_stim_per_mouse_10mW_SE,0,2,'omitnan'))/(sqrt(length(AUC_stim_per_mouse_10mW_SE)));
Graph_AUC_stim_5mW_SE_SEM(1,1) = (std(AUC_stim_per_mouse_5mW_SE,0,2,'omitnan'))/(sqrt(length(AUC_stim_per_mouse_5mW_SE)));

AUC_15mW_10mW_5mW_SE = [AUC_stim_across_mice_15mW_SE, AUC_stim_across_mice_10mW_SE, AUC_stim_across_mice_5mW_SE]
AUC_15mW_error_SE = [Graph_AUC_stim_15mW_SE_SEM,Graph_AUC_stim_10mW_SE_SEM,Graph_AUC_stim_5mW_SE_SEM];


%% Get AUC NE

Window = [51:91];
mean_stim_per_mouse_15mW_NE  = cell2mat(all_mice_stim_NE_15mW);
AUC_stim_per_mouse_15mW_NE = trapz(Window,mean_stim_per_mouse_15mW_NE(Window, :), 1);
AUC_stim_across_mice_15mW_NE = mean(AUC_stim_per_mouse_15mW_NE);
mean_null_per_mouse_15mW_NE  = cell2mat(all_mice_null_NE_15mW);
AUC_null_per_mouse_15mW_NE = trapz(Window,mean_null_per_mouse_15mW_NE(Window, :), 1);
AUC_null_across_mice_15mW_NE = mean(AUC_null_per_mouse_15mW_NE);

mean_stim_per_mouse_10mW_NE  = cell2mat(all_mice_stim_NE_10mW);
AUC_stim_per_mouse_10mW_NE = trapz(Window,mean_stim_per_mouse_10mW_NE(Window, :), 1);
AUC_stim_across_mice_10mW_NE = mean(AUC_stim_per_mouse_10mW_NE);
mean_null_per_mouse_10mW_NE  = cell2mat(all_mice_null_NE_10mW);
AUC_null_per_mouse_10mW_NE = trapz(Window,mean_null_per_mouse_10mW_NE(Window, :), 1);
AUC_null_across_mice_10mW_NE = mean(AUC_null_per_mouse_10mW_NE);

mean_stim_per_mouse_5mW_NE  = cell2mat(all_mice_stim_NE_5mW);
AUC_stim_per_mouse_5mW_NE = trapz(Window,mean_stim_per_mouse_5mW_NE(Window, :), 1);
AUC_stim_across_mice_5mW_NE = mean(AUC_stim_per_mouse_5mW_NE);
mean_null_per_mouse_5mW_NE  = cell2mat(all_mice_null_NE_5mW);
AUC_null_per_mouse_5mW_NE = trapz(Window,mean_null_per_mouse_5mW_NE(Window, :), 1);
AUC_null_across_mice_5mW_NE = mean(AUC_null_per_mouse_5mW_NE);

Graph_AUC_stim_15mW_NE_SEM(1,1) = (std(AUC_stim_per_mouse_15mW_NE,0,2,'omitnan'))/(sqrt(length(AUC_stim_per_mouse_15mW_NE)));
Graph_AUC_stim_10mW_NE_SEM(1,1) = (std(AUC_stim_per_mouse_10mW_NE,0,2,'omitnan'))/(sqrt(length(AUC_stim_per_mouse_10mW_NE)));
Graph_AUC_stim_5mW_NE_SEM(1,1) = (std(AUC_stim_per_mouse_5mW_NE,0,2,'omitnan'))/(sqrt(length(AUC_stim_per_mouse_5mW_NE)));

AUC_15mW_10mW_5mW_NE = [AUC_stim_across_mice_15mW_NE, AUC_stim_across_mice_10mW_NE, AUC_stim_across_mice_5mW_NE];
AUC_15mW_error_NE = [Graph_AUC_stim_15mW_NE_SEM,Graph_AUC_stim_10mW_NE_SEM,Graph_AUC_stim_5mW_NE_SEM];

%% all NTs

AUC_15mW_all_NTs = [AUC_stim_across_mice_15mW_DA, AUC_stim_across_mice_15mW_SE, AUC_stim_across_mice_15mW_NE]
AUC_10mW_all_NTs = [AUC_stim_across_mice_10mW_DA, AUC_stim_across_mice_10mW_SE, AUC_stim_across_mice_10mW_NE]
AUC_5mW_all_NTs = [AUC_stim_across_mice_5mW_DA, AUC_stim_across_mice_5mW_SE, AUC_stim_across_mice_5mW_NE]

AUC_15mW_error_all_NTs = [Graph_AUC_stim_15mW_DA_SEM,Graph_AUC_stim_10mW_SE_SEM,Graph_AUC_stim_15mW_NE_SEM];
AUC_10mW_error_all_NTs= [Graph_AUC_stim_10mW_DA_SEM,Graph_AUC_stim_10mW_SE_SEM,Graph_AUC_stim_10mW_NE_SEM];
AUC_5mW_error_all_NTs = [Graph_AUC_stim_5mW_DA_SEM,Graph_AUC_stim_5mW_SE_SEM,Graph_AUC_stim_5mW_NE_SEM];



%% Figure S1K

AUC_power_grouped = [AUC_5mW_all_NTs, AUC_10mW_all_NTs, AUC_15mW_all_NTs ];
AUC_power_grouped_error = [AUC_5mW_error_all_NTs, AUC_10mW_error_all_NTs,  AUC_15mW_error_all_NTs];

x = [1:9];

x2 = [1;1;1;1];
x3 = [2;2;2;2];
x4 = [3;3;3;3];
x5 = repmat((4), 4, 1)
x6 = repmat((5), 4, 1)
x7 = repmat((6), 4, 1)
x8 = repmat((7), 4, 1)
x9 = repmat((8), 4, 1)
x10 = repmat((9), 4, 1)



fig =figure
hold on

b = bar(x,AUC_power_grouped,'facecolor','flat');
er = errorbar(x, AUC_power_grouped,AUC_power_grouped_error );
er.Color = 'k' ;
er.CapSize = 0;
er.LineStyle = 'none';
markersize = 10;

scatter(x2,AUC_stim_per_mouse_5mW_DA,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x3,AUC_stim_per_mouse_5mW_SE,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x4,AUC_stim_per_mouse_5mW_NE,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);

scatter(x5,AUC_stim_per_mouse_10mW_DA,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x6,AUC_stim_per_mouse_10mW_SE,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x7,AUC_stim_per_mouse_10mW_NE,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);


scatter(x8,AUC_stim_per_mouse_15mW_DA,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x9,AUC_stim_per_mouse_15mW_SE,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);
scatter(x10,AUC_stim_per_mouse_15mW_NE,markersize,'MarkerEdgeColor','k','MarkerFaceColor',[0.5000    0.5000    1.0000]);




hold off

b.CData(1,:) = [0 0 0]	
b.CData(2,:) = [1 0 1]	
b.CData(3,:) = [0 1 1]	

b.CData(4,:) = [0 0 0]
b.CData(5,:) = [1 0 1]	
b.CData(6,:) = [0 1 1]	

b.CData(7,:) = [0 0 0]
b.CData(8,:) = [1 0 1]	
b.CData(9,:) = [0 1 1]	

    ylim([-50 800]);
        xticks([2 5 8 ]);
    xticklabels({'5mW', '10mW', '15mW'});
    ylabel('NT  AUC [z]');
   ax = gca;
    ax.FontSize = 25;
          set(gca, 'Units', 'inches','Position', [2, 2, 1.2, 1.2], 'color', 'none', 'FontName', 'Arial', 'FontSize' , 8 ); 

 axis square 

 saveas(gcf,fullfile(FigPath,'Figure_S1K'),'jpeg');
