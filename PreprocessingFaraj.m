clear all;
close all
clc
%%
data = load('FarajEpochAVGRefICA.txt');
%%
data = reshape(data,19,34000,10);
% data = Data;

%% Total Powers
fs = 200;
TotalPowers = zeros(19,10);
for ch = 1:19
    for trial = 1:10
        TotalPowers(ch,trial) = bandpower(data(ch,:,trial), fs, [0.5 70]);
    end
end

%% Total Power Avg Over All Channels
TotalAVG = mean(TotalPowers,1);

plot(TotalAVG,'LineWidth',1.5)
title("Total Power")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end


%%
fs = 200;
DeltaPowers = zeros(19,10);
ThetaPowers = zeros(19,10);
AlphaPowers = zeros(19,10);
BetaPowers = zeros(19,10);
GamaPowers = zeros(19,10);
for ch = 1:19
    for trial = 1:10
        DeltaPowers(ch,trial) = bandpower(data(ch,:,trial), fs, [1 4]);
        ThetaPowers(ch,trial) = bandpower(data(ch,:,trial), fs, [4 8]);
        AlphaPowers(ch,trial) = bandpower(data(ch,:,trial), fs, [8 12]);
        BetaPowers(ch,trial) = bandpower(data(ch,:,trial), fs, [12 35]);
        GamaPowers(ch,trial) = bandpower(data(ch,:,trial), fs, [35 100]);
    end
end
%%
% Opera Rock Pop Rap Jazz
for i = 1:19
%     subplot(10,1,i)
    ch = i;
    plot(BetaPowers(ch,:),'LineWidth',1.5);
    hold on
    xline(2,'r','LineWidth',1.5,'HandleVisibility','off');
    xline(4,'r','LineWidth',1.5,'HandleVisibility','off');
    xline(6,'r','LineWidth',1.5,'HandleVisibility','off');
    xline(8,'r','LineWidth',1.5,'HandleVisibility','off');
    xline(10,'r','LineWidth',1.5,'HandleVisibility','off');
end
title("Beta");
xlabel("Trial");
ylabel("Band Powers");
legend('1','2','3','4','5','6','7');
%% Power Avg Over All Channels
DeltaAVG = mean(DeltaPowers,1);
BetaAVG = mean(BetaPowers,1);
ThetaAVG = mean(ThetaPowers,1);
AlphaAVG = mean(AlphaPowers,1);
GamaAVG = mean(GamaPowers,1);

subplot(5,1,1)
plot(DeltaAVG,'LineWidth',1.5)
title("Delta Band")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end

subplot(5,1,2)
plot(ThetaAVG,'LineWidth',1.5)
title("Theta Band")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end

subplot(5,1,3)
plot(AlphaAVG,'LineWidth',1.5)
title("Alpha Band")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end

subplot(5,1,4)
plot(BetaAVG,'LineWidth',1.5)
title("Beta Band")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end

subplot(5,1,5)
plot(GamaAVG,'LineWidth',1.5)
title("Gama Band")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end

Powers = [AlphaAVG ; BetaAVG ; ThetaAVG ; DeltaAVG ; GamaAVG];

%% Power Avg Over Fronto-Right Channels 
% Fp2=ch2 , F4=ch6 , F8=ch7
DeltaAVG = mean(DeltaPowers([2,6,7],:),1);
BetaAVG = mean(BetaPowers([2,6,7],:),1);
ThetaAVG = mean(ThetaPowers([2,6,7],:),1);
AlphaAVG = mean(AlphaPowers([2,6,7],:),1);
GamaAVG = mean(GamaPowers([2,6,7],:),1);

subplot(5,1,1)
plot(DeltaAVG,'LineWidth',1.5)
title("Delta Band")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end

subplot(5,1,2)
plot(ThetaAVG,'LineWidth',1.5)
title("Theta Band")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end

subplot(5,1,3)
plot(AlphaAVG,'LineWidth',1.5)
title("Alpha Band")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end

subplot(5,1,4)
plot(BetaAVG,'LineWidth',1.5)
title("Beta Band")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end

subplot(5,1,5)
plot(GamaAVG,'LineWidth',1.5)
title("Gama Band")
xlabel("Trial");
for i = 2:2:10
    xline(i,'r', 'LineWidth',1.5);
end

sgtitle('Maryam-FrontoRight-Normalized(ch = 2,6,7) , Ref=AVG , BFP:0.5-70 , fs=200Hz','Interpreter','Latex');

%%
Data = importdata('MaryamEpochICA.txt');
%%
DataEpoch = reshape(Data,19,51000,11);
ReRefData = ReRefEpoch(DataEpoch);

figure;
plot(DataEpoch(18,:,1))
figure;
plot(ReRefData(18,:,1))
%%
[f, mag] = FFT1D(DataEpoch(1,:,1), 300);
x = find(f>0);
f = f(x(1):end);
mag = mag(x(1):end);
plot(f,mag);

[f, mag] = FFT1D(ReRefData(1,:,1), 300);
x = find(f>0);
f = f(x(1):end);
mag = mag(x(1):end);
figure;
plot(f,mag);


%% Functions
function ReRefData = ReRefEpoch(Data) 
    % ============================================================
    % Rereferencing data by subtracting all channel's temoporal average from 
    % each channel for each trial
    % ============================================================
    ReRefData = Data;
    for trial = 1:11
        temp = Data(:,:,trial);
        ref = mean(temp,1);
        refMat = repmat(ref,19,1);
        ReRefData(:,:,trial) = ReRefData(:,:,trial) - refMat;
    end
end

function [f, mag] = FFT1D(x, fs) % FFT(Also Contains Negative Frequnecies)
    y = fft(x);
    mag = abs(y);
    mag = fftshift(mag)/fs;
    L = size(x,2);
    f = linspace(-fs/2,fs/2,L);
end



