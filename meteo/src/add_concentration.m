%   It is an input to prepare inputs for neural networks.
%   Two files has to be ready in advance: the physical data from the
%   simulation and the measured concentrations.
%   In both, the date should have 4 columns: year-month-day-hour
%   The 5th column should be deleted as it is the minute and everywhere 0!!
%   Careful, the first row of the files should be already the data, do not
%   keep the descriptions there! Files should have .txt format.

clear all;
close all;
clc;



%% load in from plain text, all simulation data in it
data = load('data_new.txt');
% indx = data(:,1) ~= 2017;
% X = data(indx, :);

%% interpolate datas to have more probes (linear)
data_mod = -1 * ones(3*size(data,1)-2, size(data,2));

ind1 = 1 : 3 : size(data_mod,1);
ind2 = 2 : 3 : size(data_mod,1)-2;
ind3 = 1 : 3 : size(data_mod,1)-3;
ind4 = 4 : 3 : size(data_mod,1);
ind5 = 3 : 3 : size(data_mod,1)-1;

data_mod(ind1, :) = data;

data_mod(ind2, 6:size(data_mod,2)) = ...
    (2/3) * data_mod(ind3, 6:size(data_mod,2)) + (1/3) * data_mod(ind4, 6:size(data_mod,2));

data_mod(ind5, 6:size(data_mod,2)) = ...
    (1/3) * data_mod(ind3, 6:size(data_mod,2)) + (2/3) * data_mod(ind4, 6:size(data_mod,2));
%% add labels to data set
%labels and data should have the same starting and end date!!!
labels = load('label_new.txt');
labels = labels(48378:119244, :); % date range must be identical in labels and data

%%
data_labeled =[data_mod labels];
indx_tmp = labels(:,size(labels,2)) >= 50;
%binarise them
data_labeled = [data_labeled indx_tmp];


%% append new variables if needed
indx1 = [ones(1,24) 1:size(data_labeled,1) - 24];
tmp = data_labeled(indx1, size(data_labeled,2) - 1);
data_labeled = [data_labeled(:,1:size(data_labeled,2)-2) tmp data_labeled(:, size(data_labeled,2)-1:size(data_labeled,2))];

%%organise date variable
data_labeled(:,1:5) = data_labeled(:,32:36);
data_labeled = [data_labeled(:,1:31) data_labeled(:,37:size(data_labeled,2))];

%% normalise variables

K = data_labeled(:, 1:size(data_labeled,2)-2);
K = (K - repmat(mean(K), size(K, 1), 1))./ (repmat(std(K), size(K, 1), 1));

data_labeled_norm = [K data_labeled];

%% convert date variables into vectors
hp = [0 31 28 31 30 31 30 31 31 30 31 30];
Month = data_labeled(:,2);
Day = data_labeled(:,3);
Hour = data_labeled(:,4);

v = [];
for i = 1 : length(Month)
    tmp = sum(hp(1:Month(i))) + Day(i);
    v = [v; tmp];
end

t1 = sin((2*pi*v)/365);
t2 = cos((2*pi*v)/365);
t3 = sin((2*pi*Hour)/24);
t4 = cos((2*pi*Hour)/24);

data_labeled_norm = [data_labeled_norm(:,1:5) t1 t2 t3 t4 data_labeled_norm(:,6:size(data_labeled_norm,2))];
%%
%dlmwrite('data_labeled_norm.txt', data_labeled_norm);

%% delete samples where label is nonsense

tmp = data_labeled_norm(:,size(data_labeled_norm,2)-1) == -1;
tmp2 = ones(size(data_labeled_norm,1),1);
rest = logical(tmp2 - tmp); 
data = data_labeled_norm(rest, :);

%% rand partition into three groups

X = data(:, 1:size(data,2)-2);
conc = data(:, size(data,2)-1);
y = data(:, size(data,2));

[train dev test] = rand_part(X, y, conc);


