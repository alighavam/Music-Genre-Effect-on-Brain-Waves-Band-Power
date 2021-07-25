%% import data
clear; close all; clc;
MonoPolarData = importdata('ArsalanMonoPolarNormalized.txt');
%% Epoching
Fs = 500; %NrSign Fs
Temp = MonoPolarData.data;
% MonoPolarRaw = Temp(:, 1 : 21);
% MonoPolarRaw(:,9) = [];
% MonoPolarRaw(:,18) = [];
% MonoPolarRaw = [MonoPolarRaw , Temp(:, 65)]; %Triggers 65
% 
% %Raw Data Epoch
% EpochFPzRef = epoch(MonoPolarRaw, Fs);
% 
% %Avg Ref Data Epoch
% EpochAVGRef = MonoPolarRaw;
% EpochAVGRef(:, 1:19) = AVGReRef(EpochAVGRef);
% EpochAVGRef = epoch(EpochAVGRef, Fs);
%% Validation By Inspection 
subplot(2,1,1)
plot(EpochAVGRef(19,:,1));
% xlim([0 10000]);
% hold on
subplot(2,1,2)
plot(EpochFPzRef(19,:,1));
% xlim([0 10000]);
%% Saving =========================================================================
save('MaryamEpochAVGRef.mat', 'EpochAVGRef');
save('MaryamEpochFPzRef.mat', 'EpochFPzRef');

%% Functions
function ReRefData = AVGReRef(Data) % without rank drop
    % ============================================================
    % Rereferencing data by subtracting all channel's temoporal average from 
    % each channel
    % ============================================================
    ReRefData = zeros(size(Data,1), 19);
    temp = Data(:,1:19);
    temp = [temp, zeros(size(Data,1),1)]; % Adding zeros filled channel
    ref = mean(temp,2); % Average of all channels
    refMat = repmat(ref,1,19);
    ReRefData = Data(:,1:19) - refMat;
end

% function ReRefData = AVGReRef(Data) % without rank drop
%     % ============================================================
%     % Rereferencing data by subtracting all channel's temoporal average from 
%     % each channel
%     % ============================================================
%     ReRefData = zeros(size(Data,1), 19);
%     temp = Data(:,1:19);
%     temp = [temp, zeros(size(Data,1),1)]; % Adding zeros filled channel
%     ref = mean(temp,2); % Average of all channels
%     refMat = repmat(ref,1,19);
%     ReRefData = Data(:,1:19) - refMat;
% end

function EpochedData = epoch(Data, Fs) 
    % =====================================================
    % This function makes a 3D matrix of data in the standard form of
    % Epoch(Channels, Time Points, Trials) ---> exp: MaryamEpoch(19,85000,11)
    % =====================================================
    Trials = Data(:,20); % Extracting triggers
    TrialsIndex = find(Trials ~= 0); % Finding trials
    
    for i = 1:size(TrialsIndex,1)-1 % Removing repeated triggers
        if (TrialsIndex(i+1) - TrialsIndex(i)) < 10*Fs
            TrialsIndex(i+1) = 0;
        end
    end
    TrialsIndex = TrialsIndex(find(TrialsIndex ~= 0));
    TrialNumCheck = TrialsIndex
    
    TrialsIndex(18:end) = []; % Deleting Alam Task
    
    a = [1,2,4,5,7,8,10,11,13,14]; % Triggers that are related to a real trial
    TrialsIndex = TrialsIndex(a); % index of first time point of each trial
    
    EpochedData = zeros(19, 85000, 10); % (Channel(= 19), Time(= 170s), Trial(= 11))
    for ch = 1:19
        for trial = 1:10
            dataIndex01 = TrialsIndex(trial);
            dataIndex02 = dataIndex01 + 85000 - 1; % 170s of data
            EpochedData(ch, :, trial) = Data(dataIndex01:dataIndex02,ch);
        end
    end
end







