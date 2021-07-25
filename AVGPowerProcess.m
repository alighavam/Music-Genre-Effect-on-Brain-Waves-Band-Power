%%
clear all; close all; clc;
AliPowers = load('AliPowers.mat');
AliPowers = AliPowers.Powers;

MaryamPowers = load('MaryamPowers.mat');
MaryamPowers = MaryamPowers.Powers;

ArsalanPowers = load('ArsalanPowers.mat');
ArsalanPowers = ArsalanPowers.Powers;

FarajPowers = load('FarajPowers.mat');
FarajPowers = FarajPowers.Powers;

% Normalization
maximum = 1;
AliPowers = PowNormalize(AliPowers,maximum);
MaryamPowers = PowNormalize(MaryamPowers,maximum);
ArsalanPowers = PowNormalize(ArsalanPowers,maximum);
FarajPowers = PowNormalize(FarajPowers,maximum);

% Plot =========================================================
for col = 1:5
    PlotPowers(AliPowers, MaryamPowers, ArsalanPowers, FarajPowers, col);
end


%% Functions
function out = PowNormalize(in,maximum)
    out = in;
    for i = 1:5
        out(i,:) = in(i,:) * maximum / max(in(i,:));
    end
end

function PlotPowers(AliPowers, MaryamPowers, ArsalanPowers, FarajPowers, col)
    figure;
    titleVec = ["Alpha" , "Beta" , "Theta" , "Delta" , "Gamma"];
    x = ones(1,11);
    scatter(x(1:2:11) , AliPowers(col,1:2:11) , 'b');
    meanrest = mean(AliPowers(col,1:2:11));
    hold on
    scatter(x(2:2:10) , AliPowers(col,2:2:10) , 'r');
    meansong = mean(AliPowers(col,2:2:10));
    hold on
    plot(1, meanrest, 'marker', '*' ,'color', 'b');
    hold on
    plot(1, meansong, 'marker', '*' ,'color', 'r');
    hold on

    scatter(2*x(1:2:11) , MaryamPowers(col,1:2:11) , 'b');
    meanrest = mean(MaryamPowers(col,1:2:11));
    hold on
    scatter(2*x(2:2:10) , MaryamPowers(col,2:2:10) , 'r');
    meansong = mean(MaryamPowers(col,2:2:10));
    hold on
    plot(2, meanrest, 'marker', '*' ,'color', 'b');
    hold on
    plot(2, meansong, 'marker', '*' ,'color', 'r');
    hold on

    scatter(3*x(1:2:9) , ArsalanPowers(col,1:2:9) , 'b');
    meanrest = mean(ArsalanPowers(col,1:2:9));
    hold on
    scatter(3*x(2:2:9) , ArsalanPowers(col,2:2:9) , 'r');
    meansong = mean(ArsalanPowers(col,2:2:9));
    hold on
    plot(3, meanrest, 'marker', '*' ,'color', 'b');
    hold on
    plot(3, meansong, 'marker', '*' ,'color', 'r');
    hold on

    scatter(4*x(1:2:10) , FarajPowers(col,1:2:10) , 'b');
    meanrest = mean(FarajPowers(col,1:2:10));
    hold on
    scatter(4*x(2:2:10) , FarajPowers(col,2:2:10) , 'r');
    meansong = mean(FarajPowers(col,2:2:10));
    hold on
    plot(4, meanrest, 'marker', '*' ,'color', 'b');
    hold on
    plot(4, meansong, 'marker', '*' ,'color', 'r');
    hold on

    xlim([0 5]);
    title(titleVec(col));
    xlabel("Subjects");
end



