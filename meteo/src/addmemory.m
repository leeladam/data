clc;
clear all;
close all;

data = load('labeled_data_verified_bin.txt');

%%
v1 = [1:size(data,1)]';
data = [v1 data];

%%

hp = [1:size(data,1)-3]';
hp = [1; 1; 1; hp];

hp2 = [1:size(data,1)-6]';
hp2 = [1;1;1;1;1;1; hp2];
%%
data_new = [data, data(hp, 2:size(data,2)), data(hp2, 2:size(data,2))];
%%

X = data_new;
y = data_new(:, 34);
conc = data_new(:,33);
[Train Dev Test] = rand_part(X, y, conc);





