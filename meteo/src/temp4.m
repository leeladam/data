clc;
clear all;
close all;

Train = load('convdate_mem_train.txt');
Dev = load('convdate_mem_dev.txt');
Test = load('convdate_mem_test.txt');

%%
Train_new = [Train(:, 1:6), Train(:, 101:104), Train(:,7:100), Train(:,105:204), Train(:,209:size(Train,2))];
Dev_new = [Dev(:, 1:6), Dev(:, 101:104), Dev(:,7:100), Dev(:,105:204), Dev(:,209:size(Dev,2))];
Test_new = [Test(:, 1:6), Test(:, 101:104), Test(:,7:100), Test(:,105:204), Test(:,209:size(Test,2))];
%%

dlmwrite('convdate_mem_train_reorg.txt', Train_new);
dlmwrite('convdate_mem_dev_reorg.txt', Dev_new);
dlmwrite('convdate_mem_test_reorg.txt', Test_new);


